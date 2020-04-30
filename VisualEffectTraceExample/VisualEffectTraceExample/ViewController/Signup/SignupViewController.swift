//
//  SignupViewController.swift
//  VisualEffectTraceExample
//
//  Created by 酒井文也 on 2020/03/31.
//  Copyright © 2020 酒井文也. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

final class SignupViewController: UIViewController {

    // MARK: - SignupFlow

    var coordinator: SignupFlow?

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    private let tapGestureOfScrollView = UITapGestureRecognizer()

    // MEMO: もし値の中継が必要になった場合にはBehaviorRelay<T>を別途用意する
    private let inputUserName: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    private let inputMailAddress: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    private let inputRawPassword: BehaviorRelay<String?> = BehaviorRelay<String?>(value: nil)
    private let shouldEnableSignupButton: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    // MEMO: 適用するValidatorを用意する
    private let userNameValidator = SignupScreenValidator.UserNameValidator()
    private let mailAddressValidator = SignupScreenValidator.MailAddressValidator()
    private let rawPasswordValidator = SignupScreenValidator.RawPasswordValidator()

    // MEMO: サインアップ状態をハンドリングするViewModel
    private let viewModel = SignupViewModel(
        // MEMO: サインアップ実行用のUseCase
        requestSignupUseCase: RequestSignupUseCase(
            signupRepository: RequestSignupRepository(
                apiRequestManager: APIRequestManager.shared
            )
        )
    )

    // MARK: - @IBOutlet

    @IBOutlet private weak var signupScrollView: UIScrollView!

    @IBOutlet private weak var userNameInputView: FormInputTextFieldView!
    @IBOutlet private weak var mailAddressInputView: FormInputTextFieldView!
    @IBOutlet private weak var rawPasswordInputView: FormInputTextFieldView!

    @IBOutlet private weak var closeSignupScreenButton: UIButton!
    @IBOutlet private weak var showTermsOfServiceButton: UIButton!
    @IBOutlet private weak var showPrivacyPolicyButton: UIButton!
    @IBOutlet private weak var signupButton: UIButton!

    // MARK: - BlockSubscriber

