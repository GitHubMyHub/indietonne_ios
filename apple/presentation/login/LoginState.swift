//
//  LoginState.swift
//  apple
//
//  Äquivalent zu Android `presentation/login/LoginState.kt`.
//

import Foundation

struct LoginState {
    var isLoading: Bool = false
    var token: String = ""
    var error: String = ""
}
