package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.StoryService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.story.StoryListResponse

// コンテキスト層（Exception）
import net.just1factory.visual_effect_example.context.exception.NotFoundException

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.PathVariable

@RestController
@RequestMapping("/api/v1")
class StoryController {

	@Autowired
	private lateinit var storyService: StoryService

	// MEMO: StoryServiceを経由してStoryEntityにマッピングされたデータを全件取得する
	@GetMapping("/story")
	fun findAll(): StoryListResponse {
		val stories = storyService.findAll()
		return StoryListResponse(result = stories)
	}
}