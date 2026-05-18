//
//  ProfileState.swift
//

import Foundation

struct ProfileState {
    var isLoading: Bool = false
    var user: CurrentUserDTO? = nil
    var error: String = ""
}
