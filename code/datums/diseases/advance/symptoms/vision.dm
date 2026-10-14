/*Hyphema (Eye bleeding)
 * Slightly reduces stealth
 * Tremendously reduces resistance
 * Tremendously reduces stage speed
 * Greatly reduces transmissibility
 * Critical level
 * Bonus: Causes blindness.
*/
/datum/symptom/visionloss
	name = "Hyphema"
	desc = "患者眼睛的帧率低到危险的程度，导致眼部损伤并最终失明。"
	illness = "稀释瞳孔"
	stealth = 0
	resistance = -2
	stage_speed = -3
	transmittable = -2
	level = 8
	severity = 5
	base_message_chance = 50
	symptom_delay = 52.5
	required_organ = ORGAN_SLOT_EYES
	symptom_cure = /datum/reagent/medicine/oculine
	cure_color = "yellow"
	threshold_descs = list(
		"抗性 12" = "削弱眼外肌，最终导致眼球完全脱落。",
		"隐蔽性 4" = "症状在发作前难以察觉。",
	)
	/// At max stage: If FALSE, cause blindness. If TRUE, cause their eyes to fall out.
	var/remove_eyes = FALSE
	var/suppress_warning = FALSE

/datum/symptom/visionloss/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalResistance() >= 12) //goodbye eyes
		remove_eyes = TRUE

/datum/symptom/visionloss/Activate(datum/disease/advance/source_disease)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/infected_mob = source_disease.affected_mob
	var/obj/item/organ/eyes/eyes = infected_mob.get_organ_slot(ORGAN_SLOT_EYES)

	switch(source_disease.stage)
		if(1, 2)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(infected_mob, span_warning("你的眼睛发痒。"))

		if(3, 4)
			to_chat(infected_mob, span_boldwarning("你的眼睛灼痛难忍！"))
			infected_mob.set_eye_blur_if_lower(20 SECONDS)
			eyes.apply_organ_damage(1)

		else
			infected_mob.set_eye_blur_if_lower(40 SECONDS)
			eyes.apply_organ_damage(5)

			// Applies nearsighted at minimum
			if(!infected_mob.is_nearsighted_from(EYE_DAMAGE) && eyes.damage <= eyes.low_threshold)
				eyes.set_organ_damage(eyes.low_threshold)

			if(prob(eyes.damage - eyes.low_threshold + 1))
				if(remove_eyes)
					infected_mob.visible_message(
						span_warning("[infected_mob]的眼球从眼眶里掉了出来！"),
						span_userdanger("你的眼球从眼眶里掉了出来！"),
					)
					eyes.Remove(infected_mob)
					eyes.forceMove(get_turf(infected_mob))

				else if(!infected_mob.is_blind_from(EYE_DAMAGE))
					to_chat(infected_mob, span_userdanger("你失明了！"))
					eyes.apply_organ_damage(eyes.maxHealth)

			else
				to_chat(infected_mob, span_userdanger("你的眼睛承受着可怕的灼痛！"))
