package net.just1factory.visual_effect_example.domain.service

//
import net.just1factory.visual_effect_example.domain.entity.ApplicationUserEntity
import net.just1factory.visual_effect_example.domain.repository.ApplicationUserRepository

//
import org.springframework.context.annotation.Bean

//
import org.springframework.stereotype.Service

//
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

@Service
class ApplicationUserService {

	@Autowired
	private lateinit var applicationUserRepository: ApplicationUserRepository

	// ライブラリ`JPA`を利用して受け取ったリクエストからUserEntityを作成して1件保存する
	fun save(userName: String, mailAddress: String, rawPassword: String): ApplicationUserEntity {
		val user = ApplicationUserEntity(
			userName = userName,
			mainAddress = mailAddress,
			password = makeBCryptPassword(rawPassword)
		)
		return applicationUserRepository.save(user)
	}

	fun findByUsernameAndRawPassword(userName: String, rawPassword: String): ApplicationUserEntity? {
		return applicationUserRepository.findByUserNameAndPassword(userName, makeBCryptPassword(rawPassword))
	}

	private fun makeBCryptPassword(rawPassword: String): String {
		return BCryptPasswordEncoder().encode(rawPassword)
	}
}