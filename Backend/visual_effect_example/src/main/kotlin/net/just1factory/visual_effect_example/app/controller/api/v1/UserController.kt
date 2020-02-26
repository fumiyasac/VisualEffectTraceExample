package net.just1factory.visual_effect_example.app.controller.api.v1

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.request.user.CreateUserRequest
import net.just1factory.visual_effect_example.app.response.user.signup.UserSignupResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.UnprocessableEntityException

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.validation.annotation.Validated
import org.springframework.validation.BindingResult

@RestController
@RequestMapping("/api/v1")
class UserController {

	// MEMO: 新規会員登録処理を実行する
	@PostMapping("/signup")
	fun createUser(@RequestBody @Validated createUserRequest: CreateUserRequest, bindingResult: BindingResult) : UserSignupResponse {
		// MEMO: 送信された会員情報のバリデーションを実施する
		if (bindingResult.hasErrors()) {
			val errorMessages = bindingResult.allErrors.map { it.defaultMessage }.joinToString("\n")
			throw UnprocessableEntityException(errorMessages)
		}
		// TODO: 送信された会員情報をDBへ保存するための処理をUserServiceクラスを利用して実施する

		// Debug.
//		println("userName:" + createUserRequest.userName)
//		println("mainAddress:" + createUserRequest.mainAddress)
//		println("rawPassword:" + createUserRequest.rawPassword )
		return UserSignupResponse("OK")
	}
}