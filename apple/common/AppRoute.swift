//
//  AppRoute.swift
//  apple
//
//  Typsichere Navigations-Routen für NavigationStack.
//  Äquivalent zu Android `common/Screen.kt`.
//

import Foundation

enum AppRoute: Hashable {
    case login
    case register
    case places
    case streets(placeId: String)
    case trashSettings(placeId: String, streetId: String)
    case scheduleOverview
    case scheduleList(appointmentId: String)
    case profile
    case forgotPassword
    case resetPassword(token: String)
    case verifyEmail(token: String)
    case resendVerification
}
