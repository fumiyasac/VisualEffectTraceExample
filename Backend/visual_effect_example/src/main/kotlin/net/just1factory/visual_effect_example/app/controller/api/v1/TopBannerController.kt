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

// MEMO: Swagger UIに記載する内容を表示するためのアノテーション
import io.swagger.annotations.Api
import io.swagger.annotations.ApiOperation
import io.swagger.annotations.ApiResponses
import io.swagger.annotations.ApiResponse
import io.swagger.annotations.Authorization

@RestController
@RequestMapping("/api/v1")
@Api(description = "iOSアプリトップ画面表示用バナーに関するエンドポイント（表示コンテンツ）")
class TopBannerController {

	@Autowired
	private lateinit var topBannerService: TopBannerService

	// MEMO: TopBannerServiceを経由してTopBannerEntityにマッピングされたデータを全件取得する
	@GetMapping("/top_banner")
	@ApiOperation(value = "トップ画面表示用バナー一覧データ取得", produces = "application/json", notes = "DB内にあるトップ画面表示用バナー一覧データ取得します。", response = TopBannerListResponse::class, authorizations = [Authorization(value = "発行したJWT")])
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK")
		]
	)
	fun findAll(): TopBannerListResponse {
		val topBanners = topBannerService.findAll()
		return TopBannerListResponse(result = topBanners)
	}
}