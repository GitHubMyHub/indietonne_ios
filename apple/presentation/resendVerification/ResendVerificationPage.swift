//
//  ResendVerificationPage.swift
//

import SwiftUI
import Observation

struct ResendVerificationState {
    var isLoading: Bool = false
    var message: String = ""
    var isSuccess: Bool = false
    var error: String = ""
}

@Observable
@MainActor
final class ResendVerificationViewModel {
    private let useCase: ResendVerificationUseCase
    private(set) var state = ResendVerificationState()

    init(useCase: ResendVerificationUseCase) { self.useCase = useCase }

    func resend(email: String) {
        Task { @MainActor in
            state.isLoading = true; state.error = ""; state.isSuccess = false
            do {
                state.message = try await useCase.execute(email: email)
                state.isSuccess = true
            } catch {
                state.error = error.localizedDescription
            }
            state.isLoading = false
        }
    }
}

struct ResendVerificationPage: View {
    @Environment(AppEnvironment.self) private var env
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ResendVerificationViewModel?
    @State private var email: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Resend Verification").font(.title.bold())
            Text("Enter your email address to receive a new verification link.")
                .multilineTextAlignment(.center).foregroundStyle(.secondary)

            TextField("Email Address", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            Button {
                viewModel?.resend(email: email)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.primaryBrand).frame(height: 50)
                    if viewModel?.state.isLoading == true {
                        ProgressView().tint(.white)
                    } else {
                        Text("Send Verification Email").foregroundStyle(.white).font(.title3.weight(.semibold))
                    }
                }
            }
            .disabled(email.isEmpty || viewModel?.state.isLoading == true)

            if viewModel?.state.isSuccess == true {
                Text(viewModel?.state.message ?? "")
                    .foregroundStyle(Color.primaryBrand)
                Button("Back to Login") { dismiss() }
            }
            if let err = viewModel?.state.error, !err.isEmpty {
                Text(err).foregroundStyle(.red)
            }
            Spacer()
        }
        .padding(24)
        .navigationTitle("Resend Verification")
        .task {
            if viewModel == nil {
                viewModel = ResendVerificationViewModel(useCase: env.resendVerificationUseCase)
            }
        }
    }
}
