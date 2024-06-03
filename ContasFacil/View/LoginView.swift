//
//  LoginView.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var goToSignUp: Int? = 0
    
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
                    text: $email)
                
                BasicTextField(
                    title: "Senha",
                    placeholder: "Digite sua senha",
                    isPassword: true,
                    text: $password)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                
                ActionButton(buttonText: "Entrar") {
                    print("Sign In")
                }
                
                NavigationLink(destination: SignUpView()){
                    Text("Ainda não tem acesso? **Cadastre-se!**")
                        .frame(height: 46)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.ui.font)
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
                        .frame(width: 29, height: 35.66) },
                                width: 58,
                                height: 58) {
                        print("Apple Login")
                    }
                }
                .padding([.horizontal], 30)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .accentColor(Color.ui.background)
    }
}

#Preview {
    LoginView()
}
