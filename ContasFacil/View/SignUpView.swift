//
//  SignUpView.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            ZStack {
                HStack {
                    ImageButton(btnImage: { Image("BackIcon") }, hasBorder: false) {
                        dismiss()
                    }
                    Spacer()
                }
                HStack {
                    Text("Crie sua conta")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.ui.font)
                }
            }
            VStack(alignment: .leading, spacing: 20) {
                BasicTextField(
                    title: "Nome",
                    placeholder: "Digite seu nome",
                    keyboardType: .default,
                    text: $viewModel.name,
                    isError: $viewModel.nameError,
                    errorMessage: "Por favor, digite seu nome"
                )
                
                BasicTextField(
                    title: "E-mail",
                    placeholder: "Digite seu e-mail",
                    keyboardType: .emailAddress,
                    text: $viewModel.email,
                    autocapitalization: .never,
                    isError: $viewModel.emailError,
                    errorMessage: "Por favor, digite um email válido"
                )
                
                BasicTextField(
                    title: "Senha",
                    placeholder: "Digite sua senha",
                    isPassword: true,
                    text: $viewModel.password,
                    isError: $viewModel.passwordError,
                    errorMessage: "Por favor, digite uma senha"
                )
            }
            ActionButton(buttonText: "Entrar") {
                viewModel.signUp()
            }
        
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accentColor(Color.ui.background)
        .toolbar(.hidden)
    }
}

#Preview {
    SignUpView()
}
