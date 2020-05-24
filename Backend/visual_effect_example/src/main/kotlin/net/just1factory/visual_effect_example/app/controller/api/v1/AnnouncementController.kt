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

@RestController
@RequestMapping("/api/v1")
class AnnouncementController {

	@Autowired
	private lateinit var announcementService: AnnouncementService

	// MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
	@GetMapping("/announcement")
	fun findAll(): AnnouncementListResponse {
		val announcements = announcementService.findAll()
		return AnnouncementListResponse(result = announcements)
	}

	// MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを最新1件取得する
	@GetMapping("/announcement/recent")
	fun findRecent(): AnnouncementDetailResponse {
		val announcement = announcementService.findRecent() ?: throw NotFoundException("現在最新のお知らせは見つかりませんでした。")
		return AnnouncementDetailResponse(result = announcement)
	}

	// MEMO: AnnouncementServiceを経由して受け取ったIDに紐づくAnnouncementEntityにマッピングされたデータを1件取得する
	@GetMapping("/announcement/{id}")
	fun findBy(@PathVariable id: Int): AnnouncementDetailResponse {
		val announcement = announcementService.findBy(id = id) ?: throw NotFoundException("ID: " + id + "に合致するデータが見つかりませんでした。")
		return AnnouncementDetailResponse(result = announcement)
	}
}