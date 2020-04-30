package net.just1factory.visual_effect_example.app.response.eventIntroduction

// MEMO: EventIntroductionEntityの形式をJSON出力に利用する
import net.just1factory.visual_effect_example.domain.entity.EventIntroductionEntity

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class EventIntroductionListResponse @JsonCreator constructor(
	val result: List<EventIntroductionEntity>,
	val currentPage: Int,
	val hasNextPage: Boolean
)
