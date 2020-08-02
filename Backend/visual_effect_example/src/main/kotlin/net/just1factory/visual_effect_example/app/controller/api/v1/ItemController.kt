package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import io.swagger.annotations.*
import net.just1factory.visual_effect_example.domain.service.ItemService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.item.ItemListResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.BadRequestException

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestParam

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

// MEMO: Swagger UIに記載する内容を表示するためのアノテーション

@RestController
@RequestMapping("/api/v1")
@Api(description = "iOSアプリトップ画面アイテム一覧に関するエンドポイント（表示コンテンツ）")
class ItemController {

	private val LIMIT_PER_PAGE = 9

	@Autowired
	private lateinit var itemService: ItemService

	// MEMO: EventIntroductionServiceを経由してEventIntroductionEntityにマッピングされたデータを全件取得する
	@ApiOperation(value = "トップ画面表示用イベント概要一覧データ取得", produces = "application/json", notes = "DB内にあるアイテム一覧データをページネーションを伴って取得します。", response = ItemListResponse::class, authorizations = [Authorization(value = "発行したJWT")])
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK"),
			ApiResponse(code = 400, message = "パラメーターの値が不正です（BadRequestException）。")
		]
	)
	@GetMapping("/items")
	fun findListPerPage(@ApiParam(value = "ページ番号", required = false) @RequestParam(required = false, defaultValue = "1") page: String): ItemListResponse {

		// MEMO: 受け取ったパラメーター値が不正な場合はBadRequestExceptionを投げる
		val currentPage = page.toInt()
		if (currentPage < 1) {
			throw BadRequestException("パラメーターの値が不正です。")
		}

		// MEMO: ページネーションを考慮したレスポンスに必要なものをServiceクラスを利用して組み立てる
		val hasNextPage = (currentPage * LIMIT_PER_PAGE < itemService.findAllCount())
		val offset = (currentPage - 1) * LIMIT_PER_PAGE
		val items = itemService.findListPerPage(limit = LIMIT_PER_PAGE, offset = offset)
		return ItemListResponse(result = items, currentPage = currentPage, hasNextPage = hasNextPage)
	}
}