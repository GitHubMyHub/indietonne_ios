//
//  AppointmentListState.swift
//

import Foundation

struct AppointmentListState {
    var isLoading: Bool = false
    var isRefreshing: Bool = false
    var appointments: [AppointmentGroupDTO] = []
    var error: String = ""
    var snackbar: String? = nil
}
