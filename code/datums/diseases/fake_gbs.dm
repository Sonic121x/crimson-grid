/datum/disease/fake_gbs
	name = "GBS病"
	desc = "一种极其罕见且危险的疾病。由于可能带来灭世灾难，对其开展的研究十分有限。"
	max_stages = 5
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "突触嗪与硫"
	cures = list(/datum/reagent/medicine/synaptizine,/datum/reagent/sulfur)
	agent = "重力操控双势因子SADS-"
	viable_mobtypes = list(/mob/living/carbon/human)
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = HIDDEN_BOOK

/datum/disease/fake_gbs/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(0.5, seconds_per_tick))
				affected_mob.emote("sneeze")
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
			else if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("gasp")
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你开始感到十分虚弱……"))
		if(4)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("cough")

		if(5)
			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("cough")
