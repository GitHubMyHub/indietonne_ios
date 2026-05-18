//
//  AuthenticationApi.swift
//  apple
//
//  Protocol für unauthentifizierte Auth-Endpunkte.
//  Äquivalent zu Android `data/remote/AuthenticationApi.kt`.
//

import Foundation

struct LoginInput: Codable, Sendable {
    let email: String
    let password: String
}

struct SignUpInput: Codable, Sendable {
    let email: String
    let password: String
}

struct ResetPasswordInput: Codable, Sendable {
    let token: String
    let newPassword: String
}

protocol AuthenticationApi: Sendable {
    /// Liefert das JWT-Token bei erfolgreichem Login.
    func signIn(input: LoginInput) async throws -> String

    /// Liefert das JWT-Token bei erfolgreicher Registrierung.
    func signUp(input: SignUpInput) async throws -> String

    /// Liefert eine bestätigende Server-Message.
    func requestPasswordReset(email: String) async throws -> String
    func resetPassword(input: ResetPasswordInput) async throws -> String
    func verifyEmail(token: String) async throws -> String
    func resendVerificationEmail(email: String) async throws -> String
}
