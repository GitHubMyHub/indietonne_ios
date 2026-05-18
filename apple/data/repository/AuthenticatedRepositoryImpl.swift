//
//  AuthenticatedRepositoryImpl.swift
//  apple
//
//  Apollo-basierte Implementation der `AuthenticatedApi` (mit Bearer-Token).
//

import Foundation
import Apollo
import ApolloAPI

final class AuthenticatedRepositoryImpl: AuthenticatedApi {
    private let apollo: ApolloClient

    init(apollo: ApolloClient) {
        self.apollo = apollo
    }

    // MARK: Places

    func places(pagination: PaginationInput) async throws -> [PlaceDTO] {
        let query = InDieTonneAPI.PlacesQuery(
            pagination: InDieTonneAPI.PaginationInput(
                page: .some(Int32(pagination.page)),
                size: .some(Int32(pagination.size))
            )
        )
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "places")
        return result.data?.places.content.map { $0.toDTO() } ?? []
    }

    func place(placeId: String) async throws -> PlaceDTO? {
        let query = InDieTonneAPI.PlaceDetailsQuery(placeId: placeId)
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "place")
        return result.data?.place.toDTO()
    }

    // MARK: Streets

    func streets(pagination: PaginationInput, search: String) async throws -> [StreetDTO] {
        let query = InDieTonneAPI.FindStreetsQuery(
            pagination: InDieTonneAPI.PaginationInput(
                page: .some(Int32(pagination.page)),
                size: .some(Int32(pagination.size))
            ),
            search: search
        )
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "findStreets")
        return result.data?.findStreets.content.map { StreetDTO(id: $0.id, name: $0.name) } ?? []
    }

    // MARK: Districts

    func districts(pagination: PaginationInput, placeId: String?) async throws -> [DistrictDTO] {
        let query = InDieTonneAPI.DistrictsQuery(
            pagination: InDieTonneAPI.PaginationInput(
                page: .some(Int32(pagination.page)),
                size: .some(Int32(pagination.size))
            ),
            placeId: placeId.map { .some($0) } ?? .none
        )
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "districts")
        return result.data?.districts.content.map {
            DistrictDTO(id: $0.id, name: $0.name ?? $0.id)
        } ?? []
    }

    // MARK: Appointments

    func appointments(pagination: PaginationInput) async throws -> [AppointmentGroupDTO] {
        let query = InDieTonneAPI.AppointmentsQuery(
            pagination: InDieTonneAPI.PaginationInput(
                page: .some(Int32(pagination.page)),
                size: .some(Int32(pagination.size))
            )
        )
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "appointments")
        let mapped = result.data?.appointments.content.map { $0.toGroupDTO() } ?? []
        #if DEBUG
        print("[Apollo] appointments → \(mapped.count) groups (totalElements=\(result.data?.appointments.totalElements ?? 0))")
        #endif
        return mapped
    }

    func scheduleAppointment(input: ScheduleAppointmentInput) async throws {
        let mutation = InDieTonneAPI.ScheduleAppointmentMutation(
            scheduleAppointment: InDieTonneAPI.ScheduleDataInput(
                placeId: input.placeId,
                streetId: input.streetId,
                previousDays: Int32(input.previousDays),
                time: input.time,
                fractions: input.fractionIds
            )
        )
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "scheduleAppointment")
    }

    func deletePlatformUserPlaces(ids: [String]) async throws {
        let mutation = InDieTonneAPI.DeletePlatformUserPlacesMutation(
            platformUserPlaceIds: ids
        )
        let result = try await apollo.perform(mutation: mutation)
        try throwIfErrors(result.errors, op: "deletePlatformUserPlaces")
    }

    // MARK: Current User

    func currentUser() async throws -> CurrentUserDTO? {
        let query = InDieTonneAPI.CurrentUserQuery()
        let result = try await apollo.fetch(query: query, cachePolicy: .networkOnly)
        try throwIfErrors(result.errors, op: "currentUser")
        guard let first = result.data?.users.content.first else { return nil }
        let devices = first.devices.map {
            DeviceDTO(id: $0.id, agent: $0.agent,
                      createdAt: parseInstant($0.createdAt),
                      updatedAt: $0.updatedAt.flatMap { parseInstant($0) })
        }
        return CurrentUserDTO(id: first.id, username: first.username, devices: devices)
    }

    func currentUserAPNsToken(_ token: String) async throws {
        // No mutation in schema for this yet – no-op
    }
}

// MARK: - Helpers

private func throwIfErrors(_ errors: [GraphQLError]?, op: String) throws {
    guard let errors, !errors.isEmpty else { return }
    #if DEBUG
    print("[Apollo] \(op) GraphQL errors:", errors.map(\.message))
    #endif
    throw APIError.graphQLErrors(errors)
}

// MARK: - Mapping helpers

nonisolated private func parseInstant(_ value: String) -> Date {
    // ISO 8601 instant e.g. "2024-03-15T12:00:00Z" or "2024-03-15T12:00:00.123Z"
    let withFrac = ISO8601DateFormatter()
    withFrac.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    if let d = withFrac.date(from: value) { return d }
    let plain = ISO8601DateFormatter()
    plain.formatOptions = [.withInternetDateTime]
    return plain.date(from: value) ?? Date(timeIntervalSince1970: 0)
}

private extension InDieTonneAPI.PlacesQuery.Data.Places.Content {
    nonisolated func toDTO() -> PlaceDTO {
        PlaceDTO(
            id: id,
            name: name,
            zipCodes: zipCodes,
            images: images.map { ImageDTO(storedName: $0.storedName ?? "", origin: $0.origin.toAppOrigin()) },
            fractions: fractions.map { FractionDTO(id: $0.id, name: $0.name, icon: $0.icon) }
        )
    }
}

private extension InDieTonneAPI.PlaceDetailsQuery.Data.Place {
    nonisolated func toDTO() -> PlaceDTO {
        PlaceDTO(
            id: id,
            name: name,
            zipCodes: zipCodes,
            images: images.map { ImageDTO(storedName: $0.storedName ?? "", origin: $0.origin.toAppOrigin()) },
            fractions: fractions.map { FractionDTO(id: $0.id, name: $0.name, icon: $0.icon) }
        )
    }
}

private extension InDieTonneAPI.AppointmentsQuery.Data.Appointments.Content {
    nonisolated func toGroupDTO() -> AppointmentGroupDTO {
        AppointmentGroupDTO(
            id: id,
            reminderAlarm: nil,
            reminderNotify: nil,
            appointments: appointments.map {
                AppointmentDTO(
                    id: $0.id,
                    appointmentDate: parseInstant($0.appointmentDate),
                    scheduledDate: parseInstant($0.scheduledDate),
                    interval: $0.interval,
                    repetition: $0.repetition,
                    alarm: $0.alarm,
                    notify: $0.notify,
                    active: $0.active,
                    fractions: $0.fractions.map { FractionDTO(id: $0.id, name: $0.name, icon: $0.icon) }
                )
            },
            street: StreetDTO(id: street.id, name: street.name),
            place: PlaceDTO(
                id: place.id,
                name: place.name,
                zipCodes: place.zipCodes,
                images: place.images.map { ImageDTO(storedName: $0.storedName ?? "", origin: $0.origin.toAppOrigin()) },
                fractions: []
            )
        )
    }
}

private extension GraphQLEnum<InDieTonneAPI.Origin> {
    nonisolated func toAppOrigin() -> ImageOrigin {
        switch self {
        case .case(.placeLogo): return .placeLogo
        case .case(.placeBanner): return .placeBanner
        default: return .other
        }
    }
}
