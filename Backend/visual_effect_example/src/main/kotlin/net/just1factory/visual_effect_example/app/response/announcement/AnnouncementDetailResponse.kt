package net.just1factory.visual_effect_example.app.response.announcement

import com.fasterxml.jackson.annotation.JsonCreator
import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity

data class AnnouncementDetailResponse @JsonCreator constructor(
	val result: AnnouncementEntity?
)