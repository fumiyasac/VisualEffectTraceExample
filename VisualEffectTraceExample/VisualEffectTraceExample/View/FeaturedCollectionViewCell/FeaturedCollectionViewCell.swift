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

    // MARK: - @IBOutlet

    override func awakeFromNib() {
        super.awakeFromNib()

        setupFeaturedCollectionViewCell()
    }

    // MARK: - Function

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
    }
}
