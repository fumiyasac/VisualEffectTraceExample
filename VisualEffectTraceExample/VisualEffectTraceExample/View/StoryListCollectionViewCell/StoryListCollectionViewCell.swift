//
//  StoryListCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

// MEMO: AutoLayoutの制約に関しての対処
// UICollectionViewのレイアウト属性クラスを独自にカスタマイズをする場合にはレイアウトの警告には注意する必要がある。
// 特に今回のセル表示に関しては縦:260px × 横:260pxのAutoLayoutの制約がセルいっぱいに配置している要素に必要だった。 → つまりは最低サイズを決める制約が決まっていないために発生していた。
// → 「The behavior of the UICollectionViewFlowLayout is not defined because: the item width must be less than the width of the UICollectionView minus the section insets left and right values, minus the content insets left and right values.」 ... のような警告ログが表示される。
// 参考: https://qiita.com/usagimaru/items/e0a4c449d4cdf341e152

final class StoryListCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let cellSize: CGSize = CGSize(width: 260.0, height: 260.0)

    private let storyListImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.36)), .cacheOriginalImage]

    // MARK: - @IBOutlet

    @IBOutlet private weak var storyListImageView: UIImageView!
    @IBOutlet private weak var storyListTitleLabel: UILabel!
    @IBOutlet private weak var storyListDateLabel: UILabel!
    @IBOutlet private weak var storyListAuthorLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupStoryListCollectionViewCell()
    }

    // MARK: - Function

    func setCell(_ storyEntity: StoryEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: storyEntity.thumbnailUrl) {
            storyListImageView.kf.setImage(with: url, options: storyListImageOptions)
        }

        // 引数で受け取ったEntityの内容をUIに反映する
        storyListTitleLabel.text = storyEntity.title
        storyListDateLabel.text = DateLabelFormatter.getDateStringFromAPI(apiDateString: storyEntity.announcementAt)
        storyListAuthorLabel.text = storyEntity.author
    }

    // MARK: - Private Function

    private func setupStoryListCollectionViewCell() {
        storyListImageView.contentMode = .scaleAspectFit
        storyListImageView.clipsToBounds = true
    }
}
