//
//  ActionButton.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct ActionButton: View {
    
    let buttonText: String
    let isLoading: Bool
    let action: () -> Void
    
    init(buttonText: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.buttonText = buttonText
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(
            action: action,
            label: {
                if (!isLoading) {
                    Text(buttonText)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.ui.background)
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                        .background(Color.ui.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                } else {
                    ZStack {
                        LoadingAnimation(color: Color.ui.background)
                    }
                    .foregroundStyle(Color.ui.background)
                    .frame(height: 46)
                    .frame(maxWidth: .infinity)
                    .background(Color.ui.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            })
        .disabled(isLoading)
    }
}

#Preview {
    ActionButton(buttonText: "Teste", isLoading: true) {}
}
