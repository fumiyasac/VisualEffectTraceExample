//
//  GlobalTabBarScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/23.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

class GlobalTabBarScreenCoodinator: ScreenCoordinator {

    // MARK: - Initializer

    init() {}

    // MARK: - ScreenCoordinator

    func start() {

        // GlobalTabBarControllerのインスタンスを取得して該当の画面をセットする
        let globalTabBarController = GlobalTabBarController.instantiate()

        // 現在表示されているUIWindowインスタンスを取得する（※iOS13以降とそれ以下では取得方法が異なる点に注意！）
        guard let window = UIWindowScanner.getCurrentDisplayWindow() else {
            fatalError("対象のUIWindow要素を取得することができませんでした。")
        }

        // アニメーションを伴う形でrootViewControllerを切り替える
        UIView.transition(with: window, duration: 0.24, options: [.transitionCrossDissolve], animations: {
            DispatchQueue.main.async {

                // アニメーションを伴う形でrootViewControllerを切り替える
                window.rootViewController = globalTabBarController
            }
        })
    }
}
