//
//  LoginView.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Olá!")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.ui.font)
                Text("Como deseja acessar?")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.ui.font)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 10) {
                BasicTextField(
                    title: "E-mail",
                    placeholder: "Digite seu e-mail",
                    keyboardType: .emailAddress,
                    text: $viewModel.email,
                    autocapitalization: .never,
                    isError: $viewModel.isError,
                    errorMessage: ""
                )
                
                BasicTextField(
                    title: "Senha",
                    placeholder: "Digite sua senha",
                    isPassword: true,
                    text: $viewModel.password,
                    isError: $viewModel.isError,
                    errorMessage: ""
                )
                
                if ($viewModel.isError.wrappedValue) {
                    Text($viewModel.errorMessage.wrappedValue)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.ui.error)
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                
                ActionButton(buttonText: "Entrar", isLoading: $viewModel.isLoading.wrappedValue) {
                    viewModel.signIn()
                }
                
                
                Text("Ainda não tem acesso? **Cadastre-se!**")
                    .frame(height: 46)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.ui.font)
                    .onTapGesture {
                        router.navigate(to: .signup)
                    }
                
                
                LabelledDivider(label: "ou", color: Color.ui.border)
                
                HStack(alignment: .center) {
                    ImageButton(
                        btnImage: { Image("GoogleIcon") },
                        width: 58,
                        height: 58) {
                        print("Google Login")
                    }
                    Spacer()
                    ImageButton(btnImage: 
                                    { Image("AppleIcon")
                            .resizable()
                        .frame(width: 27, height: 33.66) },
                                width: 58,
                                height: 58,
                                offset: CGSize(width: 0, height: -1)
                    ) {
                        print("Apple Login")
                    }
                }
                .padding([.horizontal], 40)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accentColor(Color.ui.background)
        .onChange(of: viewModel.signInStatus) { status in
            if let safeStatus = status {
                switch safeStatus {
                case .confirmationNeeded:
                    router.navigate(to: .signupconfirmation(email: $viewModel.email.wrappedValue))
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
