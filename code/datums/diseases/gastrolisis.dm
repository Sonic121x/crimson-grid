/datum/disease/gastrolosis
	name = "侵袭性蜗化病"
	desc = "一种怪病，会让宿主长出蜗牛般的器官，最终变成半人半蜗牛的生物。"
	max_stages = 4
	spread_text = "不传染"
	spread_flags = DISEASE_SPREAD_SPECIAL
	cure_text = "盐与稳变酮"
	agent = "S因子与DNA重构"
	viable_mobtypes = list(/mob/living/carbon/human)
	stage_prob = 0.5
	disease_flags = CURABLE
	cures = list(/datum/reagent/consumable/salt,  /datum/reagent/medicine/mutadone)
	bypasses_immunity = TRUE


/datum/disease/gastrolosis/stage_act(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(is_species(affected_mob, /datum/species/snail))
		cure()
		return FALSE

	switch(stage)
		if(2)
			if(SPT_PROB(1, seconds_per_tick))
				affected_mob.emote("gag")
			if(SPT_PROB(0.5, seconds_per_tick))
				var/turf/open/OT = get_turf(affected_mob)
				if(isopenturf(OT))
					OT.MakeSlippery(TURF_WET_LUBE, 40)
		if(3)
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.emote("gag")
			if(SPT_PROB(2.5, seconds_per_tick))
				var/turf/open/OT = get_turf(affected_mob)
				if(isopenturf(OT))
					OT.MakeSlippery(TURF_WET_LUBE, 100)
		if(4)
			var/obj/item/organ/eyes/eyes = locate(/obj/item/organ/eyes/snail) in affected_mob.organs
			if(!eyes && SPT_PROB(2.5, seconds_per_tick))
				var/obj/item/organ/eyes/snail/new_eyes = new()
				new_eyes.Insert(affected_mob)
				affected_mob.visible_message(span_warning("[affected_mob]的眼球掉了出来，原处长出了蜗牛眼！"), \
				span_userdanger("新长出的蜗牛眼将你的眼球挤了出来，你疼得尖叫！"))
				affected_mob.emote("scream")
				return

			var/obj/item/shell = affected_mob.get_item_by_slot(ITEM_SLOT_BACK)
			if(!istype(shell, /obj/item/storage/backpack/snail))
				shell = null
			if(!shell && SPT_PROB(2.5, seconds_per_tick))
				if(affected_mob.dropItemToGround(affected_mob.get_item_by_slot(ITEM_SLOT_BACK)))
					affected_mob.equip_to_slot_or_del(new /obj/item/storage/backpack/snail(affected_mob), ITEM_SLOT_BACK)
					affected_mob.visible_message(span_warning("[affected_mob]的背上长出了一个怪异的壳！"), \
					span_userdanger("一个壳从你的皮肤下钻出，你疼得尖叫！"))
					affected_mob.emote("scream")
					return

			var/obj/item/organ/tongue/tongue = locate(/obj/item/organ/tongue/snail) in affected_mob.organs
			if(!tongue && SPT_PROB(2.5, seconds_per_tick))
				var/obj/item/organ/tongue/snail/new_tongue = new()
				new_tongue.Insert(affected_mob)
				to_chat(affected_mob, span_userdanger("你感觉自己的语速慢了下来……"))
				return

			if(shell && eyes && tongue && SPT_PROB(2.5, seconds_per_tick))
				affected_mob.set_species(/datum/species/snail)
				affected_mob.client?.give_award(/datum/award/achievement/jobs/snail, affected_mob)
				affected_mob.visible_message(span_warning("[affected_mob]变成了蜗牛！"), \
				span_boldnotice("你变成了蜗牛人！你只想慢——慢——爬——……"))
				cure()
				return FALSE

			if(SPT_PROB(5, seconds_per_tick))
				affected_mob.emote("gag")
			if(SPT_PROB(5, seconds_per_tick))
				var/turf/open/OT = get_turf(affected_mob)
				if(isopenturf(OT))
					OT.MakeSlippery(TURF_WET_LUBE, 100)


/datum/disease/gastrolosis/cure(add_resistance = TRUE)
	. = ..()
	if(affected_mob && !is_species(affected_mob, /datum/species/snail)) //undo all the snail fuckening
		var/mob/living/carbon/human/H = affected_mob
		var/obj/item/organ/tongue/tongue = locate(/obj/item/organ/tongue/snail) in H.organs
		if(tongue)
			var/obj/item/organ/tongue/new_tongue = new H.dna.species.mutanttongue ()
			new_tongue.Insert(H)
		var/obj/item/organ/eyes/eyes = locate(/obj/item/organ/eyes/snail) in H.organs
		if(eyes)
			var/obj/item/organ/eyes/new_eyes = new H.dna.species.mutanteyes ()
			new_eyes.Insert(H)
		var/obj/item/storage/backpack/bag = H.get_item_by_slot(ITEM_SLOT_BACK)
		if(istype(bag, /obj/item/storage/backpack/snail))
			bag.emptyStorage()
			H.temporarilyRemoveItemFromInventory(bag, TRUE)
			qdel(bag)
