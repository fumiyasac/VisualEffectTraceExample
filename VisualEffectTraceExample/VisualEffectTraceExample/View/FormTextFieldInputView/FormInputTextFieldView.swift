//
//  FormTextFieldInputView.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// MARK: - Protocol

// MEMO: View同士の処理の接続はProtocolを経由する方針とする
protocol FormTextFieldInputViewDelegate: NSObjectProtocol {

    // MEMO: テキストフィールドの入力を変更した際の処理を画面へ伝える
    func getInputTextByTextFieldType(_ text: String, targetFormInputTextFieldStyle: FormInputTextFieldStyle)
}

// MEMO: 利用しない場合やIBのエラーが出る場合は`@IBDesignable`をコメントする
@IBDesignable
class FormInputTextFieldView: CustomViewBase {

    private let disposeBag = DisposeBag()

    // MARK: -  FormTextFieldInputViewDelegate

    weak var delegate: FormTextFieldInputViewDelegate?

    // MARK: -  Variable

    // MEMO: 入力フィールドのタイプを格納する変数（デフォルト値を設定しておく）
    private var targetFormInputTextFieldStyle: FormInputTextFieldStyle = .defaultTextInput

    // MEMO: 入力フィールドをSecure状態にするかどうかのフラグ値を格納する変数（デフォルト値を設定しておく）
    private var shouldSecure: Bool = false

    // MARK: - @IBOutlet

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var remarkLabel: UILabel!
    @IBOutlet private weak var errorMessageLabel: UILabel!

    // 入力用のテキストフィールドやパスワード可視化用のボタンをまとめるUIView
    // ※ UIStackViewには罫線をはじめとするlayerプロパティの装飾が適用されない点に注意
    @IBOutlet private weak var inputTextFieldWrappedView: UIView!

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

    func setInitialText(_ text: String) {
        inputTextField.text = text
    }

    func setErrorMessage(_ text: String) {
        errorMessageLabel.text = text
    }

    func setFormInputTextFieldStyle(_ formInputTextFieldStyle: FormInputTextFieldStyle) {
        targetFormInputTextFieldStyle = formInputTextFieldStyle
        setShowPasswordButtonState()
        setTextFieldContentTypeAndKeyboardType()
    }

    // MARK: - Private Function

    private func setShowPasswordButtonState() {

        // MEMO: FormInputTextFieldStyleがパスワード入力の場合にはパスワード表示ボタンを非表示にする
        let shouldDisplayShowPasswordButton = (targetFormInputTextFieldStyle == .securePasswordTextInput)
        if shouldDisplayShowPasswordButton {
            shouldSecure = true
            showPasswordButton.isHidden = false
            showPasswordButtonWidthConstraint.constant = 33.0
        } else {
            shouldSecure = false
            showPasswordButton.isHidden = true
            showPasswordButtonWidthConstraint.constant = 0
        }
    }

    private func setTextFieldContentTypeAndKeyboardType() {

        var keyboardType: UIKeyboardType
        var contentType: UITextContentType

        switch targetFormInputTextFieldStyle {
        case .mailAddressTextInput:
            contentType = .emailAddress
            keyboardType = .emailAddress
        case .telephoneNumberTextInput:
            contentType = .telephoneNumber
            keyboardType = .numberPad
        default:
            // MEMO: 特段この設定が必要ない場合はスキップしてしまう
            return
        }
        inputTextField.textContentType = contentType
        inputTextField.keyboardType = keyboardType
    }

    private func showPasswordButtonTapped() {

        // MEMO: パスワード表示を見える状態にする
        shouldSecure = !shouldSecure
        inputTextField.isSecureTextEntry = !shouldSecure
    }

    private func setupFormTextFieldInputView() {

        // 入力エリア部分に罫線を付与する
        inputTextFieldWrappedView.layer.borderWidth = 1.0
        inputTextFieldWrappedView.layer.borderColor = UIColor.opaqueSeparator.cgColor

        // このViewにおける初期状態を決定する
        setShowPasswordButtonState()
        setTextFieldContentTypeAndKeyboardType()
        
        // テキストフィールドの変化を検知した際のアクション設定
        inputTextField.rx.text
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] targetText in
                    guard let self = self else { return }
                    if let targetText = self.inputTextField.text {
                        self.delegate?.getInputTextByTextFieldType(targetText, targetFormInputTextFieldStyle: self.targetFormInputTextFieldStyle)
                    }
                }
            )
            .disposed(by: disposeBag)

        // ボタン押下時のアクション設定
        showPasswordButton.rx.controlEvent(.touchUpInside)
            .asDriver(onErrorJustReturn: ())
            .drive(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.showPasswordButtonTapped()
                }
            )
            .disposed(by: disposeBag)
    }
}
