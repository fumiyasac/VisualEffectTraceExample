//
//  ItemsScreenSectionType.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MEMO: Items.storyboardでのSection定義用のEnum
enum ItemsScreenSectionType: CaseIterable {
    
    case itemsTopBanner
    case itemsEventIntroduction
    case itemsRecentAnnoucement
//    case itemsRegularList

    // MARK: - Properties

    static var allCount: Int {
        return self.allCases.count
    }

    // MARK: - Function

    // 全体を包括するUICollectionViewの各種セクションのindex値を取得する
    func getSectionIndex() -> Int {
        switch self {
        case .itemsTopBanner:
            return 0
        case .itemsEventIntroduction:
            return 1
        case .itemsRecentAnnoucement:
            return 2
//        case .itemsRegularList:
//            return 3
        }
    }

    // 全体を包括するUICollectionViewの各種セクションのタイトルを取得する
    func getSectionTitle() -> String {
        switch self {
        case .itemsTopBanner:
            return "Seasonal Special"
        case .itemsEventIntroduction:
            return "Event Introduction"
        case .itemsRecentAnnoucement:
            return "Recent Announcement"
//        case .itemsRegularList:
//            return "Regular Item List"
        }
    }

    // 全体を包括するUICollectionViewの各種セクションの概要を取得する
    func getSectionDescription() -> String {
        switch self {
        case .itemsTopBanner:
            return "季節に合わせたトピックを掲載しています。"
        case .itemsEventIntroduction:
            return "購入イベントやSALE情報を掲載しています。"
        case .itemsRecentAnnoucement:
            return "現在お知らせしている最新情報になります。"
//        case .itemsRegularList:
//            return "現在販売・購入実績があるアイテム一覧です。"
        }
    }
    
    // 全体を包括するUICollectionViewの各種セクションに適用するレイアウトを取得する
    func getSectionLayout() -> NSCollectionLayoutSection {
        switch self {
        case .itemsTopBanner:
            return createItemsTopBannerLayout()
        case .itemsEventIntroduction:
            return createItemsEventIntroductionLayout()
        case .itemsRecentAnnoucement:
            return createItemsRecentAnnoucementLayout()
//        case .itemsRegularList:
//            // TODO: レイアウトを作成する
        }
    }

    // MARK: - Private Function

    private func createItemsTopBannerLayout() -> NSCollectionLayoutSection {

        // 1. Itemのサイズ設定
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero

        // 2. Groupのサイズ設定
        let groupWidth = ItemsTopBannerContainerViewController.screenSize.width
        let groupHeight = ItemsTopBannerContainerViewController.screenSize.height
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .zero

        // 3. Sectionのサイズ設定
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero

        // 4. Headerのレイアウトを決定する
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(69.5))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .zero

        return section
    }

    private func createItemsEventIntroductionLayout() -> NSCollectionLayoutSection {

        // 1. Itemのサイズ設定
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero

        // 2. Groupのサイズ設定
        let groupWidth = ItemsEventIntroductionContainerViewController.screenSize.width
        let groupHeight = ItemsEventIntroductionContainerViewController.screenSize.height
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .zero

        // 3. Sectionのサイズ設定
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero

        // 4. Headerのレイアウトを決定する
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(69.5))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .zero

        return section
    }

    private func createItemsRecentAnnoucementLayout() -> NSCollectionLayoutSection {

        // MEMO: 該当のセルを基準にした高さの予測値を設定する
        let estimatedHeight = UIScreen.main.bounds.width + 81.0

        // 1. Itemのサイズ設定
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .zero

        // 2. Groupのサイズ設定
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .zero

        // 3. Sectionのサイズ設定
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero

        // 4. Headerのレイアウトを決定する
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(69.5))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .zero

        return section
    }
}
