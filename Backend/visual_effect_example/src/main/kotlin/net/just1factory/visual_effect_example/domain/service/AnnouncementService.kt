package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.repository.AnnouncementRepository
import org.springframework.stereotype.Service

//
import org.springframework.beans.factory.annotation.Autowired;

@Service
class AnnouncementService {

    @Autowired
    private lateinit var announcementRepository: AnnouncementRepository

    // MEMO: この記事を参考に実装しています。
    // 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
    // https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

    // ライブラリ`JPA`を利用してAnnouncementEntityにマッピングされたデータを全件取得する
    fun findAll(): List<AnnouncementEntity> {
        return announcementRepository.findAll()
    }

    // ライブラリ`JPA`を利用してAnnouncementEntityにマッピングされたデータのうち該当するIDに紐づくものを取得する
    fun findBy(id: Int): AnnouncementEntity? {
        return announcementRepository.findById(id).orElse(null)
    }
}