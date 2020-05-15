//
//  ItemListCollectionHeaderView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/05/04.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit

final class ItemListCollectionHeaderView: UICollectionReusableView {

    // MARK: - @IBOutlet

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    // MARK: - Function

    func setHeader(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}
