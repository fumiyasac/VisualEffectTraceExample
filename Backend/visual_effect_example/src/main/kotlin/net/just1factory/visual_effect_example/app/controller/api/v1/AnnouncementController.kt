package net.just1factory.visual_effect_example.app.controller.api.v1

// ドメイン層（Service）
import net.just1factory.visual_effect_example.domain.service.AnnouncementService

// アプリケーション層（Request・Response）
import net.just1factory.visual_effect_example.app.response.announcement.AnnouncementListResponse
import net.just1factory.visual_effect_example.app.response.announcement.AnnouncementDetailResponse

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.PathVariable

@RestController
@RequestMapping("/api/v1")
class AnnouncementController(private val announcementService: AnnouncementService) {

    // MEMO: AnnouncementServiceを経由してAnnouncementEntityにマッピングされたデータを全件取得する
    @GetMapping("/announcement")
    fun findAll(): AnnouncementListResponse {
        val announcements = announcementService.findAll()
        return AnnouncementListResponse(announcements)
    }

    // MEMO: AnnouncementServiceを経由して受け取ったIDに紐づくAnnouncementEntityにマッピングされたデータを1件取得する
    @GetMapping("/announcement/{id}")
    fun findBy(@PathVariable id: Int): AnnouncementDetailResponse {
        val announcement = announcementService.findBy(id)
        return AnnouncementDetailResponse(announcement)
    }
}