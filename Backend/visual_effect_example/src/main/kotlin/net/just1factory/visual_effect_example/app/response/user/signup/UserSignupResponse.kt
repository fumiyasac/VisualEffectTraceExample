package net.just1factory.visual_effect_example.app.response.user.signup

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class UserSignupResponse @JsonCreator constructor(
	val result: String
)