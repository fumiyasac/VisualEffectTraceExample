//
//  TopBannerCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class TopBannerCollectionViewCell: UICollectionViewCell {

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

    // MARK: - Private Function

    private func setupTopBannerCollectionViewCell() {
        topBannerImageView.contentMode = .scaleAspectFit
        topBannerImageView.clipsToBounds = true
    }
}
