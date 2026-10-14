/datum/status_effect/pain_botch
	id = "pain_botch"
	duration = 1 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/pain_botch
	var/botches_total = 0

/atom/movable/screen/alert/status_effect/pain_botch
	name = "痛苦之道大失败"
	desc = "你渴求痛苦，不断抓挠自己的皮肤。"
	icon_state = "blooddrunk"

/datum/status_effect/pain_botch/on_apply()
	. = ..()
	botches_total++
	if(botches_total >= 3)
		qdel(src)

/datum/status_effect/pain_botch/on_creation(mob/living/carbon/new_owner)
	. = ..()
	ADD_TRAIT(owner, TRAIT_PAIN_BOTCH, PATH_OF_PAIN_TRAIT)

/datum/status_effect/pain_botch/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PAIN_BOTCH, PATH_OF_PAIN_TRAIT)

// HUNDRED DEATHS STATUS EFFECT
/datum/status_effect/hundred_deaths
	id = "hundred_deaths"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/hundred_deaths

/atom/movable/screen/alert/status_effect/hundred_deaths
	name = "百死折磨"
	desc = "你感到百次死亡的重压正碾碎你的身躯与灵魂。"
	icon_state = "blooddrunk"

/datum/status_effect/hundred_deaths/on_creation(mob/living/carbon/new_owner)
	. = ..()
	owner.maxHealth = owner.maxHealth - 50

/datum/status_effect/hundred_deaths/on_remove()
	. = ..()
	owner.maxHealth = owner.maxHealth + 50
