package net.just1factory.visual_effect_example.domain.entity

import javax.persistence.*
import java.util.Date

@Entity
@Table(name="top_banners")
data class TopBannerEntity(

        // MEMO: カラムに対応する値を定義する（※テーブルとの対応が1:1の場合）
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        @Column(name = "id", unique = true, nullable = false)
        val id: Int,
        @Column(name = "banner_contents_id", nullable = true)
        val bannerContentsId: Int? = null,
        @Column(name = "banner_url", nullable = true)
        val bannerUrl: String? = null,
        @Column(name = "title", nullable = false)
        val title: String,
        @Column(name = "caption", nullable = true)
        val caption: String? = null,
        @Column(name="announcement_at")
        val announcementAt: Date,
        @Column(name="created_at")
        val createdAt: Date,
        @Column(name="updated_at")
        val updatedAt: Date
)