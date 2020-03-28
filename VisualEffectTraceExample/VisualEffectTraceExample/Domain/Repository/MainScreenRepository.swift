//
//  MainScreenRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol MainRepository {

    // チュートリアル画面への表示データ配列を取得する
    func searchApplicationUserData() -> ApplicationUserStatus
}

final class MainScreenRepository: MainRepository {

    // MARK: - Properties

    private let realmAccessManager: RealmAccessProtocol
    private let keychainAccessManager: KeychainAccessProtocol

    // MARK: - Initializer

    init(realmAccessManager: RealmAccessProtocol, keychainAccessManager: KeychainAccessProtocol) {
        self.realmAccessManager = realmAccessManager
        self.keychainAccessManager = keychainAccessManager
    }

    // MARK: - MainRepository

    func searchApplicationUserData() -> ApplicationUserStatus {

        // Realm(ApplicationUserEntity)のデータの状態に応じてら対象の画面遷移先を決定する
        if let applicationUser = realmAccessManager.getAllObjects(ApplicationUserEntity.self)?.first {

            switch applicationUser {

            case _ where !applicationUser.alreadyPassTutorial :
                return ApplicationUserStatus.needToMoveTutorialScreen

            case _ where applicationUser.alreadyPassTutorial && !applicationUser.alreadySignup :
                return ApplicationUserStatus.needToMoveLoginScreen

            default:
                return ApplicationUserStatus.needToMoveGlobalTabBarScreen
            }

        } else {

            // レコードがそもそも存在しない場合はTutorial画面へ遷移する
            return ApplicationUserStatus.needToMoveTutorialScreen
        }
    }
}
