//
//  TabBarItemType.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import ESTabBarController_swift

// MainTabBarControllerへ配置するものに関する設定

enum TabBarItemType: CaseIterable {

    // UITabBar部分に配置するコンテンツ
    case main
    case essay

    // MARK: - Function

    // 該当のViewControllerを取得する
    func getViewController() -> UIViewController? {
        var storyboardName: String
        switch self {
        case .main:
            storyboardName = "Main"
        case .essay:
            storyboardName = "Essay"
        }
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }

    // TabBarControllerのインデックス番号を取得する
    func getTabIndex() -> Int {
        switch self {
        case .main:
            return 0
        case .essay:
            return 1
        }
    }

    // MainTabBarのタイトルを取得する
    func getTitle() -> String {
        switch self {
        case .main:
            return "好きなものリスト"
        case .essay:
            return "エッセイサンプル一覧"
        }
    }

    // MainTabBarに使うIconを取得する
    func getTabBarItem() -> ESTabBarItem {

        let itemSize = CGSize(width: 28.0, height: 28.0)
        let normalColor = UIColor.init(code: "#cccccc")

        switch self {
        case .main:
            let icon = UIImage.fontAwesomeIcon(name: .home, style: .solid, textColor: normalColor, size: itemSize)
            return ESTabBarItem.init(BouncesTabContentView(), title: "MAIN", image: icon, selectedImage: icon)
        case .essay:
            let icon = UIImage.fontAwesomeIcon(name: .bookOpen, style: .solid, textColor: normalColor, size: itemSize)
            return ESTabBarItem.init(BouncesTabContentView(), title: "ESSAY", image: icon, selectedImage: icon)
        }
    }
}
