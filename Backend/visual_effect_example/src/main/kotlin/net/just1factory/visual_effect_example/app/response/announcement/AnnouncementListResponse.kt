package net.just1factory.visual_effect_example.app.response.announcement

// MEMO: AnnouncementEntityの形式をJSON出力に利用する
import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class AnnouncementListResponse @JsonCreator constructor(
	val result: List<AnnouncementEntity>
)
