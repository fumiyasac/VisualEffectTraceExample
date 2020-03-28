//
//  TutorialCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/22.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class TutorialCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet

    @IBOutlet private weak var tutorialWrappedView: UIView!
    @IBOutlet private weak var tutorialTitleLabel: UILabel!
    @IBOutlet private weak var tutorialCatchCopyLabel: UILabel!
    @IBOutlet private weak var tutorialImageView: UIImageView!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupTutorialCollectionViewCell()
    }
    
    // MARK: - Function

    func setCell(_ tutorialEntity: TutorialEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        tutorialImageView.image = UIImage(named: tutorialEntity.thumbnail)
        tutorialTitleLabel.text = tutorialEntity.title
        tutorialCatchCopyLabel.text = tutorialEntity.catchCopy
    }

    func setCellDecoration() {

        // UICollectionViewのおおもとの部分にはドロップシャドウに関する設定を行う
        tutorialWrappedView.layer.masksToBounds = false
        tutorialWrappedView.layer.shadowColor = UIColor.systemGray.cgColor
        tutorialWrappedView.layer.shadowOffset = CGSize(width: 1.5, height: 2.0)
        tutorialWrappedView.layer.shadowRadius = 3.0
        tutorialWrappedView.layer.shadowOpacity = 0.36

        // ドロップシャドウの形状をcontentViewに付与した角丸を考慮するようにする
        tutorialWrappedView.layer.shadowPath = UIBezierPath(roundedRect: self.tutorialWrappedView.bounds, cornerRadius: tutorialWrappedView.layer.cornerRadius).cgPath
    }

    // MARK: - Private Function

    private func setupTutorialCollectionViewCell() {
        tutorialImageView.contentMode = .scaleAspectFill
        tutorialImageView.clipsToBounds = true
    }
}
