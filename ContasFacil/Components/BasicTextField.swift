//
//  BasicTextField.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct BasicTextField: View {
    
    let title: String
    let placeholder: String
    let isPassword: Bool
    let keyboardType: UIKeyboardType
    var text: Binding<String>
    var autocapitalization: TextInputAutocapitalization
    var isError: Binding<Bool>?
    var errorMessage: String?
    
    init(title: String, placeholder: String, isPassword: Bool = false, keyboardType: UIKeyboardType = .default, text: Binding<String>,
         autocapitalization: TextInputAutocapitalization = .words, isError: Binding<Bool>? = nil,
         errorMessage: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self.isPassword = isPassword
        self.keyboardType = keyboardType
        self.text = text
        self.autocapitalization = autocapitalization
        self.isError = isError
        self.errorMessage = errorMessage
    }
    
    var borderColor: Color {
        let isErrorActive = self.isError ?? Binding.constant(false)
        
        if (isErrorActive.wrappedValue) {
            return Color.ui.error
        }
        
        return Color.ui.border
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(Color.ui.font)
            if (isPassword) {
                SecureField(placeholder, text: text.onChange({ value in
                    if let isErrorSafe = isError {
                        isErrorSafe.wrappedValue = false
                    }
                }))
                    .frame(height: 56)
                    .padding([.horizontal], 15)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.ui.font)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(self.borderColor))
                    .keyboardType(keyboardType)
            }
            else {
                TextField(placeholder, 
                          text: text.onChange({ value in
                    if let isErrorSafe = isError {
                        isErrorSafe.wrappedValue = false
                    }
                }))
                    .frame(height: 56)
                    .padding([.horizontal], 15)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.ui.font)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(self.borderColor))
                    .keyboardType(keyboardType)
                    .textInputAutocapitalization(autocapitalization)
            }
            if let isErrorSafe = isError {
                if (isErrorSafe.wrappedValue) {
                    Text(errorMessage ?? "There's a problem here")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.ui.error)
                }
            }
        }
    }
}

struct BasicTextField_Preview: PreviewProvider {
    
    @State static var text: String = ""
    @State static var isError: Bool = true
    
    static var previews: some View {
        VStack {
            BasicTextField(
                title: "Title",
                placeholder: "Type anything",
                text: $text,
                isError: $isError,
                errorMessage: "Please type something"
            )
        }
        .padding()
    }
}

