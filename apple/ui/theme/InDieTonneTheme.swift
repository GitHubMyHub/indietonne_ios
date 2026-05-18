//
//  InDieTonneTheme.swift
//  apple
//
//  ViewModifier mit App-Defaults (Tint, Typography, Background).
//  Äquivalent zu Android `InDieTonneTheme`.
//

import SwiftUI

struct InDieTonneTheme: ViewModifier {
    func body(content: Content) -> some View {
        content
            .tint(.primaryBrand)
            .background(Color.whiteBackground)
    }
}

extension View {
    func inDieTonneTheme() -> some View {
        modifier(InDieTonneTheme())
    }
}
