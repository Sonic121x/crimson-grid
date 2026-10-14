/*Polyvitiligo
 * Slight reduction to stealth
 * Greatly increases resistance
 * Slightly increases stage speed
 * Increases transmissibility
 * Critical level
 * Bonus: Makes the mob gain a random crayon powder colorful reagent.
*/
/datum/symptom/polyvitiligo
	name = "Polyvitiligo"
	desc = "病毒将皮肤中的黑色素替换为活性色素。"
	illness = "色彩失衡"
	stealth = -1
	resistance = 3
	stage_speed = 1
	transmittable = 2
	level = 5
	severity = 1
	symptom_delay = 10.5
	symptom_cure = /datum/reagent/water/salt

/datum/symptom/polyvitiligo/Activate(datum/disease/advance/A)
	. = ..()
	if(!.)
		return
	var/mob/living/M = A.affected_mob
	switch(A.stage)
		if(5)
			var/static/list/banned_reagents = list(/datum/reagent/colorful_reagent/powder/invisible, /datum/reagent/colorful_reagent/powder/white)
			var/color = pick(subtypesof(/datum/reagent/colorful_reagent/powder) - banned_reagents)
			if(M.reagents.total_volume <= (M.reagents.maximum_volume/10)) // no flooding humans with 1000 units of colorful reagent
				M.reagents.add_reagent(color, 5)
		else
			if (prob(50)) // spam
				M.visible_message(span_warning("[M]看起来色彩斑斓……"), span_notice("这色彩，天啊，这色彩……"))
