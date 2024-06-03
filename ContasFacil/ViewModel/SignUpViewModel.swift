//
//  SignUpViewModel.swift
//  ContasFacil
//
//  Created by Elisson Silva on 01/06/24.
//

import SwiftUI
import Foundation

class SignUpViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var nameError: Bool = false
    @Published var emailError: Bool = false
    @Published var passwordError: Bool = false
    
    func isFormValid() -> Bool {
        if (name.isEmpty || email.isEmpty || password.isEmpty || !email.isValidEmail) {
            
            if (name.isEmpty) {
                nameError = true
            }
            
            if (email.isEmpty || !email.isValidEmail) {
                emailError = true
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
            print("Valid Form! Do SignUp")
        } else {
            print("Form Not Valid")
        }
    }
    
    
}



