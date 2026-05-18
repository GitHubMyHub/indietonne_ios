//
//  PlaceListState.swift
//

import Foundation

struct PlaceListState {
    var isLoading: Bool = false
    var places: [PlaceDTO] = []
    var error: String = ""
}
