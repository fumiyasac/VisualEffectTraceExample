//
//  HandleMainScreenUseCase.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MARK: - Protocol

//sourcery: AutoMockable
protocol MainScreenUseCase {

    // 起動用画面からユーザーの状態を確認して遷移先を決定する
    func execute() -> ApplicationUserStatus
}

final class HandleMainScreenUseCase: MainScreenUseCase {

    // MARK: - Properties

    @Dependencies.Inject(Dependencies.Name(rawValue: "MainRepository")) private var mainRepository: MainRepository

    // MARK: - TutorialUseCase

    func execute() -> ApplicationUserStatus {
        return mainRepository.searchApplicationUserData()
    }
}
