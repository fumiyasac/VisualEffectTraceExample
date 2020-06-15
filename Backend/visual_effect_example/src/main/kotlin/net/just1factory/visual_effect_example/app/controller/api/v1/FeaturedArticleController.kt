package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.FeaturedArticleService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.featuredArticle.FeaturedArticleListResponse

// Spring Frameworkのインポート宣言
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

// MEMO: Setter Injectionを利用するためのアノテーション
import org.springframework.beans.factory.annotation.Autowired

@RestController
@RequestMapping("/api/v1")
class FeaturedArticleController {

	@Autowired
	private lateinit var featuredArticleService: FeaturedArticleService

	// MEMO: FeaturedArticleServiceを経由してFeaturedArticleEntityにマッピングされたデータを全件取得する
	@GetMapping("/featured_article")
	fun findAll(): FeaturedArticleListResponse {
		val featuredArticles = featuredArticleService.findAll()
		return FeaturedArticleListResponse(result = featuredArticles)
	}
}