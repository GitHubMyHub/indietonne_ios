//
//  PostLoginUseCase.swift
//  apple
//

import Foundation

struct PostLoginUseCase: Sendable {
    private let api: AuthenticationApi

    init(api: AuthenticationApi) {
        self.api = api
    }

    func execute(email: String, password: String) async throws -> String {
        try await api.signIn(input: LoginInput(email: email, password: password))
    }
}
