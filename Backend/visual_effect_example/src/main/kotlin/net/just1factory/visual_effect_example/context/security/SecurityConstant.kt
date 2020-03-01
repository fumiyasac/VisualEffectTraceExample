package net.just1factory.visual_effect_example.context.security

val ANNOUNCEMENT_LIST_URL = "/api/v1/announcement"
val ANNOUNCEMENT_DETAIL_URL = "/api/v1/announcement/{id}"
val SIGN_UP_URL = "/api/v1/signup"
val SIGN_IN_URL = "/api/v1/signin"
val SECRET = "SecretKeyToGenJWTs"
val TOKEN_PREFIX = "Bearer "
val HEADER_STRING = "Authorization"
val EXPIRATION_TIME: Long = 864_000_000 // 10 days
