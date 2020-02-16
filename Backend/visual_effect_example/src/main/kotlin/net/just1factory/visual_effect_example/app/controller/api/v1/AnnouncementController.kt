package net.just1factory.visual_effect_example.app.controller.api.v1

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMethod

@RestController
class AnnouncementController {
    @RequestMapping("/announcement", method = [RequestMethod.GET])
    fun index(): String {
        return "お知らせ管理ページになります。"
    }
}