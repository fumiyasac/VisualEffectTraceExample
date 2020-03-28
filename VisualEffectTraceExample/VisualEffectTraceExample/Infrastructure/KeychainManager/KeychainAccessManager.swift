//
//  KeychainAccessManager.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import KeychainAccess

protocol KeychainAccessProtocol {

    // 新しく取得したJWTの保存処理
    func saveJsonAccessToken(_ token: String)

    // 既に登録されているJWTの削除処理
    func deleteJsonAccessToken()

    // 既に登録されているJWTの存在確認処理
    func existsJsonAccessToken() -> Bool
}

class KeychainAccessManager: KeychainAccessProtocol {

    // MARK: - Singleton Instance

    static let shared = KeychainAccessManager()

    // MARK: - Properies

    private let keyName = AppConstants.keychainAccessKeyName
    private let keychain = Keychain(service: AppConstants.bundleIdentifier)

    // MARK: - Function

    // API管理クラスで利用するJWT文字列を取得する
    func getAuthenticationHeader() -> String {
        if existsJsonAccessToken() {
            return AppConstants.jwtTokenPrefix + keychain[string: keyName]!
        } else {
            return ""
        }
    }

    // API管理クラスで利用するJWT文字列をキーチェーンへ保存する
    func saveJsonAccessToken(_ token: String) {
        keychain[string: keyName] = token
    }

    // API管理クラスで利用するJWT文字列をキーチェーンから削除する
    func deleteJsonAccessToken() {
        keychain[string: keyName] = nil
    }

    // JWT文字列がキーチェーンに存在するかを判定する
    func existsJsonAccessToken() -> Bool {
        return (keychain[string: keyName] != nil)
    }
}
