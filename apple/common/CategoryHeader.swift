//
//  CategoryHeader.swift
//  apple
//
//  Wiederverwendbare Header-View mit generischem Category<T>-Modell.
//  Äquivalent zu Android `common/CategoryHeader.kt`.
//

import SwiftUI

struct Category<T: Hashable>: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let items: [T]
}

struct CategoryHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 8)
    }
}

#Preview {
    CategoryHeader(title: "Beispiel")
}
