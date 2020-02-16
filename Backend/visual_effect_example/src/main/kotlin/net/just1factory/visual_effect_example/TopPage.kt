package net.just1factory.visual_effect_example

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.bind.annotation.RequestMethod

@RestController
class TopPage {
    @RequestMapping("/", method = [RequestMethod.GET])
    fun index() : String {
        return "こんにちは! Kotlinの世界へようこそ!"
    }
}