//
//  ProfileViewModel.swift
//

import Foundation
import Observation

@Observable
@MainActor
final class ProfileViewModel {
    private let useCase: GetAppointmentsUseCase
    private(set) var state = ProfileState()

    init(useCase: GetAppointmentsUseCase) {
        self.useCase = useCase
    }

    func load() {
        Task { @MainActor in
            state.isLoading = true
            do {
                state.user = try await useCase.currentUser()
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
}
