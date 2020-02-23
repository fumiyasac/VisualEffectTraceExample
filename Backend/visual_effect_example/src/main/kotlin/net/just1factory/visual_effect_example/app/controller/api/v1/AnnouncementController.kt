package net.just1factory.visual_effect_example.app.controller.api.v1

import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity
import net.just1factory.visual_effect_example.domain.service.AnnouncementService
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable

// Javaクラスのインポート宣言
import java.util.*

@RestController
@RequestMapping("/api/v1")
class AnnouncementController(private val announcementService: AnnouncementService) {

    // MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
    @GetMapping("/announcement")
    fun findAll(): List<AnnouncementEntity> {
        return announcementService.findAll()
    }

    // MEMO: AnnouncementServiceを経由して受け取ったIDに紐づくAnnouncementEntityにマッピングされたデータを1件取得する
    @GetMapping("/announcement/{id}")
    fun findBy(@PathVariable id: Int): Optional<AnnouncementEntity> {
         return announcementService.findBy(id)
    }
}