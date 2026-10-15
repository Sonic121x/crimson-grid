/*Eternal Youth
 * Greatly increases stealth
 * Tremendous increase to resistance
 * Tremendous increase to stage speed
 * Tremendous reduction to transmissibility
 * Critical level
 * Bonus: Can be used to buff your virus
*/

/datum/symptom/youth
	name = "Eternal Youth"
	desc = "病毒与宿主体内的细胞形成共生关系，阻止并逆转衰老。\
	作为回报，病毒抗性增强、发展更快且更难被发现，但离开宿主后繁殖能力较差。"
	stealth = 3
	resistance = 4
	stage_speed = 4
	transmittable = -4
	level = 6
	base_message_chance = 100
	symptom_delay = 37.5
	symptom_cure = null
	immunity_proof = TRUE

/datum/symptom/youth/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		switch(A.stage)
			if(1)
				if(H.age > 41)
					H.age = 41
					to_chat(H, span_notice("你已经多年没有这么精力充沛了！"))
			if(2)
				if(H.age > 36)
					H.age = 36
					to_chat(H, span_notice("你的心情突然好了起来。"))
			if(3)
				if(H.age > 31)
					H.age = 31
					to_chat(H, span_notice("你开始感觉身体更加轻盈灵活。"))
			if(4)
				if(H.age > 26)
					H.age = 26
					to_chat(H, span_notice("你感到自己重新焕发了活力。"))
			if(5)
				if(H.age > 21)
					H.age = 21
					to_chat(H, span_notice("你觉得自己有力量迎接整个世界的挑战！"))
