/obj/ritual_rune/abyss/heart_that_beats_in_silence
	name = "静默搏动之心"
	desc = "创造一个暗影憎恶，保护勒森布拉及其领地。"
	icon_state = "rune1"
	word = "ANI UMRA"
	level = 2
	cost = 1

/obj/ritual_rune/abyss/heart_that_beats_in_silence/complete()
	. = ..()
	var/mob/living/carbon/human/H = last_activator
	last_activator.apply_damage(30, AGGRAVATED)
	H.add_beastmaster_minion(/mob/living/basic/shadow_guard)
	//BG.melee_damage_lower = BG.melee_damage_lower+activator_bonus
	//BG.melee_damage_upper = BG.melee_damage_upper+activator_bonus
	if(length(H.beastmaster_minions) > H.st_get_stat(STAT_OCCULT))
		var/mob/living/beastmaster_minion = pick(H.beastmaster_minions)
		beastmaster_minion.death()
	qdel(src)

/obj/ritual_rune/abyss/heart_that_beats_in_silence/ritual_failure()
	. = ..()
	qdel(src)

/obj/ritual_rune/abyss/heart_that_beats_in_silence/ritual_botch()
	. = ..()
	to_chat(last_activator, span_warning("你失去了对仪式的控制！"))
	last_activator.apply_damage(30, AGGRAVATED)
	qdel(src)

