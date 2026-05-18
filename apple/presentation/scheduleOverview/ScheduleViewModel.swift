//
//  ScheduleViewModel.swift
//
//  Äquivalent zu Android `presentation/scheduleOverview/ScheduleViewModel.kt`.
//  MVI-Aktionen werden via `onAction` dispatched.
//

import Foundation
import Observation

enum ScheduleOverviewAction {
    case load
    case refresh
    case delete(id: String)
}

@Observable
@MainActor
final class ScheduleViewModel {
    private let useCase: GetAppointmentsUseCase
    private(set) var state = AppointmentListState()

    init(useCase: GetAppointmentsUseCase) {
        self.useCase = useCase
    }

    func onAction(_ action: ScheduleOverviewAction) {
        switch action {
        case .load:    load()
        case .refresh: refresh()
        case .delete(let id): delete(id: id)
        }
    }

    private func load() {
        Task { @MainActor in
            state.isLoading = true
            do {
                state.appointments = try await useCase.appointments(page: 0, size: 10)
                state.isLoading = false
            } catch {
                state.error = error.localizedDescription
                state.snackbar = "Failed to load appointments"
                state.isLoading = false
            }
        }
    }

    private func refresh() {
        Task { @MainActor in
            state.isRefreshing = true
            do {
                state.appointments = try await useCase.appointments(page: 0, size: 10)
            } catch {
                state.snackbar = "Failed to refresh appointments"
            }
            state.isRefreshing = false
        }
    }

    private func delete(id: String) {
        Task { @MainActor in
            let previous = state.appointments
            state.appointments.removeAll { $0.id == id }
            do {
                try await useCase.deletePlatformUserPlaces(ids: [id])
                state.snackbar = "Successfully deleted"
            } catch {
                state.appointments = previous
                state.snackbar = "Failed to delete"
            }
        }
    }

    func consumeSnackbar() { state.snackbar = nil }
}
