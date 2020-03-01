package net.just1factory.visual_effect_example.context.security

class SecurityConstant {

	// 認証や認可に関する処理を構築する際に利用する定数値
	companion object {

		// MEMO: 認証不要な状態で表示できるエンドポイント
		const val ANNOUNCEMENT_LIST_URL = "/api/v1/announcement"
		const val ANNOUNCEMENT_DETAIL_URL = "/api/v1/announcement/{id}"

		// MEMO: 新規ユーザー登録・ユーザー認証用のエンドポイント
		const val SIGN_UP_URL = "/api/v1/signup"
		const val SIGN_IN_URL = "/api/v1/signin"

		// MEMO: JWTに関連するものを定義した定数
		const val SECRET = "QYmmcTTihyBHMXS2J42fRRi4VaBt2AeRfEEguJ7LNyekyQAfBiHynHR9HPzUyGJS"
		const val TOKEN_PREFIX = "Bearer "
		const val HEADER_STRING = "Authorization"

		// MEMO: 10日間の有効期限保持
		const val EXPIRATION_TIME: Long = 864_000_000
	}
}


