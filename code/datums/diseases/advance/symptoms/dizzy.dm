/**Dizziness
 * Increases stealth
 * Lowers resistance
 * Decreases stage speed considerably
 * Slightly reduces transmissibility
 * Intense Level
 * Bonus: Shakes the affected mob's screen for short periods.
 */

/datum/symptom/dizzy // Not the egg
	name = "Dizziness"
	desc = "病毒导致前庭系统发炎，引发阵发性眩晕。"
	illness = "晕动症"
	stealth = 1
	resistance = 1
	stage_speed = 3
	transmittable = 3
	level = 2
	severity = 2
	base_message_chance = 50
	symptom_delay = 22.5
	symptom_cure = /datum/reagent/medicine/haloperidol
	cure_color = "yellow"
	threshold_descs = list(
		"传播力 6" = "还会引发吸毒般的视觉异常。",
		"隐蔽性 4" = "症状在发作前难以察觉。",
	)
	var/suppress_warning = FALSE

/datum/symptom/dizzy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4)
		suppress_warning = TRUE
	if(A.totalTransmittable() >= 6) //druggy
		power = 2

/datum/symptom/dizzy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance) && !suppress_warning)
				to_chat(M, span_warning("[pick("你感到眩晕。", "你感到天旋地转。")]"))
		else
			to_chat(M, span_userdanger("一阵强烈的眩晕感袭来！"))
			M.adjust_dizzy_up_to(40 SECONDS, 80 SECONDS)
			if(power >= 2)
				M.set_drugginess(60 SECONDS)
