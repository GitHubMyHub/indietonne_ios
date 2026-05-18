//
//  RegisterViewModel.swift
//

import Foundation
import Observation

@Observable
@MainActor
final class RegisterViewModel {
    private let useCase: PostRegisterUseCase
    private(set) var state = RegisterState()

    init(useCase: PostRegisterUseCase) {
        self.useCase = useCase
    }

    func signUp(email: String, password: String) {
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
