//
//  AnnouncementScreenTransitioningDelegate.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/19.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// Modal(present/dismiss)の遷移でカスタムトランジションを適用するためのクラス
// → 画面遷移処理についてはCoodinatorクラスで分離しているので、
// (1) NSObjectクラスを継承
// (2) UIViewControllerTransitioningDelegateプロトコルを適合
// の条件を満たすクラスのインスタンスを各種Coodinatorへ引き渡すことで実現させる

final class AnnouncementScreenTransitioningDelegate: NSObject {

    // MEMO: お知らせ画面への遷移時のカスタムトランジションを実行するためのクラス
    private let announcementScreenTransition = AnnouncementScreenTransition()

    // アニメーション対象なるViewControllerの位置やサイズ情報を格納するメンバ変数
    var screenFrame: CGRect = CGRect.zero
}

// MARK: - UIViewControllerTransitioningDelegate

extension AnnouncementScreenTransitioningDelegate: UIViewControllerTransitioningDelegate {

    // 進む場合のアニメーションの設定を行う
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        // 現在の画面サイズを引き渡して画面が縮むトランジションにする
        announcementScreenTransition.originalFrame = screenFrame
        announcementScreenTransition.presenting = true
        return announcementScreenTransition
    }

    // 戻る場合のアニメーションの設定を行う
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        // 縮んだ状態から画面が戻るトランジションにする
        announcementScreenTransition.presenting = false
        return announcementScreenTransition
    }
}
