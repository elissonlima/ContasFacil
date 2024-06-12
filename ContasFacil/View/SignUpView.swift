//
//  SignUpView.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 25) {
                
                BackButton()
                
                Text("Crie sua conta")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.ui.font)
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
                    errorMessage: $viewModel.emailErrorMsg.wrappedValue
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
            ActionButton(buttonText: "Cadastrar", isLoading: $viewModel.isLoading.wrappedValue) {
                    viewModel.signUp()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accentColor(Color.ui.background)
        .toolbar(.hidden)
        .onChange(of: viewModel.signUpStatus){ status in
            if let safeStatus = status {
                switch safeStatus {
                case .ok:
                    router.navigateToRoot()
                case .confirmationNeeded:
                    router.navigate(to: .signupconfirmation(email: $viewModel.email.wrappedValue))
                case .emailExists:
                    viewModel.emailError = true
                    viewModel.emailErrorMsg = "Já existe um cadastro com esse e-mail"
                case .error(let msg):
                    viewModel.errorMessage = msg
                    viewModel.showErrorMessage = true
                }
            }
        }
        .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorMessage) { Button("OK", role: .cancel) {
            viewModel.showErrorMessage = false
            viewModel.signUpStatus = nil
        } }
    }
}

#Preview {
    SignUpView()
}
