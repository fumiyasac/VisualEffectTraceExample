//
//  ItemsTopBannerContainerViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AnimatedCollectionViewLayout

// MARK: - Protocol

protocol ItemsTopBannerContainerDelegate: NSObjectProtocol {

    // MEMO: 表示バナーをタップした際の振る舞い
    func topBannerCellTapped(targetBannerContentsId: Int)
}

// MEMO: この画面に対応するViewControllerはItems.storyboardに配置している

final class ItemsTopBannerContainerViewController: UIViewController {

    // MARK: -  ItemsTopBannerContainerDelegate

    weak var delegate: ItemsTopBannerContainerDelegate?

    // MARK: - Properties

    static let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 126.0 / 375.0 + 48.0)

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    @IBOutlet private weak var topBannerCollectionView: UICollectionView!
    @IBOutlet private weak var topBannerPrevButton: UIButton!
    @IBOutlet private weak var topBannerNextButton: UIButton!
    @IBOutlet private weak var topBannerPageControl: UIPageControl!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTopBannerCollectionView()
        setupPreviousAndNextButtons()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupTopBannerCollectionView() {

        // UICollectionViewに関する設定
        topBannerCollectionView.isPagingEnabled = true
        topBannerCollectionView.isScrollEnabled = true
        topBannerCollectionView.showsHorizontalScrollIndicator = false
        topBannerCollectionView.showsVerticalScrollIndicator = false
        topBannerCollectionView.registerCustomCell(TopBannerCollectionViewCell.self)

        // UICollectionViewに付与するアニメーションに関する設定
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ParallaxAttributesAnimator()
        layout.scrollDirection = .horizontal
        topBannerCollectionView.collectionViewLayout = layout
    }

    private func setupPreviousAndNextButtons() {

        // 戻るボタンのデザイン調整
        topBannerPrevButton.layer.masksToBounds = true
        topBannerPrevButton.layer.cornerRadius = 24.0
        topBannerPrevButton.alpha = 0.75

        // 次へボタンのデザイン調整
        topBannerNextButton.layer.masksToBounds = true
        topBannerNextButton.layer.cornerRadius = 24.0
        topBannerNextButton.alpha = 0.75
    }

    private func bindToRxSwift() {
        
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsTopBannerContainerViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return "ItemsTopBannerContainer"
    }
}
