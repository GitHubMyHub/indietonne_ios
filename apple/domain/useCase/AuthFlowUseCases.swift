//
//  AuthFlowUseCases.swift
//  apple
//
//  Sammeldatei für die Passwort-Reset- und E-Mail-Verifikations-UseCases.
//

import Foundation

struct RequestPasswordResetUseCase: Sendable {
    private let api: AuthenticationApi
    init(api: AuthenticationApi) { self.api = api }
    func execute(email: String) async throws -> String {
        try await api.requestPasswordReset(email: email)
    }
}

struct ResetPasswordUseCase: Sendable {
    private let api: AuthenticationApi
    init(api: AuthenticationApi) { self.api = api }
    func execute(token: String, newPassword: String) async throws -> String {
        try await api.resetPassword(input: ResetPasswordInput(token: token, newPassword: newPassword))
    }
}

struct VerifyEmailUseCase: Sendable {
    private let api: AuthenticationApi
    init(api: AuthenticationApi) { self.api = api }
    func execute(token: String) async throws -> String {
        try await api.verifyEmail(token: token)
    }
}

struct ResendVerificationUseCase: Sendable {
    private let api: AuthenticationApi
    init(api: AuthenticationApi) { self.api = api }
    func execute(email: String) async throws -> String {
        try await api.resendVerificationEmail(email: email)
    }
}
