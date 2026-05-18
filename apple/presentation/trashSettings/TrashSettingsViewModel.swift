//
//  TrashSettingsViewModel.swift
//

import Foundation
import Observation

@Observable
@MainActor
final class TrashSettingsViewModel {
    private let useCase: GetAppointmentsUseCase
    private(set) var placeState = PlaceSettingsState()
    private(set) var appointmentState = AppointmentSettingsState()

    init(useCase: GetAppointmentsUseCase) {
        self.useCase = useCase
    }

    func loadPlace(id: String) {
        Task { @MainActor in
            placeState.isLoading = true
            do {
                placeState.place = try await useCase.place(id: id)
                placeState.isLoading = false
            } catch {
                placeState.error = error.localizedDescription
                placeState.isLoading = false
            }
        }
    }

    func schedule(input: ScheduleAppointmentInput) {
        Task { @MainActor in
            appointmentState.isSaving = true
            appointmentState.error = ""
            do {
                try await useCase.scheduleAppointment(input)
                appointmentState.didSchedule = true
                appointmentState.isSaving = false
            } catch {
                appointmentState.error = error.localizedDescription
                appointmentState.isSaving = false
            }
        }
    }
}
