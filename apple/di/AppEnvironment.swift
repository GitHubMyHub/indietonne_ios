//
//  AppEnvironment.swift
//  apple
//
//  Zentraler Service-Container.
//

import Foundation
import SwiftUI
import Observation

@Observable
@MainActor
final class AppEnvironment {
    // Infrastructure
    let keychain: KeychainServicing
    let tokenStore: TokenStore
    let deviceInfo: DeviceInfoServicing
    let apolloProvider: ApolloClientProvider

    // Data layer
    let authApi: AuthenticationApi
    let authenticatedApi: AuthenticatedApi
    let imageRepository: ImageRepositoryProtocol

    // Domain layer (UseCases)
    let postLoginUseCase: PostLoginUseCase
    let postRegisterUseCase: PostRegisterUseCase
    let getAppointmentsUseCase: GetAppointmentsUseCase
    let getImageUseCase: GetImageUseCase
    let requestPasswordResetUseCase: RequestPasswordResetUseCase
    let resetPasswordUseCase: ResetPasswordUseCase
    let verifyEmailUseCase: VerifyEmailUseCase
    let resendVerificationUseCase: ResendVerificationUseCase

    init() {
        let keychain = KeychainService()
        let tokenStore = TokenStore(keychain: keychain)
        let deviceInfo = DeviceInfoService()
        let apollo = ApolloClientProvider(tokenStore: tokenStore)

        // Sync initial token into TokenBox
        apollo.tokenBox.token = tokenStore.token

        let authApi: AuthenticationApi = AuthRepositoryImpl(
            apollo: apollo.unauthenticated,
            deviceInfo: deviceInfo
        )
        let authenticatedApi: AuthenticatedApi = AuthenticatedRepositoryImpl(
            apollo: apollo.authenticated
        )
        let imageRepository: ImageRepositoryProtocol = ImageRepositoryImpl()

        self.keychain = keychain
        self.tokenStore = tokenStore
        self.deviceInfo = deviceInfo
        self.apolloProvider = apollo

        self.authApi = authApi
        self.authenticatedApi = authenticatedApi
        self.imageRepository = imageRepository

        self.postLoginUseCase = PostLoginUseCase(api: authApi)
        self.postRegisterUseCase = PostRegisterUseCase(api: authApi)
        self.getAppointmentsUseCase = GetAppointmentsUseCase(api: authenticatedApi)
        self.getImageUseCase = GetImageUseCase(repo: imageRepository)
        self.requestPasswordResetUseCase = RequestPasswordResetUseCase(api: authApi)
        self.resetPasswordUseCase = ResetPasswordUseCase(api: authApi)
        self.verifyEmailUseCase = VerifyEmailUseCase(api: authApi)
        self.resendVerificationUseCase = ResendVerificationUseCase(api: authApi)
    }

    /// Call after login/logout to sync the JWT token into the Apollo interceptor.
    func tokenDidChange() {
        apolloProvider.syncToken()
    }
}
