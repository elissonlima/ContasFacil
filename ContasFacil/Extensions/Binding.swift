//
//  Binding.swift
//  ContasFacil
//
//  Created by Elisson Silva on 01/06/24.
//

import SwiftUI
import Foundation

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
