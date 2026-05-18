//
//  AuthRepositoryImpl.swift
//  apple
//
//  Apollo-basierte Implementation der `AuthenticationApi` (unauthentifiziert).
//  Solange das Apollo-SPM-Paket nicht eingebunden ist, wird ein
//  Mock-Repository (`AuthRepositoryMock`) verwendet, damit das Projekt baut.
//

import Foundation

#if canImport(Apollo) && canImport(ApolloAPI) && canImport(IndieTonneAPI)
import Apollo
import ApolloAPI
import IndieTonneAPI // generierter Apollo-Schema-Modul-Name (anpassen)

final class AuthRepositoryImpl: AuthenticationApi {
    private let apollo: ApolloClient

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }

    func signIn(input: LoginInput) async throws -> String {
        // TODO: SignInQuery(loginUser: ...) ausführen, signIn als String zurückgeben
        fatalError("TODO: implementieren mit generiertem Apollo-Code")
    }

    func signUp(input: SignUpInput) async throws -> String {
        fatalError("TODO: implementieren mit generiertem Apollo-Code")
    }

    func requestPasswordReset(email: String) async throws -> String {
        fatalError("TODO")
    }

    func resetPassword(input: ResetPasswordInput) async throws -> String {
        fatalError("TODO")
    }

    func verifyEmail(token: String) async throws -> String {
        fatalError("TODO")
    }

    func resendVerificationEmail(email: String) async throws -> String {
        fatalError("TODO")
    }
}

#else

/// Mock-Implementation – wird benutzt, bis Apollo eingebunden ist.
/// Erlaubt der UI, gegen ein funktionierendes Backend-Interface zu entwickeln.
final class AuthRepositoryImpl: AuthenticationApi {
    init(serverURL: URL = Constants.baseURL) {}

    func signIn(input: LoginInput) async throws -> String {
        try await Task.sleep(nanoseconds: 400_000_000)
        return "mock-jwt-token-\(UUID().uuidString)"
    }

    func signUp(input: SignUpInput) async throws -> String {
        try await Task.sleep(nanoseconds: 400_000_000)
        return "mock-jwt-token-\(UUID().uuidString)"
    }

    func requestPasswordReset(email: String) async throws -> String {
        try await Task.sleep(nanoseconds: 200_000_000)
        return "If an account exists for \(email), a reset link has been sent."
    }

    func resetPassword(input: ResetPasswordInput) async throws -> String {
        try await Task.sleep(nanoseconds: 200_000_000)
        return "Password has been reset successfully."
    }

    func verifyEmail(token: String) async throws -> String {
        try await Task.sleep(nanoseconds: 200_000_000)
        return "Email verified successfully."
    }

    func resendVerificationEmail(email: String) async throws -> String {
        try await Task.sleep(nanoseconds: 200_000_000)
        return "Verification email sent to \(email)."
    }
}

#endif
