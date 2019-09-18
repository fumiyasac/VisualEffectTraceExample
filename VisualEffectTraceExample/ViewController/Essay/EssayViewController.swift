//
//  EssayViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class EssayViewController: UIViewController {

    // 一度だけ配置する処理を実行するための識別子のPrefix
    private let onceTokenPrefix = "Essay_"

    // バインダー型のUICollectionViewCellを開いた状態にするレイアウト属性クラス
    private let expandedFileBinderLayout = ExpandedFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellを閉じた状態にするレイアウト属性クラス
    private let indexFileBinderLayout = IndexFileBinderCollectionViewLayout()

    // バインダー型のUICollectionViewCellの状態ハンドリング用の変数
    private var shouldExpandCell = false

    @IBOutlet weak private var collectionView: UICollectionView!

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarTitle("心温まるエッセイ集")
        setupArticleCollectionView()
    }

    // MARK: - Private Function

    private func setupArticleCollectionView() {

        // UICollectionViewに関する初期設定
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.bottom = 84.0
        collectionView.registerCustomCell(EssayCollectionViewCell.self)

        // UICollectionViewに付与するUICollectionViewLayoutを継承したクラスを付与する
        collectionView.setCollectionViewLayout(indexFileBinderLayout, animated: true)
        if let targetCollectionView = self.collectionView {
            indexFileBinderLayout.height = targetCollectionView.frame.size.height
            indexFileBinderLayout.targetItemGap = 150.0
        }
    }
}

extension EssayViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // MEMO: Containerとして表示したいViewControllerと親要素のViewControllerを渡す
        let cell = collectionView.dequeueReusableCustomCell(with: EssayCollectionViewCell.self, indexPath: indexPath)

        // MEMO: セルの配置を一度だけ実行する
        DispatchQueue.once(token: "\(onceTokenPrefix)\(indexPath.item)") {
            DispatchQueue.main.async {}
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! EssayCollectionViewCell

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
