//
//  StreetViewModel.swift
//

import Foundation
import Observation

@Observable
@MainActor
final class StreetViewModel {
    private let useCase: GetAppointmentsUseCase
    private(set) var state = StreetListState()

    init(useCase: GetAppointmentsUseCase) {
        self.useCase = useCase
    }

    func load(placeId: String, search: String = "") {
        Task { @MainActor in
            state.isLoading = true
            do {
                // TODO: placeId via StreetFiler an Backend übergeben sobald
                // Apollo eingebunden ist – Mock filtert nur clientseitig.
                state.streets = try await useCase.streets(search: search, page: 0, size: 1000)
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.isLoading = false
            }
        }
    }
}
