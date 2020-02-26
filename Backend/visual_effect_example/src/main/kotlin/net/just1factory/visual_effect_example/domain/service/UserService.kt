package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.UserEntity
import net.just1factory.visual_effect_example.domain.repository.UserRepository
import org.springframework.stereotype.Service

@Service
class UserService (private val userRepository: UserRepository) {

	// ライブラリ`JPA`を利用して受け取ったリクエストからUserEntityを作成して1件保存する
	fun save(user: UserEntity): UserEntity {
		return userRepository.save(user)
	}
}