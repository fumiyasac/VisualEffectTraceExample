package net.just1factory.visual_effect_example.app.controller.api.v1

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.service.AnnouncementService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/v1")
class AnnouncementController(private val announcementService: AnnouncementService) {

    // MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
    @GetMapping("/announcement")
    fun findAll(): List<AnnouncementEntity> {
        return announcementService.findAll()
    }
}