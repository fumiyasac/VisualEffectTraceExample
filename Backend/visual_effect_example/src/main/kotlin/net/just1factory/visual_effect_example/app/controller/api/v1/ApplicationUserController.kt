package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.ApplicationUserService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.request.user.CreateUserRequest
import net.just1factory.visual_effect_example.app.request.user.LoginUserRequest
import net.just1factory.visual_effect_example.app.response.user.signup.UserSignupResponse
import net.just1factory.visual_effect_example.app.response.user.signin.UserSigninResponse

// コンテキスト層（JWT・Exception）
import net.just1factory.visual_effect_example.context.jwt.JWTGenerator
import net.just1factory.visual_effect_example.context.exception.UnprocessableEntityException
import net.just1factory.visual_effect_example.context.exception.ConflictException
import net.just1factory.visual_effect_example.context.exception.UnauthorizedException

// Spring FrameworkのValidationに関するインポート宣言
import org.springframework.validation.annotation.Validated
import org.springframework.validation.BindingResult

// Spring FrameworkのAnnotationに関するインポート宣言
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.CrossOrigin

// MEMO: RestAPIを開発する上で知っておくと良さそうな点

// 補足: 【図解】RESTful WebサービスにおけるHTTPステータスコード
// https://www.agilegroup.co.jp/technote/rest-status-code.html

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
class ApplicationUserController {

	@Autowired
	private lateinit var applicationUserService: ApplicationUserService

	// MEMO: 新規会員登録処理を実行する
	@PostMapping("/signup")
	fun createApplicationUser(@RequestBody @Validated createUserRequest: CreateUserRequest, bindingResult: BindingResult) : UserSignupResponse {

		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}

		val userName = createUserRequest.userName!!
		val mailAddress = createUserRequest.mainAddress!!
		val rawPassword = createUserRequest.rawPassword!!

		// MEMO: 同一ユーザーが存在するかを検証する（※ユーザー名は一意である点に注意）
		// 例外: 同一ユーザーが存在する場合はConflictExceptionを投げる
		val foundApplicationUser = applicationUserService.findByUserName(
			userName = userName
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
		//println("userName:" + userName)
		//println("mainAddress:" + mailAddress)
		//println("rawPassword:" + rawPassword)

		return UserSignupResponse(result = "OK")
	}

	// MEMO: ログイン処理を実行する
	@PostMapping("/signin")
	fun loginApplicationUser(@RequestBody @Validated loginUserRequest: LoginUserRequest, bindingResult: BindingResult) : UserSigninResponse {

		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}

		val mailAddress = loginUserRequest.mainAddress!!
		val rawPassword = loginUserRequest.rawPassword!!

		// MEMO: メールアドレスとパスワードを検証して正しい場合はユーザー名を取得する
		// 例外: ユーザー名が取得できなかった場合はUnauthorizedExceptionを投げる
		val loginSuccessUserName = applicationUserService.checkLoginAndGetUserName(
			mailAddress = mailAddress,
			rawPassword = rawPassword
		) ?: throw UnauthorizedException("入力したパスワードまたはメールアドレスに誤りがあります。")

		// 該当ユーザーのJWT(Json Web Token)を生成する
		val userJwt = JWTGenerator().generateToken(
			userName = loginSuccessUserName
		)

		// Debug.
		//println("userName:" + loginSuccessUserName)
		//println("mainAddress:" + mailAddress)
		//println("rawPassword:" + rawPassword)
		//println("userJwt:" + userJwt)

		return UserSigninResponse(
			result = "OK",
			token = userJwt
		)
	}

	// MEMO: JWTによる認可処理デバッグ時に表示する情報を取得する
	@GetMapping("/debug")
	fun example(): String {
		return "成功: 認証が通過したら閲覧可能です!"
	}
}