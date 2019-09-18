//
//  MainCardBaseView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2019/09/18.
//  Copyright © 2019 酒井文也. All rights reserved.
//

import Foundation
import UIKit

final class MainCardBaseView: CustomViewBase {

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)

        setupMainCardBaseView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupMainCardBaseView()
    }

    // MARK: - Private Function

    private func setupMainCardBaseView() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
    }
}
