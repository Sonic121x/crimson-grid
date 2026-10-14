/*Hallucigen
 * Slightly increases stealth
 * Lowers resistance tremendously
 * Slightly decreases stage speed
 * Slightly reduces transmissibility
 * Critical level
 * Bonus:Makes the affected mob be hallucinated for short periods of time.
*/

/datum/symptom/hallucigen
	name = "Hallucigen"
	desc = "病毒刺激大脑，导致偶尔出现幻觉。"
	illness = "疑神疑鬼"
	stealth = 1
	resistance = -2
	stage_speed = 2
	transmittable = -1
	level = 3
	severity = 2
	base_message_chance = 25
	symptom_delay = 57.5
	symptom_cure = /datum/reagent/medicine/psicodine
	cure_color = "yellow"
	threshold_descs = list(
		"发展速度 7" = "增加幻觉。",
		"隐蔽性 4" = "病毒会伪装出有益症状的表现。",
	)
	var/fake_healthy = FALSE

/datum/symptom/hallucigen/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4) //fake good symptom messages
		fake_healthy = TRUE
		base_message_chance = 50
	if(A.totalStageSpeed() >= 7) //stronger hallucinations
		power = 2

/datum/symptom/hallucigen/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/M = A.affected_mob
	var/list/healthy_messages = list("你的肺感觉棒极了。", "你意识到自己一直没有呼吸。", "你觉得自己不需要呼吸。",\
					"你的眼睛感觉棒极了。", "你的耳朵感觉棒极了。", "你觉得自己不需要眨眼。")
	switch(A.stage)
		if(1, 2)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_notice("[pick("有什么东西在你的余光中一闪而过。", "你听到不知从何处传来的微弱低语。", "你的头隐隐作痛。")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
		if(3, 4)
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_danger("[pick("有什么东西在跟着你。", "有人在监视你。", "你听到耳边有人低语。", "不知从何处传来的沉重脚步声正向你逼近。")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
		else
			if(prob(base_message_chance))
				if(!fake_healthy)
					to_chat(M, span_userdanger("[pick("噢，你的头……", "你的头一阵阵地抽痛。", "它们无处不在！快跑！", "阴影中有什么东西……")]"))
				else
					to_chat(M, span_notice("[pick(healthy_messages)]"))
			M.adjust_hallucinations(90 SECONDS * power)
