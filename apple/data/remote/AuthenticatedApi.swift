//
//  AuthenticatedApi.swift
//  apple
//
//  Protocol für authentifizierte Endpunkte (Places, Streets, Appointments, ...).
//  Äquivalent zu Android `data/remote/MyApiAuthenticated.kt`.
//

import Foundation

// MARK: - Domain-Modelle (vereinfacht, später durch Apollo-generierte Modelle ersetzbar)

struct PaginationInput: Codable, Sendable {
    let page: Int
    let size: Int
}

/// Image-Origin (matches `Origin` GraphQL Enum).
enum ImageOrigin: String, Sendable, Codable {
    case placeLogo = "PLACE_LOGO"
    case placeBanner = "PLACE_BANNER"
    case fractionIcon = "FRACTION_ICON"
    case other = "OTHER"
}

struct ImageDTO: Hashable, Sendable, Codable {
    let storedName: String
    let origin: ImageOrigin
}

struct PlaceDTO: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let zipCodes: [String]
    let images: [ImageDTO]
    let fractions: [FractionDTO]

    init(id: String,
         name: String,
         zipCodes: [String] = [],
         images: [ImageDTO] = [],
         fractions: [FractionDTO] = []) {
        self.id = id
        self.name = name
        self.zipCodes = zipCodes
        self.images = images
        self.fractions = fractions
    }
}

struct StreetDTO: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
}

struct DistrictDTO: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
}

struct FractionDTO: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let icon: String?
}

struct AppointmentDTO: Identifiable, Hashable, Sendable {
    let id: String
    let appointmentDate: Date
    let scheduledDate: Date?
    let interval: Int?
    let repetition: Int?
    let alarm: Bool
    let notify: Bool
    let active: Bool
    let fractions: [FractionDTO]
}

struct AppointmentGroupDTO: Identifiable, Hashable, Sendable {
    let id: String
    let reminderAlarm: Date?
    let reminderNotify: Date?
    let appointments: [AppointmentDTO]
    let street: StreetDTO?
    let place: PlaceDTO?
}

struct ScheduleAppointmentInput: Codable, Sendable {
    let placeId: String
    let streetId: String
    let fractionIds: [String]
    let previousDays: Int
    let time: String           // "HH:mm"
    let alarm: Bool
    let notify: Bool
}

struct DeviceDTO: Identifiable, Hashable, Sendable {
    let id: String
    let agent: String
    let createdAt: Date
    let updatedAt: Date?
}

struct CurrentUserDTO: Identifiable, Hashable, Sendable {
    let id: String
    let username: String
    let devices: [DeviceDTO]
}

// MARK: - API

protocol AuthenticatedApi: Sendable {
    func places(pagination: PaginationInput) async throws -> [PlaceDTO]
    func streets(pagination: PaginationInput, search: String) async throws -> [StreetDTO]
    func districts(pagination: PaginationInput, placeId: String?) async throws -> [DistrictDTO]
    func appointments(pagination: PaginationInput) async throws -> [AppointmentGroupDTO]
    func scheduleAppointment(input: ScheduleAppointmentInput) async throws
    func deletePlatformUserPlaces(ids: [String]) async throws
    func place(placeId: String) async throws -> PlaceDTO?
    func currentUser() async throws -> CurrentUserDTO?
    func currentUserAPNsToken(_ token: String) async throws
}
