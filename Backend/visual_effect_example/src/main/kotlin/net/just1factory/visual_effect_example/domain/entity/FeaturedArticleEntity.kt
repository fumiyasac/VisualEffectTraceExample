package net.just1factory.visual_effect_example.domain.entity

import javax.persistence.*
import java.util.Date

@Entity
@Table(name="featured_articles")
data class FeaturedArticleEntity(

	// MEMO: カラムに対応する値を定義する（※テーブルとの対応が1:1の場合）
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	val id: Int,
	@Column(name = "title", nullable = false)
	val title: String,
	@Column(name = "catch_copy", nullable = false)
	val catchCopy: String,
	@Column(name = "statement", nullable = true)
	val statement: String? = null,
	@Column(name = "thumbnail_url", nullable = true)
	val thumbnailUrl: String? = null,
	@Column(name = "publish_flag", nullable = false)
	val publishFlag: Int = 0,
	@Column(name = "author", nullable = false)
	val author: String,
	@Column(name="announcement_at")
	val announcementAt: Date,
	@Column(name="created_at")
	val createdAt: Date,
	@Column(name="updated_at")
	val updatedAt: Date
)