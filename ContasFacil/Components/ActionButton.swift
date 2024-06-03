//
//  ActionButton.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI

struct ActionButton: View {
    
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                Text(buttonText)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.ui.background)
                    .frame(height: 46)
                    .frame(maxWidth: .infinity)
                    .background(Color.ui.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            })
    }
}

#Preview {
    ActionButton(buttonText: "Teste") {}
}
