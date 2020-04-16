//
//  AnnouncementTableViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/13.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

final class AnnouncementTableViewCell: UITableViewCell {

    private let announceImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.64)), .cacheOriginalImage]

    // MARK: - @IBOutlet

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statementLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupAnnouncementTableViewCell()
    }

    // MARK: - Function
 
    func setCell(_ announcementEntity: AnnouncementEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: announcementEntity.thumbnailUrl) {
            thumbnailImageView.kf.setImage(with: url, options: announceImageOptions)
        }
        titleLabel.text = announcementEntity.title
        statementLabel.text = announcementEntity.statement
    }

    // MARK: - Private Function

    private func setupAnnouncementTableViewCell() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
    }
}
