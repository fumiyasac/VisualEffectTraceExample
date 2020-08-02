//
//  FeaturedCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/09.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

final class FeaturedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    private let featuredImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.36)), .cacheOriginalImage]
    
    // MARK: - @IBOutlet

    @IBOutlet private weak var featuredImageView: UIImageView!
    @IBOutlet private weak var featuredTitleLabel: UILabel!
    @IBOutlet private weak var featuredCatchCopyLabel: UILabel!
    @IBOutlet private weak var featuredStatementLabel: UILabel!
    
    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupFeaturedCollectionViewCell()
    }

    // MARK: - Function

    func setCell(_ featuredArticleEntity: FeaturedArticleEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: featuredArticleEntity.thumbnailUrl) {
            featuredImageView.kf.setImage(with: url, options: featuredImageOptions)
        }

        // 引数で受け取ったEntityの内容をUIに反映する
        featuredTitleLabel.text = featuredArticleEntity.title
        featuredCatchCopyLabel.text = featuredArticleEntity.catchCopy

        // 属性付きテキスト(本文表示)の設定をする
        let statementAttributedKeys = UILabelDecorator.KeysForDecoration(
            lineSpacing: 6.0,
            font: UIFont(name: "HelveticaNeue-Bold", size: 11.0)!,
            foregroundColor: UIColor.white
        )
        featuredStatementLabel.attributedText = NSAttributedString(
            string: featuredArticleEntity.statement,
            attributes: UILabelDecorator.getLabelAttributesBy(keys: statementAttributedKeys)
        )
    }

    func setDecoration(shouldDisplayBorder: Bool = true) {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        if shouldDisplayBorder {
            self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            self.contentView.layer.borderColor = UIColor.clear.cgColor
        }
    }

    // MARK: - Private Function

    private func setupFeaturedCollectionViewCell() {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.backgroundColor = UIColor(code: "#eeeeee")

        // サムネイル画像を表示するUIImageViewの設定
        featuredImageView.contentMode = .scaleAspectFill
        featuredImageView.clipsToBounds = true
    }
}
