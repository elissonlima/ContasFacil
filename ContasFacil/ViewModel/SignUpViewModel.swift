//
//  SignUpViewModel.swift
//  ContasFacil
//
//  Created by Elisson Silva on 01/06/24.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var nameError: Bool = false
    @Published var emailError: Bool = false
    @Published var emailErrorMsg: String = ""
    @Published var passwordError: Bool = false
    
    @Published var isLoading: Bool = false
    @Published var signUpStatus: SignUpStatus?
    @Published var showErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    
    func isFormValid() -> Bool {
        if (name.isEmpty || email.isEmpty || password.isEmpty || !email.isValidEmail) {
            
            if (name.isEmpty) {
                nameError = true
            }
            
            if (email.isEmpty || !email.isValidEmail) {
                emailError = true
                emailErrorMsg = "Por favor, digite um e-mail válido"
            }
            
            if (password.isEmpty) {
                passwordError = true
            }
            
            return false
        }
        
        return true
    }
    
    func signUp() {
        if (isFormValid()) {
            
            isLoading = true
            Task {@MainActor in
                self.signUpStatus = await CognitoAuth.signUp(name: self.name,
                                                   password: self.password,
                                                   email: self.email)
            }
            isLoading = false
        }
    }
    
}



