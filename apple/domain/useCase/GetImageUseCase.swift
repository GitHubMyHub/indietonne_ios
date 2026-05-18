//
//  GetImageUseCase.swift
//  apple
//

import Foundation

struct GetImageUseCase: Sendable {
    private let repo: ImageRepositoryProtocol

    init(repo: ImageRepositoryProtocol) {
        self.repo = repo
    }

    func execute(storedName: String) async throws -> Data {
        try await repo.fetchImage(storedName: storedName)
    }
}
