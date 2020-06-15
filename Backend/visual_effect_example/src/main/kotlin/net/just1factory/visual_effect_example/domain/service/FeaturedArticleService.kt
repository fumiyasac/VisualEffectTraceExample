package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.FeaturedArticleEntity
import net.just1factory.visual_effect_example.domain.repository.FeaturedArticleRepository
import org.springframework.stereotype.Service

import org.springframework.beans.factory.annotation.Autowired

@Service
class FeaturedArticleService {

	@Autowired
	private lateinit var featuredArticleRepository: FeaturedArticleRepository

	// MEMO: この記事を参考に実装しています。
	// 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
	// https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

	// ライブラリ`JPA`を利用してFeaturedArticleRepositoryにマッピングされたデータを全件取得して総数を取得する
	fun findAll(): List<FeaturedArticleEntity> {
		return featuredArticleRepository.findAll()
	}
}