/**Confusion
 * Slightly increases stealth
 * Slightly lowers resistance
 * Decreases stage speed
 * No effect to transmissibility
 * Intense level
 * Bonus: Makes the affected mob be confused for short periods of time.
 */
/datum/symptom/confusion
	name = "Confusion"
	desc = "病毒干扰神经系统的正常功能，导致间歇性的意识混乱与行动失常。"
	illness = "破碎现实"
	stealth = 2
	resistance = 1
	stage_speed = 1
	transmittable = 2
	level = 3
	severity = 2
	base_message_chance = 25
	symptom_delay = 20
	symptom_cure = /datum/reagent/medicine/synaptizine
	threshold_descs = list(
		"抗性 6" = "随时间推移造成脑部损伤。",
		"传播力 6" = "延长意识混乱的持续时间并增强其程度。",
		"隐蔽性 4" = "症状在发作前难以察觉。",
	)
	var/brain_damage = FALSE
	var/causes_illiteracy = FALSE
	var/suppress_warning = FALSE

/datum/symptom/confusion/Start(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return
	if(advanced_disease.totalStageSpeed() >= 6)
		causes_illiteracy = TRUE
	if(advanced_disease.totalResistance() >= 6)
		brain_damage = TRUE
	if(advanced_disease.totalTransmittable() >= 6)
		power = 1.5
	if(advanced_disease.totalStealth() >= 4)
		suppress_warning = TRUE

/datum/symptom/confusion/End(datum/disease/advance/advanced_disease)
	advanced_disease.affected_mob.remove_status_effect(/datum/status_effect/confusion)
	return ..()

/datum/symptom/confusion/Activate(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/infected_mob = advanced_disease.affected_mob
	switch(advanced_disease.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(infected_mob, span_warning("[pick("你的头很疼。", "你的脑海一瞬间变得空白。")]"))
		else
			to_chat(infected_mob, span_userdanger("你无法正常思考了！"))
			infected_mob.adjust_confusion_up_to(16 SECONDS * power, 30 SECONDS)
			if(brain_damage)
				infected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 3 * power, 80)
				infected_mob.updatehealth()
	return
