/datum/status_effect/delirium
	id = "delirium"
	status_type = STATUS_EFFECT_REFRESH
	duration = 10 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/delirium
	COOLDOWN_DECLARE(message_cooldown)
	var/static/list/willpower_levels = list(
		"吓到僵直",
		"惊慌失措",
		"难以置信",
		"狂暴怒意",
		"极度恐惧",
		"求饶的冲动",
		"压抑着恐惧",
		"好奇",
		"嗜血欲望",
		"毫无反应"
	)
	var/willpower_dots = 1
	var/datum/weakref/scary_wolf_ref
	var/image/scary_static

/datum/status_effect/delirium/on_creation(mob/living/new_owner, mob/big_wolf)
	scary_wolf_ref = WEAKREF(big_wolf)
	. = ..()
	linked_alert.desc += " 你此刻的状态是<b>[willpower_levels[willpower_dots]]</b>。"

/datum/status_effect/delirium/on_apply()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return FALSE
	if(!human_owner.affected_by_delirium())
		return FALSE
	var/mob/living/wolf = scary_wolf_ref?.resolve()
	if(!wolf)
		return FALSE

	var/effective_dots = human_owner.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(HAS_TRAIT(wolf, TRAIT_WEAK_DELIRIUM))
		effective_dots += 2
	willpower_dots = clamp(effective_dots, 1, 10)

	to_chat(owner, span_cult_large("看到[wolf]，你内心深处的某种本能使你陷入<b>[willpower_levels[willpower_dots]]</b>的状态。"))

	if(owner.client)
		// dir SOUTH is admitting i compeletly lost the fight against this stupid bullshit and cant get the image to properly mimmic the direction of the mob.
		var/image/overlay_image = image(loc = wolf, dir = SOUTH)
		overlay_image.appearance = wolf.appearance
		overlay_image.override = TRUE
		overlay_image.name = "未知存在"
		overlay_image.pixel_y = 0
		overlay_image.pixel_x = 0
		overlay_image.pixel_w = 0
		overlay_image.pixel_z = 0
		SET_PLANE_EXPLICIT(overlay_image, ABOVE_GAME_PLANE, wolf)

		var/mutable_appearance/static_effect = mutable_appearance('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/big_static.dmi', "static_base")
		static_effect.color = "#373642"
		static_effect.blend_mode = BLEND_INSET_OVERLAY
		overlay_image.overlays += static_effect

		owner.client.images += overlay_image
		scary_static = overlay_image

	if(willpower_dots == 1)
		owner.Unconscious(30)

/datum/status_effect/delirium/on_remove()
	. = ..()
	to_chat(owner, span_notice("你激荡的情绪逐渐消退，开始平静下来。"))
	owner.client?.images -= scary_static
	QDEL_NULL(scary_static)

/datum/status_effect/delirium/tick(seconds_between_ticks)
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return
	if(!human_owner.affected_by_delirium())
		return
	if(COOLDOWN_FINISHED(src, message_cooldown))
		COOLDOWN_START(src, message_cooldown, rand(10, 15) SECONDS)
		var/message = get_message()
		if(message)
			to_chat(owner, span_cult_bold(message))


/datum/status_effect/delirium/proc/get_message()
	switch(willpower_dots)
		// Catatonic Fear
		if(1)
			return pick("恐惧", "晕厥", "瘫倒")
		// Panic
		if(2)
			return pick("快跑", "马上跑", "离远点")
		// Disbelief
		if(3)
			return pick("躲起来", "蜷缩起来")
		// Beserk
		if(4)
			return pick("战斗", "踢", "打", "咬", "挥击")
		// Terror
		if(5)
			return pick("快跑", "马上跑", "离远点", "想办法")
		// Conciliatory
		if(6)
			return pick("求饶", "讨价还价", "呜咽")
		// Controlled Fear
		if(7)
			return "恐惧"
		// Curiosity
		if(8)
			return pick("了解", "探索")
		// Bloodlust
		if(9)
			return "愤怒"
		// No reaction
		if(10)
			return


/atom/movable/screen/alert/status_effect/delirium
	name = "谵妄"
	desc = "一种超自然的恐惧。"
	icon_state = "fear"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'


/mob/living/carbon/human/proc/affected_by_delirium()
	if(issupernatural(src))
		return FALSE

	if(st_get_stat(STAT_PERMANENT_WILLPOWER) >= 10)
		return FALSE

	return TRUE
