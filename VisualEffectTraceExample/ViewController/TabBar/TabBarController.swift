//
//  TabBarController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import TransitionableTab

final class TabBarController: ESTabBarController {
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarInitialSetting()
        setupTabBarContents()
    }
    
    // MARK: - Private Function
    
    // UITabBarControllerの初期設定に関する調整
    private func setupTabBarInitialSetting() {
        
        // UITabBarControllerDelegateの宣言
        self.delegate = self
        
        // 初期設定として空のUIViewControllerのインスタンスを追加する
        self.viewControllers = [UIViewController(), UIViewController()]
    }
    
    // TabBarControllerで表示したい画面に関する設定処理
    private func setupTabBarContents() {
        
        // TabBarに表示する画面を決める
        let _ = TabBarItemType.allCases.enumerated().map { (index, item) in
            
            // 該当ViewControllerの設置
            guard let vc = item.getViewController() else {
                fatalError()
            }
            self.viewControllers?[index] = vc
            
            // 該当ViewControllerのタイトル設置
            self.viewControllers?[index].tabBarItem = item.getTabBarItem()
        }
    }
}


// MARK: - TransitionableTab

// MEMO: UITabBarControllerDelegateの処理がすでにTransitionableTabプロトコルで考慮している
extension TabBarController: TransitionableTab {
    
    // アニメーションの実行秒数
    func transitionDuration() -> CFTimeInterval {
        return 0.24
    }
    
    // アニメーションの実行オプション
    func transitionTimingFunction() -> CAMediaTimingFunction {
        return .easeInOut
    }
    
    // コンテンツ切り替え時(インデックス減少)にタブのインデックス値が増加する場合に実行するアニメーションの設定
    func fromTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        // MEMO: TransitionableTabで提供しているものをそのまま利用する
        return DefineAnimation.fade(.from)
    }
    
    // コンテンツ切り替え時(インデックス増加)にタブのインデックス値が減少する場合に実行するアニメーションの設定
    func toTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        // MEMO: TransitionableTabで提供しているものをそのまま利用する
        return DefineAnimation.fade(.to)
    }
    
    // コンテンツ切り替え時に実行される処理
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
