/**Choking
 * Very very noticable.
 * Lowers resistance
 * Decreases stage speed
 * Greatly decreases transmissibility
 * Moderate Level.
 * Bonus: Inflicts spikes of oxyloss
 */

/datum/symptom/choking
	name = "Choking"
	desc = "病毒导致宿主气道发炎，引发间歇性的呼吸阻塞。"
	illness = "气压管道"
	stealth = -1
	resistance = 0
	stage_speed = -1
	transmittable = -1
	level = 6
	severity = 3
	base_message_chance = 15
	symptom_delay = 20
	required_organ = ORGAN_SLOT_LUNGS
	symptom_cure = /datum/reagent/medicine/c2/tirimol
	cure_color = "orange"
	threshold_descs = list(
		"发展速度 8" = "更频繁地引发呼吸阻塞。",
		"隐蔽性 4" = "症状在发作前难以察觉。"
	)
	var/suppress_warning = FALSE

/datum/symptom/choking/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() >= 8)
		symptom_delay = 15.5
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE

/datum/symptom/choking/Activate(datum/disease/advance/advanced_disease)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/infected_mob = advanced_disease.affected_mob

	switch(advanced_disease.stage)
		if(1, 2)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(infected_mob, span_warning("[pick("你呼吸困难。", "你的呼吸变得沉重。")]"))
		if(3, 4)
			if(!suppress_warning)
				to_chat(infected_mob, span_warning("[pick("你的气管感觉细得像根吸管。", "你的呼吸变得极其困难。")]"))
			else
				to_chat(infected_mob, span_warning("你感到[pick("头晕目眩","昏昏沉沉","几乎要昏倒了")]。")) //fake bloodloss messages
			Choke_stage_3_4(infected_mob, advanced_disease)
			infected_mob.emote("gasp")
		else
			to_chat(infected_mob, span_userdanger("[pick("你快窒息了！", "你无法呼吸！")]"))
			Choke(infected_mob, advanced_disease)
			infected_mob.emote("gasp")

/datum/symptom/choking/proc/Choke_stage_3_4(mob/living/M, datum/disease/advance/A)
	M.adjust_oxy_loss(rand(6,13))
	return 1

/datum/symptom/choking/proc/Choke(mob/living/M, datum/disease/advance/A)
	M.adjust_oxy_loss(rand(10,18))
	return 1

/*
//////////////////////////////////////

Asphyxiation

	Very very noticable.
	Decreases stage speed.
	Decreases transmittability.

Bonus
	Inflicts large spikes of oxyloss
	Introduces Asphyxiating drugs to the system

//////////////////////////////////////
*/

/datum/symptom/asphyxiation
	name = "Acute respiratory distress syndrome"
	desc = "病毒导致宿主的肺部萎缩，引发严重窒息。"
	illness = "铁肺症"
	stealth = -2
	resistance = 0
	stage_speed = -1
	transmittable = -2
	level = 9
	severity = 6
	base_message_chance = 15
	symptom_delay = 22
	required_organ = ORGAN_SLOT_LUNGS
	symptom_cure = /datum/reagent/toxin/bonehurtingjuice // It'll be funny I swear
	cure_color = "orange" // The only level 7 symptom without a red color
	threshold_descs = list(
		"发展速度 8" = "额外在宿主体内合成泮库溴铵和硫喷妥钠。",
		"传播力 8" = "症状造成的伤害翻倍。"
	)
	var/paralysis = FALSE


/datum/symptom/asphyxiation/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStageSpeed() >= 8)
		paralysis = TRUE
	if(A.totalTransmittable() >= 8)
		power = 2

/datum/symptom/asphyxiation/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(3, 4)
			to_chat(M, span_warning("<b>[pick("你的气管感觉变细了。", "你的肺感觉变小了。")]"))
			Asphyxiate_stage_3_4(M, A)
			M.emote("gasp")
		if(5)
			to_chat(M, span_userdanger("[pick("你的肺很疼！", "每次呼吸都很疼！")]"))
			Asphyxiate(M, A)
			M.emote("gasp")
			if(M.get_oxy_loss() >= (M.maxHealth / (200/120)))
				M.visible_message(span_warning("[M]停止了呼吸，仿佛肺部已经完全塌陷！"))
				Asphyxiate_death(M, A)
	return

/datum/symptom/asphyxiation/proc/Asphyxiate_stage_3_4(mob/living/M, datum/disease/advance/A)
	var/get_damage = rand(10,15) * power
	M.adjust_oxy_loss(get_damage)
	return 1

/datum/symptom/asphyxiation/proc/Asphyxiate(mob/living/M, datum/disease/advance/A)
	var/get_damage = rand(15,21) * power
	M.adjust_oxy_loss(get_damage)
	if(paralysis)
		M.reagents.add_reagent_list(list(/datum/reagent/toxin/pancuronium = 3, /datum/reagent/toxin/sodium_thiopental = 3))
	return 1

/datum/symptom/asphyxiation/proc/Asphyxiate_death(mob/living/M, datum/disease/advance/A)
	var/get_damage = rand(25,35) * power
	M.adjust_oxy_loss(get_damage)
	M.adjust_organ_loss(ORGAN_SLOT_BRAIN, get_damage/2)
	return 1
