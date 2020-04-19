//
//  AnnouncementScreenCoodinator.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/14.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol AnnouncementFlow: class {

    // お知らせ一覧画面から前の画面へ戻る
    func dismissSignin()
}

class AnnouncementScreenCoodinator: ScreenCoordinator, AnnouncementFlow {

    private let currentDisplayViewController: UIViewController

    // MEMO: カスタムトランジションを適用するためのアニメーションに関するクラス
    private var targetTransitioningDelegate: UIViewControllerTransitioningDelegate? = nil

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

    // MARK: - Function

    // MEMO: カスタムトランジションを適用するために必要なUIViewControllerTransitioningDelegateクラスを受け取る
    func setTranstioningDelegateIfNeeded(transitioningDelegate: UIViewControllerTransitioningDelegate?) {
        targetTransitioningDelegate = transitioningDelegate
    }

    // MARK: - ScreenCoordinator

    func start() {

        // お知らせ画面表示用のViewControllerのインスタンスを取得して該当Coodinatorのプロトコルを適合させる
        let announcementViewController = AnnouncementViewController.instantiate()
        announcementViewController.coordinator = self
        announcementViewController.transitioningDelegate = targetTransitioningDelegate

        // お知らせ画面へ画面遷移を実行する
        if #available(iOS 13.0, *) {
            announcementViewController.modalPresentationStyle = .fullScreen
        }
        currentDisplayViewController.present(announcementViewController, animated: true, completion: nil)
    }

    // MARK: - AnnouncementFlow

    func dismissSignin() {

        // お知らせ画面から元の遷移元へ戻る
        currentDisplayViewController.dismiss(animated: true, completion: nil)
    }
}
