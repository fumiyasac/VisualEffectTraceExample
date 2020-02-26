package net.just1factory.visual_effect_example.app.request.user

// MEMO: JSONのキーを変数名と対応するために利用するアノテーション
import com.fasterxml.jackson.annotation.JsonProperty

// MEMO: バリデーション用に利用するアノテーション
import javax.validation.constraints.NotNull
import javax.validation.constraints.Pattern
import javax.validation.constraints.Size
import javax.validation.constraints.Email

// MEMO: Data Classにバリデーションを仕込む場合には「@field: アノテーション」としないと正常にバリデーションが実行されない点に注意
// 参考: 【Kotlin】バリデーションの書き方の基礎【SpringBoot】
// → https://qiita.com/wrongwrong/items/8120faeb9f7498f925c5
data class CreateUserRequest(
	@JsonProperty("user_name")
	@field: NotNull(message = "ユーザー名が送信されていません。")
	@field: Pattern(regexp = "^[0-9a-zA-Z]+${'$'}", message = "ユーザー名に利用できるのは記号を除いた半角英数字だけになります。")
	@field: Size(min = 8, max = 50, message = "ユーザー名は6文字以上50文字以下で入力してください。")
	val userName: String?,

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