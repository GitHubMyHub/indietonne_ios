//
//  AuthenticatedRepositoryImpl.swift
//  apple
//
//  Apollo-basierte Implementation der `AuthenticatedApi` (mit Bearer-Token).
//  Mock-Fallback solange Apollo nicht eingebunden ist.
//

import Foundation

#if canImport(Apollo) && canImport(ApolloAPI) && canImport(IndieTonneAPI)
import Apollo
import ApolloAPI
import IndieTonneAPI

final class AuthenticatedRepositoryImpl: AuthenticatedApi {
    private let apollo: ApolloClient

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }

    func places(pagination: PaginationInput) async throws -> [PlaceDTO] {
        fatalError("TODO: PlacesQuery ausführen + Mapping in PlaceDTO")
    }
    func streets(pagination: PaginationInput, search: String) async throws -> [StreetDTO] { fatalError("TODO") }
    func districts(pagination: PaginationInput, placeId: String?) async throws -> [DistrictDTO] { fatalError("TODO") }
    func appointments(pagination: PaginationInput) async throws -> [AppointmentGroupDTO] { fatalError("TODO") }
    func scheduleAppointment(input: ScheduleAppointmentInput) async throws { fatalError("TODO") }
    func deletePlatformUserPlaces(ids: [String]) async throws { fatalError("TODO") }
    func place(placeId: String) async throws -> PlaceDTO? { fatalError("TODO") }
    func currentUser() async throws -> CurrentUserDTO? { fatalError("TODO") }
    func currentUserAPNsToken(_ token: String) async throws {
        fatalError("TODO: Devices-Mutation senden")
    }
}

#else

final class AuthenticatedRepositoryImpl: AuthenticatedApi {
    init() {}

    private static let mockFractions: [FractionDTO] = [
        FractionDTO(id: "f-rest",  name: "Restabfall",  icon: "trashcan=4b4b4b"),
        FractionDTO(id: "f-paper", name: "Papiertonne", icon: "trashcan=2b6cb0"),
        FractionDTO(id: "f-bio",   name: "Biotonne",    icon: "trashcan=219e4e"),
        FractionDTO(id: "f-yellow", name: "Gelber Sack", icon: "trashcan=f6be12"),
    ]

    func places(pagination: PaginationInput) async throws -> [PlaceDTO] {
        try await Task.sleep(nanoseconds: 300_000_000)
        return [
            PlaceDTO(id: "p1", name: "Köln",        zipCodes: ["50667"], images: [], fractions: Self.mockFractions),
            PlaceDTO(id: "p2", name: "Düsseldorf",  zipCodes: ["40213"], images: [], fractions: Self.mockFractions),
            PlaceDTO(id: "p3", name: "Bonn",        zipCodes: ["53111"], images: [], fractions: Self.mockFractions),
            PlaceDTO(id: "p4", name: "Rietberg",    zipCodes: ["33397"], images: [], fractions: Self.mockFractions),
            PlaceDTO(id: "p5", name: "Aachen",      zipCodes: ["52062"], images: [], fractions: Self.mockFractions),
        ]
    }

    func streets(pagination: PaginationInput, search: String) async throws -> [StreetDTO] {
        try await Task.sleep(nanoseconds: 200_000_000)
        let base: [StreetDTO] = [
            StreetDTO(id: "s1", name: "Hauptstraße"),
            StreetDTO(id: "s2", name: "Ringstraße"),
            StreetDTO(id: "s3", name: "Bahnhofstraße"),
            StreetDTO(id: "s4", name: "Schulstraße"),
            StreetDTO(id: "s5", name: "Kirchweg"),
        ]
        if search.isEmpty { return base }
        return base.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    func districts(pagination: PaginationInput, placeId: String?) async throws -> [DistrictDTO] { [] }

    func appointments(pagination: PaginationInput) async throws -> [AppointmentGroupDTO] {
        try await Task.sleep(nanoseconds: 300_000_000)
        let now = Date()
        return [
            AppointmentGroupDTO(
                id: "g1",
                reminderAlarm: now,
                reminderNotify: now,
                appointments: [
                    AppointmentDTO(
                        id: "a1",
                        appointmentDate: now.addingTimeInterval(86_400 * 2),
                        scheduledDate: now.addingTimeInterval(86_400 * 2 - 3_600 * 6),
                        interval: 1, repetition: 1, alarm: true, notify: true, active: true,
                        fractions: [Self.mockFractions[2]]
                    ),
                    AppointmentDTO(
                        id: "a2",
                        appointmentDate: now.addingTimeInterval(86_400 * 9),
                        scheduledDate: now.addingTimeInterval(86_400 * 9 - 3_600 * 6),
                        interval: 1, repetition: 1, alarm: true, notify: true, active: true,
                        fractions: [Self.mockFractions[3]]
                    )
                ],
                street: StreetDTO(id: "s2", name: "Ringstraße"),
                place: PlaceDTO(id: "p4", name: "Rietberg", zipCodes: ["33397"], images: [], fractions: [])
            )
        ]
    }

    func scheduleAppointment(input: ScheduleAppointmentInput) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    func deletePlatformUserPlaces(ids: [String]) async throws {
        try await Task.sleep(nanoseconds: 200_000_000)
    }

    func place(placeId: String) async throws -> PlaceDTO? {
        try await Task.sleep(nanoseconds: 150_000_000)
        return PlaceDTO(id: placeId, name: "Mock Place", zipCodes: ["00000"], images: [], fractions: Self.mockFractions)
    }

    func currentUser() async throws -> CurrentUserDTO? {
        try await Task.sleep(nanoseconds: 200_000_000)
        return CurrentUserDTO(
            id: "user-1",
            username: "admin@admin.de",
            devices: [
                DeviceDTO(id: "d1", agent: "iPhone 16 Pro", createdAt: Date(), updatedAt: nil)
            ]
        )
    }

    func currentUserAPNsToken(_ token: String) async throws {
        try await Task.sleep(nanoseconds: 100_000_000)
    }
}

#endif
