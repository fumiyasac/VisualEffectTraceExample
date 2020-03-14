package net.just1factory.visual_effect_example.context.jwt

class JWTConstant {

	// 認証や認可に関する処理を構築する際に利用する定数値
	companion object {

		// MEMO: JWTに関連するものを定義した定数
		// 本当はベタ書きしない方が望ましい ... (今回はサンプル用なのでこの形としています)
		const val SECRET = "QYmmcTTihyBHMXS2J42fRRi4VaBt2AeRfEEguJ7LNyekyQAfBiHynHR9HPzUyGJS"
		const val TOKEN_PREFIX = "Bearer "
		const val HEADER_STRING = "Authorization"

		// MEMO: 1日間の有効期限
		const val EXPIRATION_TIME: Long = 86400000
	}
}


