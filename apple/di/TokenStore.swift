//
//  TokenStore.swift
//  apple
//
//  Reaktiver Token-Manager. Wraps `KeychainService` und stellt einen
//  beobachtbaren `token`-State bereit.
//  Äquivalent zu Android `AuthTokenModuleViewModel` + `UserPreferences`.
//

import Foundation
import Observation

@Observable
@MainActor
final class TokenStore {
    private static let tokenKey = "jwt_token"
    private static let darkModeDefaultsKey = "user.darkMode"

    private let keychain: KeychainServicing
    private let defaults: UserDefaults
    private(set) var token: String?
    var isDarkMode: Bool? {
        didSet {
            if let v = isDarkMode {
                defaults.set(v, forKey: Self.darkModeDefaultsKey)
            } else {
                defaults.removeObject(forKey: Self.darkModeDefaultsKey)
            }
        }
    }

    var isAuthenticated: Bool { token?.isEmpty == false }

    init(keychain: KeychainServicing, defaults: UserDefaults = .standard) {
        self.keychain = keychain
        self.defaults = defaults
        self.token = keychain.read(forKey: Self.tokenKey)
        self.isDarkMode = defaults.object(forKey: Self.darkModeDefaultsKey) as? Bool
    }

    func setToken(_ value: String) {
        do {
            try keychain.save(value, forKey: Self.tokenKey)
            self.token = value
        } catch {
            // In Produktion via Logger melden
            print("⚠️ TokenStore.setToken failed: \(error)")
        }
    }

    func clear() {
        try? keychain.delete(forKey: Self.tokenKey)
        self.token = nil
    }

    func toggleDarkMode() {
        isDarkMode = !(isDarkMode ?? false)
    }
}
