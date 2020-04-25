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

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGlobalTabBar()
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
        // 2. Search
        let searchNavigationController = UINavigationController()
        let searchScreenCoordinator = SearchScreenCoodinator(navigationController: searchNavigationController)
        // 3. Featured
        let featuredNavigationController = UINavigationController()
        let featuredScreenCoordinator = FeaturedScreenCoodinator(navigationController: featuredNavigationController)
        // 4. Story
        let storyNavigationController = UINavigationController()
        let storyScreenCoordinator = StoryScreenCoodinator(navigationController: storyNavigationController)

        // MEMO: 各画面の土台となるUINavigationControllerをセットする
        self.viewControllers = [
            itemsNavigationController,
            searchNavigationController,
            featuredNavigationController,
            storyNavigationController,
        ]

        // MEMO: GlobalTabBarControllerに配置する画面に対応するCoodinatorの処理を実行する
        itemsScreenCoordinator.start()
        searchScreenCoordinator.start()
        featuredScreenCoordinator.start()
        storyScreenCoordinator.start()

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

extension GlobalTabBarController: UITabBarControllerDelegate {}

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
