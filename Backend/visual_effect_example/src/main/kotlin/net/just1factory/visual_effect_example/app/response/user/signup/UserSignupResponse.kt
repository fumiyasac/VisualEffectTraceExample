package net.just1factory.visual_effect_example.app.response.user.signup

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスのステータスコードを構築するためのアノテーション
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.http.HttpStatus

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
@ResponseStatus(code = HttpStatus.CREATED)
@ResponseBody
data class UserSignupResponse @JsonCreator constructor(
	val result: String
)