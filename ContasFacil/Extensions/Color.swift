//
//  Color.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//
import SwiftUI
import Foundation

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let background = Color("BackgroundColor")
        let font = Color("FontColor")
        let border = Color("BorderColor")
        let green = Color("PrimaryGreen")
        let error = Color("DangerColor")
    }
}
