/datum/discipline/obeah
	name = "Obeah"
	desc = {"运用第三只眼进行治疗或保护。
● 生命感知：感知 + 共情（难度 7）
●● 麻醉之触：意志力（目标不自愿时难度为 8）
●●● 健全肉身：无需掷骰
●●●● 牧者守望：无需掷骰
●●●●● 卸去兽魂重负：智力 + 共情（难度 8）"}
	icon_state = "obeah"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/obeah

/datum/discipline_power/obeah
	name = "Valeren power name"
	desc = "Valeren power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/obeah.ogg'

/datum/discipline_power/obeah/sense_vitality
	name = "生命感知"
	desc = "感知目标的生命状况。"
	level = 1
	check_flags = DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 1
	cooldown_length = 3 TURNS
	duration_length = 1 TURNS
	activate_sound = null
	vitae_cost = 0
	var/successes = 0

	var/msg_creature = "" // what kinda phreak they is
	var/msg_damage = ""
	var/msg_blood = ""
	var/msg_disease = ""
	var/msg_mental = ""
	var/datum/storyteller_roll/sense_vitality/vitality_roll // defined in valeren.dm

/datum/discipline_power/obeah/sense_vitality/pre_activation_checks(mob/living/target)
	. = ..()
	if(!vitality_roll)
		vitality_roll = new()
	successes = vitality_roll.st_roll(owner, target)
	if(successes >= 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/obeah/sense_vitality/proc/blood_read(mob/living/carbon/human/target)
	var/blood_volume = target.get_blood_volume(apply_modifiers = TRUE)
	switch(blood_volume)
		if(BLOOD_VOLUME_EXCESS to INFINITY)
			return "对方的血管胀得几乎破裂。"
		if(BLOOD_VOLUME_MAXIMUM to BLOOD_VOLUME_EXCESS)
			return "对方体内的血液严重过量。"
		if(BLOOD_VOLUME_SAFE to BLOOD_VOLUME_MAXIMUM)
			return "对方的血容量正常。"
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			return "对方的血容量低于正常水平。"
		if(BLOOD_VOLUME_RISKY to BLOOD_VOLUME_OKAY)
			return "对方的血容量已低至危险水平。"
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_RISKY)
			return "血量低至危险水平。"
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			return "对方几乎流尽了鲜血。若不立即施救，很快就会死亡。"
		else
			return "对方的鲜血已经流尽。"

/datum/discipline_power/obeah/sense_vitality/proc/damage_severity(damage)
	if(damage < 30)
		return "轻度"
	if(damage < 50)
		return "中度"
	return "重度"

/datum/discipline_power/obeah/sense_vitality/ui_state(mob/user)
	return GLOB.always_state

/datum/discipline_power/obeah/sense_vitality/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	var/datum/asset/valeren_files = get_asset_datum(/datum/asset/simple/valeren_assets)
	if(user.client)
		valeren_files.send(user.client)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new /datum/tgui(user, src, "Valeren")
		ui.open()

/datum/discipline_power/obeah/sense_vitality/ui_data(mob/living/user)
	var/list/data = list()
	data["creature"] = msg_creature
	data["damage"] = msg_damage
	data["blood"] = msg_blood
	data["disease"] = msg_disease
	data["mental"] = msg_mental
	return data

/datum/discipline_power/obeah/sense_vitality/activate(mob/living/target)
	. = ..()
	msg_creature = ""
	msg_damage = ""
	msg_blood = ""
	msg_disease = ""
	msg_mental = ""

	// on one success, identify their splat
	var/creature_type = "凡人"
	if(get_kindred_splat(target))
		creature_type = "血族"
	else if(get_ghoul_splat(target))
		creature_type = "血仆"
	else if(isavatar(target) || isobserver(target)) // because salubri spend all their time in the clinic anyway. they'll use this on ghosts
		creature_type = "怨灵"
	msg_creature = "[target]是[creature_type]。"

	// on two successes, identify their damage
	if(successes >= 2)
		var/brute = target.get_brute_loss()
		var/burn = target.get_fire_loss()
		var/tox = target.get_tox_loss()
		var/oxy = target.get_oxy_loss()
		var/agg = target.get_agg_loss()
		var/list/damage_parts = list()
		if(brute > 0)
			damage_parts += "[damage_severity(brute)]瘀伤"
		if(burn > 0)
			damage_parts += "[damage_severity(burn)]烧伤"
		if(tox > 0)
			damage_parts += "[damage_severity(tox)]毒素伤害"
		if(oxy > 0)
			damage_parts += "[damage_severity(oxy)]缺氧"
		if(agg > 0)
			damage_parts += "[damage_severity(agg)]超自然创伤"
		msg_damage = length(damage_parts) ? "对方存在[english_list(damage_parts, nothing_text = "无", and_text = "和", comma_text = "、", final_comma_text = "")]。" : "对方看起来没有受伤。"

	// on three successes, detect their bloodpool, if any exists
	if(successes >= 3)
		msg_blood = "[blood_read(target)]血池剩余 [round(target.bloodpool / target.maxbloodpool * 100)]%。"

	// on four, display any diseases they might have
	if(successes >= 4)
		var/list/datum/disease/diseases = target.get_static_viruses()
		if(LAZYLEN(diseases))
			var/list/disease_names = list()
			for(var/datum/disease/D in diseases)
				disease_names += D.name
			msg_disease = "在对方血液中检测到[english_list(disease_names, nothing_text = "无", and_text = "和", comma_text = "、", final_comma_text = "")]。"
		else
			msg_disease = "未在对方血液中发现疾病。"
		var/list/mental_conditions = list()
		if(target.has_quirk(/datum/quirk/insanity))
			mental_conditions += "精神错乱"
		if(target.has_quirk(/datum/quirk/darkpack/derangement))
			mental_conditions += "无法治愈的精神紊乱"
		if(length(mental_conditions))
			msg_mental = "[english_list(mental_conditions, nothing_text = "无", and_text = "和", comma_text = "、", final_comma_text = "")]蒙蔽了对方的心智。"

	ui_interact(owner)
	to_chat(owner, span_notice("[msg_creature] \n[msg_damage] \n[msg_blood] \n[msg_disease] \n[msg_mental]"))

/datum/discipline_power/obeah/sense_vitality/deactivate()
	. = ..()

/datum/discipline_power/obeah/anesthetic_touch
	name = "麻醉之触"
	desc = "抚平患者的痛苦，或使凡人安然入睡。"
	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1
	cooldown_length = 3 TURNS
	var/sleep_duration_length = 10 TURNS
	var/soothe_duration_length = 1 SCENES
	var/successes = 0
	var/datum/storyteller_roll/anesthetic_touch/touch_roll // these are defined in valeren.dm
	var/datum/storyteller_roll/anesthetic_touch/unwilling/touch_roll_unwilling
	frenzy_usable = FALSE

/datum/discipline_power/obeah/anesthetic_touch/pre_activation_checks(mob/living/target)
	. = ..()
	var/datum/storyteller_roll/anesthetic_touch/roll_to_use
	if(target.combat_mode)
		if(!touch_roll_unwilling)
			touch_roll_unwilling = new()
		roll_to_use = touch_roll_unwilling
	else
		if(!touch_roll)
			touch_roll = new()
		roll_to_use = touch_roll
	successes = roll_to_use.st_roll(owner, target)
	if(successes >= 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/obeah/anesthetic_touch/activate(mob/living/target)
	. = ..()
	var/list/choices = list(
		"Soothe Pain" = localized_radial_choice(icon('icons/mob/actions/actions_spells.dmi', "statue"), "缓解疼痛"),
		"Put To Sleep" = localized_radial_choice(icon('icons/mob/actions/actions_spells.dmi', "blind"), "使其入睡"),
	)
	var/chosen_option = show_radial_menu(owner, target, choices, radius = 38, require_near = TRUE)
	switch(chosen_option)
		if("Soothe Pain")
			owner.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			ADD_TRAIT(target, TRAIT_ANALGESIA, type)
			addtimer(CALLBACK(src, PROC_REF(end_soothe_pain), target), (successes TURNS) + soothe_duration_length)
		if("Put To Sleep")
			if(get_kindred_splat(target))
				to_chat(owner, span_warning("你无法用这种能力使血族入睡！"))
				return TRUE
			target.SetSleeping(sleep_duration_length + (successes TURNS)) // 50 seconds + successes in turns
			target.adjust_blood_pool(1) // restores a BP to the target, but if this gets abused, maybe make this depend on successes
	return TRUE

/datum/discipline_power/obeah/anesthetic_touch/proc/end_soothe_pain(mob/living/target)
	owner.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	REMOVE_TRAIT(target, TRAIT_ANALGESIA, type)

/datum/discipline_power/obeah/corpore_sano
	name = "健全肉身"
	desc = "将双手放在患者身上，治愈其伤口。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB // CRIMSON EDIT CHANGE - Healer Buff PR (Salubri and Theurges) - Original: target_type = TARGET_LIVING
	range = 1
	frenzy_usable = FALSE

	violates_masquerade = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/obeah/corpore_sano/activate(atom/target)
	. = ..()
	var/mob/living/living_target = target
	if(living_target.get_agg_loss() && (owner.bloodpool >= 1))
		owner.adjust_blood_pool(-1)
		living_target.heal_storyteller_health(dots_to_heal = 4, heal_aggravated = TRUE, heal_scars = TRUE, heal_blood = TRUE, heal_burn = TRUE) // CRIMSON EDIT CHANGE - Healer Buff PR (Salubri and Theurges) - Original: living_target.heal_storyteller_health(dots_to_heal = 1, heal_aggravated = TRUE, heal_scars = TRUE, heal_blood = TRUE)
	else
		living_target.heal_storyteller_health(dots_to_heal = 4, heal_aggravated = FALSE, heal_scars = TRUE, heal_blood = TRUE, heal_burn = TRUE) // CRIMSON EDIT CHANGE - Healer Buff PR (Salubri and Theurges)  - Original: living_target.heal_storyteller_health(dots_to_heal = 4, heal_aggravated = FALSE, heal_scars = TRUE, heal_blood = TRUE, heal_burn = TRUE)

// Radius - the length of the line you draw from the central point of a circle towards any point of the outer boundary, which in geometry is called the circumference.
#define SHEPHERDS_WATCH_RADIUS 3
/datum/discipline_power/obeah/shepherds_watch
	name = "牧者守望"
	desc = "创造一道超自然屏障，保护自己免受伤害。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS
	duration_length = 1 TURNS
	willpower_cost = 2
	cancelable = TRUE
	var/datum/proximity_monitor/advanced/shepherds_watch/area_of_effect
	frenzy_usable = FALSE

/datum/discipline_power/obeah/shepherds_watch/activate(atom/target)
	. = ..()
	area_of_effect = new(owner, SHEPHERDS_WATCH_RADIUS)
	for(var/mob/living/mob_living in range(SHEPHERDS_WATCH_RADIUS, owner))
		area_of_effect.ignored_mobs |= mob_living

/datum/discipline_power/obeah/shepherds_watch/duration_expire(atom/target)
	clear_duration_timer()
	owner.update_action_buttons()
	if(!check_discipline_flags())
		deactivate(owner, FALSE)
		return
	do_duration(owner)

/datum/discipline_power/obeah/shepherds_watch/deactivate(atom/target, direct)
	. = ..()
	QDEL_NULL(area_of_effect)

#undef SHEPHERDS_WATCH_RADIUS

/datum/discipline_power/obeah/mens_sana
	name = "健全心智"
	desc = "借助这种能力，萨鲁布里可以治愈疯狂，平息内心的恶魔，使灵魂重获安宁。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS
	vitae_cost = 2
	target_type = TARGET_LIVING
	range = 1
	var/datum/storyteller_roll/mens_sana/discipline_roll
	frenzy_usable = FALSE

/datum/storyteller_roll/mens_sana
	bumper_text = "健全心智"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_EMPATHY)
	difficulty = 8
	roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_TARGET

/datum/discipline_power/obeah/mens_sana/activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_target = target
	if(!carbon_target)
		return
	var/obj/item/organ/brain/target_brain = carbon_target.get_organ_by_type(/obj/item/organ/brain)
	var/list/gotten_traumas = target_brain.traumas
	if(carbon_target.has_quirk(/datum/quirk/darkpack/derangement))
		gotten_traumas += "Derangement"
	var/chosen_derangement = tgui_input_list(owner, "选择要治愈的创伤", "脑部创伤", gotten_traumas)
	if(!chosen_derangement)
		to_chat(owner, span_notice("你未能找到任何创伤。"))
		return
	var/datum/storyteller_roll/mens_sana/discipline_roll = new()
	var/success = discipline_roll.st_roll(owner, target)
	switch(success)
		if(ROLL_BOTCH)
			var/obj/item/organ/brain/owner_brain = owner.get_organ_by_type(/obj/item/organ/brain)
			if(chosen_derangement == "Derangement")
				owner.add_quirk(/datum/quirk/darkpack/derangement)
			else
				owner_brain.gain_trauma_type(chosen_derangement, TRAUMA_RESILIENCE_MAGIC)
			to_chat(owner, span_bolddanger("你未能缓解[target]的[chosen_derangement == "Derangement" ? "精神紊乱" : chosen_derangement]，反而让自己的大脑染上了它！"))
		if(ROLL_FAILURE)
			to_chat(owner, span_danger("你未能缓解[target]的[chosen_derangement == "Derangement" ? "精神紊乱" : chosen_derangement]。"))
		if(ROLL_SUCCESS)
			if(chosen_derangement == "Derangement")
				carbon_target.remove_quirk(/datum/quirk/darkpack/derangement)
			else
				target_brain.cure_trauma_type(chosen_derangement, TRAUMA_RESILIENCE_MAGIC)
			to_chat(owner, span_notice("你成功缓解了[target]的[chosen_derangement == "Derangement" ? "精神紊乱" : chosen_derangement]。"))

