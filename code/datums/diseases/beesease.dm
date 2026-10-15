/datum/disease/beesease
	name = "蜂巢病"
	form = "寄生虫"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "糖"
	cures = list(/datum/reagent/consumable/sugar)
	agent = "蜜蜂寄生"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "一种怪病，会在患者胃里孕育蜜蜂，患者经常会将这些蜜蜂吐出。"
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD //bees nesting in corpses


/datum/disease/beesease/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2) //also changes say, see say.dm
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_notice("你尝到了嘴里的蜂蜜味。"))
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你的肚子咕噜作响。"))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("你的胃里一阵刺痛。"))
				if(prob(20))
					affected_mob.adjust_tox_loss(2)
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]发出嗡嗡声。"), \
												span_userdanger("你的胃里嗡嗡声大作！"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到有东西在喉咙里蠕动。"))
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]咳出了一群蜜蜂！"), \
													span_userdanger("你咳出了一群蜜蜂！"))
				new /mob/living/basic/bee(affected_mob.loc)
