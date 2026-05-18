//
//  PlacesViewModel.swift
//

import Foundation
import Observation

@Observable
@MainActor
final class PlacesViewModel {
    private let useCase: GetAppointmentsUseCase
    private(set) var state = PlaceListState()

    init(useCase: GetAppointmentsUseCase) {
        self.useCase = useCase
    }

    func load() {
        Task { @MainActor in
            state.isLoading = true
            do {
                state.places = try await useCase.places(page: 0, size: 2000)
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
}
