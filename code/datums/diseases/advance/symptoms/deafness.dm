/**Deafness
 * Slightly decreases stealth
 * Lowers Resistance
 * Slightly decreases stage speed
 * Decreases transmissibility
 * Intense level
 * Bonus: Causes intermittent loss of hearing.
*/
/datum/symptom/deafness
	name = "Deafness"
	desc = "病毒导致耳膜发炎，引发间歇性耳聋。"
	illness = "耳膜穿孔"
	stealth = 0
	resistance = 1
	stage_speed = 1
	transmittable = -2
	level = 4
	severity = 4
	base_message_chance = 100
	symptom_delay = 52.5
	required_organ = ORGAN_SLOT_EARS
	symptom_cure = /datum/reagent/medicine/psicodine
	threshold_descs = list(
		"抗性 9" = "造成永久性耳聋，而非间歇性耳聋。",
		"隐蔽性 4" = "症状在发作前难以察觉。",
	)
	var/causes_permanent_deafness = FALSE
	var/suppress_warning = FALSE

/datum/symptom/deafness/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalResistance() >= 9) //permanent deafness
		causes_permanent_deafness = TRUE

/datum/symptom/deafness/End(datum/disease/advance/advanced_disease)
	REMOVE_TRAIT(advanced_disease.affected_mob, TRAIT_DEAF, DISEASE_TRAIT)
	return ..()

/datum/symptom/deafness/Activate(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/infected_mob = advanced_disease.affected_mob

	switch(advanced_disease.stage)
		if(3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(infected_mob, span_warning("[pick("你听到耳内响起鸣声。", "你的耳内啵地响了一声。")]"))
		if(5)
			if(causes_permanent_deafness)
				if(!HAS_TRAIT_FROM(infected_mob, TRAIT_DEAF, DISEASE_TRAIT))
					to_chat(infected_mob, span_userdanger("你的耳内啪地一声，传来剧痛并开始流血！"))
					// Just absolutely murder me man
					infected_mob.adjust_organ_loss(ORGAN_SLOT_EARS, INFINITY)
					infected_mob.emote("scream")
					ADD_TRAIT(infected_mob, TRAIT_DEAF, DISEASE_TRAIT)
			else
				to_chat(infected_mob, span_userdanger("你的耳内啵地一声，随后响起刺耳的鸣声！"))
				var/obj/item/organ/ears/ears = infected_mob.get_organ_slot(ORGAN_SLOT_EARS)
				var/deafness_to_add = min(40 SECONDS - ears.temporary_deafness, 30 SECONDS)
				if(deafness_to_add > 0)
					ears.adjust_temporary_deafness(deafness_to_add)

/datum/symptom/deafness/on_stage_change(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/infected_mob = advanced_disease.affected_mob
	if(advanced_disease.stage < 5 || !causes_permanent_deafness)
		REMOVE_TRAIT(infected_mob, TRAIT_DEAF, DISEASE_TRAIT)
	return TRUE
