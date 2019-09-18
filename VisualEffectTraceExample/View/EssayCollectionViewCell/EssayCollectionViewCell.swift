//
//  EssayCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import UIKit

final class EssayCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()

        setupEssayCollectionViewCell()
    }

    // MARK: - Function

    func setDecoration(shouldDisplayBorder: Bool = true) {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        if shouldDisplayBorder {
            self.contentView.layer.borderColor = UIColor(code: "#cccccc").cgColor
        } else {
            self.contentView.layer.borderColor = UIColor.white.cgColor
        }
    }

    // MARK: - Private Function

    private func setupEssayCollectionViewCell() {

        // UICollectionViewのcontentViewプロパティには罫線と角丸に関する設定を行う
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor(code: "#cccccc").cgColor
    }
}
