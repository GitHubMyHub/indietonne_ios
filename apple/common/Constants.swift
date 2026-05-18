//
//  Constants.swift
//  apple
//
//  App-weite Konstanten. Werte werden aus dem App-Bundle Info.plist gelesen,
//  das via .xcconfig pro Build-Konfiguration befüllt wird.
//

import Foundation

enum Constants {
    /// GraphQL-Endpoint (z.B. http://localhost:8080/graphql)
    static let baseURL: URL = {
        let value = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
            ?? "http://localhost:8080/graphql"
        return URL(string: value) ?? URL(string: "http://localhost:8080/graphql")!
    }()

    /// Bild-Service-Basis-URL (z.B. http://localhost:3001/)
    static let basePictureServiceURL: URL = {
        let value = Bundle.main.object(forInfoDictionaryKey: "BASE_PICTURE_SERVICE_URL") as? String
            ?? "http://localhost:3001/"
        return URL(string: value) ?? URL(string: "http://localhost:3001/")!
    }()

    /// Keychain-Service-Identifier
    static let keychainService = "com.indietonne.ios.keychain"

    /// Notification Category Identifier (Äquivalent zum Android Notification Channel)
    static let trashNotificationCategory = "trash_notification_channel"
}
