package net.just1factory.visual_effect_example.context.security

// MEMO: 設定クラスで必要なアノテーション
import org.springframework.context.annotation.Configuration

// MEMO: 認証が必要なエンドポイントを定義する際に必要
import org.springframework.http.HttpMethod

// MEMO: Spring Securityが提供している機能を利用する
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter

@Configuration
@EnableWebSecurity
class SecurityConfig: WebSecurityConfigurerAdapter() {

	override fun configure(http: HttpSecurity) {

		// MEMO: 認証が必要なエンドポイントやそうでない部分の設定を実施する
		http.csrf().disable().authorizeRequests()
			.antMatchers(HttpMethod.POST, SecurityConstant.SIGN_UP_URL).permitAll()
			.antMatchers(HttpMethod.POST, SecurityConstant.SIGN_IN_URL).permitAll()
			.antMatchers(HttpMethod.GET, SecurityConstant.ANNOUNCEMENT_LIST_URL).permitAll()
			.antMatchers(HttpMethod.GET, SecurityConstant.ANNOUNCEMENT_DETAIL_URL).permitAll()
			.anyRequest().authenticated()
	}
}
