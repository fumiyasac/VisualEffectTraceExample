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
import PKHUD

final class SigninViewController: UIViewController {

    // MARK: - SigninFlow

    var coordinator: SigninFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private let tapGestureOfScrollView = UITapGestureRecognizer()

    // MEMO: 適用するValidatorを用意する
    private let mailAddressValidator = SigninScreenValidator.MailAddressValidator()
    private let rawPasswordValidator = SigninScreenValidator.RawPasswordValidator()

    // MEMO: サインイン状態をハンドリングするViewModel
    @Dependencies.Inject(Dependencies.Name(rawValue: "SigninViewModelType")) private var viewModel: SigninViewModelType

    // MARK: - @IBOutlet

    @IBOutlet private weak var signinScrollView: UIScrollView!

    @IBOutlet private weak var mailAddressInputView: FormInputTextFieldView!
    @IBOutlet private weak var rawPasswordInputView: FormInputTextFieldView!

    @IBOutlet private weak var showAnnouncementScreenButton: UIButton!
    @IBOutlet private weak var showSignupScreenButton: UIButton!
    @IBOutlet private weak var signinButton: UIButton!

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
        mailAddressInputView.setFormInputTextFieldStyle(.mailAddressTextInput)

        mailAddressInputView.setTitle("メールアドレス")
        mailAddressInputView.setSummary("登録したメールアドレスを入力して下さい。")
        mailAddressInputView.setRemark("※必須項目", shouldRequired: true)
        mailAddressInputView.setErrorMessage("")
    }

    private func setupRawPasswordInputView() {

        rawPasswordInputView.delegate = self
        rawPasswordInputView.setFormInputTextFieldStyle(.securePasswordTextInput)

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

        // Viewからの入力値の変化に関する処理
        // MEMO: 入力されたメールアドレス/パスワードに応じた画面状態を反映させる
        viewModel.outputs.requestStatus
            .subscribe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] apiRequestState in
                    guard let self = self else { return }

                    // サインイン処理実行時における処理状態に応じたダイアログ表示を実行する
                    self.handleProgressViewState(apiRequestState: apiRequestState)
                }
            )
            .disposed(by: disposeBag)

        // MEMO: 入力されたメールアドレス/パスワードに応じた画面状態を反映させる
        Observable.combineLatest(viewModel.outputs.mailAddress, viewModel.outputs.rawPassword)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] mailAddress, rawPassword in
                    guard let self = self else { return }

                    // メールアドレスに対してバリデーションを実行してエラーメッセージを表示する
                    let targetMailAddressValidationResult = self.mailAddressValidator.validate(mailAddress)
                    self.displayErrorMessageForMailAddressIfNeeded(
                        mailAddressValidationResult: targetMailAddressValidationResult
                    )
                    // パスワードに対してバリデーションを実行してエラーメッセージを表示する
                    let targetRawPasswordValidationResult = self.rawPasswordValidator.validate(rawPassword)
                    self.displayErrorMessageForRawPasswordIfNeeded(
                        rawPasswordValidationResult: targetRawPasswordValidationResult
                    )
                    // ログインボタンの押下状態をコントロールする
                    self.handleSigninButtonState(
                        mailAddressValidationResult: targetMailAddressValidationResult,
                        rawPasswordValidationResult: targetRawPasswordValidationResult
                    )
                }
            )
            .disposed(by: disposeBag)

        // キーボードを閉じるためのGestureRecognizerに関する処理
        tapGestureOfScrollView.rx.event
            .observe(on: MainScheduler.instance)
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
            .observe(on: MainScheduler.instance)
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
            .observe(on: MainScheduler.instance)
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
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }

                    // MEMO: カスタムトランジションに必要なクラスをインスタンス化して、必要な値をセットした上でCoodinatorに引き渡す
                    let announcementScreenTransitioningDelegate = AnnouncementScreenTransitioningDelegate()
                    announcementScreenTransitioningDelegate.screenFrame = self.view.frame
                    self.coordinator?.coordinateToAnnouncement(transitioningDelegate: announcementScreenTransitioningDelegate)
                }
            )
            .disposed(by: disposeBag)
        showSignupScreenButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.coordinator?.coordinateToSignup()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchDown)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSigninButtonAnimationOfTouchDown()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observe(on: MainScheduler.instance)
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
        }, completion: { _ in
            // MEMO: ViewModelに定義したサインイン処理を実行する
            self.viewModel.inputs.executeSigninRequestTrigger.onNext(())
        })
    }

    private func displayErrorMessageForMailAddressIfNeeded(mailAddressValidationResult: ValidationResult) {
        switch mailAddressValidationResult {
        case .invalid(let error):
            mailAddressInputView.setErrorMessage(error.localizedDescription)
        default:
            mailAddressInputView.setErrorMessage("")
        }
    }

    private func displayErrorMessageForRawPasswordIfNeeded(rawPasswordValidationResult: ValidationResult) {
        switch rawPasswordValidationResult {
        case .invalid(let error):
            rawPasswordInputView.setErrorMessage(error.localizedDescription)
        default:
            rawPasswordInputView.setErrorMessage("")
        }
    }

    private func handleSigninButtonState(mailAddressValidationResult: ValidationResult, rawPasswordValidationResult: ValidationResult) {
        switch (mailAddressValidationResult, rawPasswordValidationResult) {
        case (.valid, .valid):
            signinButton.alpha = 1.0
            signinButton.isEnabled = true
        default:
            signinButton.alpha = 0.4
            signinButton.isEnabled = false
        }
    }

    private func handleProgressViewState(apiRequestState: APIRequestState) {
        // MEMO: DispatchQueue.main.asyncを記載しないとクラッシュしてしまったため、その防止策として「DispatchQueue.main.async {...}」を記載している
        DispatchQueue.main.async {
            switch apiRequestState {
            case .none:
                break
            case .requesting:
                // MEMO: 読み込み中のプログレス表示をする
                HUD.show(.labeledProgress(title: "処理中", subtitle: nil))
            case .success:
                // MEMO: 画面の状態を元に戻して、メインのタブ表示画面(GlobalTab)へ遷移する
                HUD.flash(
                    .labeledSuccess(title: "サインイン成功", subtitle: nil),
                    delay: 1.50,
                    completion: { _ in
                        HUD.hide()
                        self.viewModel.inputs.undoAPIRequestStateTrigger.onNext(())
                        self.coordinator?.coordinateToGlobalTab()
                    }
                )
            case .error:
                // MEMO: 入力部分以外の画面の状態を元に戻す
                HUD.flash(
                    .labeledError(title: "サインイン失敗", subtitle: nil),
                    delay: 1.50,
                    completion: { _ in
                        HUD.hide()
                        self.viewModel.inputs.undoAPIRequestStateTrigger.onNext(())
                    }
                )
            }
        }
    }
}

// MARK: - FormTextFieldInputViewDelegate

extension SigninViewController: FormTextFieldInputViewDelegate {

    // MEMO: 配置しているテキストフィールドが変化した際に実行される処理
    // ※ 個々のテキストフィールドに対応する値をタイプを一緒に取得できる様にしているので、場合に応じて利用する形にしている
    func getInputTextByTextFieldType(_ text: String, targetFormInputTextFieldStyle: FormInputTextFieldStyle) {
        switch targetFormInputTextFieldStyle {
        case .mailAddressTextInput:
            viewModel.inputs.inputMailAddressTrigger.onNext(text)
        case .securePasswordTextInput:
            viewModel.inputs.inputRawPasswordTrigger.onNext(text)
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
