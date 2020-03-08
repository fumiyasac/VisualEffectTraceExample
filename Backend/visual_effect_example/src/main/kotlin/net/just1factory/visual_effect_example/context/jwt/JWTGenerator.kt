package net.just1factory.visual_effect_example.context.jwt

// MEMO: JWTに関するインポート宣言
import io.jsonwebtoken.Jwts
import io.jsonwebtoken.SignatureAlgorithm

import java.util.Date

// MEMO: JWTを生成するための処理
// 方針: 一意となるユーザー名を元にしてJWTを生成する（おおまかな実装については下記リポジトリを参考にしました！）
// https://github.com/Jonss/jwtsample-kotlin

// 参考1: JWTのデバッグ方法
// https://webbibouroku.com/Blog/Article/jwt

// 参考2: ライブラリ「JJWT」へのリポジトリ
// https://github.com/jwtk/jjwt

class JWTGenerator {

	fun generateToken(userName: String): String {

		val secret = JWTConstant.SECRET.toByteArray()
		val expirationDate = Date(System.currentTimeMillis() + JWTConstant.EXPIRATION_TIME)

		// MEMO: シークレットキー・有効期限・引数から受け取ったユーザー名を元にJWTを生成する
		return Jwts.builder()
			.setSubject(userName)
			.setExpiration(expirationDate)
			.signWith(SignatureAlgorithm.HS512, secret)
			.compact()
	}
}
