package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.StoryEntity
import net.just1factory.visual_effect_example.domain.repository.StoryRepository
import org.springframework.stereotype.Service

import org.springframework.beans.factory.annotation.Autowired

@Service
class StoryService {

	@Autowired
	private lateinit var storyRepository: StoryRepository

	// MEMO: この記事を参考に実装しています。
	// 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
	// https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

	// ライブラリ`JPA`を利用してStoryRepositoryにマッピングされたデータを全件取得して総数を取得する
	fun findAll(): List<StoryEntity> {
		return storyRepository.findAll()
	}

	// ライブラリ`JPA`を利用してStoryEntityにマッピングされたデータのうち該当するIDに紐づくものを取得する
	fun findBy(id: Int): StoryEntity? {
		return storyRepository.findById(id).orElse(null)
	}
}