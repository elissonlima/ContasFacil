//
//  ImageButton.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import SwiftUI
import Foundation

struct ImageButton<Content: View>: View {
    
    let btnImage: Content
    let action: () -> Void
    let hasBorder: Bool
    let width: CGFloat
    let height: CGFloat
    
    init(@ViewBuilder btnImage: () -> Content, hasBorder: Bool = true, width: CGFloat = 46, height: CGFloat = 46, action: @escaping () -> Void) {
        self.btnImage = btnImage()
        self.action = action
        self.hasBorder = hasBorder
        self.height = height
        self.width = width
    }
    
    var body: some View {
        Button(action: action, label: {
            ZStack {
                self.btnImage
            }
            .frame(width: width, height: height)
            .overlay(hasBorder ? RoundedRectangle(cornerRadius: 5).stroke(Color.ui.border) : nil)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        })
    }
}

#Preview {
    ImageButton(btnImage: { Image("BackIcon") }, hasBorder: false) {}
}
