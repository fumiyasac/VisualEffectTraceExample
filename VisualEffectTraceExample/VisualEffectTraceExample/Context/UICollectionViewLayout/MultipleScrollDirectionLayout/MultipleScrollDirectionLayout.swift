//
//  MultipleScrollDirectionLayout.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/24.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// UICollectionViewで縦横両方向にスクロールさせる様な形を実現するUICollectionViewFlowLayoutを継承したクラス
// MEMO: 下記ブログで紹介されているコードを参考に再実装をしてみました。
// (1) 横方向のセル数はnumberOfItemsInSectionで定義する
// (2) 縦方向のセル数はnumberOfSectionsで定義する
// https://xyk.hatenablog.com/entry/2017/02/09/184410

final class MultipleScrollDirectionLayout: UICollectionViewFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    weak var delegate: UICollectionViewDelegateFlowLayout?

    // MARK: - Properties

    private var layoutInfo: [IndexPath : UICollectionViewLayoutAttributes] = [:]
    private var maxRowsWidth: CGFloat = 0
    private var maxColumnHeight: CGFloat = 0

    // MARK: - Override (Computed Property)

    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxRowsWidth, height: maxColumnHeight)
    }

    // MARK: - Override (Function)

    // セルのレイアウト属性の計算処理を実行する前に実行する
    override func prepare() {
        super.prepare()

        guard let targetCollectionView = self.collectionView else {
            fatalError("対象のUICollectionViewが配置されていません。")
        }
        guard let _ = targetCollectionView.delegate as? UICollectionViewDelegateFlowLayout else {
            fatalError("対象のUICollectionViewが配置されていません。")
        }

        // 全体の幅・高さの最大値とレイアウト属性を計算するための処理
        calculateMaxRowsWidth()
        calculateMaxColumnHeight()
        calculateCellLayoutInfo()
    }

    // 表示領域が変わる場合に実行され、現在表示されている範囲内のセルにおけるUICollectionViewLayoutAttributesを配列で返す
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)

        // 現在計算されているUICollectionViewLayoutAttributesと表示されているUICollectionViewLayoutAttributesの重なりを判定する
        // → 重なっている部分を適用する
        // ※ 以降のメソッドに記載している処理ももしかしたらこんな感じで書けるのかも...
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        let _ = layoutInfo.values
            .map { $0 }
            .filter { rect.intersects($0.frame) }
            .compactMap { visibleLayoutAttributes.append($0) }
        return visibleLayoutAttributes
    }

    // IndexPathに該当するセルのUICollectionViewLayoutAttributesを再度計算して返す
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutInfo[indexPath]
    }

    // 常にレイアウトの再計算を実行するか(※常に再計算を実行する場合はtrueを返す)
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // MARK: - Private Function

    // 配置したセル要素群を基に全体の幅の最大値を算出する
    private func calculateMaxRowsWidth() {

        guard let targetCollectionView = self.collectionView else {
            fatalError("対象のUICollectionViewが配置されていません。")
        }
        guard let targetDelegate = self.delegate else {
            fatalError("対象のUICollectionViewDelegateFlowLayoutが定義されていません。")
        }

        var maxRowWidth: CGFloat = 0

        // MEMO: セクション毎に配置されているセル要素のサイズを抽出して変数へ加算していく
        for section in 0..<targetCollectionView.numberOfSections {
            var maxWidth: CGFloat = 0
            for item in 0..<targetCollectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let itemSize = targetDelegate.collectionView?(targetCollectionView, layout: self, sizeForItemAt: indexPath) {
                    maxWidth += itemSize.width
                }
            }
            maxRowWidth = maxWidth > maxRowWidth ? maxWidth : maxRowWidth
        }
        maxRowsWidth = maxRowWidth
    }

    // 配置したセル要素群を基に全体の高さの最大値を算出する
    private func calculateMaxColumnHeight() {

        guard let targetCollectionView = self.collectionView else {
            fatalError("対象のUICollectionViewが配置されていません。")
        }
        guard let targetDelegate = self.delegate else {
            fatalError("対象のUICollectionViewDelegateFlowLayoutが定義されていません。")
        }

        var maxHeight: CGFloat = 0

        // MEMO: セクション毎に配置されているセル要素のサイズを抽出して変数へ加算していく
        for section in 0..<targetCollectionView.numberOfSections {
            var maxRowHeight: CGFloat = 0
            for item in 0..<targetCollectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                if let itemSize = targetDelegate.collectionView?(targetCollectionView, layout: self, sizeForItemAt: indexPath) {
                    maxRowHeight = itemSize.height > maxRowHeight ? itemSize.height : maxRowHeight
                }
            }
            maxHeight += maxRowHeight
        }
        maxColumnHeight = maxHeight
    }

    // 配置したセル要素の各々のレイアウト属性を算出する
    private func calculateCellLayoutInfo() {

        guard let targetCollectionView = self.collectionView else {
            fatalError("対象のUICollectionViewが配置されていません。")
        }
        guard let targetDelegate = self.delegate else {
            fatalError("対象のUICollectionViewDelegateFlowLayoutが定義されていません。")
        }

        var cellLayoutInfo: [IndexPath : UICollectionViewLayoutAttributes] = [:]
        var originY: CGFloat = 0

        // MEMO: セクション毎に配置されているセル要素のサイズを再計算してセル属性として適用していく
        for section in 0..<targetCollectionView.numberOfSections {
            var height: CGFloat = 0
            var originX: CGFloat = 0
            for item in 0..<targetCollectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if let itemSize = targetDelegate.collectionView?(targetCollectionView, layout: self, sizeForItemAt: indexPath) {
                    itemAttributes.frame = CGRect(x: originX, y: originY, width: itemSize.width, height: itemSize.height)
                    cellLayoutInfo[indexPath] = itemAttributes
                    originX += itemSize.width
                    height = height > itemSize.height ? height : itemSize.height
                }
            }
            originY += height
        }
        layoutInfo = cellLayoutInfo
    }
}
