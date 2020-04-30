package net.just1factory.visual_effect_example.app.response.topBanner

// MEMO: AnnouncementEntityの形式をJSON出力に利用する
import net.just1factory.visual_effect_example.domain.entity.TopBannerEntity

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class TopBannerListResponse @JsonCreator constructor(
	val result: List<TopBannerEntity>
)
