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

protocol FormTextFieldInputViewDelegate: NSObjectProtocol {

    // MEMO: テキストフィールドの入力を変更した際の処理を画面へ伝える
    func getInputTextByTextFieldType(_ text: String, style: FormInputTextFieldStyle)
}

// MEMO: 利用しない場合やIBのエラーが出る場合は`@IBDesignable`をコメントする
//@IBDesignable
class FormTextFieldInputView: CustomViewBase {

    weak var delegate: FormTextFieldInputViewDelegate?

    // MARK: -  Variable

    // MEMO: 入力フィールドのタイプを格納する変数（デフォルト値を設定しておく）
    private var selectedType: FormInputTextFieldStyle = .defaultTextInput

    private var shouldSecure: Bool = true

    // MARK: - @IBOutlet

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var remarkLabel: UILabel!
    @IBOutlet private weak var errorMessageLabel: UILabel!

    // 入力用のテキストフィールド
    @IBOutlet private weak var inputTextField: UITextField!

    // パスワード可視化用のボタン
    @IBOutlet private weak var showPasswordButton: UIButton!
    // MEMO: パスワード入力時以外は非表示かつ幅調整をするための制約値
    @IBOutlet private weak var showPasswordButtonWidthConstraint: NSLayoutConstraint!

    // MARK: - Initializer

    required init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFormTextFieldInputView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupFormTextFieldInputView()
    }

    // MARK: - Function

    func setTitle(_ text: String) {
        titleLabel.text = text
    }

    func setRemark(_ text: String, shouldRequired: Bool = false) {
        remarkLabel.textColor = shouldRequired ? UIColor.red : UIColor.lightGray
        remarkLabel.text = text
    }

    func setSummary(_ text: String) {
        summaryLabel.text = text
    }

    func setPlaceholder(_ text: String) {
        inputTextField.placeholder = text
    }

    func setFormInputTextFieldStyle(_ style: FormInputTextFieldStyle) {
        displayShowPasswordButtonIfNeeded(style)
    }

    // MARK: - Private Function

    @objc func textFieldDidChange() {

        if let targetText = inputTextField.text {
            self.delegate?.getInputTextByTextFieldType(targetText, style: selectedType)
        }
    }

    @objc func showPasswordButtonTapped() {

        // MEMO: パスワード表示を見える状態にする
        shouldSecure = !shouldSecure
        inputTextField.isSecureTextEntry = !shouldSecure
    }

    private func displayShowPasswordButtonIfNeeded(_ style: FormInputTextFieldStyle) {

        // MEMO: FormInputTextFieldStyleがパスワード入力の場合にはパスワード表示ボタンを非表示にする
        if style == .secureTextInput {
            showPasswordButton.isHidden = false
            showPasswordButtonWidthConstraint.constant = 33.0
        } else {
            showPasswordButton.isHidden = true
            showPasswordButtonWidthConstraint.constant = 0
        }
    }

    private func setupFormTextFieldInputView() {

        // テキストフィールドの変化を検知した際のアクション設定
        inputTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)

        // ボタン押下時のアクション設定
        showPasswordButton.addTarget(self, action:  #selector(self.showPasswordButtonTapped), for: .touchUpInside)
    }
}
