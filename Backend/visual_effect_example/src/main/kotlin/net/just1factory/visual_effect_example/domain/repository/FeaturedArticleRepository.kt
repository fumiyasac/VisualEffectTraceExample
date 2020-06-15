package net.just1factory.visual_effect_example.domain.repository

import net.just1factory.visual_effect_example.domain.entity.FeaturedArticleEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface FeaturedArticleRepository :JpaRepository<FeaturedArticleEntity, Int> {
	// MEMO: ライブラリ`JPA`を利用してFeaturedArticleEntityを利用したCRUDメソッドを利用可能にする

	// 参考URL: Spring Boot/KotlinでCRUD操作のできるAPIを作成する方法
	// https://qiita.com/akkino_D-En/items/574ccdc057849e0e22ce

	// 参考URL: SpringDataJPAの使い方リファレンス
	// https://github.com/devhyukke/HelloWorldTS/wiki/SpringDataJPA
}