//
//  RecentAnnouncementCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/21.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

final class RecentAnnouncementCollectionViewCell: UICollectionViewCell {

    // MARK: -  Properties

    private let announceImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.64)), .cacheOriginalImage]

    // MARK: - @IBOutlet

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statementLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupRecentAnnouncementCollectionViewCell()
    }

    // MARK: - Function

    func setCell(_ announcementEntity: AnnouncementEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: announcementEntity.thumbnailUrl) {
            thumbnailImageView.kf.setImage(with: url, options: announceImageOptions)
        }

        // 属性付きテキスト(タイトル表示)の設定をする
        let titleAttributedKeys = UILabelDecorator.KeysForDecoration(
            lineSpacing: 6.0,
            font: UIFont(name: "HelveticaNeue-Bold", size: 13.0)!,
            foregroundColor: UIColor.black
        )
        titleLabel.attributedText = NSAttributedString(
            string: announcementEntity.title,
            attributes: UILabelDecorator.getLabelAttributesBy(keys: titleAttributedKeys)
        )

        // 属性付きテキスト(本文表示)の設定をする
        let statementAttributedKeys = UILabelDecorator.KeysForDecoration(
            lineSpacing: 6.0,
            font: UIFont(name: "HelveticaNeue-Bold", size: 11.0)!,
            foregroundColor: UIColor.systemGray
        )
        statementLabel.attributedText = NSAttributedString(
            string: announcementEntity.statement,
            attributes: UILabelDecorator.getLabelAttributesBy(keys: statementAttributedKeys)
        )
    }

    // MARK: - Private Function

    private func setupRecentAnnouncementCollectionViewCell() {

        // UICollectionViewのおおもとの部分には罫線を付与する
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.layer.borderWidth = 0.5
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor

        // サムネイル画像を表示するUIImageViewの設定
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
    }
}
