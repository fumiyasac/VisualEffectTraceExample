package net.just1factory.visual_effect_example.domain.entity

import javax.persistence.*
import java.util.Date

@Entity
@Table(name="users")
data class ApplicationUserEntity(

	// MEMO: カラムに対応する値を定義する（※テーブルとの対応が1:1の場合）
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	val id: Int = 0,
	@Column(name = "user_name", nullable = false)
	val userName: String = "",
	@Column(name = "mail_address", nullable = false)
	val mailAddress: String = "",
	@Column(name = "password", nullable = false)
	val password: String = "",
	@Column(name = "device_token", nullable = true)
	val deviceToken: String? = null,
	@Column(name = "status_code", nullable = false)
	val publishFlag: Int = 0,
	@Column(name="created_at")
	val createdAt: Date = Date(),
	@Column(name="updated_at")
	val updatedAt: Date = Date()
)
