//
//  SignUpConfirmationView.swift
//  ContasFacil
//
//  Created by Elisson Silva on 08/06/24.
//

import SwiftUI

struct SignUpConfirmationView: View {
    
    @ObservedObject var viewModel: SignUpConfirmationViewModel = SignUpConfirmationViewModel()
    
    var email: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Verifique o seu e-mail")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.ui.font)
            Text("Informe o código que enviamos para seu e-mail")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.ui.font)

            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                VStack(spacing: 25) {
                    
                    BasicTextField(
                        title:  "",
                        placeholder: "",
                        keyboardType: .numberPad,
                        text: $viewModel.confirmationCode,
                        autocapitalization: .never,
                        isError: $viewModel.isConfirmationCodeError,
                        errorMessage: "Código Inválido"
                    )
                    
                    Text("Não recebeu o e-mail? **Enviar Novamente**")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.ui.font)
                        .onTapGesture {
                            Task { @MainActor in
                                
                            }
                        }
                    
                    ActionButton(buttonText: "Confirmar") {
                        print("Sending")
                    }
                }
            }
            .padding([.horizontal], 30)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accentColor(Color.ui.background)
        .toolbar(.hidden)
    }
}

#Preview {
    SignUpConfirmationView(email: "test@email.com")
}
