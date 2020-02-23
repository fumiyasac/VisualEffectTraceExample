package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.repository.AnnouncementRepository
import org.springframework.stereotype.Service

// Javaクラスのインポート宣言
import java.util.*

@Service
class AnnouncementService (private val announcementRepository: AnnouncementRepository) {

    // MEMO: この記事を参考に実装しています。
    // 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
    // https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

    // ライブラリ`JPA`を利用してAnnouncementEntityにマッピングされたデータを全件取得する
    fun findAll(): List<AnnouncementEntity> = announcementRepository.findAll()

    // ライブラリ`JPA`を利用してAnnouncementEntityにマッピングされたデータのうち該当するIDに紐づくものを取得する
    fun findBy(id: Int): AnnouncementEntity? = announcementRepository.findById(id).orElse(null)
}