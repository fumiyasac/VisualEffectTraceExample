package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.AnnouncementService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.announcement.AnnouncementListResponse
import net.just1factory.visual_effect_example.app.response.announcement.AnnouncementDetailResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.NotFoundException

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

// MEMO: Swagger UIに記載する内容を表示するためのアノテーション
import io.swagger.annotations.Api
import io.swagger.annotations.ApiParam
import io.swagger.annotations.ApiOperation
import io.swagger.annotations.ApiResponses
import io.swagger.annotations.ApiResponse
import io.swagger.annotations.Authorization

@RestController
@RequestMapping("/api/v1")
@Api(description = "アプリ内容に関連するお知らせに関するエンドポイント（イベント情報告知や最新商品の入荷情報等を掲載）")
class AnnouncementController {

	@Autowired
	private lateinit var announcementService: AnnouncementService

	// MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
	@ApiOperation(value = "お知らせ一覧データ取得", produces = "application/json", notes = "DB内にあるお知らせ一覧データ取得します。", response = AnnouncementListResponse::class)
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK")
		]
	)
	@GetMapping("/announcement")
	fun findAll(): AnnouncementListResponse {
		val announcements = announcementService.findAll()
		return AnnouncementListResponse(result = announcements)
	}

	// MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを最新1件取得する
	@ApiOperation(value = "最新お知らせ詳細データ取得", produces = "application/json", notes = "DB内にある最新お知らせデータを最新1件取得します。", response = AnnouncementDetailResponse::class)
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK"),
			ApiResponse(code = 404, message = "現在最新のお知らせは見つかりませんでした（NotFoundException）。")
		]
	)
	@GetMapping("/announcement/recent")
	fun findRecent(): AnnouncementDetailResponse {
		val announcement = announcementService.findRecent() ?: throw NotFoundException("現在最新のお知らせは見つかりませんでした。")
		return AnnouncementDetailResponse(result = announcement)
	}

	// MEMO: AnnouncementServiceを経由して受け取ったIDに紐づくAnnouncementEntityにマッピングされたデータを1件取得する
	@ApiOperation(value = "IDに対応するお知らせ詳細データ取得", produces = "application/json", notes = "IDに対応するDB内にある詳細お知らせデータを1件取得します。", response = AnnouncementDetailResponse::class)
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK"),
			ApiResponse(code = 404, message = "ID: xxxに合致するデータが見つかりませんでした。（NotFoundException）。")
		]
	)
	@GetMapping("/announcement/{id}")
	fun findBy(@ApiParam(value = "お知らせID", required = true) @PathVariable id: Int): AnnouncementDetailResponse {
		val announcement = announcementService.findBy(id = id) ?: throw NotFoundException("ID: " + id + "に合致するデータが見つかりませんでした。")
		return AnnouncementDetailResponse(result = announcement)
	}
}