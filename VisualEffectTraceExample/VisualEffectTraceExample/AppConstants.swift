//
//  AppConstants.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

struct AppConstants {

    // このアプリの「Bundle Indentifier」名
    static let bundleIdentifier = Bundle.main.bundleIdentifier!

    // keychainAccessのKey名
    static let keychainAccessKeyName = "jsonAccessToken"

    // JWTのprefix名
    static let jwtTokenPrefix = "Bearer "
}
