//
//  ImageRepositoryProtocol.swift
//  apple
//
//  Protocol für den Bild-Service (Picture API).
//  Äquivalent zu Android `data/remote/ImageRepository.kt` + `PictureApi.kt`.
//

import Foundation

protocol ImageRepositoryProtocol: Sendable {
    /// Lädt ein Bild über den Picture-Service.
    /// - Parameter storedName: Der `storedName` aus dem Place/Appointment-Payload.
    /// - Returns: Rohdaten des Bildes (typischerweise JPEG).
    func fetchImage(storedName: String) async throws -> Data
}
