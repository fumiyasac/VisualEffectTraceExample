package net.just1factory.visual_effect_example.domain.repository

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface AnnouncementRepository :JpaRepository<AnnouncementEntity, Int> {
    // MEMO: ライブラリ`JPA`を利用してAnnouncementEntityを利用したCRUDメソッドを利用可能にする

    // 参考URL: Spring Boot/KotlinでCRUD操作のできるAPIを作成する方法
    // https://qiita.com/akkino_D-En/items/574ccdc057849e0e22ce
}
