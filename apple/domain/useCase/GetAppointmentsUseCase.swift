//
//  GetAppointmentsUseCase.swift
//  apple
//
//  Sammel-UseCase für alle authentifizierten Daten-Abfragen.
//  Äquivalent zu Android `GetAppointmentsUseCase.kt`.
//

import Foundation

struct GetAppointmentsUseCase: Sendable {
    private let api: AuthenticatedApi

    init(api: AuthenticatedApi) {
        self.api = api
    }

    func places(page: Int = 0, size: Int = 20) async throws -> [PlaceDTO] {
        try await api.places(pagination: PaginationInput(page: page, size: size))
    }

    func streets(search: String, page: Int = 0, size: Int = 20) async throws -> [StreetDTO] {
        try await api.streets(pagination: PaginationInput(page: page, size: size), search: search)
    }

    func appointments(page: Int = 0, size: Int = 20) async throws -> [AppointmentGroupDTO] {
        try await api.appointments(pagination: PaginationInput(page: page, size: size))
    }

    func scheduleAppointment(_ input: ScheduleAppointmentInput) async throws {
        try await api.scheduleAppointment(input: input)
    }

    func place(id: String) async throws -> PlaceDTO? {
        try await api.place(placeId: id)
    }

    func deletePlatformUserPlaces(ids: [String]) async throws {
        try await api.deletePlatformUserPlaces(ids: ids)
    }

    func currentUser() async throws -> CurrentUserDTO? {
        try await api.currentUser()
    }
}
