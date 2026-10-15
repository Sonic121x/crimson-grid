/*Weight Loss
 * No effect on stealth
 * Increases resistance
 * Reduces stage speed
 * Reduces transmissibility
 * Bonus: Drains nutrition from the host
*/
/datum/symptom/weight_loss
	name = "Weight Loss"
	desc = "病毒改变宿主的新陈代谢，使其几乎无法从食物中获取营养。"
	illness = "平缓反流"
	stealth = 0
	resistance = 2
	stage_speed = -2
	transmittable = -2
	level = 7
	severity = 3
	base_message_chance = 100
	symptom_delay = 30
	required_organ = ORGAN_SLOT_STOMACH
	symptom_cure = /datum/reagent/medicine/diphenhydramine // It's good with terrible stats, it should be harder to cure
	cure_color = "orange"
	threshold_descs = list(
		"隐蔽性 4" = "症状更难被察觉。"
	)

/datum/symptom/weight_loss/Start(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	if(A.totalStealth() >= 4) //warn less often
		base_message_chance = 25

/datum/symptom/weight_loss/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(1, 2, 3, 4)
			if(prob(base_message_chance))
				to_chat(M, span_warning("[pick("你感到饥饿。", "你渴望吃点东西。")]"))
		else
			to_chat(M, span_warning("<i>[pick("好饿……", "为了一口吃的，你甚至愿意杀人……", "饥饿让你的腹部一阵痉挛……")]</i>"))
			M.overeatduration = max(M.overeatduration - 200 SECONDS, 0)
			M.adjust_nutrition(-100)
