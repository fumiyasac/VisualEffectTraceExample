package net.just1factory.visual_effect_example.domain.service

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.repository.AnnouncementRepository
import org.springframework.stereotype.Service

@Service
class AnnouncementService (private val announcementRepository: AnnouncementRepository) {

    // MEMO: ライブラリ`JPA`を利用してAnnouncementEntityにマッピングされたデータを全件取得する
    fun findAll(): List<AnnouncementEntity> = announcementRepository.findAll()
}