package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.ApplicationUserService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.request.user.CreateUserRequest
import net.just1factory.visual_effect_example.app.request.user.LoginUserRequest
import net.just1factory.visual_effect_example.app.response.user.signup.UserSignupResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.UnprocessableEntityException

// Spring Frameworkのインポート宣言
import org.springframework.validation.annotation.Validated
import org.springframework.validation.BindingResult

//
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

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
		// MEMO: 同一ユーザーが存在する場合はExceptionを投げる

		// MEMO: 送信された会員情報をDBへ保存するための処理をUserServiceクラスを利用して実施する
		applicationUserService.save(
			createUserRequest.userName!!,
			createUserRequest.mainAddress!!,
			createUserRequest.rawPassword!!
		)

		// Debug.
		println("userName:" + createUserRequest.userName)
		println("mainAddress:" + createUserRequest.mainAddress)
		println("rawPassword:" + createUserRequest.rawPassword )
		return UserSignupResponse("OK")
	}

	// MEMO: ログイン処理を実行する
	@PostMapping("/signin")
	fun createUser(@RequestBody @Validated loginUserRequest: LoginUserRequest, bindingResult: BindingResult) {
		// MEMO: 送信された会員情報のバリデーションを実施してエラーを検知した際はUnprocessableEntityExceptionを投げる
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}
		// MEMO: 同一ユーザーが存在する場合はExceptionを投げる

		// MEMO: 送信された会員情報をDBへ保存するための処理をUserServiceクラスを利用して実施する
		val foundApplicationUser = applicationUserService.findByUsernameAndRawPassword(
			loginUserRequest.mainAddress!!,
			loginUserRequest.rawPassword!!
		)

		// Debug.
		println("mainAddress:" + loginUserRequest.mainAddress!!)
		println("rawPassword:" + loginUserRequest.rawPassword!!)
	}

	// MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
	@GetMapping("/example")
	fun example(): String {
		return "認証が通過したら閲覧可能です!"
	}
}