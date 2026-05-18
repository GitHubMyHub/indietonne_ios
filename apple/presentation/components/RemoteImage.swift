//
//  RemoteImage.swift
//  apple
//
//  Async-Image-Loader, der den ImageRepository-Stack benutzt
//  (Picture-Microservice). Äquivalent zu Android `GlideImage`.
//  Verwendet `Resource<UIImage>` als State, analog zur Android
//  `presentation/notification/ImageState.kt`.
//

import SwiftUI
import UIKit

@Observable
@MainActor
final class RemoteImageLoader {
    private let useCase: GetImageUseCase
    var state: Resource<UIImage> = .loading

    init(useCase: GetImageUseCase) {
        self.useCase = useCase
    }

    func load(storedName: String) {
        Task { @MainActor in
            state = .loading
            do {
                let data = try await useCase.execute(storedName: storedName)
                if let img = UIImage(data: data) {
                    state = .success(img)
                } else {
                    state = .error("Invalid image data")
                }
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}

struct RemoteImage<Placeholder: View>: View {
    let storedName: String
    @ViewBuilder var placeholder: () -> Placeholder

    @Environment(AppEnvironment.self) private var env
    @State private var loader: RemoteImageLoader?

    var body: some View {
        Group {
            switch loader?.state ?? .loading {
            case .success(let img):
                Image(uiImage: img)
                    .resizable()
            case .loading:
                placeholder().redacted(reason: .placeholder)
            case .error:
                placeholder()
            }
        }
        .task(id: storedName) {
            if loader == nil {
                loader = RemoteImageLoader(useCase: env.getImageUseCase)
            }
            guard !storedName.isEmpty else { return }
            loader?.load(storedName: storedName)
        }
    }
}
