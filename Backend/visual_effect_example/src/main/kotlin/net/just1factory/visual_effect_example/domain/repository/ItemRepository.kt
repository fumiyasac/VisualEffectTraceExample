package net.just1factory.visual_effect_example.domain.repository

import net.just1factory.visual_effect_example.domain.entity.ItemEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import org.springframework.stereotype.Repository

@Repository
interface ItemRepository :JpaRepository<ItemEntity, Int> {
    // MEMO: ライブラリ`JPA`を利用してAnnouncementEntityを利用したCRUDメソッドを利用可能にする

    // 参考URL: Spring Boot/KotlinでCRUD操作のできるAPIを作成する方法
    // https://qiita.com/akkino_D-En/items/574ccdc057849e0e22ce

	// 参考URL: 生のクエリを直接書いてデータを取得する方法
	// https://kleinblog.net/kotlin-jpa-sql/

	@Query(value = "SELECT * FROM items ORDER BY id DESC LIMIT :limit OFFSET :offset" , nativeQuery = true)
	fun selectItemPerPage(@Param("limit") limit: Int, @Param("offset") offset: Int): List<ItemEntity>
}
