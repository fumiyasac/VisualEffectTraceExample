package net.just1factory.visual_effect_example.domain.entity

import javax.persistence.*
import java.util.Date

@Entity
@Table(name="story_images")
data class StoryImageEntity(

	// MEMO: カラムに対応する値を定義する
	// ※テーブルとの対応が1:Nの場合 → One StoryEntity has Many StoryImageEntity
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	val id: Int,
	@Column(name = "story_id", nullable = false)
	val storyId: Int,
	@Column(name = "photo_url", nullable = true)
	val photoUrl: String? = null,
	@Column(name = "title", nullable = false)
	val title: String,
	@Column(name = "caption", nullable = true)
	val caption: String? = null,
	@Column(name = "statement", nullable = true)
	val statement: String? = null,
	@Column(name = "credit", nullable = true)
	val credit: String? = null,
	@Column(name="created_at")
	val createdAt: Date,
	@Column(name="updated_at")
	val updatedAt: Date,
	// MEMO: 1:NのEntity同士のAssociation定義
	@OneToMany(cascade = [CascadeType.ALL])
	val featuredArticleImages: List<FeaturedArticleImageEntity>? = null
)