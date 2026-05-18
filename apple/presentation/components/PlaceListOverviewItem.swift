//
//  PlaceListOverviewItem.swift
//  apple
//
//  Listenzelle für `ScheduleOverview`. Zeigt Place + Fraktionen-Icons
//  der aktuellen Woche an. Äquivalent zu Android `PlaceListOverviewItem.kt`.
//

import SwiftUI

struct PlaceListOverviewItem: View {
    let text: String
    let fractions: [FractionDTO]
    let placeId: String
    let placePicture: String
    var onItemClick: () -> Void

    var body: some View {
        Button(action: onItemClick) {
            HStack(spacing: 12) {
                Group {
                    if placePicture.isEmpty {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.primaryBrand.opacity(0.8))
                    } else {
                        RemoteImage(storedName: placePicture) {
                            Image(systemName: "trash.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray.opacity(0.4))
                        }
                        .scaledToFit()
                    }
                }
                .frame(width: 70, height: 70)

                VStack(alignment: .leading, spacing: 4) {
                    Text(text)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.primary)

                    HStack(spacing: 4) {
                        Text("This week:")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        if fractions.isEmpty {
                            Text("None").font(.caption).foregroundStyle(.secondary)
                        } else {
                            ForEach(fractions, id: \.id) { f in
                                Circle()
                                    .fill(color(for: f.icon))
                                    .frame(width: 16, height: 16)
                                    .overlay(
                                        Image(systemName: "trash.fill")
                                            .font(.system(size: 9))
                                            .foregroundStyle(.white)
                                    )
                            }
                        }
                    }
                }
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

    /// `trashcan=4b4b4b` → SwiftUI Color.
    private func color(for icon: String?) -> Color {
        guard let icon, let hex = icon.split(separator: "=").last else {
            return .gray
        }
        return Color(hex: String(hex)) ?? .gray
    }
}

private extension Color {
    init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard hex.count == 6, let value = UInt32(hex, radix: 16) else { return nil }
        self.init(
            red:   Double((value >> 16) & 0xFF) / 255,
            green: Double((value >>  8) & 0xFF) / 255,
            blue:  Double( value        & 0xFF) / 255
        )
    }
}
