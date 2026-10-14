/*Narcolepsy
 * Slight reduction to stealth
 * Reduces resistance
 * Greatly reduces stage speed
 * No change to transmissibility
 * Fatal level
 * Bonus: Causes drowsiness and sleep.
*/
/datum/symptom/narcolepsy
	name = "Narcolepsy"
	desc = "病毒导致激素失衡，使宿主困倦并出现突发性睡眠。"
	illness = "极光鼾鸣"
	stealth = -1
	resistance = -2
	stage_speed = -2
	transmittable = 0
	level = 4
	symptom_delay = 57.5
	severity = 4
	symptom_cure = /datum/reagent/medicine/ondansetron
	cure_color = "yellow"
	var/yawning = FALSE
	threshold_descs = list(
		"传播力 4" = "使宿主周期性地打哈欠，尝试将病毒传染给周围6米内的人。",
		"发展速度 10" = "提高睡病的发作频率，增加宿主入睡的可能性。",
	)

/datum/symptom/narcolepsy/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalTransmittable() >= 4) //yawning (mostly just some copy+pasted code from sneezing, with a few tweaks)
		yawning = TRUE
	if(A.totalStageSpeed() >= 10) //act more often
		symptom_delay = 32.5

/datum/symptom/narcolepsy/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return

	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1)
			if(prob(50))
				to_chat(M, span_warning("你感到疲倦。"))
		if(2)
			if(prob(50))
				to_chat(M, span_warning("你感到十分疲倦。"))
		if(3)
			if(prob(50))
				to_chat(M, span_warning("你努力集中精神，保持清醒。"))

			M.adjust_drowsiness_up_to(10 SECONDS, 140 SECONDS)

		if(4)
			if(prob(50))
				if(yawning)
					to_chat(M, span_warning("你想忍住哈欠，却没能成功。"))
				else
					to_chat(M, span_warning("你打了个短暂的瞌睡。")) //you can't really yawn while nodding off, can you?

			M.adjust_drowsiness_up_to(20 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)

		if(5)
			if(prob(50))
				to_chat(M, span_warning("[pick("好累……","你感到困极了。","你几乎睁不开眼。","你努力保持清醒。")]"))

			M.adjust_drowsiness_up_to(80 SECONDS, 140 SECONDS)

			if(yawning)
				M.emote("yawn")
				A.airborne_spread(6)
