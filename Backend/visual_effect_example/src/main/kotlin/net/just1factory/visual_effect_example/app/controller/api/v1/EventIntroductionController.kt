package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.EventIntroductionService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.eventIntroduction.EventIntroductionListResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.BadRequestException

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestParam

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/v1")
class EventIntroductionController {

	private val LIMIT_PER_PAGE = 5

	@Autowired
	private lateinit var eventIntroductionService: EventIntroductionService

	// MEMO: EventIntroductionServiceを経由してEventIntroductionEntityにマッピングされたデータを全件取得する
	@GetMapping("/event_introduction")
	fun findListPerPage(@RequestParam(required = false, defaultValue = "1") page: String): EventIntroductionListResponse {

		// MEMO: 受け取ったパラメーター値が不正な場合はBadRequestExceptionを投げる
		val currentPage = page.toInt()
		if (currentPage < 1) {
			throw BadRequestException("パラメーターの値が不正です。")
		}

		// MEMO: ページネーションを考慮したレスポンスに必要なものをServiceクラスを利用して組み立てる
		val hasNextPage = (currentPage * LIMIT_PER_PAGE < eventIntroductionService.findAllCount())
		val offset = (currentPage - 1) * LIMIT_PER_PAGE
		val eventIntroduction = eventIntroductionService.findListPerPage(limit = LIMIT_PER_PAGE, offset = offset)
		return EventIntroductionListResponse(result = eventIntroduction, currentPage = currentPage, hasNextPage = hasNextPage)
	}
}