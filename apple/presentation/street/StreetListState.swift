//
//  StreetListState.swift
//

import Foundation

struct StreetListState {
    var isLoading: Bool = false
    var streets: [StreetDTO] = []
    var error: String = ""
}
