//
//  SignupScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/12.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol SignupFlow: class {

    // 新規会員登録画面から前の画面へ戻る
    func dismissSignup()
}

class SignupScreenCoordinator: ScreenCoordinator, SignupFlow {
    
    private let currentDisplayViewController: UIViewController
    
    // MARK: - Initializer

    init() {

        // 現在表示されているUIWindowインスタンスを取得する（※iOS13以降とそれ以下では取得方法が異なる点に注意！）
        guard let window = UIWindowScanner.getCurrentDisplayWindow() else {
            fatalError("対象のUIWindow要素を取得することができませんでした。")
        }

        // 現在表示されているViewControllerを取得する
        guard let currentDisplayViewController = window.rootViewController else {
            fatalError("遷移元のViewController要素を取得することができませんでした。")
        }
        self.currentDisplayViewController = currentDisplayViewController
    }

    // MARK: - ScreenCoordinator

    func start() {

        // サインアップ画面表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let signupViewController = SignupViewController.instantiate()
        signupViewController.coordinator = self

        // サインアップ画面へ画面遷移を実行する
        if #available(iOS 13.0, *) {
            signupViewController.modalPresentationStyle = .fullScreen
        }
        currentDisplayViewController.present(signupViewController, animated: true, completion: nil)
    }

    // MARK: - SignupFlow

    func dismissSignup() {

        // サインアップ画面から元の遷移元へ戻る
        currentDisplayViewController.dismiss(animated: true, completion: nil)
    }
}
