//
//  TabBarItemsType.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import FontAwesome_swift

// MEMO: GloalTabBarControllerへ配置するものに関する設定
enum TabBarItemsType: CaseIterable {

    case items
    case search
    case featured
    case story
    case settings

    // MARK: - Function

    // GlobalTabBarに配置するタイトルを取得する
    func getGlobalTabBarTitle() -> String {
        switch self {
        case .items:
            return "Items"
        case .search:
            return "Search"
        case .featured:
            return "Featured"
        case .story:
            return "Story"
        case .settings:
            return "Settings"
        }
    }

    // GlobalTabBarに配置するアイコンを取得する
    func getGlobalTabBarIcon() -> FontAwesome {
        switch self {
        case .items:
            return .images
        case .search:
            return .search
        case .featured:
            return .lightbulb
        case .story:
            return .book
        case .settings:
            return .cog
        }
    }
}
