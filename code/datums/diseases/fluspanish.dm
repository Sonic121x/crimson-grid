/datum/disease/fluspanish
	name = "西班牙宗教裁判所流感"
	max_stages = 3
	spread_text = "空气传播"
	cure_text = "太空西林或普通流感抗体"
	cures = list(/datum/reagent/medicine/spaceacillin)
	cure_chance = 5
	agent = "1nqu1s1t10n型流感病毒粒子"
	viable_mobtypes = list(/mob/living/carbon/human)
	spreading_modifier = 0.75
	desc = "普通流感的一种变体，危险性略高。\
		若不治疗，患者会以异端之名被活活烧死。"
	severity = DISEASE_SEVERITY_DANGEROUS
	required_organ = ORGAN_SLOT_LUNGS

/datum/disease/fluspanish/cure(add_resistance)
	// buy one, get one free
	if(add_resistance && affected_mob)
		LAZYOR(affected_mob.disease_resistances, "[/datum/disease/flu]")
	return ..()

/datum/disease/fluspanish/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	switch(stage)
		if(2)
			affected_mob.adjust_bodytemperature(5 * seconds_per_tick)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(0.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到自己的皮肉正在燃烧！"))
				affected_mob.take_bodypart_damage(0, 5, updating_health = FALSE)

		if(3)
			affected_mob.adjust_bodytemperature(10 * seconds_per_tick)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("sneeze")
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("cough")
			if(SPT_PROB(2.5, seconds_per_tick))
				to_chat(affected_mob, span_danger("你感到自己的皮肉正在燃烧！"))
				affected_mob.take_bodypart_damage(0, 5, updating_health = FALSE)
