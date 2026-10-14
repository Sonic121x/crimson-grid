/obj/ritual_rune/abyss/calling_the_hungry_shade
	name = "召唤饥饿幽影"
	desc = "召来一个饥饿而狂怒的深渊幽影，并尝试驯服它。小心，失败后它会反过来攻击你！"
	icon_state = "rune8"
	word = "饥饿之灵。"
	level = 3
	cost = 1
	difficulty = 9

/obj/ritual_rune/abyss/calling_the_hungry_shade/complete()
	. = ..()
	if(ishuman(last_activator))
		var/mob/living/carbon/human/human_activator = last_activator
		human_activator.add_beastmaster_minion(/mob/living/basic/shadow_guard/hungry_shade)
		if(length(human_activator.beastmaster_minions) > human_activator.st_get_stat(STAT_OCCULT))
			var/mob/living/beastmaster_minion = pick(human_activator.beastmaster_minions)
			beastmaster_minion.death()
	qdel(src)

/obj/ritual_rune/abyss/calling_the_hungry_shade/ritual_failure()
	. = ..()
	var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
	shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
	shade.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, last_activator)
	shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
	to_chat(last_activator, span_warning("仪式脱离了你的掌控，仍有某种存在回应了召唤！"))
	qdel(src)

/obj/ritual_rune/abyss/calling_the_hungry_shade/ritual_botch()
	. = ..()
	var/mob/living/basic/shadow_guard/hungry_shade/shade = new(get_turf(src))
	shade.ai_controller = new /datum/ai_controller/basic_controller/simple/simple_hostile(shade)
	shade.ai_controller.set_blackboard_key(BB_CURRENT_TARGET, last_activator)
	shade.remove_faction(VAMPIRE_CLAN_LASOMBRA)
	to_chat(last_activator, span_warning("你失去了对仪式的控制！"))
	last_activator.apply_damage(30, AGGRAVATED)
	qdel(src)
