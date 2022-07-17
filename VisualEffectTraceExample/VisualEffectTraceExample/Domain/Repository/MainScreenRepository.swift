//
//  MainScreenRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

//sourcery: AutoMockable
protocol MainRepository {

    // チュートリアル画面への表示データ配列を取得する
    func searchApplicationUserData() -> ApplicationUserStatus
}

final class MainScreenRepository: MainRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "RealmAccessProtocol")) private var realmAccessManager: RealmAccessProtocol
    @Dependencies.Inject(Dependencies.Name(rawValue: "KeychainAccessProtocol")) private var keychainAccessManager: KeychainAccessProtocol

    // MARK: - MainRepository

    func searchApplicationUserData() -> ApplicationUserStatus {

        // Realm(ApplicationUserEntity)のデータの状態に応じてら対象の画面遷移先を決定する
        if let applicationUser = realmAccessManager.getApplicationUser() {

            switch applicationUser {

            case _ where !applicationUser.alreadyPassTutorial:
                return ApplicationUserStatus.needToMoveTutorialScreen

            case _ where applicationUser.alreadyPassTutorial && !keychainAccessManager.existsJsonAccessToken():
                return ApplicationUserStatus.needToMoveSigninScreen

            default:
                return ApplicationUserStatus.needToMoveGlobalTabBarScreen
            }

        } else {

            // レコードがそもそも存在しない場合はTutorial画面へ遷移する
            return ApplicationUserStatus.needToMoveTutorialScreen
        }
    }
}
