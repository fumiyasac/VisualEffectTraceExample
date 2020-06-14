package net.just1factory.visual_effect_example.domain.entity

import javax.persistence.*
import java.util.Date

@Entity
@Table(name="featured_article_images")
data class FeaturedArticleImageEntity(

	// MEMO: カラムに対応する値を定義する
	// ※テーブルとの対応が1:nの場合 → One FeaturedArticleEntity has Many FeaturedArticleImageEntity
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	val id: Int,
	@Column(name = "featured_article_id", nullable = false)
	val featuredArticleId: Int,
	@Column(name = "photo_url", nullable = true)
	val photoUrl: String? = null,
	@Column(name = "title", nullable = false)
	val title: String,
	@Column(name = "caption", nullable = true)
	val catchCopy: String? = null,
	@Column(name = "statement", nullable = true)
	val statement: String? = null,
	@Column(name = "credit", nullable = true)
	val credit: String? = null,
	@Column(name="created_at")
	val createdAt: Date,
	@Column(name="updated_at")
	val updatedAt: Date
)