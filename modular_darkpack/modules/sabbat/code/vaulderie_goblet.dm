/obj/item/reagent_containers/cup/silver_goblet
	name = "银制高脚杯"
	desc = "用于古老吸血鬼仪式的闪亮高脚杯。"
	icon = 'modular_darkpack/modules/sabbat/icons/vaulderie_goblet.dmi'
	icon_state = "pewter_cup"
	base_icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT)
	possible_transfer_amounts = list(1, 5)
	volume = 80
	spillable = TRUE
	resistance_flags = FIRE_PROOF
	var/list/blood_donors = list()

/obj/item/reagent_containers/cup/silver_goblet/is_drainable()
	return TRUE

/obj/item/reagent_containers/cup/silver_goblet/Initialize(mapload)
	. = ..()
	blood_donors = list()

/obj/item/reagent_containers/cup/silver_goblet/update_icon_state()
	. = ..()
	if(reagents && (reagents.has_reagent(/datum/reagent/blood)))
		icon_state = "[base_icon_state]_filled_blood"
	else
		icon_state = base_icon_state

/obj/item/reagent_containers/cup/silver_goblet/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return ..()

	if(!get_kindred_splat(user))
		to_chat(user, span_warning("你并不想把自己的血滴进这个杯子。"))
		return

	if(reagents.total_volume >= volume)
		to_chat(user, span_warning("[src]已经满了！"))
		return

	if(user.bloodpool < 2)
		to_chat(user, span_warning("你没有足够的血可以献出！"))
		return

	user.visible_message(span_notice("[user]准备割开自己的手腕，将鲜血注入[src]。"), span_notice("你准备割开手腕，将自己的鲜血注入[src]。"))

	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("你决定不往[src]里献血。"))
		return

	user.visible_message(span_notice("[user]割开自己的手腕，让鲜血滴入[src]。"), span_notice("你割开手腕，让鲜血流入[src]。"))

	playsound(user, 'sound/items/weapons/bladeslice.ogg', 30, TRUE)
	user.adjust_brute_loss(5)

	reagents.add_reagent(/datum/reagent/blood/vitae, 10)
	user.adjust_blood_pool(-2)

	if(!(user in blood_donors))
		blood_donors += user

	update_appearance()

/obj/item/reagent_containers/cup/silver_goblet/try_drink(mob/living/target_mob, mob/living/user)
	if(!reagents.has_reagent(/datum/reagent/blood) && !reagents.has_reagent(/datum/reagent/blood/vitae))
		return ..()

	if(!get_kindred_splat(target_mob))
		return ..()

	if(length(blood_donors) >= 2)
		var/choice = tgui_alert(target_mob, "你想参与共血仪式吗？这会使你与其他参与者建立血缚，并解除原有的血缚……（这会使你的角色转入魔宴同盟！）", "共血仪式", list("是", "否"), 10 SECONDS)
		if(choice != "是")
			to_chat(target_mob, span_cult("你决定不参与共血仪式。"))
			return ITEM_INTERACT_BLOCKING

	if(length(blood_donors) > 0 && (reagents.has_reagent(/datum/reagent/blood/vitae) || reagents.has_reagent(/datum/reagent/blood)))
		for(var/mob/living/carbon/human/donor in blood_donors)
			if(target_mob != donor)
				to_chat(target_mob, span_warning("随着血液交融，你感到自己与<b>[donor]</b>之间建立起了奇异的联系！"))
				to_chat(donor, span_notice("你感到<b>[target_mob]</b>饮下了你的血，如今与你建立了血缚。"))
				target_mob.visible_message(span_notice("[target_mob]与[donor]建立血缚时，双眼闪过一道微光。"), span_notice("血缚形成时，你的双眼闪过一道光芒。"))
				playsound(target_mob, 'sound/effects/magic/smoke.ogg', 20, TRUE)

	if(length(blood_donors) > 1)
		if(!is_sabbatist(target_mob.mind?.assigned_role))
			to_chat(target_mob, span_cult("你参与共血仪式、加入魔宴同盟，感到原有的血缚正在消散……"))
			target_mob.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatpack))
			target_mob.mind.add_antag_datum(/datum/antagonist/sabbatist) // CRIMSON EDIT ADD - Sabbat Identifier Fix
			//var/datum/antagonist/temp_antag = new()
			//qdel(temp_antag)
	else
		var/antag_transferred = FALSE

		for(var/mob/living/carbon/human/donor in blood_donors)
			if(donor.mind && is_sabbatist(donor.mind.assigned_role))
				if(target_mob.mind && !is_sabbatist(target_mob.mind.assigned_role))
					to_chat(target_mob, span_warning("你饮下[donor]的血，感到自己与对方之间产生了奇异的联系……"))
					target_mob.mind.set_assigned_role(SSjob.get_job_type(/datum/job/vampire/sabbatpack))
					target_mob.mind.add_antag_datum(/datum/antagonist/sabbatist) // CRIMSON EDIT ADD - Sabbat Identifier Fix
					//var/datum/antagonist/temp_antag = new()
					//qdel(temp_antag)
					antag_transferred = TRUE
					break

		if(antag_transferred)
			to_chat(target_mob, span_cult("陌生的思想与理念涌入你的脑海。你如今效忠于魔宴同盟！"))

	return ..()

/obj/item/reagent_containers/cup/silver_goblet/on_reagent_change()
	. = ..()
	if(reagents.total_volume == 0)
		blood_donors.Cut()
	update_appearance()

/obj/item/reagent_containers/cup/silver_goblet/afterattack(obj/target, mob/user, proximity)
	if(!proximity || !check_allowed_items(target, 1))
		return

	if(target.is_refillable() && !istype(target, /obj/item/reagent_containers/cup/silver_goblet))
		if(reagents.total_volume > 0 && target.reagents.total_volume < target.reagents.maximum_volume)
			blood_donors.Cut()

	return ..()

/obj/item/reagent_containers/cup/silver_goblet/vaulderie_goblet
	name = "共血仪式高脚杯"
	desc = "用于古老吸血鬼仪式的高脚杯，通体漆黑如黑曜石。"
	icon_state = "vaulderie_goblet"
	base_icon_state = "vaulderie_goblet"
