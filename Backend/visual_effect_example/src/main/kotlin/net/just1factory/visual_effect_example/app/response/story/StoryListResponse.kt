package net.just1factory.visual_effect_example.app.response.story

// MEMO: StoryEntityの形式をJSON出力に利用する
import net.just1factory.visual_effect_example.domain.entity.StoryEntity

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class StoryListResponse @JsonCreator constructor(
	val result: List<StoryEntity>
)
