//
//  AuthRepositoryImpl.swift
//  apple
//
//  Apollo-basierte Implementation der `AuthenticationApi` (unauthentifiziert).
//

import Foundation
import Apollo
import ApolloAPI

final class AuthRepositoryImpl: AuthenticationApi {
    private let apollo: ApolloClient
    private let deviceInfo: DeviceInfoServicing

    init(apollo: ApolloClient, deviceInfo: DeviceInfoServicing) {
        self.apollo = apollo
        self.deviceInfo = deviceInfo
    }

    func signIn(input: LoginInput) async throws -> String {
        let info = deviceInfo.current
        let deviceInfoStr = "\(info.model) \(info.systemName) \(info.systemVersion)"
        let query = InDieTonneAPI.SignInQuery(
            loginUser: InDieTonneAPI.LoginInput(
                username: input.email,
                password: input.password,
                firebaseToken: .some(""),
                deviceInfo: deviceInfoStr
            )
        )
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        if let errors = result.errors, !errors.isEmpty {
            #if DEBUG
            print("[Apollo] signIn errors:", errors.map(\.message))
            #endif
            throw APIError.graphQLErrors(errors)
        }
        guard let token = result.data?.signIn else {
            throw APIError.noData
        }
        return token
    }

    func signUp(input: SignUpInput) async throws -> String {
        let mutation = InDieTonneAPI.SignUpMutation(
            loginUser: InDieTonneAPI.SignUpInput(
                username: input.email,
                password: input.password,
                firebaseToken: "",
                deviceInfo: "\(deviceInfo.current.model) \(deviceInfo.current.systemName) \(deviceInfo.current.systemVersion)"
            )
        )
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "signUp")
        guard let token = result.data?.signUp else { throw APIError.noData }
        return token
    }

    func requestPasswordReset(email: String) async throws -> String {
        let mutation = InDieTonneAPI.RequestPasswordResetMutation(email: email)
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "requestPasswordReset")
        guard let msg = result.data?.requestPasswordReset else { throw APIError.noData }
        return msg
    }

    func resetPassword(input: ResetPasswordInput) async throws -> String {
        let mutation = InDieTonneAPI.ResetPasswordMutation(
            input: InDieTonneAPI.ResetPasswordInput(token: input.token, newPassword: input.newPassword)
        )
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "resetPassword")
        guard let msg = result.data?.resetPassword else { throw APIError.noData }
        return msg
    }

    func verifyEmail(token: String) async throws -> String {
        let mutation = InDieTonneAPI.VerifyEmailMutation(token: token)
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "verifyEmail")
        guard let msg = result.data?.verifyEmail else { throw APIError.noData }
        return msg
    }

    func resendVerificationEmail(email: String) async throws -> String {
        let mutation = InDieTonneAPI.ResendVerificationEmailMutation(email: email)
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "resendVerificationEmail")
        guard let msg = result.data?.resendVerificationEmail else { throw APIError.noData }
        return msg
    }
}

private func throwIfErrors(_ errors: [GraphQLError]?, op: String) throws {
    guard let errors, !errors.isEmpty else { return }
    #if DEBUG
    print("[Apollo] \(op) GraphQL errors:", errors.map(\.message))
    #endif
    throw APIError.graphQLErrors(errors)
}

enum APIError: LocalizedError {
    case noData
    case graphQLErrors([GraphQLError])

    var errorDescription: String? {
        switch self {
        case .noData: return "No data received from server."
        case .graphQLErrors(let errs): return errs.compactMap(\.message).joined(separator: "\n")
        }
    }
}
