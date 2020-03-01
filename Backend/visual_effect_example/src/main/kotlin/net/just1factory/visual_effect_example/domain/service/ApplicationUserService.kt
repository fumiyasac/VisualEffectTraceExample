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

	fun save(userName: String, mailAddress: String, rawPassword: String): ApplicationUserEntity {
		val user = ApplicationUserEntity(
			userName = userName,
			mailAddress = mailAddress,
			password = makeBCryptPassword(rawPassword)
		)
		return applicationUserRepository.save(user)
	}

	fun findByUserNameAndMailAddress(userName: String, mailAddress: String): ApplicationUserEntity? {
		return applicationUserRepository.findByUserNameAndMailAddress(
			userName = userName,
			mailAddress = mailAddress
		)
	}

	fun findByMailAddressAndPassword(mailAddress: String, rawPassword: String): ApplicationUserEntity? {
		return applicationUserRepository.findByMailAddressAndPassword(
			mailAddress = mailAddress,
			password = makeBCryptPassword(rawPassword)
		)
	}

	private fun makeBCryptPassword(rawPassword: String): String {
		return BCryptPasswordEncoder().encode(rawPassword)
	}
}