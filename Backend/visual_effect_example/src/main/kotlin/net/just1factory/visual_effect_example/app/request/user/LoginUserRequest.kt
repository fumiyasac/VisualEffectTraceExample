package net.just1factory.visual_effect_example.app.request.user

import com.fasterxml.jackson.annotation.JsonProperty
import javax.validation.constraints.Email
import javax.validation.constraints.NotNull
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size

data class LoginUserRequest(
	@JsonProperty("mail_address")
	@field: NotNull(message = "メールアドレスが送信されていません")
	@field: Email(message = "メールアドレスの形式に誤りがあります。")
	val mainAddress: String?,

	@JsonProperty("password")
	@field: NotNull(message = "パスワードが送信されていません。")
	@field: Pattern(regexp = "^[0-9a-zA-Z]+${'$'}", message = "パスワードに利用できるのは記号を除いた半角英数字だけになります。")
	@field: Size(min = 8, max = 50, message = "パスワードは6文字以上50文字以下で入力してください。")
	val rawPassword: String?
)