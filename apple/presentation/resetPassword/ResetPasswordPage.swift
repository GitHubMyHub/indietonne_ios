//
//  ResetPasswordPage.swift
//

import SwiftUI
import Observation

struct ResetPasswordState {
    var isLoading: Bool = false
    var message: String = ""
    var isSuccess: Bool = false
    var error: String = ""
}

@Observable
@MainActor
final class ResetPasswordViewModel {
    private let useCase: ResetPasswordUseCase
    private(set) var state = ResetPasswordState()

    init(useCase: ResetPasswordUseCase) { self.useCase = useCase }

    func reset(token: String, newPassword: String) {
        Task { @MainActor in
            state.isLoading = true; state.error = ""; state.isSuccess = false
            do {
                state.message = try await useCase.execute(token: token, newPassword: newPassword)
                state.isSuccess = true
            } catch {
                state.error = error.localizedDescription
            }
            state.isLoading = false
        }
    }
}

struct ResetPasswordPage: View {
    @Environment(AppEnvironment.self) private var env
    @Binding var path: NavigationPath
    let token: String

    @State private var viewModel: ResetPasswordViewModel?
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Reset Password").font(.title.bold())
            SecureField("New Password", text: $password).textFieldStyle(.roundedBorder)
            SecureField("Confirm Password", text: $confirmPassword).textFieldStyle(.roundedBorder)
            if !confirmPassword.isEmpty && password != confirmPassword {
                Text("Passwords don't match").foregroundStyle(.red).font(.caption)
            }
            Button {
                viewModel?.reset(token: token, newPassword: password)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.primaryBrand).frame(height: 50)
                    if viewModel?.state.isLoading == true {
                        ProgressView().tint(.white)
                    } else {
                        Text("Reset Password").foregroundStyle(.white).font(.title3.weight(.semibold))
                    }
                }
            }
            .disabled(!canSubmit)

            if viewModel?.state.isSuccess == true {
                Text(viewModel?.state.message ?? "Password reset! Redirecting…")
                    .foregroundStyle(Color.primaryBrand)
            }
            if let err = viewModel?.state.error, !err.isEmpty {
                Text(err).foregroundStyle(.red)
            }
            Spacer()
        }
        .padding(24)
        .navigationTitle("Reset Password")
        .task {
            if viewModel == nil {
                viewModel = ResetPasswordViewModel(useCase: env.resetPasswordUseCase)
            }
        }
        .onChange(of: viewModel?.state.isSuccess) { _, success in
            guard success == true else { return }
            Task {
                try? await Task.sleep(nanoseconds: 1_500_000_000)
                path = NavigationPath()
                path.append(AppRoute.login)
            }
        }
    }

    private var canSubmit: Bool {
        !(viewModel?.state.isLoading ?? false)
            && password.count >= 6
            && password == confirmPassword
            && !token.isEmpty
    }
}
