//
//  FeaturedScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class FeaturedScreenCoodinator: ScreenCoordinator {

    // MARK: - Properties

    private let navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {

        // MEMO: GlobalTabBarに接続する画面については、UINavigationControllerでラップしているのでこの形にしています。
        self.navigationController = navigationController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // 特集表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let featuredViewController = FeaturedViewController.instantiate()

        // 特集画面の表示を実行する
        navigationController.pushViewController(featuredViewController, animated: false)
    }
}
