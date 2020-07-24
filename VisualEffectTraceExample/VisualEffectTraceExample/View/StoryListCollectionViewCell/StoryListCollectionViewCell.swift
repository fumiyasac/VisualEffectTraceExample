//
//  StoryListCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/07/25.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

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
