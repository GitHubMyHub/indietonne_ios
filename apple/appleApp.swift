//
//  appleApp.swift
//  apple
//
//  App-Entry-Point. Konstruiert den DI-Container `AppEnvironment`,
//  initialisiert den NavigationStack und wählt die Start-Destination
//  anhand des persistierten JWT-Tokens.
//

import SwiftUI

@main
struct appleApp: App {
    @State private var env = AppEnvironment()
    @State private var path = NavigationPath()

    var body: some Scene {
        WindowGroup {
            RootView(path: $path)
                .environment(env)
                .environment(env.tokenStore)
                .preferredColorScheme(env.tokenStore.isDarkMode.map { $0 ? .dark : .light })
                .inDieTonneTheme()
        }
    }
}

struct RootView: View {
    @Environment(TokenStore.self) private var tokenStore
    @Binding var path: NavigationPath

    var body: some View {
        NavigationStack(path: $path) {
            startView
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
    }

    @ViewBuilder
    private var startView: some View {
        if tokenStore.isAuthenticated {
            ScheduleOverviewPage(path: $path)
        } else {
            LoginPage(path: $path)
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .login:
            LoginPage(path: $path)
        case .register:
            RegisterPage(path: $path)
        case .places:
            PlacesPage(path: $path)
        case .streets(let placeId):
            StreetPage(path: $path, placeId: placeId)
        case .trashSettings(let placeId, let streetId):
            TrashSettingsPage(path: $path, placeId: placeId, streetId: streetId)
        case .scheduleOverview:
            ScheduleOverviewPage(path: $path)
        case .scheduleList(let appointmentId):
            ScheduleListPage(path: $path, appointmentId: appointmentId)
        case .profile:
            ProfilePage()
        case .forgotPassword:
            ForgotPasswordPage()
        case .resetPassword(let token):
            ResetPasswordPage(path: $path, token: token)
        case .verifyEmail(let token):
            VerifyEmailPage(path: $path, token: token)
        case .resendVerification:
            ResendVerificationPage()
        }
    }
}
