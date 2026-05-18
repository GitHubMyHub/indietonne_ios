//
//  RegisterPage.swift
//
//  Mirror of Android `presentation/register/RegisterPage.kt`.
//

import SwiftUI

struct RegisterPage: View {
    @Environment(AppEnvironment.self) private var env
    @Environment(TokenStore.self) private var tokenStore
    @Binding var path: NavigationPath

    @State private var viewModel: RegisterViewModel?
    @State private var email: String = "admin2@admin.de"
    @State private var password: String = "admin"
    @State private var confirmPassword: String = "admin"
    @State private var passwordVisible: Bool = false
    @State private var confirmVisible: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {
            LinearGradient(
                colors: [Color.primaryBrand.opacity(0.8), Color.secondaryBrand.opacity(0.4)],
                startPoint: .top, endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(maxHeight: 120)
                surface
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            if viewModel == nil {
                viewModel = RegisterViewModel(useCase: env.postRegisterUseCase)
            }
        }
        .onChange(of: viewModel?.state.token) { _, newToken in
            guard let token = newToken, !token.isEmpty else { return }
            tokenStore.setToken(token)
            env.tokenDidChange()
            path = NavigationPath()
            path.append(AppRoute.scheduleOverview)
        }
    }

    private var surface: some View {
        VStack(spacing: 16) {
            Text("Sign Up")
                .font(.system(size: 30, weight: .bold))
                .kerning(2)
                .padding(.top, 32)

            TextField("Email Address", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            secureField($password, placeholder: "Password", visible: $passwordVisible)
            secureField($confirmPassword, placeholder: "Confirm Password", visible: $confirmVisible)

            Button {
                viewModel?.signUp(email: email, password: password)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color.primaryBrand)
                        .frame(height: 50)
                    if viewModel?.state.isLoading == true {
                        ProgressView().tint(.white)
                    } else {
                        Text("Sign Up").font(.title3.weight(.semibold)).foregroundStyle(.white)
                    }
                }
            }
            .disabled(viewModel?.state.isLoading == true || password != confirmPassword)
            .padding(.top, 8)

            if let msg = viewModel?.state.error, !msg.isEmpty {
                Text(msg).foregroundStyle(.red).font(.callout)
            }

            Button("Login Instead") {
                path = NavigationPath()
                path.append(AppRoute.login)
            }
            .padding(.top, 12)

            Spacer()
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(
                cornerRadii: .init(topLeading: 30, topTrailing: 30)
            )
            .fill(Color(uiColor: .systemBackground))
        )
        .frame(maxHeight: .infinity, alignment: .bottom)
    }

    @ViewBuilder
    private func secureField(_ text: Binding<String>, placeholder: String, visible: Binding<Bool>) -> some View {
        HStack {
            Group {
                if visible.wrappedValue {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()

            Button {
                visible.wrappedValue.toggle()
            } label: {
                Image(systemName: visible.wrappedValue ? "eye.slash" : "eye")
                    .foregroundStyle(visible.wrappedValue ? Color.primaryBrand : .secondary)
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.3))
        )
    }
}
