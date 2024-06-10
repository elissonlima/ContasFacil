//
//  LoginViewModel.swift
//  ContasFacil
//
//  Created by Elisson Silva on 09/06/24.
//

import Amplify
import AWSCognitoAuthPlugin
import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var signInStatus: SignInStatus?
    
    func isFormValid() -> Bool {
        if (email.isEmpty || password.isEmpty || !email.isValidEmail) {
            
            if (email.isEmpty || !email.isValidEmail) {
                isError = true
                errorMessage = "Por favor, digite um e-mail válido"
            }
            
            if (password.isEmpty) {
                isError = true
                errorMessage = "Por favor, digite sua senha"
            }
            
            return false
        }
        
        return true
    }
    
    func signIn() {
        
        if (isFormValid()) {
            isLoading = true
            
            Task {@MainActor in
                self.signInStatus = await CognitoAuth.signIn(email: email, password: password)
            }
            
            isLoading = false
        }
        
    }
    
}

