//
//  ItemCollectionViewCell.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/08/02.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import Kingfisher

final class ItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let itemImageOptions: KingfisherOptionsInfo = [.transition(.fade(0.36)), .cacheOriginalImage]

    // MARK: - @IBOutlet

    @IBOutlet private weak var itemImageView: UIImageView!
    @IBOutlet private weak var itemTitleLabel: UILabel!
    @IBOutlet private weak var itemStatementLabel: UILabel!

    // MARK: - Override

    override func awakeFromNib() {
        super.awakeFromNib()

        setupItemCollectionViewCell()
    }

    // MARK: - Function

    func setCell(_ itemEntity: ItemEntity) {

        // 引数で受け取ったEntityの内容をUIに反映する
        if let url = URL(string: itemEntity.thumbnailUrl) {
            itemImageView.kf.setImage(with: url, options: itemImageOptions)
        }

        // 引数で受け取ったEntityの内容をUIに反映する
        itemTitleLabel.text = itemEntity.title
        itemStatementLabel.text = itemEntity.statement
    }

    // MARK: - Private Function

    private func setupItemCollectionViewCell() {
        itemImageView.contentMode = .scaleAspectFill
        itemImageView.clipsToBounds = true
    }
}
