package net.just1factory.visual_effect_example.context.security

import net.just1factory.visual_effect_example.context.jwt.JWTAuthenticationFilter
import net.just1factory.visual_effect_example.domain.service.ApplicationUserService

// MEMO: 設定クラスで必要なアノテーション
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration

// MEMO: Spring Securityが提供している機能を利用する
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.http.HttpMethod

@Configuration
@EnableWebSecurity
class SecurityConfig: WebSecurityConfigurerAdapter() {

	@Autowired
	private lateinit var applicationUserService: ApplicationUserService

	override fun configure(http: HttpSecurity) {

		// MEMO: 基本的には認証を前提としたAPIで処理する
		// 補足: 除外したいエンドポイントについてはJWTAuthenticationFilterにも記載する

		// 参考1: Spring Security 使い方メモ 基礎・仕組み
		// https://qiita.com/opengl-8080/items/c105152c9ca48509bd0c
		// 参考2: Spring Boot with Spring Security の Filter 設定とハマりポイント
		// https://qiita.com/R-STYLE/items/61a3b6a678cb0ff00edf

		http.csrf()
			.disable()
			.authorizeRequests()
			// MEMO: SwaggerUIの表示のために必要な部分を除外する設定
			.antMatchers(
				"/v2/api-docs",
				"/swagger-resources/**",
				"/swagger-ui.html",
				"/webjars/**" ,
				"/swagger.json"
			)
			.permitAll()
			// MEMO: アプリ側でJWTが必要なくともアクセス可能なエンドポイントに関する定義
			.antMatchers(HttpMethod.GET,"/api/v1/announcement").permitAll()
			.antMatchers(HttpMethod.GET,"/api/v1/announcement/{id}").permitAll()
			.antMatchers(HttpMethod.POST,"/api/v1/signup").permitAll()
			.antMatchers(HttpMethod.POST,"/api/v1/signin").permitAll()
			.anyRequest()
			.authenticated()
			.and()
			.addFilter(JWTAuthenticationFilter(authenticationManager(), applicationUserService))
	}
}
