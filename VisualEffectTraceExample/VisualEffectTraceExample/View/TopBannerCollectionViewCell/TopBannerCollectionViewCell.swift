//
//  TopBannerCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

final class TopBannerCollectionViewCell: UICollectionViewCell {

    // MARK: -  Properties

    static let cellSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 126.0 / 375.0)

    private let topBannerImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.36)), .cacheOriginalImage]

    // MARK: - @IBOutlet

    @IBOutlet private weak var topBannerImageView: UIImageView!
    @IBOutlet private weak var topBannerAnnouncementDateLabel: UILabel!
    @IBOutlet private weak var topBannerCaptionLabel: UILabel!
    @IBOutlet private weak var topBannerTitleLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupTopBannerCollectionViewCell()
    }

    // MARK: - Function

    func setCell(_ topBannerEntity: TopBannerEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: topBannerEntity.bannerUrl) {
            topBannerImageView.kf.setImage(with: url, options: topBannerImageOptions)
        }

        // 引数で受け取ったEntityの内容をUIに反映する
        topBannerTitleLabel.text = topBannerEntity.title
        topBannerCaptionLabel.text = topBannerEntity.caption
        topBannerAnnouncementDateLabel.text = DateLabelFormatter.getDateStringFromAPI(apiDateString: topBannerEntity.announcementAt)
    }

    // MARK: - Private Function

    private func setupTopBannerCollectionViewCell() {
        topBannerImageView.contentMode = .scaleAspectFit
        topBannerImageView.clipsToBounds = true
    }
}
