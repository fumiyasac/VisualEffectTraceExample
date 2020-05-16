//
//  UpdateCurrentApplicationUserStatusUsecase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol ApplicationUserStatusUseCase {

    // ユーザーのチュートリアル完了フラグを更新する
    func executeUpdatePassTutorialStatus()

    // ユーザーがサインイン時に受け取ったJsonAccessTokenをキーチェーンへ格納する
    func executeUpdateToken(_ token: String)
}

final class UpdateCurrentApplicationUserStatusUseCase: ApplicationUserStatusUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "ApplicationUserRepository")) private var applicationUserRepository: ApplicationUserRepository

    // MARK: - ApplicationUserStatusUsecase

    func executeUpdatePassTutorialStatus() {
        applicationUserRepository.updatePassTutorialStatus()
    }

    func executeUpdateToken(_ token: String) {
        applicationUserRepository.updateJsonAccessToken(token)
    }
}
