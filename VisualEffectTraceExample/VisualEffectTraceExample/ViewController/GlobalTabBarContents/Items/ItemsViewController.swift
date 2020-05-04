//
//  ItemsViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import WaterfallLayout

// MEMO: こちらのライブラリを利用した形で実装しています。
// https://github.com/sgr-ksmt/WaterfallLayout
// その他の実装について:
// どのライブラリもUICollectionViewLayoutクラスを継承した方針で作成されている点は同じかと思います。
// (1) https://github.com/Jinya/WaterflowLayout
// (2) https://github.com/ecerney/CollectionViewWaterfallLayout
// ※ iOS13で登場したUICollectionViewCompositionalLayoutでも同様な表現は実現できます。

final class ItemsViewController: UIViewController {

    // MARK: - ItemsFlow

    var coordinator: ItemsFlow?

    // MEMO: UICollectionViewCellへContainerViewとして配置する画面
    private let itemsTopBannerContainerViewController = ItemsTopBannerContainerViewController.instantiate()
    private let itemsEventIntroductionContainerViewController = ItemsEventIntroductionContainerViewController.instantiate()
    
    // MARK: - @IBOutlet

    @IBOutlet private weak var itemCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.items.getGlobalTabBarTitle())
        setupItemCollectionView()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupItemCollectionView() {

        // UICollectionViewに関する設定
        itemCollectionView.isPagingEnabled = false
        itemCollectionView.isScrollEnabled = true
        itemCollectionView.showsHorizontalScrollIndicator = false
        itemCollectionView.showsVerticalScrollIndicator = true
        itemCollectionView.registerCustomCell(ContainerCollectionViewCell.self)

        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.reloadData()

        // ライブラリ「WaterfallLayout」を利用したUICollectionViewの表示
        let layout = WaterfallLayout()
        layout.delegate = self
        itemCollectionView.collectionViewLayout = layout
    }

    private func bindToRxSwift() {
        
        //
    }
}

// MARK: - UICollectionViewDelegate

extension ItemsViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

extension ItemsViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ItemsScreenSectionType.allCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
            return ItemsScreenSectionType.itemsTopBanner.getRowsCount()
        case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
            return ItemsScreenSectionType.itemsEventIntroduction.getRowsCount()
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // MEMO: Containerとして表示したいViewControllerと親要素のViewControllerを渡す
        let cell = collectionView.dequeueReusableCustomCell(with: ContainerCollectionViewCell.self, indexPath: indexPath)

        var targetViewController: UIViewController
        switch indexPath.section {
        case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
            itemsTopBannerContainerViewController.delegate = self
            targetViewController = itemsTopBannerContainerViewController
        case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
            itemsEventIntroductionContainerViewController.delegate = self
            targetViewController = itemsEventIntroductionContainerViewController
        default:
            targetViewController = UIViewController()
        }

        let viewControllerInfo = ContainerCollectionViewCell.DisplayViewControllerInContainerViewInformation(
            targetViewController: targetViewController,
            parentViewController: self
        )
        cell.setCell(viewControllerInfo)
        return cell
    }
}

// MARK: - WaterfallLayoutDelegate

extension ItemsViewController: WaterfallLayoutDelegate {

    // セルのサイズを設定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
            return ItemsTopBannerContainerViewController.screenSize
        case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
            return ItemsEventIntroductionContainerViewController.screenSize
        default:
            return CGSize.zero
        }
    }

    // セルのレイアウトパターンを設定する
    func collectionViewLayout(for section: Int) -> WaterfallLayout.Layout {

        switch section {
        case ItemsScreenSectionType.itemsTopBanner.getSectionIndex():
            return .flow(column: 1)
        case ItemsScreenSectionType.itemsEventIntroduction.getSectionIndex():
            return .flow(column: 1)
        default:
            return .flow(column: 1)
        }
    }

    // セルの垂直方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumInteritemSpacingFor section: Int) -> CGFloat? {
        return .zero
    }

    // セルの水平方向の余白(margin)を設定する
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, minimumLineSpacingFor section: Int) -> CGFloat? {
        return .zero
    }

    // セル内のアイテム間の余白(margin)調整を行う
    func collectionView(_ collectionView: UICollectionView, layout: WaterfallLayout, sectionInsetFor section: Int) -> UIEdgeInsets? {
        return .zero
    }
}

// MARK: - ItemsTopBannerContainerDelegate

extension ItemsViewController: ItemsTopBannerContainerDelegate {

    func topBannerCellTapped(targetBannerContentsId: Int) {

        // TODO: 取得したトップバナーコンテンツIDを元に該当画面へ遷移する処理
        print("targetBannerContentsId:", targetBannerContentsId)
    }
}

// MARK: - ItemsEventIntroductionContainerDelegate

extension ItemsViewController: ItemsEventIntroductionContainerDelegate {

    func eventIntroductionCellTapped(targetEventIntroductionId: Int) {

        // TODO: 取得したイベント概要IDを元に該当画面へ遷移する処理
        print("targetEventIntroductionId:", targetEventIntroductionId)
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
