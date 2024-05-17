//
//  FadeBackgroundModifier.swift
//  CatApp
//
//  Created by António Fonseca on 17/05/2024.
//

import SwiftUI

struct FadeBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.5), Color.clear]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .cornerRadius(10)
            .shadow(color: Color.red.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func fadeBackground() -> some View {
        self.modifier(FadeBackgroundModifier())
    }
}
