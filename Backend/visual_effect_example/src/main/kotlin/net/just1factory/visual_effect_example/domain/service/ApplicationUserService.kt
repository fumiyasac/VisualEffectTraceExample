package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.ApplicationUserEntity
import net.just1factory.visual_effect_example.domain.repository.ApplicationUserRepository

import org.springframework.stereotype.Service
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Service
class ApplicationUserService {

	@Autowired
	private lateinit var applicationUserRepository: ApplicationUserRepository

	fun findByUserName(userName: String): ApplicationUserEntity? {
		return applicationUserRepository.findByUserName(
			userName = userName
		)
	}

	fun save(userName: String, mailAddress: String, rawPassword: String): ApplicationUserEntity {
		val user = ApplicationUserEntity(
			userName = userName,
			mailAddress = mailAddress,
			password = makeBCryptPassword(rawPassword)
		)
		return applicationUserRepository.save(user)
	}

	// メールアドレス及びパスワードが正しい場合にはユーザー名を返す
	fun checkLoginAndGetUserName(mailAddress: String, rawPassword: String): String? {

		// MEMO: メールアドレスからユーザーを調べる（※メールアドレスは一意である点に注意）
		val targetApplicationUserEntity = findByMailAddress(
			mailAddress = mailAddress
		) ?: return null

		// MEMO: パスワードが合致しているかを調べる
		val checkEncodedPasswordResult = checkEncodedPassword(
			rawPassword = rawPassword,
			encodedPassword = targetApplicationUserEntity.password
		)
		if (!checkEncodedPasswordResult) {
			return null
		}
		return targetApplicationUserEntity.userName
	}

	private fun findByMailAddress(mailAddress: String): ApplicationUserEntity? {
		return applicationUserRepository.findByMailAddress(
			mailAddress = mailAddress
		)
	}

	private fun checkEncodedPassword(rawPassword: String, encodedPassword: String): Boolean {
		return BCryptPasswordEncoder().matches(rawPassword, encodedPassword)
	}

	private fun makeBCryptPassword(rawPassword: String): String {
		return BCryptPasswordEncoder().encode(rawPassword)
	}
}