/obj/structure/bath/sabbatbath
	name = "魔宴血浴池"
	desc = "魔宴同盟仪式中常用的大型浴池，似乎专门用来盛装鲜血。"
	icon_state = "tub"
	can_buckle = TRUE
	buckle_lying = 90
	layer = BELOW_MOB_LAYER
	var/blood_level = 0
	var/max_blood = 500
	var/list/blood_donors = list()

/obj/structure/bath/sabbatbath/Initialize(mapload)
	. = ..()
	create_reagents(max_blood, INJECTABLE)
	update_icon()

/obj/structure/bath/sabbatbath/examine(mob/user)
	. = ..()
	if(blood_level <= 0)
		. += span_notice("浴池是空的。")
	else
		. += span_notice("浴池里盛满了鲜血。")

	if(length(blood_donors) > 0)
		. += span_notice("你能感受到这混合的血液来自[length(blood_donors)]名不同的献血者。")

/obj/structure/bath/sabbatbath/update_icon()
	. = ..()
	// Change the sprite when it contains blood
	if(blood_level > 0)
		icon = 'modular_darkpack/modules/sabbat/icons/sabbat_blood_bath.dmi'
		icon_state = "bath_full_blood"
	else
		icon = 'modular_darkpack/modules/decor/icons/bathroom.dmi'
		icon_state = "tub"

/obj/structure/bath/sabbatbath/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/sabbat_priest_tome))
		if(user.mind && is_sabbat_priest(user.mind.assigned_role) && has_buckled_mobs())
			var/mob/living/buckled_mob = buckled_mobs[1]
			if(buckled_mob.mind)
				// CRIMSON EDIT ADD START - Sabbat Identifier Fix
				if(!is_sabbatist(buckled_mob.mind.assigned_role))
					to_chat(user, span_warning("血粹拒绝了对方。只有先加入战团，才能成为战团首领。"))
					return ITEM_INTERACT_BLOCKING
				// CRIMSON EDIT ADD END - Sabbat Identifier Fix
				// First, demote any existing Ductus to regular Sabbat Pack
				for(var/mob/living/carbon/human/H in GLOB.human_list) // CRIMSON EDIT - Sabbat Identifier Fix - Original: GLOB.player_list
					if(H.mind && is_sabbat_ductus(H.mind.assigned_role))
						H.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatpack))
						// CRIMSON EDIT ADD START - Sabbat Identifier Fix
						H.mind.remove_antag_datum(/datum/antagonist/sabbatist/ductus)
						H.mind.add_antag_datum(/datum/antagonist/sabbatist)
						// CRIMSON EDIT ADD END - Sabbat Identifier Fix
						var/datum/antagonist/temp_antag = new()
						//temp_antag.remove_antag_hud(ANTAG_HUD_REV, H)
						//temp_antag.add_antag_hud(ANTAG_HUD_REV, "rev", H)
						qdel(temp_antag)

						to_chat(H, span_cult("你感到自己身为战团首领的权威正在消退……你现在是一名普通的战团成员了……"))
				// Then promote the new Ductus
				buckled_mob.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatductus))
				// CRIMSON EDIT ADD START - Sabbat Identifier Fix
				buckled_mob.mind.remove_antag_datum(/datum/antagonist/sabbatist)
				buckled_mob.mind.add_antag_datum(/datum/antagonist/sabbatist/ductus)
				// CRIMSON EDIT ADD END - Sabbat Identifier Fix
				var/datum/antagonist/temp_antag = new()
				//temp_antag.add_antag_hud(ANTAG_HUD_REV, "rev_head", buckled_mob)
				qdel(temp_antag)
				// Notify all Sabbat members of the new Ductus
				for(var/mob/living/carbon/human/sabbat_member in GLOB.player_list)
					if(sabbat_member.mind && is_sabbatist(sabbat_member.mind.assigned_role))
						to_chat(sabbat_member, span_cult("[buckled_mob]已受膏成为新的战团首领！"))

				to_chat(buckled_mob, span_cult("你已受膏成为新的战团首领！"))
		return ITEM_INTERACT_SUCCESS
	if(istype(tool, /obj/item/knife/vamp))
		playsound(loc,'sound/items/weapons/bladeslice.ogg', 50, FALSE)
		if(do_after(user, 100))
			if(user.bloodpool <= 0)
				to_chat(user, span_warning("你已经没有血可以献出了！"))
				return ITEM_INTERACT_BLOCKING

			user.visible_message(span_notice("[user]割开自己的手腕，让鲜血流入浴池。"), span_notice("你割开手腕，让鲜血流入浴池。"))

			var/amount_to_donate = min(user.bloodpool, 3)

			user.adjust_blood_pool(-amount_to_donate)

			blood_level = min(blood_level + amount_to_donate, max_blood)
			reagents.add_reagent(/datum/reagent/blood, amount_to_donate)

			if(!(user in blood_donors))
				blood_donors += user

			update_icon()

			return ITEM_INTERACT_SUCCESS
		else
			to_chat(user, span_warning("你决定不往浴池里献血了……"))
			return ITEM_INTERACT_BLOCKING

	// Handle vaulderie goblet specifically so that the Priest can use the tub's blood for vaulderie (part of the blood bath rite)
	if(istype(tool, /obj/item/reagent_containers/cup/silver_goblet/vaulderie_goblet))
		var/obj/item/reagent_containers/cup/silver_goblet/vaulderie_goblet/goblet = tool
		if(blood_level <= 0)
			to_chat(user, span_warning("浴池是空的。"))
			return ITEM_INTERACT_BLOCKING

		var/transfer_amount = min(goblet.volume - goblet.reagents.total_volume, blood_level)
		if(transfer_amount <= 0)
			to_chat(user, span_warning("高脚杯已经满了。"))
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[user]用[goblet]从浴池中舀起鲜血。"), span_notice("你用[goblet]从浴池中舀起鲜血。"))

		reagents.trans_to(goblet, transfer_amount)
		blood_level -= transfer_amount

		if(length(blood_donors) > 0)
			goblet.blood_donors = blood_donors

		if(blood_level <= 0)
			update_icon()

		return  ITEM_INTERACT_SUCCESS

/obj/structure/bath/sabbatbath/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	. = ..()
	if(. && blood_level > 0)
		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/catched.ogg', 50, FALSE)
		if(do_after(user, 100))
			if(M == user)
				M.visible_message(span_notice("[user]爬进盛满鲜血的浴池。"), span_notice("你爬进盛满鲜血的浴池。"))
			else
				M.visible_message(span_notice("[user]将[M]放进盛满鲜血的浴池。"), span_notice("[user]将你放进盛满鲜血的浴池。"))


/obj/structure/bath/sabbatbath/user_unbuckle_mob(mob/living/buckled_mob, mob/user)
	. = ..()
	if(.)
		if(buckled_mob == user)
			buckled_mob.visible_message(span_notice("[buckled_mob]爬出浴池。"), span_notice("你爬出浴池。"))
		else
			buckled_mob.visible_message(span_notice("[user]将[buckled_mob]拉出浴池。"), span_notice("[user]将你拉出浴池。"))

		// Create blood splatters as they exit
		if(blood_level > 0 && ishuman(buckled_mob))
			var/turf/T = get_turf(src)
			for(var/turf/adjacent in RANGE_TURFS(1, T))
				if(prob(40) && adjacent != T)
					buckled_mob.add_splatter_floor(adjacent)
