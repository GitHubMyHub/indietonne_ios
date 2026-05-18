//
//  PlaceListItem.swift
//  apple
//
//  Listenzelle für `PlacesPage`. Äquivalent zu Android
//  `presentation/components/PlaceListItem.kt`.
//

import SwiftUI

struct PlaceListItem: View {
    let text: String
    let placePicture: String
    var onItemClick: () -> Void

    var body: some View {
        Button(action: onItemClick) {
            HStack(spacing: 12) {
                Group {
                    if placePicture.isEmpty {
                        Image(systemName: "building.2.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.primaryBrand.opacity(0.8))
                    } else {
                        RemoteImage(storedName: placePicture) {
                            Image(systemName: "building.2.crop.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                        .scaledToFit()
                    }
                }
                .frame(width: 60, height: 60)

                Text(text)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .contentShape(Rectangle())
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PlaceListItem(text: "Rietberg", placePicture: "") {}
}
