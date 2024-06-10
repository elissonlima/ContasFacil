//
//  CognitoAuth.swift
//  ContasFacil
//
//  Created by Elisson Silva on 09/06/24.
//

import Amplify
import AWSCognitoAuthPlugin
import SwiftUI
import Foundation


enum SignUpStatus: Equatable {
    case ok
    case confirmationNeeded
    case error(_ msg: String)
    case emailExists
}

enum SignInStatus: Equatable {
    case ok
    case error(_ msg: String)
    case confirmationNeeded
}


struct CognitoAuth {

    static func signUp(name: String, password: String, email: String) async -> SignUpStatus{
        let userAttributes = [AuthUserAttribute(.givenName, value: name),
                              AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(
                username: email,
                password: password,
                options: options
            )
            if case .confirmUser(_, _, _) = signUpResult.nextStep {
                return .confirmationNeeded
            } else {
                return .ok
            }
        } catch let error as AuthError {
            if let underError = error.underlyingError  {
                if (underError as! AWSCognitoAuthError == AWSCognitoAuthError.usernameExists) {
                    return .emailExists
                }
            }
            return .error("Um erro ocorreu ao tentar cadastrar um usuário.")
        } catch {
            print("Unexpected error: \(error)")
            return .error("Um erro inesperado ocorreu. Por favor, tente novamente mais tarde.")
        }
    }
    
    static func signIn(email: String, password: String) async -> SignInStatus {
        do {
            let signInResult = try await Amplify.Auth.signIn(
                username: email,
                password: password
            )
            if signInResult.isSignedIn {
                return .ok
            } else {
                switch signInResult.nextStep {
                case .confirmSignUp(_):
                    return .confirmationNeeded
                default:
                    print("Unexpected signInResult \(signInResult)")
                    return .error("Por favor, verifique o seu cadastro e tente novamente.")
                }
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
            return .error("Um erro ocorreu durante tentativa de login")
        } catch {
            print("Unexpected error: \(error)")
            return .error("Um erro inesperado ocorreu. Por favor, tente novamente mais tarde.")
        }
    }
    
    static func resendConfirmationCode(for email: String) async -> Bool {
        do {
            let _ = try await Amplify.Auth.resendSignUpCode(for: email)
            return true
        } catch let error as AuthError {
            print("Resend failed \(error)")
            return false
        } catch {
            print("Unexpected error: \(error)")
            return false
        }
    }
    
}

