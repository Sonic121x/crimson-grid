/datum/mood_event/drunk
	mood_change = 3
	description = "喝上一两杯，一切都感觉好多了。"
	/// The blush overlay to display when the owner is drunk
	var/datum/bodypart_overlay/simple/emote/blush_overlay

/datum/mood_event/drunk/add_effects(drunkness)
	update_change(drunkness)
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	blush_overlay = human_owner.give_emote_overlay(/datum/bodypart_overlay/simple/emote/blush)

/// Updates the description and value of the moodlet according to the passed drunkness value
/// (Does not add to or remove from the current level - it will sets it directly to the new value)
/datum/mood_event/drunk/proc/update_change(drunkness = 0)
	var/old_mood = mood_change
	switch(drunkness)
		if(0 to 30)
			mood_change = 3
			description = "喝上一两杯，一切都感觉好多了。"
		if(30 to 45)
			mood_change = 4
			description = "是越来越热了，还是只有我这么觉得？我得再喝一杯降降温。"
		if(45 to 60)
			mood_change = 5
			description = "谁一直在挪地板？我要找他理论……等我喝完这杯。"
		if(60 to 90)
			mood_change = 6
			description = "我才没——醉，你才醉了！说真的……我还要再来一杯！"
		if(90 to INFINITY)
			mood_change = 3 // crash out
			description = "你是我最——好的兄弟……咱俩一起跟全世界干，兄弟。来，再喝一杯。"
	if(HAS_PERSONALITY(owner, /datum/personality/teetotal))
		mood_change *= -1.5
		description = "我不喜欢喝酒……这感觉糟透了。"
	if(HAS_PERSONALITY(owner, /datum/personality/bibulous))
		mood_change *= 1.5
	if(old_mood != mood_change)
		owner.mob_mood.update_mood()

/datum/mood_event/drunk/remove_effects()
	QDEL_NULL(blush_overlay)

/datum/mood_event/drunk_after
	mood_change = 2
	description = "酒劲可能过去了，但我还是感觉不错。"
	timeout = 5 MINUTES

/datum/mood_event/wrong_brandy
	description = "我讨厌这种饮品。"
	mood_change = -2
	timeout = 6 MINUTES

/datum/mood_event/quality_revolting
	description = "那是我这辈子喝过最恶心的东西。"
	mood_change = -8
	timeout = 7 MINUTES

/datum/mood_event/quality_nice
	description = "那杯饮品还真不赖。"
	mood_change = 2
	timeout = 7 MINUTES

/datum/mood_event/quality_good
	description = "那杯饮品相当不错。"
	mood_change = 4
	timeout = 7 MINUTES

/datum/mood_event/quality_verygood
	description = "那杯饮品真棒！"
	mood_change = 6
	timeout = 7 MINUTES

/datum/mood_event/quality_fantastic
	description = "那杯饮品简直令人惊艳！"
	mood_change = 8
	timeout = 7 MINUTES

/datum/mood_event/amazingtaste
	description = "味道棒极了！"
	mood_change = 50
	timeout = 10 MINUTES

/datum/mood_event/wellcheers
	description = "这罐畅饮牌果汁真好喝！咸味葡萄风味让人精神一振。"
	mood_change = 3
	timeout = 7 MINUTES

/datum/mood_event/sweetcoffee
	description = "咖啡苦中带甜的滋味还不错。"
	mood_change = 2
	timeout = 5 MINUTES

/datum/mood_event/sweettea
	description = "让烦恼像茶里的糖一样融化吧。"
	mood_change = 4
	timeout = 2.5 MINUTES
