/datum/disease/gbs
	name = "GBS病"
	desc = "一种极其罕见且危险的疾病。由于可能带来灭世灾难，对其开展的研究十分有限。"
	max_stages = 4
	spread_text = "皮肤接触"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "突触嗪与硫"
	cures = list(/datum/reagent/medicine/synaptizine,/datum/reagent/sulfur)
	cure_chance = 7.5 //higher chance to cure, since two reagents are required
	agent = "重力操控双势因子SADS+"
	viable_mobtypes = list(/mob/living/carbon/human)
	disease_flags = CAN_CARRY|CAN_RESIST|CURABLE
	spreading_modifier = 1
	severity = DISEASE_SEVERITY_BIOHAZARD
	bypasses_immunity = TRUE

/datum/disease/gbs/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("gasp")
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到浑身疼痛！"))
		if(4)
			to_chat(affected_mob, span_userdanger("你感到自己的身体仿佛要从内部撕裂开来！"))
			if(SPT_PROB(30, seconds_per_tick))
				affected_mob.investigate_log("has been gibbed by GBS.", INVESTIGATE_DEATHS)
				affected_mob.gib(DROP_ALL_REMAINS)
				return FALSE

/datum/disease/gbs/no_transmission
	name = "非传染性GBS病"
	spread_text = "不传染"
	spread_flags = DISEASE_SPREAD_NON_CONTAGIOUS
	spreading_modifier = 0
