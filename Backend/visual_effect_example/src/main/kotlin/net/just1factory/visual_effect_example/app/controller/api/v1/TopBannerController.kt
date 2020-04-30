package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.TopBannerService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.topBanner.TopBannerListResponse

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/v1")
class TopBannerController {

	@Autowired
	private lateinit var topBannerService: TopBannerService

	// MEMO: TopBannerServiceを経由してTopBannerEntityにマッピングされたデータを全件取得する
	@GetMapping("/top_banner")
	fun findAll(): TopBannerListResponse {
		val topBanners = topBannerService.findAll()
		return TopBannerListResponse(result = topBanners)
	}
}