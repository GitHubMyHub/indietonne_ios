//
//  LoginPage.swift
//  apple
//
//  Mirror of Android `presentation/login/LoginPage.kt`.
//

import SwiftUI

struct LoginPage: View {
    @Environment(AppEnvironment.self) private var env
    @Environment(TokenStore.self) private var tokenStore
    @Binding var path: NavigationPath

    @State private var viewModel: LoginViewModel?
    @State private var email: String = "admin@admin.de"
    @State private var password: String = "admin"
    @State private var passwordVisible: Bool = false
    @FocusState private var passwordFocused: Bool

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "trash.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 220)
                    .foregroundStyle(Color.primaryBrand)
                    .padding(.top, 32)

                Text("Sign In")
                    .font(.system(size: 30, weight: .bold))
                    .kerning(2)

                VStack(spacing: 12) {
                    TextField("Email Address", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)

                    HStack {
                        Group {
                            if passwordVisible {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        .focused($passwordFocused)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                        Button {
                            passwordVisible.toggle()
                        } label: {
                            Image(systemName: passwordVisible ? "eye.slash" : "eye")
                                .foregroundStyle(passwordVisible ? Color.primaryBrand : .secondary)
                        }
                    }
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.secondary.opacity(0.3))
                    )

                    HStack {
                        Spacer()
                        Button("Forgot password?") {
                            path.append(AppRoute.forgotPassword)
                        }
                        .foregroundStyle(Color.primaryBrand)
                        .font(.callout)
                    }

                    Button {
                        viewModel?.login(email: email, password: password)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.primaryBrand)
                                .frame(height: 50)
                            if viewModel?.state.isLoading == true {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                            } else {
                                Text("Sign In")
                                    .font(.title3.weight(.semibold))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .disabled(viewModel?.state.isLoading == true)
                    .padding(.top, 6)

                    if let msg = viewModel?.state.error, !msg.isEmpty {
                        Text(msg).foregroundStyle(.red).font(.callout)
                    }
                }
                .padding(.horizontal, 32)

                VStack(spacing: 12) {
                    Button("Create An Account") {
                        path.append(AppRoute.register)
                    }
                    .foregroundStyle(.primary)

                    Button("Resend verification email") {
                        path.append(AppRoute.resendVerification)
                    }
                    .foregroundStyle(Color.primaryBrand)
                }
                .padding(.vertical, 20)

                Spacer(minLength: 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            if viewModel == nil {
                viewModel = LoginViewModel(useCase: env.postLoginUseCase)
            }
        }
        .onChange(of: viewModel?.state.token) { _, newToken in
            guard let token = newToken, !token.isEmpty else { return }
            tokenStore.setToken(token)
            env.tokenDidChange()
            // RootView observes tokenStore.isAuthenticated and switches the
            // start destination to ScheduleOverviewPage automatically.
            path = NavigationPath()
        }
    }
}

#Preview {
    @Previewable @State var path = NavigationPath()
    NavigationStack(path: $path) {
        LoginPage(path: $path)
            .environment(AppEnvironment())
            .environment(AppEnvironment().tokenStore)
    }
}
