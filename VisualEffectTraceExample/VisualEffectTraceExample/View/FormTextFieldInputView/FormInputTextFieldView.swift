//
//  FormTextFieldInputView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol

protocol FormTextFieldInputViewDelegate: NSObjectProtocol {}

// MEMO: 利用しない場合は`@IBDesignable`をコメントしてしまっても良い
//@IBDesignable
class FormTextFieldInputView: CustomViewBase {

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFormTextFieldInputView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupFormTextFieldInputView()
    }

    // MARK: - Private Function

    private func setupFormTextFieldInputView() {
        
    }
}
