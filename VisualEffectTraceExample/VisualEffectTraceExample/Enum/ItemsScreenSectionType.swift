//
//  ItemsScreenSectionType.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation

// MEMO: Items.storyboardでのSection定義用のEnum
enum ItemsScreenSectionType: CaseIterable {
    
    case itemsTopBanner
    case itemsEventIntroduction
    case itemsRegularList

    // MARK: - Properties

    static var allCount: Int {
        return [.itemsTopBanner, itemsEventIntroduction, .itemsRegularList].count
    }

    // MARK: - Function

    // 全体を包括するUICollectionViewの各種セクションのindex値を取得する
    func getSectionIndex() -> Int {
        switch self {
        case .itemsTopBanner:
            return 0
        case .itemsEventIntroduction:
            return 1
        case .itemsRegularList:
            return 2
        }
    }

    // 全体を包括するUICollectionViewの各種セクションのRowsカウント数を取得する
    func getRowsCount() -> Int {
        switch self {
        case .itemsTopBanner:
            return 1
        case .itemsEventIntroduction:
            return 1
        case .itemsRegularList:
            // MEMO: この部分は可変しうる部分なので利用しない
            fatalError()
        }
    }
}
