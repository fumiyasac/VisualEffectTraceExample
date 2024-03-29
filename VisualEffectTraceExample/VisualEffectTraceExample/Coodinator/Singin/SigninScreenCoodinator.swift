//
//  SigninScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol SigninFlow: AnyObject {

    // 新規会員登録画面へ遷移するためのSignupScreenCoodinatorを初期化する
    func coordinateToSignup()

    // 運営からのお知らせ画面へ遷移するためのAnnouncementScreenCoodinatorを初期化する
    func coordinateToAnnouncement(transitioningDelegate: UIViewControllerTransitioningDelegate?)

    // コンテンツ表示用のTabBar画面へ遷移するためのGlobalTabScreenCoodinatorを初期化する
    func coordinateToGlobalTab()
}

class SigninScreenCoordinator: ScreenCoordinator, SigninFlow {
    
    // MARK: - Initializer

    init() {}

    // MARK: - ScreenCoordinator

    func start() {

        // サインイン画面表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let signinViewController = SigninViewController.instantiate()
        signinViewController.coordinator = self

        // 現在表示されているUIWindowインスタンスを取得する（※iOS13以降とそれ以下では取得方法が異なる点に注意！）
        guard let window = UIWindowScanner.getCurrentDisplayWindow() else {
            fatalError("対象のUIWindow要素を取得することができませんでした。")
        }

        // アニメーションを伴う形でrootViewControllerを切り替える
        UIView.transition(with: window, duration: 0.24, options: [.transitionCrossDissolve], animations: {
            DispatchQueue.main.async {
                window.rootViewController = signinViewController
            }
        })
    }

    // MARK: - SigninFlow

    func coordinateToSignup() {

        // サインアップ画面へ遷移するためのCoodinatorの処理を実施する
        let signupCoodinator = SignupScreenCoordinator()
        coordinate(to: signupCoodinator)
    }

    func coordinateToAnnouncement(transitioningDelegate: UIViewControllerTransitioningDelegate?) {

        // お知らせ画面へ遷移するためのCoodinatorの処理を実施する
        let announcementCoodinator = AnnouncementScreenCoodinator()
        // MEMO: カスタムトランジションを加える場合にはsetTranstioningDelegateIfNeededを利用する
        announcementCoodinator.setTranstioningDelegateIfNeeded(transitioningDelegate: transitioningDelegate)
        coordinate(to: announcementCoodinator)
    }

    func coordinateToGlobalTab() {

        // GlobalTabBar画面へ遷移するためのCoodinatorの処理を実施する
        let globalTabBarCoodinator = GlobalTabBarScreenCoodinator()
        coordinate(to: globalTabBarCoodinator)
    }
}
