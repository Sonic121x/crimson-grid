/datum/disease/anxiety
	name = "重度焦虑症"
	form = "病症"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "乙醇（酒壮怂人胆）"
	cures = list(/datum/reagent/consumable/ethanol)
	agent = "灭蝶剂过量"
	viable_mobtypes = list(/mob/living/carbon/human)
	desc = "一种已有充分记载的病症，会让患者的胃里真的出现蝴蝶，并经常将其吐出。"
	severity = DISEASE_SEVERITY_MINOR


/datum/disease/anxiety/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2) //also changes say, see say.dm
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感到焦虑不安。"))
		if(3)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你的胃里一阵扑腾。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_notice("你感到惊慌失措。"))
			if(SPT_PROB(1, seconds_per_tick))
				to_chat(affected_mob, span_danger("恐慌将你彻底吞没！"))
				affected_mob.adjust_confusion(rand(2 SECONDS, 3 SECONDS))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到胃里有蝴蝶在扑腾。"))
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]惊慌地四处踉跄。"), \
												span_userdanger("你惊恐发作了！"))
				affected_mob.adjust_confusion(rand(6 SECONDS, 8 SECONDS))
				affected_mob.adjust_jitter(rand(12 SECONDS, 16 SECONDS))
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.visible_message(span_danger("[affected_mob]咳出了蝴蝶！"), \
													span_userdanger("你咳出了蝴蝶！"))
				new /mob/living/basic/butterfly(affected_mob.loc)
				new /mob/living/basic/butterfly(affected_mob.loc)
