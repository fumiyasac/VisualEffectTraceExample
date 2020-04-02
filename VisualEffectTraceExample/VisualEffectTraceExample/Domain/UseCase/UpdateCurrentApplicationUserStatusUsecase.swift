//
//  UpdateCurrentApplicationUserStatusUsecase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol ApplicationUserStatusUsecase {

    // ユーザーのチュートリアル完了フラグを更新する
    func executeUpdatePassTutorialStatus()

    // ユーザーが会員登録を終えたタイミングで実行する
    func executeUpdateAlreadySignupStatus()
}

final class UpdateCurrentApplicationUserStatusUsecase: ApplicationUserStatusUsecase {

    private let mainScreenRepository: MainScreenRepository

    // MARK: - Initializer

    init(mainScreenRepository: MainScreenRepository) {
        self.mainScreenRepository = mainScreenRepository
    }

    // MARK: - ApplicationUserStatusUsecase

    func executeUpdatePassTutorialStatus() {
    }

    func executeUpdateAlreadySignupStatus() {
    }
}
