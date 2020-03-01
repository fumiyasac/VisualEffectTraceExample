package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.ApplicationUserService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.request.user.CreateUserRequest
import net.just1factory.visual_effect_example.app.request.user.LoginUserRequest
import net.just1factory.visual_effect_example.app.response.user.signup.UserSignupResponse
import net.just1factory.visual_effect_example.app.response.user.signin.UserSigninResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.UnprocessableEntityException
import net.just1factory.visual_effect_example.context.exception.ConflictException
import net.just1factory.visual_effect_example.context.exception.UnauthorizedException

// Spring Frameworkのインポート宣言
import org.springframework.validation.annotation.Validated
import org.springframework.validation.BindingResult

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestBody

@RestController
@RequestMapping("/api/v1")
class ApplicationUserController {

	@Autowired
	private lateinit var applicationUserService: ApplicationUserService

	// MEMO: 新規会員登録処理を実行する
	@PostMapping("/signup")
	fun createUser(@RequestBody @Validated createUserRequest: CreateUserRequest, bindingResult: BindingResult) : UserSignupResponse {

		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}

		val userName = createUserRequest.userName!!
		val mailAddress = createUserRequest.mainAddress!!
		val rawPassword = createUserRequest.rawPassword!!

		// MEMO: 同一ユーザーが存在する場合はConflictExceptionを投げる
		val foundApplicationUser = applicationUserService.findByUserNameAndMailAddress(
			userName = userName,
			mailAddress = mailAddress
		)
		if (foundApplicationUser != null) {
			throw ConflictException("このユーザーは既に存在しています。")
		}

		// MEMO: 送信された会員情報をDBへ保存するための処理をUserServiceクラスを利用して実施する
		applicationUserService.save(
			userName = userName,
			mailAddress = mailAddress,
			rawPassword = rawPassword
		)

		// Debug.
		println("userName:" + userName)
		println("mainAddress:" + mailAddress)
		println("rawPassword:" + rawPassword)

		return UserSignupResponse("OK")
	}

	// MEMO: ログイン処理を実行する
	@PostMapping("/signin")
	fun createUser(@RequestBody @Validated loginUserRequest: LoginUserRequest, bindingResult: BindingResult) : UserSigninResponse {

		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}

		val mailAddress = loginUserRequest.mainAddress!!
		val rawPassword = loginUserRequest.rawPassword!!

		// MEMO: 同一ユーザーが存在しない場合はUnauthorizedExceptionを投げる
		val foundApplicationUser = applicationUserService.findByMailAddressAndPassword(
			mailAddress = mailAddress,
			rawPassword = rawPassword
		)
		if (foundApplicationUser != null) {
			throw UnauthorizedException("入力したパスワードまたはメールアドレスに誤りがあります。")
		}

		// Debug.
		println("mainAddress:" + mailAddress)
		println("rawPassword:" + rawPassword)

		// TODO: 認証用のトークンについても一緒に返却するように変更する
		return UserSigninResponse("OK")
	}

	// MEMO: デバッグ時に表示する情報を取得する
	@GetMapping("/debug")
	fun example(): String {
		return "認証が通過したら閲覧可能です!"
	}
}