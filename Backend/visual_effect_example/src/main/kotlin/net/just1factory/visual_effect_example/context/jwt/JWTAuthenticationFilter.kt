package net.just1factory.visual_effect_example.context.jwt

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.ApplicationUserService

// MEMO: JWTに関するインポート宣言
import io.jsonwebtoken.Claims
import io.jsonwebtoken.Jwts

// Spring Frameworkのインポート宣言
import org.springframework.http.HttpMethod

// Spring Securityのインポート宣言
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken

import java.util.*
import javax.servlet.FilterChain
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

// 補足1: KotlinでRESTfulAPIを開発する
// https://auth0.com/blog/jp-developing-restful-apis-with-kotlin/

// 補足2: JWTでセッション管理してはいけない
// https://qiita.com/hakaicode/items/1d504a728156cf54b3f8

// 補足3: Spring Securityのお話
// http://kozake.hatenablog.com/entry/2016/09/13/220328

// 補足4: JWT: add stateless authentication to your microservices（Kotlin + JWT + MicroServiceのお話）
// https://medium.com/@abuarquemf/jwt-add-stateless-authentication-to-your-microservices-637a2de23c9d
// https://github.com/ABuarque/JWT_in_microservices

// 補足5: JWTを利用したSpringアプリのAPI認証
// https://qiita.com/nyasba/items/f9b1b6be5540743f8bac

// 悩ましい部分: 自分で実装しておいて何だが、これはもうちょっと良い方法があるのでは...???
// MEMO: AuthenticationManagerクラス・ApplicationUserServiceは呼び出し元で初期化する形としている点に注意

class JWTAuthenticationFilter(authManager: AuthenticationManager, private val applicationUserService: ApplicationUserService): BasicAuthenticationFilter(authManager) {

	// MEMO: 今回の除外ルールの策定（本来ならば該当エンドポイント用のFilterクラスを用意するのが正解だと思われる）
	// (参考URL) https://medium.com/@abuarquemf/jwt-add-stateless-authentication-to-your-microservices-637a2de23c9d

	// Rule: ここではURIの文字列を基準として下記のようなルールを設けています。
	// [GET] → お知らせの一覧・詳細表示の様に公開しても良いエンドポイントの場合は除外する
	// [POST] → 新規会員登録・ログインのエンドポイントの場合は除外する
	private val excludePostPathList: List<String> = listOf(
		"signup",
		"signin"
	)
	private val excludeGetPathList: List<String> = listOf(
		"announcement"
	)

	override fun doFilterInternal(request: HttpServletRequest, response: HttpServletResponse, chain: FilterChain) {

		val uri = request.requestURI as String
		val method = request.method as String

		// MEMO: JWTの認証を除外するエンドポイントへのアクセス時の処理
		if (shouldExcludeRequest(uri = uri, method = method)) {
			chain!!.doFilter(request, response)
			return
		}

		// MEMO: HeaderからJWTを取得してTokenを抜き出す
		val header = request.getHeader(JWTConstant.HEADER_STRING)
		val targetClaimsToken = getClaimsToken(header = header)

		// MEMO: JWTの検証を実施してアクセスを試みたユーザーのものであるかと調べる
		if (shouldAuthenticated(claims = targetClaimsToken)) {

			// MEMO: アクセスを試みたユーザーのJWTであればSecurityContextHolderに保存してフィルタを実行する
			SecurityContextHolder.getContext().authentication = UsernamePasswordAuthenticationToken(
				targetClaimsToken,
				null,
				null
			)
		}
		chain!!.doFilter(request, response)
	}

	private fun shouldExcludeRequest(uri: String, method: String): Boolean {

		// MEMO: SecurityConfigに定義した除外対象のエンドポイントかを検証する
		return (shouldExcludeGetRequest(uri = uri, method = method) || shouldExcludePostRequest(uri = uri, method = method))
	}

	private fun shouldExcludeGetRequest(uri: String, method: String): Boolean {
		if (method != HttpMethod.GET.toString()) {
			return false
		}
		return (excludeGetPathList.filter{ uri.contains(it) }.count() > 0)
	}

	private fun shouldExcludePostRequest(uri: String, method: String): Boolean {
		if (method != HttpMethod.POST.toString()) {
			return false
		}
		return (excludePostPathList.filter{ uri.contains(it) }.count() > 0)
	}

	private fun shouldAuthenticated(claims: Claims?): Boolean {

		// MEMO: 存在ユーザーの妥当性を検証する
		// (1) Claimsがnullではないか?
		val targetClaims = claims ?: return false
		// (2) Claimsからユーザー名を取得できるか?
		val targetUserName = targetClaims.subject ?: return false
		// (3) DBから該当するユーザー名を取得できるか?
		val foundUser = applicationUserService.findByUserName(userName = targetUserName) ?: return false

		// MEMO: 有効期限の妥当性を検証する
		val expirationDate = targetClaims.expiration
		val nowDate = Date(System.currentTimeMillis())
		return (expirationDate != null && nowDate.before(expirationDate))
	}

	private fun getClaimsToken(header: String?): Claims? {

		// MEMO: Header情報を取得する
		val targeHeader = header ?: return null

		// MEMO: ClaimsをHeaderから取得する（※Exceptionが発生した際にはnullとする）
		return try {
			return Jwts.parser()
				.setSigningKey(JWTConstant.SECRET.toByteArray())
				.parseClaimsJws(targeHeader.replace(JWTConstant.TOKEN_PREFIX, ""))
				.body
		} catch (e: Exception) {
			null
		}
	}
}