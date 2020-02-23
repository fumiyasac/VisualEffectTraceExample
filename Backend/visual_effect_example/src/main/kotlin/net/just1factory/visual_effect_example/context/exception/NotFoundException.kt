package net.just1factory.visual_effect_example.context.exception

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ResponseStatus
import java.lang.RuntimeException

// MEMO: StatusCode = 404 (Not Found)の例外を返却するレスポンス定義
// ※ SpringBootのエラーレスポンス内容を改変する
@ResponseStatus(code = HttpStatus.NOT_FOUND)
class NotFoundException (message: String? = null) : RuntimeException(message)