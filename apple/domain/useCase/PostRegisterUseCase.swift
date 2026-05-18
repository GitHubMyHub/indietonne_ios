//
//  PostRegisterUseCase.swift
//  apple
//

import Foundation

struct PostRegisterUseCase: Sendable {
    private let api: AuthenticationApi

    init(api: AuthenticationApi) {
        self.api = api
    }

    func execute(email: String, password: String) async throws -> String {
        try await api.signUp(input: SignUpInput(email: email, password: password))
    }
}
