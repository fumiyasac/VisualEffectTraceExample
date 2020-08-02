package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.ItemEntity
import net.just1factory.visual_effect_example.domain.repository.ItemRepository
import org.springframework.stereotype.Service

import org.springframework.beans.factory.annotation.Autowired

@Service
class ItemService {

    @Autowired
    private lateinit var itemRepository: ItemRepository

    // MEMO: この記事を参考に実装しています。
    // 参考: Kotlin + SpringBoot + JPA + Thymeleafで簡単なCRUDを作る②～画面と機能作成まで～
    // https://qiita.com/ozaki25/items/301d43dfcb1903ef995b

    // ライブラリ`JPA`を利用してEventIntroductionRepositoryにマッピングされたデータを全件取得して総数を取得する
    fun findAllCount(): Int {
        return itemRepository.findAll().count()
    }

    // ライブラリ`JPA`を利用してページネーションを考慮したEventIntroductionRepositoryにマッピングされたデータを取得する
    fun findListPerPage(limit: Int, offset: Int): List<ItemEntity> {
        return itemRepository.selectItemPerPage(limit = limit, offset = offset)
    }
}