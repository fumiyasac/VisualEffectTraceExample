//
//  FeaturedViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class FeaturedViewController: UIViewController {

    // MARK: - Properties

    // 一度だけ配置する処理を実行するための識別子のPrefix
    private let onceTokenPrefix = "Featured_"

    // バインダー型のUICollectionViewCellを開いた状態にするレイアウト属性クラス
    private let expandedFileBinderLayout = ExpandedFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellを閉じた状態にするレイアウト属性クラス
    private let indexFileBinderLayout = IndexFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellの状態ハンドリング用の変数
    private var shouldExpandCell = false

    // MARK: - @IBOutlet

    @IBOutlet private weak var featuredCollectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle(TabBarItemsType.featured.getGlobalTabBarTitle())
        setupCollectionView()
    }

    // MARK: - Private Function

    private func setupCollectionView() {

        // UICollectionViewに関する初期設定
        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        featuredCollectionView.bounces = false
        featuredCollectionView.registerCustomCell(FeaturedCollectionViewCell.self)

        // MEMO: 配置したUICollectionViewにおける下方向オフセット値を調整する
        featuredCollectionView.contentInset.bottom = 82.0

        // UICollectionViewに付与するUICollectionViewLayoutを継承したクラスを付与する
        featuredCollectionView.setCollectionViewLayout(indexFileBinderLayout, animated: true)
        if let targetCollectionView = self.featuredCollectionView {
            indexFileBinderLayout.height = targetCollectionView.frame.size.height

            // MEMO: セルごとの間隔を調整する
            indexFileBinderLayout.targetItemGap = 188.0
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FeaturedViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // MEMO: 配置しているセルに対する処理を実施する場合に利用する
        let cell = collectionView.cellForItem(at: indexPath) as! FeaturedCollectionViewCell

        DispatchQueue.main.async {

            // MEMO: タップした対象のセルをデザインを切り替える
            cell.setDecoration(shouldDisplayBorder: self.shouldExpandCell)

            // MEMO: 変数shouldExpandCellの状態に応じてスクロール可否を適用し直す
            collectionView.isScrollEnabled = self.shouldExpandCell

            // MEMO: 変数shouldExpandCellの状態に応じてレイアウトを適用し直す
            let targetLayout: UICollectionViewLayout = self.shouldExpandCell ? self.indexFileBinderLayout : self.expandedFileBinderLayout
            collectionView.setCollectionViewLayout(targetLayout, animated: true)

            self.shouldExpandCell = !self.shouldExpandCell
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FeaturedViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // MEMO: Containerとして表示したいViewControllerと親要素のViewControllerを渡す
        let cell = collectionView.dequeueReusableCustomCell(with: FeaturedCollectionViewCell.self, indexPath: indexPath)

        // MEMO: セルの配置を一度だけ実行する
        DispatchQueue.once(token: "\(onceTokenPrefix)\(indexPath.item)") {
            DispatchQueue.main.async {

            }
        }
        return cell
    }
}

// MARK: - StoryboardInstantiatable

extension FeaturedViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Featured"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
