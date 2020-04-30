//
//  ItemsEventIntroductionContainerViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Protocol

protocol ItemsEventIntroductionContainerDelegate: NSObjectProtocol {

    // MEMO: 表示バナーをタップした際の振る舞い
    func eventIntroductionCellTapped(targetEventIntroductionId: Int)
}

// MEMO: この画面に対応するViewControllerはItems.storyboardに配置している

final class ItemsEventIntroductionContainerViewController: UIViewController {

    // MARK: -  ItemsEventIntroductionContainerDelegate

    weak var delegate: ItemsEventIntroductionContainerDelegate?

    // MARK: - Properties

    static let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 256.0)

    private let disposeBag = DisposeBag()

    // MARK: - @IBOutlet

    @IBOutlet private weak var eventIntroductionCollectionView: UICollectionView!
    
    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupEventIntroductionCollectionView()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupEventIntroductionCollectionView() {
        
        // UICollectionViewに関する設定
        eventIntroductionCollectionView.isPagingEnabled = false
        eventIntroductionCollectionView.isScrollEnabled = true
        eventIntroductionCollectionView.showsHorizontalScrollIndicator = true
        eventIntroductionCollectionView.showsVerticalScrollIndicator = false
        eventIntroductionCollectionView.registerCustomCell(EventIntroductionCollectionViewCell.self)

        // UICollectionViewLayoutの設定でスクロール方向を設定する
        if let layout = eventIntroductionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

    private func bindToRxSwift() {
        
    }
}

// MARK: - StoryboardInstantiatable

extension ItemsEventIntroductionContainerViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Items"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return "ItemsEventIntroductionContainer"
    }
}
