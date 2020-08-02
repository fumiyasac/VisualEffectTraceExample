//
//  StoryScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class StoryScreenCoodinator: ScreenCoordinator {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {

        // MEMO: GlobalTabBarに接続する画面については、UINavigationControllerでラップしているのでこの形にしています。
        self.navigationController = navigationController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // ストーリー表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let storyViewController = StoryViewController.instantiate()

        // アイテム画面の表示を実行する
        navigationController.pushViewController(storyViewController, animated: false)
    }
}
