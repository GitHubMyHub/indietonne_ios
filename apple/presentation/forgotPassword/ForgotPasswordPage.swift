//
//  ForgotPasswordState.swift / ViewModel / Page – Single file.
//

import SwiftUI
import Observation

struct ForgotPasswordState {
    var isLoading: Bool = false
    var message: String = ""
    var isSuccess: Bool = false
    var error: String = ""
}

@Observable
@MainActor
final class ForgotPasswordViewModel {
    private let useCase: RequestPasswordResetUseCase
    private(set) var state = ForgotPasswordState()

    init(useCase: RequestPasswordResetUseCase) { self.useCase = useCase }

    func requestReset(email: String) {
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

struct ForgotPasswordPage: View {
    @Environment(AppEnvironment.self) private var env
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ForgotPasswordViewModel?
    @State private var email: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Forgot Password").font(.title.bold())
            Text("Enter your email address and we'll send you a link to reset your password.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            TextField("Email Address", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            Button {
                viewModel?.requestReset(email: email)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.primaryBrand).frame(height: 50)
                    if viewModel?.state.isLoading == true {
                        ProgressView().tint(.white)
                    } else {
                        Text("Send Reset Link").foregroundStyle(.white).font(.title3.weight(.semibold))
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
        .navigationTitle("Forgot Password")
        .task {
            if viewModel == nil {
                viewModel = ForgotPasswordViewModel(useCase: env.requestPasswordResetUseCase)
            }
        }
    }
}
