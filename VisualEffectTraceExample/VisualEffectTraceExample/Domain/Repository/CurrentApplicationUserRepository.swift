//
//  CurrentApplicationUserRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

//sourcery: AutoMockable
protocol ApplicationUserRepository {

    // ユーザーのチュートリアル完了フラグを更新する
    func updatePassTutorialStatus()

    // Keychainに格納されているJsonAccessTokenを更新する
    func updateJsonAccessToken(_ token: String)
}

final class CurrentApplicationUserRepository: ApplicationUserRepository {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "RealmAccessProtocol")) private var realmAccessManager: RealmAccessProtocol
    @Dependencies.Inject(Dependencies.Name(rawValue: "KeychainAccessProtocol")) private var keychainAccessManager: KeychainAccessProtocol

    // MARK: - ApplicationUserRepository

    func updatePassTutorialStatus() {

        // Realm内のチュートリアル完了フラグを更新する
        let applicationUserEntity = executeFindOrCreateApplicationUser()
        applicationUserEntity.alreadyPassTutorial = true
        realmAccessManager.saveApplicationUser(applicationUserEntity)
    }
    
    func updateJsonAccessToken(_ token: String) {

        // 引数で受け取ったJsonAccessTokenをKeychainに格納する
        keychainAccessManager.saveJsonAccessToken(token)
    }

    // MARK: - Private Function

    private func executeFindOrCreateApplicationUser() -> ApplicationUserEntity {

        // アプリのユーザー情報を既存データ取得ないしは新規データを作成する
        if let applicationUser = realmAccessManager.getApplicationUser() {
            return applicationUser
        } else {
            return ApplicationUserEntity()
        }
    }
}
