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

// Spring FrameworkのValidationに関するインポート宣言
import org.springframework.validation.annotation.Validated
import org.springframework.validation.BindingResult

// Spring FrameworkのAnnotationに関するインポート宣言
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.CrossOrigin

// MEMO: Swagger UIに記載する内容を表示するためのアノテーション
import io.swagger.annotations.Api
import io.swagger.annotations.ApiParam
import io.swagger.annotations.ApiOperation
import io.swagger.annotations.ApiResponses
import io.swagger.annotations.ApiResponse
import io.swagger.annotations.Authorization

// MEMO: RestAPIを開発する上で知っておくと良さそうな点

// 補足1: 【図解】RESTful WebサービスにおけるHTTPステータスコード
// https://www.agilegroup.co.jp/technote/rest-status-code.html

// 補足2: Spring FrameworkのControllerの基本的なアノテーション
// https://morizyun.github.io/java/spring-framework-controller-annotation.html

// 補足3: Authentication e Authorization usando Springboot + Kotlin
// https://medium.com/@jonssantana/authentication-e-authorization-usando-springboot-kotlin-382681024d08

@RestController
@CrossOrigin("*")
@RequestMapping("/api/v1")
@Api(description = "iOSアプリ登録会員情報に関するエンドポイント（ユーザーの新規登録・JWTの発行等の部分）")
class ApplicationUserController {

	@Autowired
	private lateinit var applicationUserService: ApplicationUserService

	// MEMO: 新規会員登録処理を実行する
	@PostMapping("/signup")
	@ApiOperation(value = "iOSアプリ新規会員登録", produces = "application/json", consumes = "application/json", notes = "送信された会員情報をDBへ保存します。")
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK"),
			ApiResponse(code = 422, message = "送信された会員情報が不正です（UnprocessableEntityException）。"),
			ApiResponse(code = 409, message = "このユーザーは既に存在しています（ConflictException）。")
		]
	)
	fun createApplicationUser(@ApiParam(value = "ユーザー名・メールアドレス・パスワードを格納したJSON（全てString型＆バリデーション定義はCreateUserRequestを参照）", required = true) @RequestBody @Validated createUserRequest: CreateUserRequest, bindingResult: BindingResult) : UserSignupResponse {

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
	@ApiOperation(value = "iOSアプリログイン", produces = "application/json", consumes = "application/json", notes = "送信されたメールアドレス・パスワードをDBと照合して一致時にJWTを発行します。", response = UserSigninResponse::class)
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK"),
			ApiResponse(code = 422, message = "入力したパスワードまたはメールアドレスに誤りがあります（UnprocessableEntityException）。")
		]
	)
	fun loginApplicationUser(@RequestBody @Validated loginUserRequest: LoginUserRequest, bindingResult: BindingResult) : UserSigninResponse {

		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}

		val mailAddress = loginUserRequest.mainAddress!!
		val rawPassword = loginUserRequest.rawPassword!!

		// MEMO: メールアドレスとパスワードを検証して正しい場合はユーザー名を取得する
		// 例外: ユーザー名が取得できなかった場合はUnprocessableEntityExceptionを投げる
		val loginSuccessUserName = applicationUserService.checkLoginAndGetUserName(
			mailAddress = mailAddress,
			rawPassword = rawPassword
		) ?: throw UnprocessableEntityException("入力したパスワードまたはメールアドレスに誤りがあります。")

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
}