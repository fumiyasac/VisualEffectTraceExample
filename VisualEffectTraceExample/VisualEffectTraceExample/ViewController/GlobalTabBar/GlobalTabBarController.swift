//
//  GlobalTabBarController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class GlobalTabBarController: UITabBarController {

    // MARK: - Properties

    private let itemSize = CGSize(width: 28.0, height: 28.0)
    private let normalColor: UIColor = UIColor.lightGray
    private let selectedColor: UIColor = UIColor.systemYellow
    private let tabBarItemFont = UIFont(name: "HelveticaNeue-Medium", size: 10)!

    // MEMO: UITabBarの切り替え時に実行するカスタムトランジションのクラス
    private let tabBarTransition = GlobalTabBarTransition()

    // (参考) https://stackoverflow.com/questions/42135889/tabbar-icon-bounce-effect-on-selection-like-a-twitter-app-in-swift
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGlobalTabBar()
    }

    // UITabBarItemが押下された際に実行される処理
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        // MEMO: UITabBarに配置されているUIImageView要素に対してアニメーションさせるための処理
        // (参考) https://bit.ly/2VCP5Am
        guard let index = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > index + 1, let imageView = tabBar.subviews[index + 1].subviews[1] as? UIImageView else {
            return
        }
        // MEMO: 抽出したUIImageView要素に対してCoreAnimationを適用する
        imageView.layer.add(bounceAnimation, forKey: nil)
    }

    // MARK: - Private Function

    private func setupGlobalTabBar() {

        // MEMO: UITabBarControllerDelegateの宣言
        self.delegate = self

        // MEMO: 初期設定として空のUIViewControllerのインスタンスを追加する
        //  → 実際の画面との連結処理についてはCoodinator側で実施するようにしているが、この形で良いかは疑問

        // MEMO: 各画面のCoodinatorとUINavigationControllerをインスタンス化する
        // 1. Items
        let itemsNavigationController = UINavigationController()
        let itemsScreenCoordinator = ItemsScreenCoodinator(navigationController: itemsNavigationController)
        // 2. Featured
        let featuredNavigationController = UINavigationController()
        let featuredScreenCoordinator = FeaturedScreenCoodinator(navigationController: featuredNavigationController)
        // 3. Story
        let storyNavigationController = UINavigationController()
        let storyScreenCoordinator = StoryScreenCoodinator(navigationController: storyNavigationController)
        // 4. Settings
        let settingsNavigationController = UINavigationController()
        let settingsScreenCoordinator = SettingsScreenCoodinator(navigationController: settingsNavigationController)

        // MEMO: 各画面の土台となるUINavigationControllerをセットする
        self.viewControllers = [
            itemsNavigationController,
            featuredNavigationController,
            storyNavigationController,
            settingsNavigationController
        ]

        // MEMO: GlobalTabBarControllerに配置する画面に対応するCoodinatorの処理を実行する
        itemsScreenCoordinator.start()
        featuredScreenCoordinator.start()
        storyScreenCoordinator.start()
        settingsScreenCoordinator.start()

        // MEMO: タブの選択時・非選択時の色とアイコンのサイズを決める
        // UITabBarItem用のAttributeを決める
        let normalAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: normalColor
        ]
        let selectedAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: tabBarItemFont,
            NSAttributedString.Key.foregroundColor: selectedColor
        ]
        // UITabBarに表示する画面を決める
        let _ = TabBarItemsType.allCases.enumerated().map { (index, tabBarItem) in

             // 該当ViewControllerのタイトルの設定
             self.viewControllers?[index].title = tabBarItem.getGlobalTabBarTitle()
             // 該当ViewControllerのUITabBar要素の設定
             self.viewControllers?[index].tabBarItem.tag = index
             self.viewControllers?[index].tabBarItem.setTitleTextAttributes(normalAttributes, for: [])
             self.viewControllers?[index].tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
             self.viewControllers?[index].tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -1.0)
             self.viewControllers?[index].tabBarItem.image
                = UIImage.fontAwesomeIcon(
                    name: tabBarItem.getGlobalTabBarIcon(),
                    style: .solid,
                    textColor: normalColor,
                    size: itemSize
                )
                .withRenderingMode(.alwaysOriginal)
             self.viewControllers?[index].tabBarItem.selectedImage
                = UIImage.fontAwesomeIcon(
                    name: tabBarItem.getGlobalTabBarIcon(),
                    style: .solid,
                    textColor: selectedColor,
                    size: itemSize)
                .withRenderingMode(.alwaysOriginal)
         }
    }
}

// MARK: - UITabBarControllerDelegate

extension GlobalTabBarController: UITabBarControllerDelegate {

    // UITabBarControllerの画面遷移が実行された場合の遷移アニメーションの定義
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return tabBarTransition
    }
}

// MARK: - StoryboardInstantiatable

extension GlobalTabBarController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "GlobalTabBar"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
