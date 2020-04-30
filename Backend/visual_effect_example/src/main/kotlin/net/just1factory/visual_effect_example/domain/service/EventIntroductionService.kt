package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.EventIntroductionEntity
import net.just1factory.visual_effect_example.domain.repository.EventIntroductionRepository
import org.springframework.stereotype.Service

import org.springframework.beans.factory.annotation.Autowired

@Service
class EventIntroductionService {

    @Autowired
    private lateinit var eventIntroductionRepository: EventIntroductionRepository

    // MEMO: この記事を参考に実装しています。
    // 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
    // https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

    // ライブラリ`JPA`を利用してEventIntroductionRepositoryにマッピングされたデータを全件取得して総数を取得する
    fun findAllCount(): Int {
        return eventIntroductionRepository.findAll().count()
    }

    // ライブラリ`JPA`を利用してページネーションを考慮したEventIntroductionRepositoryにマッピングされたデータを取得する
    fun findListPerPage(limit: Int, offset: Int): List<EventIntroductionEntity> {
        return eventIntroductionRepository.selectEventIntroductionPerPage(limit = limit, offset = offset)
    }
}