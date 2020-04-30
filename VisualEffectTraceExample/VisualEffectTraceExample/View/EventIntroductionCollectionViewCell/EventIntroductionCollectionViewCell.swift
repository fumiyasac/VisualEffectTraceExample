//
//  EventIntroductionCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class EventIntroductionCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet

    @IBOutlet private weak var eventIntroductionImageView: UIImageView!
    @IBOutlet private weak var eventIntroductionTitleLabel: UILabel!
    @IBOutlet private weak var eventIntroductionAnnouncementDateLabel: UILabel!
    @IBOutlet private weak var eventIntroductionCaptionLabel: UILabel!
    @IBOutlet private weak var eventIntroductionStatementLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupEventIntroductionCollectionViewCell()
    }

    // MARK: - Function

    func setCellDecoration() {

        // UICollectionViewのおおもとの部分には罫線を付与する
         self.contentView.layer.masksToBounds = true
         self.contentView.layer.borderWidth = 1.0
         self.contentView.layer.borderColor = UIColor.systemGray6.cgColor
    }

    // MARK: - Private Function

    private func setupEventIntroductionCollectionViewCell() {
        eventIntroductionImageView.contentMode = .scaleAspectFit
        eventIntroductionImageView.clipsToBounds = true
    }
}
