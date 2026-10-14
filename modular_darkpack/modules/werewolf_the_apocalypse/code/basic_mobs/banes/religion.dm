/mob/living/basic/bane/religion
	desc = "一个看着莫名眼熟的怪物，让你想起自己的姨妈。"
	icon_state = "religion_bane"
	maxHealth = 50
	health = 50
	pass_flags = PASSMOB
	mob_size = MOB_SIZE_SMALL

/mob/living/basic/bane/religion/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)
	AddComponent(/datum/component/swarming)
