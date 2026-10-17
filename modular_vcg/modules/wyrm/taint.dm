/datum/reagent/wyrmtaint
	name = "污泥"
	description = "成分不明的污泥。"
	color = "#000000"
	taste_mult = 0
	chemical_flags = REAGENT_INVISIBLE
	metabolization_rate = 0.02 * REAGENTS_METABOLISM
	self_consuming = TRUE
	purge_multiplier = 0
	var/taint_cycles = 40

/datum/reagent/wyrmtaint/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle >= taint_cycles )
		ADD_TRAIT(affected_mob, TRAIT_WYRMTAINTED, type)

/datum/reagent/wyrmtaint/on_mob_delete(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_WYRMTAINTED, type)

/datum/reagent/medicine/modafinil/magafinil
	name = "玛加醒"

/datum/reagent/medicine/modafinil/magafinil/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.st_add_stat_mod(STAT_ALERTNESS, 1, type)
	affected_mob.st_add_stat_mod(STAT_PERCEPTION, 1, type)

/datum/reagent/medicine/modafinil/magafinil/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.st_remove_stat_mod(STAT_ALERTNESS, type)
	affected_mob.st_remove_stat_mod(STAT_PERCEPTION, type)

/datum/reagent/medicine/modafinil/magafinil/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	holder.add_reagent(/datum/reagent/wyrmtaint, 0.1 * metabolization_ratio * seconds_per_tick)

/datum/reagent/drug/happiness/magaloft
	name = "玛加舒"

/datum/reagent/drug/happiness/magaloft/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	holder.add_reagent(/datum/reagent/wyrmtaint, 0.1 * metabolization_ratio * seconds_per_tick)

/obj/item/reagent_containers/applicator/pill/magaloft
	name = "玛加舒药片"
	desc = "用于缓解焦虑与抑郁，经证实没有副作用*。"
	list_reagents = list(/datum/reagent/drug/happiness/magaloft = 5)
	icon_state = "pill_happy"
	rename_with_volume = TRUE

/obj/item/storage/pill_bottle/magaloft
	name = "玛加舒抗抑郁药"
	desc = "尚未证实有副作用的抗抑郁药*。"
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/magaloft

/obj/item/reagent_containers/applicator/pill/magafinil
	name = "玛加醒药片"
	desc = "用于治疗嗜睡和突发意识丧失等症状。"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/synaptizine = 5, /datum/reagent/medicine/modafinil/magafinil = 3)
	icon_state = "pill15"

/obj/item/storage/pill_bottle/magafinil
	name = "玛加醒药片瓶"
	desc = "一瓶玛加醒药片，用于帮助预防困倦并提高警觉。"
	spawn_count = 7
	spawn_type = /obj/item/reagent_containers/applicator/pill/magafinil
