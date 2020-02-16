package net.just1factory.visual_effect_example

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController class TopPage {
    @RequestMapping("/")
    fun index() : String {
        return "こんにちは! Kotlinの世界へようこそ!"
    }
}