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

    // MEMO: もし値の中継が必要になった場合にはBehaviorRelay<T>を別途用意する
    private let inputMailAddress: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    private let inputRawPassword: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    private let shouldEnableSigninButton: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    // MEMO: 適用するValidatorを用意する
    private let mailAddressValidator = SigninScreenValidator.MailAddressValidator()
    private let rawPasswordValidator = SigninScreenValidator.RawPasswordValidator()

    // MEMO: サインイン状態をハンドリングするViewModel
    private let viewModel = SigninViewModel()

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

        // MEMO: UI要素への反映を実行する場合はメインスレッドで処理を実行する
        DispatchQueue.main.async {

            // メールアドレスに対してバリデーションを実行してエラーメッセージを表示する
            let targetMailAddressValidationResult = self.mailAddressValidator.validate(state.mailAddress)
            self.displayErrorMessageForMailAddressIfNeeded(
                mailAddressValidationResult: targetMailAddressValidationResult
            )
            // パスワードに対してバリデーションを実行してエラーメッセージを表示する
            let targetRawPasswordValidationResult = self.rawPasswordValidator.validate(state.rawPassword)
            self.displayErrorMessageForRawPasswordIfNeeded(
                rawPasswordValidationResult: targetRawPasswordValidationResult
            )
            // ログインボタンの押下状態をコントロールする
            self.handleSigninButtonState(
                mailAddressValidationResult: targetMailAddressValidationResult,
                rawPasswordValidationResult: targetRawPasswordValidationResult
            )
            // 画面全体に表示するプログレスバーの状態をコントロールする
            self.handleProgressViewState(state: state)
        }
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 購読対象のStateをBlockSubscriberを利用して決定する
        appStore.subscribe(self.signinScreenSubscriber) { state in
            state.select { state in state.signinScreenState }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 購読対象のStateを解除する
        appStore.unsubscribe(self.signinScreenSubscriber)
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

        // ViewModelからの入力＆出力値の変化に関する処理
        viewModel.outputs.requestStatus
            .subscribeOn(MainScheduler.instance)
            .subscribe(
                onNext: { apiRequestStatus in

                    // MEMO: Redux側の処理を更新することでUI表示を変化させる
                    switch apiRequestStatus {
                    case .none:
                        break
                    case .requesting:
                        SigninScreenActionCreator.changeStateToProcessingSignin()
                    case .success:
                        SigninScreenActionCreator.changeStateToSigninSuccess()
                    case .error:
                        SigninScreenActionCreator.changeStateToSigninError()
                    }
                }
            )
            .disposed(by: disposeBag)

        // Viewからの入力値の変化に関する処理
        // MEMO: 入力されたメールアドレス/パスワードを画面状態を保持するReduxへ反映させる
        inputMailAddress
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { mailAddress in
                    guard let mailAddress = mailAddress else { return }
                    SigninScreenActionCreator.inputMailAddress(targetText: mailAddress)
                }
            )
            .disposed(by: disposeBag)
        inputRawPassword
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { rawPassword in
                    guard let rawPassword = rawPassword else { return }
                    SigninScreenActionCreator.inputRawPassword(targetText: rawPassword)
                }
            )
            .disposed(by: disposeBag)
        shouldEnableSigninButton
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] result in
                    guard let self = self else { return }
                    self.signinButton.alpha = result ? 1.0 : 0.4
                    self.signinButton.isEnabled = result
                }
            )
            .disposed(by: disposeBag)

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
            .observeOn(MainScheduler.instance)
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
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.coordinator?.coordinateToSignup()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchDown)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSigninButtonAnimationOfTouchDown()
                }
            )
            .disposed(by: disposeBag)
        signinButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observeOn(MainScheduler.instance)
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
            // MEMO: ViewModelに定義したサインイン処理を実行する
            if let targetMailAddress = self.inputMailAddress.value, let targetRawPassword = self.inputRawPassword.value {
                let signinParameters = SigninViewModel.SigninPatameters(
                    targetMailAddress: targetMailAddress,
                    targetRawPassword: targetRawPassword
                )
                self.viewModel.executeSigninRequestTrigger.onNext(signinParameters)
            }
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
            shouldEnableSigninButton.accept(true)
        default:
            shouldEnableSigninButton.accept(false)
        }
    }

    private func handleProgressViewState(state: SigninScreenState) {
        switch state {
        case _ where state.isProcessionSigninRequest:
            // MEMO: 読み込み中のプログレス表示をする
            HUD.show(.labeledProgress(title: "処理中", subtitle: nil))
        case _ where state.isSigninRequestSuccess:
            // MEMO: 画面の状態を元に戻して、メインのタブ表示画面(GlobalTab)へ遷移する
            HUD.flash(
                .labeledSuccess(title: "サインイン成功", subtitle: nil),
                delay: 1.50,
                completion: { _ in
                    HUD.hide()
                    SigninScreenActionCreator.changeStateToInitial()
                    self.coordinator?.coordinateToGlobalTab()
                }
            )
        case _ where state.isSigninRequestError:
            // MEMO: 入力部分以外の画面の状態を元に戻す
            HUD.flash(
                .labeledError(title: "サインイン失敗", subtitle: nil),
                delay: 1.50,
                completion: { _ in
                    HUD.hide()
                    SigninScreenActionCreator.changeStateToSigninNormal()
                }
            )
        default:
            break
        }
    }
}

// MARK: - FormTextFieldInputViewDelegate

extension SigninViewController: FormTextFieldInputViewDelegate {

    func getInputTextByTextFieldType(_ text: String, targetFormInputTextFieldStyle: FormInputTextFieldStyle) {

        // 受け取った値を中継地点となる変数へ格納しておく（ここではメールアドレスとパスワードのBehaviorRelay<String?>に値をセットする）
        switch targetFormInputTextFieldStyle {
        case .mailAddressTextInput:
            inputMailAddress.accept(text)
        case .securePasswordTextInput:
            inputRawPassword.accept(text)
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
