package net.just1factory.visual_effect_example.app.response.item

// MEMO: ItemEntityの形式をJSON出力に利用する
import net.just1factory.visual_effect_example.domain.entity.ItemEntity

// MEMO: マッピングを作成するためにJsonCreatorアノテーションを利用する
import com.fasterxml.jackson.annotation.JsonCreator

// MEMO: レスポンスとして返却するJSONの形を定義するクラス
data class ItemListResponse @JsonCreator constructor(
	val result: List<ItemEntity>,
	val currentPage: Int,
	val hasNextPage: Boolean
)
