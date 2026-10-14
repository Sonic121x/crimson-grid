/*Viral adaptation
 * Greatly increases stealth
 * Tremendous buff for resistance
 * Greatly decreases stage speed
 * No effect to transmissibility
 *
 * Bonus: Buffs resistance & stealth. Extremely useful for buffing viruses
*/
/datum/symptom/viraladaptation
	name = "Viral self-adaptation"
	desc = "病毒模仿正常细胞的功能，变得更难发现和根除，但发展速度降低。\
	该症状本身没有其他效果。"
	stealth = 3
	resistance = 5
	stage_speed = -3
	transmittable = 0
	level = 4
	symptom_cure = null

/datum/symptom/viraladaptation/OnAdd(datum/disease/advance/our_disease)
	. = ..()
	our_disease.NeuterSymptom(src)


/*Viral evolution
 * Reduces stealth
 * Greatly reduces resistance
 * Tremendous buff for stage speed
 * Greatly increases transmissibility
 *
 * Bonus: Buffs transmission and speed. Extremely useful for buffing viruse*
*/
/datum/symptom/viralevolution
	name = "Viral evolutionary acceleration"
	desc = "病毒迅速适应环境，尽可能加快在宿主体内外的传播速度。\
	但这也使病毒更容易被发现，且更难抵抗治疗。该症状本身没有其他效果。"
	stealth = -2
	resistance = -3
	stage_speed = 5
	transmittable = 3
	level = 4
	symptom_cure = null

/datum/symptom/viralevolution/OnAdd(datum/disease/advance/our_disease)
	. = ..()
	our_disease.NeuterSymptom(src)
