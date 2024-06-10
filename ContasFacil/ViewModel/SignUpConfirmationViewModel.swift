//
//  SignUpConfirmationViewModel.swift
//  ContasFacil
//
//  Created by Elisson Silva on 09/06/24.
//

import Foundation


class SignUpConfirmationViewModel: ObservableObject {
    
    @Published var confirmationCode: String = ""
    @Published var isConfirmationCodeError: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var isResendingError: Bool = false
    
    
    func resendCode(for email: String) {
        isLoading = true
        
        Task {@MainActor in
            let result = await CognitoAuth.resendConfirmationCode(for: email)
            self.isResendingError = result
        }
        
        isLoading = false
    }
    
    
}
