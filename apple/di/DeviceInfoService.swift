//
//  DeviceInfoService.swift
//  apple
//
//  Liest Geräteinformationen aus. Äquivalent zu Android `DeviceInfoModule`.
//

import Foundation
import UIKit

struct DeviceInfo: Sendable {
    let model: String
    let systemName: String
    let systemVersion: String
    let identifierForVendor: String?
    let appVersion: String
    let appBuild: String
}

protocol DeviceInfoServicing {
    var current: DeviceInfo { get }
}

final class DeviceInfoService: DeviceInfoServicing {
    var current: DeviceInfo {
        let device = UIDevice.current
        let info = Bundle.main.infoDictionary
        return DeviceInfo(
            model: device.model,
            systemName: device.systemName,
            systemVersion: device.systemVersion,
            identifierForVendor: device.identifierForVendor?.uuidString,
            appVersion: info?["CFBundleShortVersionString"] as? String ?? "",
            appBuild: info?["CFBundleVersion"] as? String ?? ""
        )
    }
}