    private lazy var signupScreenSubscriber: BlockSubscriber<SignupScreenState> = BlockSubscriber { [weak self] state in
        guard let self = self else { return }

        // MEMO: UI要素への反映を実行する場合はメインスレッドで処理を実行する
        DispatchQueue.main.async {

            // ユーザーネームに対してバリデーションを実行してエラーメッセージを表示する
            let targetUserNameValidationResult = self.userNameValidator.validate(state.userName)
            self.displayErrorMessageForUserNameIfNeeded(
                userNameValidationResult: targetUserNameValidationResult
            )
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
            self.handleSignupButtonState(
                userNameValidationResult: targetUserNameValidationResult,
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

        setupSignupScrollView()
        setupCloseSignupScreenButton()
        setupUserNameInputView()
        setupMailAddressInputView()
        setupRawPasswordInputView()
        bindToRxSwift()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 購読対象のStateをBlockSubscriberを利用して決定する
        appStore.subscribe(self.signupScreenSubscriber) { state in
            state.select { state in state.signupScreenState }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // 購読対象のStateを解除する
        appStore.unsubscribe(self.signupScreenSubscriber)
    }

    // MARK: - Private Fucntion

    private func setupSignupScrollView() {

        signupScrollView.delaysContentTouches = false
        signupScrollView.addGestureRecognizer(tapGestureOfScrollView)
    }

    private func setupCloseSignupScreenButton() {

        closeSignupScreenButton.layer.masksToBounds = true
        closeSignupScreenButton.layer.cornerRadius = 18.0
    }

    private func setupUserNameInputView() {

        userNameInputView.delegate = self
        userNameInputView.setFormInputTextFieldStyle(.userNameTextInput)

        userNameInputView.setTitle("ユーザーネーム")
        userNameInputView.setSummary("登録したユーザーネームを入力して下さい。")
        userNameInputView.setRemark("※必須項目", shouldRequired: true)
        userNameInputView.setErrorMessage("")
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
                        SignupScreenActionCreator.changeStateToProcessingSignup()
                    case .success:
                        SignupScreenActionCreator.changeStateToSignupSuccess()
                    case .error:
                        SignupScreenActionCreator.changeStateToSignupError()
                    }
                }
            )
            .disposed(by: disposeBag)

        // Viewからの入力値の変化に関する処理
        // MEMO: 入力されたユーザーネーム/メールアドレス/パスワードを画面状態を保持するReduxへ反映させる
        inputUserName
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { userName in
                    guard let userName = userName else { return }
                    SignupScreenActionCreator.inputUserName(targetText: userName)
                }
            )
            .disposed(by: disposeBag)
        inputMailAddress
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { mailAddress in
                    guard let mailAddress = mailAddress else { return }
                    SignupScreenActionCreator.inputMailAddress(targetText: mailAddress)
                }
            )
            .disposed(by: disposeBag)
        inputRawPassword
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { rawPassword in
                    guard let rawPassword = rawPassword else { return }
                    SignupScreenActionCreator.inputRawPassword(targetText: rawPassword)
                }
            )
            .disposed(by: disposeBag)
        shouldEnableSignupButton
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] result in
                    guard let self = self else { return }
                    self.signupButton.alpha = result ? 1.0 : 0.4
                    self.signupButton.isEnabled = result
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
                        self.signupScrollView.contentInset = contentInsets
                        self.signupScrollView.scrollIndicatorInsets = contentInsets
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
                        self.signupScrollView.contentInset = .zero
                        self.signupScrollView.scrollIndicatorInsets = .zero
                        self.view.layoutIfNeeded()
                    })
                }
            )
            .disposed(by: disposeBag)

        // 配置したボタン類をRxSwiftの処理で結合する
        closeSignupScreenButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.coordinator?.dismissSignup()
                }
            )
            .disposed(by: disposeBag)
        showTermsOfServiceButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                    // TODO: 利用規約ページへ遷移する
                    print("利用規約ページへ遷移する")
                }
            )
            .disposed(by: disposeBag)
        showPrivacyPolicyButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { _ in
                    // TODO: プライバシーポリシーページへ遷移する
                    print("プライバシーポリシーページへ遷移する")
                }
            )
            .disposed(by: disposeBag)
        signupButton.rx.controlEvent(.touchDown)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSignupButtonAnimationOfTouchDown()
                }
            )
            .disposed(by: disposeBag)
        signupButton.rx.controlEvent(.touchUpInside)
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] _ in
                    guard let self = self else { return }
                    self.executeSignupButtonAnimationOfTouchUpInside()
                }
            )
            .disposed(by: disposeBag)
    }

    // サインアップ実行ボタンの.touchDown時のAnimationを付与する
    private func executeSignupButtonAnimationOfTouchDown() {
        UIView.animate(withDuration: 0.16, animations: {
            self.signupButton.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    // サインアップ実行ボタンの.touchUpInside時のAnimationを付与する
    private func executeSignupButtonAnimationOfTouchUpInside() {
        UIView.animate(withDuration: 0.16, animations: {
            self.signupButton.transform = CGAffineTransform.identity
        }, completion: { finished in
            // MEMO: ViewModelに定義したサインアップ処理を実行する
            if let targetUserName = self.inputUserName.value, let targetMailAddress = self.inputMailAddress.value, let targetRawPassword = self.inputRawPassword.value {
                let signupParameters = SignupViewModel.SignupPatameters(
                    targetUserName: targetUserName,
                    targetMailAddress: targetMailAddress,
                    targetRawPassword: targetRawPassword
                )
                self.viewModel.executeSignupRequestTrigger.onNext(signupParameters)
            }
        })
    }

    private func displayErrorMessageForUserNameIfNeeded(userNameValidationResult: ValidationResult) {
        switch userNameValidationResult {
        case .invalid(let error):
            userNameInputView.setErrorMessage(error.localizedDescription)
        default:
            userNameInputView.setErrorMessage("")
        }
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

    private func handleSignupButtonState(userNameValidationResult: ValidationResult, mailAddressValidationResult: ValidationResult, rawPasswordValidationResult: ValidationResult) {
        switch (userNameValidationResult, mailAddressValidationResult, rawPasswordValidationResult) {
        case (.valid, .valid, .valid):
            shouldEnableSignupButton.accept(true)
        default:
            shouldEnableSignupButton.accept(false)
        }
    }

    private func handleProgressViewState(state: SignupScreenState) {
        switch state {
        case _ where state.isProcessionSignupRequest:
            // MEMO: 読み込み中のプログレス表示をする
            HUD.show(.labeledProgress(title: "処理中", subtitle: nil))
        case _ where state.isSignupRequestSuccess:
            // MEMO: 画面の状態を元に戻して、サインイン画面へ戻る
            HUD.flash(
                .labeledSuccess(title: "サインアップ成功", subtitle: nil),
                delay: 1.50,
                completion: { _ in
                    HUD.hide()
                    SignupScreenActionCreator.changeStateToInitial()
                    self.coordinator?.dismissSignup()
                }
            )
        case _ where state.isSignupRequestError:
            // MEMO: 入力部分以外の画面の状態を元に戻す
            HUD.flash(
                .labeledError(title: "サインアップ失敗", subtitle: nil),
                delay: 1.50,
                completion: { _ in
                    HUD.hide()
                    SignupScreenActionCreator.changeStateToSignupNormal()
                }
            )
        default:
            break
        }
    }
}

// MARK: - FormTextFieldInputViewDelegate

extension SignupViewController: FormTextFieldInputViewDelegate {

    func getInputTextByTextFieldType(_ text: String, targetFormInputTextFieldStyle: FormInputTextFieldStyle) {

        // 受け取った値を中継地点となる変数へ格納しておく（ここではユーザーネーム/メールアドレス/パスワードのBehaviorRelay<String?>に値をセットする）
        switch targetFormInputTextFieldStyle {
        case .userNameTextInput:
            inputUserName.accept(text)
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

extension SignupViewController: StoryboardInstantiatable {

    // このViewControllerに対応するStoryboard名
    static var storyboardName: String {
        return "Signup"
    }

    // このViewControllerに対応するViewControllerのIdentifier名
    static var viewControllerIdentifier: String? {
        return nil
    }
}
