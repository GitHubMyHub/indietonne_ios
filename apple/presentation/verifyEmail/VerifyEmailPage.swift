//
//  VerifyEmailPage.swift
//

import SwiftUI
import Observation

struct VerifyEmailState {
    var isLoading: Bool = true
    var message: String = ""
    var isSuccess: Bool = false
    var error: String = ""
}

@Observable
@MainActor
final class VerifyEmailViewModel {
    private let useCase: VerifyEmailUseCase
    private(set) var state = VerifyEmailState()

    init(useCase: VerifyEmailUseCase) { self.useCase = useCase }

    func verify(token: String) {
        Task { @MainActor in
            state.isLoading = true; state.error = ""; state.isSuccess = false
            do {
                state.message = try await useCase.execute(token: token)
                state.isSuccess = true
            } catch {
                state.error = error.localizedDescription
            }
            state.isLoading = false
        }
    }
}

struct VerifyEmailPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    let token: String

    @State private var viewModel: VerifyEmailViewModel?

    var body: some View {
        VStack(spacing: 24) {
            Text("Email Verification").font(.title.bold())

            if viewModel?.state.isLoading == true {
                ProgressView(); Text("Verifying your email…")
            } else if viewModel?.state.isSuccess == true {
                Text(viewModel?.state.message ?? "Your email has been verified!")
                    .foregroundStyle(Color.primaryBrand)
                Button {
                    path = NavigationPath()
                    path.append(AppRoute.login)
                } label: {
                    Text("Continue to Login")
                        .font(.title3.weight(.semibold)).foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.primaryBrand, in: .rect(cornerRadius: 10))
                }
            } else if let err = viewModel?.state.error, !err.isEmpty {
                Text(err).foregroundStyle(.red)
                Button("Retry") { viewModel?.verify(token: token) }
                Button("Resend Verification Email") {
                    path.append(AppRoute.resendVerification)
                }
            }
            Spacer()
        }
        .padding(24)
        .task(id: token) {
            if viewModel == nil {
                viewModel = VerifyEmailViewModel(useCase: env.verifyEmailUseCase)
            }
            if !token.isEmpty { viewModel?.verify(token: token) }
        }
    }
}
