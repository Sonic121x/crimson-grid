/datum/disease/decloning
	form = "病毒"
	name = "细胞退化症"
	max_stages = 5
	stage_prob = 0.5
	cure_text = "复生酮可治愈，稳变酮可缓解，死亡也会终止病程"
	agent = "严重基因损伤"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = @"若不治疗，患者将会[内容已删节]！"
	severity = "Dangerous!"
	cures = list(/datum/reagent/medicine/rezadone)
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spread_text = "不传染"
	process_dead = TRUE
	bypasses_immunity = TRUE

/datum/disease/decloning/cure(add_resistance = TRUE)
	affected_mob.remove_status_effect(/datum/status_effect/decloning)
	return ..()

/datum/disease/decloning/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(affected_mob.stat == DEAD)
		cure()
		return FALSE

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("itch")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("yawn")
		if(3)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("itch")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(1.5, seconds_per_tick))
				affected_mob.apply_status_effect(/datum/status_effect/decloning)
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的皮肤感觉怪怪的。"))
		if(4)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("itch")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.apply_status_effect(/datum/status_effect/decloning)
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1, 170)
			if(SPT_PROB(7.5, seconds_per_tick))
				affected_mob.adjust_stutter(6 SECONDS)
		if(5)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("itch")
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("drool")
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的皮肤开始溃烂！"))
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.apply_status_effect(/datum/status_effect/decloning)
				affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2, 170)
