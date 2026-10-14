/obj/ritual_rune/thaumaturgy/blood_guardian
	name = "鲜血小鬼"
	desc = "血魔法师有时需要一两个实验室助手，协助工作或保卫秘所。此仪式赋予一个由施术者自身鲜血构成的人形造物以生命。"
	icon_state = "rune1"
	word = "UR'JOLA"
	level = 3
	cost = 5

/obj/ritual_rune/thaumaturgy/blood_guardian/complete()
	. = ..()
	var/mob/living/carbon/human/H = last_activator
	H.add_beastmaster_minion(/mob/living/basic/blood_guard)
	if(length(H.beastmaster_minions) > 3+H.st_get_stat(STAT_LEADERSHIP))
		var/mob/living/basic/blood_guard/B = pick(H.beastmaster_minions)
		B.death()
	qdel(src)

