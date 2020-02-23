package net.just1factory.visual_effect_example.app.response.announcement

import com.fasterxml.jackson.annotation.JsonCreator
import net.just1factory.visual_effect_example.domain.entity.AnnouncementEntity

data class AnnouncementListResponse @JsonCreator constructor(
	val result: List<AnnouncementEntity>
)
