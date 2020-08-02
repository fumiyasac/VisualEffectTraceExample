//
//  SettingsScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/06/16.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol SettingsFlow: class {

    // 設定一覧画面からログアウト処理を実行する
    func coordinateToSignin()
}

class SettingsScreenCoodinator: ScreenCoordinator, SettingsFlow {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {

        // MEMO: GlobalTabBarに接続する画面については、UINavigationControllerでラップしているのでこの形にしています。
        self.navigationController = navigationController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // アイテム表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let settingsViewController = SettingsViewController.instantiate()
        settingsViewController.coordinator = self

        // アイテム画面の表示を実行する
        navigationController.pushViewController(settingsViewController, animated: false)
    }

    // MARK: - SettingsFlow

    func coordinateToSignin() {

        // サインイン画面へ遷移するためのCoodinatorの処理を実施する
        let signinCoodinator = SigninScreenCoordinator()
        coordinate(to: signinCoodinator)
    }
}
