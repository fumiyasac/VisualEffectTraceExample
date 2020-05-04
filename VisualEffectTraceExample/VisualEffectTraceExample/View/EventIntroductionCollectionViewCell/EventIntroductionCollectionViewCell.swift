//
//  EventIntroductionCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/04/29.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

// MEMO: サムネイル画像エリアをラップするUIView / 概要等テキスト表示エリアをラップするUIView は高さの制約をつけているがpriorityを999にしている。
// → 1000にするとAutoLayoutの警告が発生するため。

final class EventIntroductionCollectionViewCell: UICollectionViewCell {

    // MARK: -  Properties

    static let cellSize: CGSize = CGSize(width: 240.0, height: 240.0)

    private let eventIntroductionImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.36)), .cacheOriginalImage]

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

    func setCell(_ eventIntroductionEntity: EventIntroductionEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: eventIntroductionEntity.thumbnailUrl) {
            eventIntroductionImageView.kf.setImage(with: url, options: eventIntroductionImageOptions)
        }

        // 引数で受け取ったEntityの内容をUIに反映する
        eventIntroductionTitleLabel.text = eventIntroductionEntity.title
        eventIntroductionAnnouncementDateLabel.text = DateLabelFormatter.getDateStringFromAPI(apiDateString: eventIntroductionEntity.announcementAt)
        eventIntroductionCaptionLabel.text = eventIntroductionEntity.caption
        
        // 属性付きテキスト(本文表示)の設定をする
        let statementAttributedKeys = UILabelDecorator.KeysForDecoration(
            lineSpacing: 5.0,
            font: UIFont(name: "HelveticaNeue-Thin", size: 10.0)!,
            foregroundColor: UIColor.black
        )
        eventIntroductionStatementLabel.attributedText = NSAttributedString(
            string: eventIntroductionEntity.statement,
            attributes: UILabelDecorator.getLabelAttributesBy(keys: statementAttributedKeys)
        )
    }

    func setCellDecoration() {

        // UICollectionViewのおおもとの部分には罫線を付与する
         self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
         self.contentView.layer.borderColor = UIColor.darkGray.cgColor
    }

    // MARK: - Private Function

    private func setupEventIntroductionCollectionViewCell() {
        eventIntroductionImageView.contentMode = .scaleAspectFit
        eventIntroductionImageView.clipsToBounds = true
    }
}
