//
//  TutorialScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/28.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol TutorialFlow: AnyObject {

    // サインイン画面へ遷移するためのSignupScreenCoodinatorを初期化する
    func coordinateToSignin()
}

class TutorialScreenCoordinator: ScreenCoordinator, TutorialFlow {
    
    // MARK: - Initializer

    init() {}

    // MARK: - ScreenCoordinator

    func start() {

        // チュートリアル画面表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let tutorialViewController = TutorialViewController.instantiate()
        tutorialViewController.coordinator = self

        // 現在表示されているUIWindowインスタンスを取得する（※iOS13以降とそれ以下では取得方法が異なる点に注意！）
        guard let window = UIWindowScanner.getCurrentDisplayWindow() else {
            fatalError("対象のUIWindow要素を取得することができませんでした。")
        }

        // アニメーションを伴う形でrootViewControllerを切り替える
        UIView.transition(with: window, duration: 0.24, options: [.transitionCrossDissolve], animations: {
            DispatchQueue.main.async {
                window.rootViewController = tutorialViewController
            }
        })
    }

    // MARK: - TutorialFlow

    func coordinateToSignin() {

        // サインイン画面へ遷移するためのCoodinatorの処理を実施する
        let signinCoodinator = SigninScreenCoordinator()
        coordinate(to: signinCoodinator)
    }
}
