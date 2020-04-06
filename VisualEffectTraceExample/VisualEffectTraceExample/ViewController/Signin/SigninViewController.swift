//
//  SigninViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SigninViewController: UIViewController {

    private let disposeBag = DisposeBag()

    // MARK: - Variables

    private let tapGestureOfScrollView = UITapGestureRecognizer()

    // MARK: - SigninFlow

    var coordinator: SigninFlow?

    // MARK: - @IBOutlet

    @IBOutlet private weak var signinScrollView: UIScrollView!

    @IBOutlet private weak var mailAddressInputView: FormInputTextFieldView!
    @IBOutlet private weak var rawPasswordInputView: FormInputTextFieldView!

    @IBOutlet private weak var showAnnouncementScreenButton: UIButton!
    @IBOutlet private weak var showSignupScreenButton: UIButton!
    @IBOutlet private weak var signinButton: UIButton!

    // MARK: - BlockSubscriber

    private lazy var signinScreenSubscriber: BlockSubscriber<SigninScreenState> = BlockSubscriber { [weak self] state in
        guard let self = self else { return }
        // TODO: 画面表示に関連する処理を実行する

    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSigninScrollView()
        setupMailAddressInputView()
        setupRawPasswordInputView()
        setupAnnouncementScreenButton()
        bindToRxSwift()
    }

    // MARK: - Private Fucntion

    private func setupSigninScrollView() {

        signinScrollView.delaysContentTouches = false
        signinScrollView.addGestureRecognizer(tapGestureOfScrollView)
    }

    private func setupMailAddressInputView() {

        mailAddressInputView.delegate = self
        mailAddressInputView.setTitle("メールアドレス")
        mailAddressInputView.setSummary("登録したメールアドレスを入力して下さい。")
        mailAddressInputView.setRemark("※必須項目", shouldRequired: true)
        mailAddressInputView.setErrorMessage("")
    }

    private func setupRawPasswordInputView() {

        rawPasswordInputView.delegate = self
        rawPasswordInputView.setTitle("パスワード")
        rawPasswordInputView.setSummary("登録したパスワードを入力して下さい。")
        rawPasswordInputView.setRemark("※必須項目", shouldRequired: true)
        rawPasswordInputView.setErrorMessage("")
    }

    private func setupAnnouncementScreenButton() {

        showAnnouncementScreenButton.layer.masksToBounds = true
        showAnnouncementScreenButton.layer.cornerRadius = 24.0
    }

    private func bindToRxSwift() {

        // キーボードを閉じるためのGestureRecognizerに関する処理
        tapGestureOfScrollView.rx.event
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.view.endEditing(true)
                }
            )
            .disposed(by: disposeBag)

        // keyboardの開閉に関わる部分のNotificationに関する処理
        // 参考: https://qiita.com/ikemai/items/8d3efcc71ea9db340484
        // 補足: 自前での実装をしなくても良い場合にはRxCommunity/RxKeyboard等を利用するのもアイデアとしては良いと思います。
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] notification in
                    guard let self = self else { return }

                    // キーボードを開く際のObserver処理（キーボードの高さ分だけ中をずらす）
                    // 参考: https://newfivefour.com/swift-ios-xcode-resizing-on-keyboard.html

                    // MEMO: notificationの内容から必要な情報を抽出する（キーボードの情報とアニメーション秒数が必要）
                    guard let userInfo = notification.userInfo as? [String : Any] else {
                        return
                    }
                    guard let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                        return
                    }
                    guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                        return
                    }
                    // MEMO: 得られたキーボード情報から配置しているUIScrollViewのOffset値をキーボードの高さ分だけ動かす
                    let keyboardSize = keyboardInfo.cgRectValue.size
                    let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    UIView.animate(withDuration: duration, animations: {
                        self.signinScrollView.contentInset = contentInsets
                        self.signinScrollView.scrollIndicatorInsets = contentInsets
                        self.view.layoutIfNeeded()
                    })
                }
            )
            .disposed(by: disposeBag)
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] notification in
                    guard let self = self else { return }

                    // MEMO: notificationの内容から必要な情報を抽出する（キーボードの情報とアニメーション秒数が必要）
                    guard let userInfo = notification.userInfo as? [String : Any] else {
                        return
                    }
                    guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
                        return
                    }
                    // MEMO: 配置しているUIScrollViewのOffet値を元に戻す
                    UIView.animate(withDuration: duration, animations: {
                        self.signinScrollView.contentInset = .zero
                        self.signinScrollView.scrollIndicatorInsets = .zero
                        self.view.layoutIfNeeded()
                    })
                }
            )
            .disposed(by: disposeBag)

        // 配置したボタン類をRxSwiftの処理で結合する
        showAnnouncementScreenButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.coordinator?.coordinateToAnnouncement()
                }
            )
            .disposed(by: disposeBag)
        showSignupScreenButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.coordinator?.coordinateToSignup()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchDown)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSigninButtonAnimationOfTouchDown()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSigninButtonAnimationOfTouchUpInside()
                }
            )
            .disposed(by: disposeBag)
    }

    // サインイン実行ボタンの.touchDown時のAnimationを付与する
    private func executeSigninButtonAnimationOfTouchDown() {
        UIView.animate(withDuration: 0.16, animations: {
            self.signinButton.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    // サインイン実行ボタンの.touchUpInside時のAnimationを付与する
    private func executeSigninButtonAnimationOfTouchUpInside() {
        UIView.animate(withDuration: 0.16, animations: {
            self.signinButton.transform = CGAffineTransform.identity
        }, completion: { finished in

            // MEMO: サインイン処理を実行する
        })
    }
}

// MARK: - StoryboardInstantiatable

extension SigninViewController: FormTextFieldInputViewDelegate {

    func getInputTextByTextFieldType(_ text: String, targetFormInputTextFieldStyle: FormInputTextFieldStyle) {

        // 入力されたメールアドレス/パスワードを画面状態を保持するReduxへ反映させる
        switch targetFormInputTextFieldStyle {
        case .mailAddressTextInput:
            SigninScreenActionCreator.inputMailAddress(targetText: text)
        case .securePasswordTextInput:
            SigninScreenActionCreator.inputRawPassword(targetText: text)
        default:
            break
        }
    }
}

// MARK: - StoryboardInstantiatable

extension SigninViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Signin"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
