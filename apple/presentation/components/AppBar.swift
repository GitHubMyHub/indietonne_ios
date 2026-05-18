//
//  AppBar.swift
//  apple
//
//  Wiederverwendbare Toolbar mit Suchfeld + Profil-Menü.
//  Äquivalent zu Android `presentation/components/AppBar.kt`.
//
//  Verwendung: Als `.toolbar { AppBarContent(...) }` einbinden, ODER
//  als eigenständige Header-View über einem Hintergrundbild platzieren
//  (siehe ScheduleOverviewPage / TrashSettingsPage).
//

import SwiftUI

/// Inline-Header (kein NavigationBar) – wird über Bildern verwendet.
struct InlineAppBar: View {
    let systemImage: String
    var title: String = ""
    var hasPicture: Bool = false
    var activeSearch: Bool = false
    @Binding var searchValue: String
    var showProfileMenu: Bool = false
    var navigationIconAction: () -> Void = {}
    var onProfileClick: () -> Void = {}
    var onToggleTheme: () -> Void = {}
    var onLogout: () -> Void = {}

    @State private var isSearchActive = false
    @Environment(TokenStore.self) private var tokenStore

    var body: some View {
        HStack(spacing: 8) {
            Button(action: navigationIconAction) {
                Image(systemName: systemImage)
                    .font(.title3)
                    .foregroundStyle(hasPicture ? .white : Color.primaryBrand)
                    .padding(8)
            }

            if isSearchActive && activeSearch {
                TextField("Search", text: $searchValue)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.search)
            } else {
                Text(title)
                    .font(.title3.bold())
                    .foregroundStyle(hasPicture ? .white : Color.primaryBrand)
                    .lineLimit(1)
                    .shadow(color: hasPicture ? .black.opacity(0.6) : .clear, radius: 3, x: 2, y: 2)
            }

            Spacer()

            if activeSearch {
                Button { isSearchActive.toggle() } label: {
                    Image(systemName: isSearchActive ? "xmark" : "magnifyingglass")
                        .foregroundStyle(hasPicture ? .white : Color.primaryBrand)
                        .padding(8)
                }
            }

            if showProfileMenu {
                Menu {
                    Button {
                        onProfileClick()
                    } label: {
                        Label("Profile", systemImage: "person")
                    }
                    Button {
                        onToggleTheme()
                    } label: {
                        Label(
                            (tokenStore.isDarkMode ?? false) ? "Light Mode" : "Dark Mode",
                            systemImage: (tokenStore.isDarkMode ?? false) ? "sun.max" : "moon"
                        )
                    }
                    Button(role: .destructive) {
                        onLogout()
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.title2)
                        .foregroundStyle(hasPicture ? .white : Color.primaryBrand)
                        .padding(8)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
    }
}
