//
//  Resource.swift
//  apple
//
//  Sealed-class-Äquivalent für asynchrone Operationen.
//  Äquivalent zu Android `common/Resource.kt`.
//

import Foundation

enum Resource<T> {
    case loading
    case success(T)
    case error(String)

    var value: T? {
        if case .success(let v) = self { return v }
        return nil
    }

    var errorMessage: String? {
        if case .error(let msg) = self { return msg }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
}
