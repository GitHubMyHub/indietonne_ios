//
//  ImageRepositoryImpl.swift
//  apple
//
//  URLSession-basierte Implementierung. Äquivalent zu Android `PictureRepositoryImpl.kt`.
//

import Foundation

final class ImageRepositoryImpl: ImageRepositoryProtocol {
    private let session: URLSession
    private let baseURL: URL

    init(session: URLSession = .shared, baseURL: URL = Constants.basePictureServiceURL) {
        self.session = session
        self.baseURL = baseURL
    }

    func fetchImage(storedName: String) async throws -> Data {
        let url = baseURL.appending(path: storedName)
        let (data, response) = try await session.data(from: url)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return data
    }
}
