//
//  LoginViewModel.swift
//  apple
//
//  Äquivalent zu Android `LoginViewModel`.
//

import Foundation
import Observation

@Observable
@MainActor
final class LoginViewModel {
    private let useCase: PostLoginUseCase
    private(set) var state = LoginState()

    init(useCase: PostLoginUseCase) {
        self.useCase = useCase
    }

    func login(email: String, password: String) {
        Task { @MainActor in
            state.isLoading = true
            state.error = ""
            do {
                let token = try await useCase.execute(email: email, password: password)
                state.token = token
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
}
