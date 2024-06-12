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
    let offset: CGSize
    
    init(@ViewBuilder btnImage: () -> Content, hasBorder: Bool = true, width: CGFloat = 46, height: CGFloat = 46,
         offset: CGSize = CGSize(width: 0, height: 0), action: @escaping () -> Void) {
        self.btnImage = btnImage()
        self.action = action
        self.hasBorder = hasBorder
        self.height = height
        self.width = width
        self.offset = offset
    }
    
    var body: some View {
        Button(action: action, label: {
            ZStack(alignment:Alignment(horizontal: .center, vertical: .center)) {
                self.btnImage
            }
            .offset(self.offset)
            .padding()
            .frame(width: width, height: height)
            .overlay(hasBorder ? RoundedRectangle(cornerRadius: 5).stroke(Color.ui.border) : nil)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        })
    }
}

struct BackButton: View {
    
    @EnvironmentObject var router: Router
    
    var isToRoot: Bool
    
    init(isToRoot: Bool = false) {
        self.isToRoot = isToRoot
    }
    
    var body: some View {
        ImageButton(btnImage: { Image("BackIcon") },
                    hasBorder: false,
                    offset: CGSize(width: -1.2, height: 0)) {
            if (isToRoot){
                router.navigateToRoot()
            } else {
                router.navigateBack()
            }
        }
    }
}

#Preview {
    BackButton()
}
