package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import io.swagger.annotations.*
import net.just1factory.visual_effect_example.domain.service.StoryService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.story.StoryListResponse
import net.just1factory.visual_effect_example.app.response.topBanner.TopBannerListResponse

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/v1")
@Api(description = "Story(アプリ内ではフォトギャラリー)画面表示関するエンドポイント（表示コンテンツ）")
class StoryController {

	@Autowired
	private lateinit var storyService: StoryService

	// MEMO: StoryServiceを経由してStoryEntityにマッピングされたデータを全件取得する
	@GetMapping("/story")
	@ApiOperation(value = "Story一覧データ取得", produces = "application/json", notes = "DB内にあるStory一覧データ取得します。", response = StoryListResponse::class, authorizations = [Authorization(value = "発行したJWT")])
	@ApiResponses(
		value = [
			ApiResponse(code = 200, message = "OK")
		]
	)
	fun findAll(): StoryListResponse {
		val stories = storyService.findAll()
		return StoryListResponse(result = stories)
	}
}