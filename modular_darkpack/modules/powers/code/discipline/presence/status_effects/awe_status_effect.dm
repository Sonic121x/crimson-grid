/datum/status_effect/awe //Used for powers that force a target to walk to you.
	id = "awe"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 1 SCENES
	alert_type = /atom/movable/screen/alert/status_effect/awe
	var/mob/living/carbon/human/source

/datum/status_effect/awe/on_creation(mob/living/new_owner, mob/living/carbon/human/awe_source)
	. = ..()
	source = awe_source
	if(linked_alert && source)
		linked_alert.desc = "[capitalize("[source.get_visible_name(add_id_name = FALSE, examiner = owner)]")]似乎很有魅力……我被那份气质迷住了。我得再靠近一点。"

/atom/movable/screen/alert/status_effect/awe
	name = "敬畏"
	desc = "那个人似乎很有魅力……我被那份气质迷住了。我得再靠近一点。"
	icon_state = "hypnosis"
