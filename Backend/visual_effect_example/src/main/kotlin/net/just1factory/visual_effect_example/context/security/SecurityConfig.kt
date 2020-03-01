package net.just1factory.visual_effect_example.context.security

//
import org.springframework.context.annotation.Configuration

//
import org.springframework.http.HttpMethod

//
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter

@Configuration
@EnableWebSecurity
class SecurityConfig: WebSecurityConfigurerAdapter() {

	override fun configure(http: HttpSecurity) {
		http.csrf().disable().authorizeRequests()
			.antMatchers(HttpMethod.POST, SIGN_UP_URL).permitAll()
			.antMatchers(HttpMethod.POST, SIGN_IN_URL).permitAll()
			.antMatchers(HttpMethod.GET, ANNOUNCEMENT_LIST_URL).permitAll()
			.antMatchers(HttpMethod.GET, ANNOUNCEMENT_DETAIL_URL).permitAll()
			.anyRequest().authenticated()
	}
}
