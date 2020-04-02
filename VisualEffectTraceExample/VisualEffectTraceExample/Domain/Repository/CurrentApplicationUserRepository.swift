//
//  CurrentApplicationUserRepository.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol ApplicationUserRepository {

    // ユーザーのチュートリアル完了フラグを更新する
    func updatePassTutorialStatus()

    // ユーザーが会員登録を終えたタイミングで会員登録完了フラグを更新する
    func updateAlreadySignupStatus()
}

final class CurrentApplicationUserRepository: ApplicationUserRepository {

    // MARK: - Properties

    private let realmAccessManager: RealmAccessProtocol

    // MARK: - Initializer

    init(realmAccessManager: RealmAccessProtocol) {
        self.realmAccessManager = realmAccessManager
    }

    // MARK: - ApplicationUserRepository

    func updatePassTutorialStatus() {

        // Realm内のチュートリアル完了フラグを更新する
        let applicationUser = executeFindOrCreateApplicationUser()
        applicationUser.alreadyPassTutorial = true
        realmAccessManager.save(applicationUser)
    }
    
    func updateAlreadySignupStatus() {

        // Realm内の会員登録完了フラグを更新する
        let applicationUser = executeFindOrCreateApplicationUser()
        applicationUser.alreadySignup = true
        realmAccessManager.save(applicationUser)
    }

    // MARK: - Private Function

    private func executeFindOrCreateApplicationUser() -> ApplicationUserEntity {

        // アプリのユーザー情報を既存データ取得ないしは新規データを作成する
        if let applicationUser = realmAccessManager.getAllObjects(ApplicationUserEntity.self)?.first {
            return applicationUser
        } else {
            return ApplicationUserEntity()
        }
    }
}
