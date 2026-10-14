#define SENSE_VISION "视觉"
#define SENSE_HEARING "听觉"
#define SENSE_SMELL "嗅觉"
#define SENSE_TASTE "味觉"
#define SENSE_TOUCH "触觉"
#define TELEPATHY_MIND_READING "读心"
#define TELEPATHY_IMPLANT_THOUGHT "植入思绪"

/datum/discipline/auspex
	name = "Auspex"
	desc = {"透过墙壁看见生物、灵光及其健康状况。
● 感官强化：被动
●● 灵光感知：被动
●●● 灵魂之触：被动
●●●● 心灵感应：智力 + 诡诈，对抗目标的意志力
●●●●● 灵魂投射：感知 + 灵觉（难度 7）"}
	icon_state = "auspex"
	power_type = /datum/discipline_power/auspex

/datum/discipline_power/auspex
	name = "Auspex power name"
	desc = "Auspex power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/auspex/auspex.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/auspex/auspex_deactivate.ogg'

//HEIGHTENED SENSES
/datum/discipline_power/auspex/heightened_senses
	name = "感官强化"
	desc = "将你的感官增强至远超人类极限的程度。"

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS

	toggled = TRUE

/datum/discipline_power/auspex/heightened_senses/activate()
	. = ..()

	var/list/chosen_sense = tgui_input_checkboxes(owner, "选择要强化的感官", "感官强化", list(
		SENSE_VISION,
		SENSE_HEARING,
		SENSE_SMELL,
		SENSE_TASTE,
		SENSE_TOUCH
	))
	if(isnull(chosen_sense))
		deactivate()
		return
	var/list/output_senses = list()
	for(var/list/sense as anything in chosen_sense)
		output_senses += sense[1]

	if(SENSE_VISION in output_senses)
		owner.client?.view_size?.setTo(2) // This increases the view size of the player by 2 tiles in each direction. I dont know why it's called Set if it Adds.
		ADD_TRAIT(owner, TRAIT_REFLECTIVE_EYES, DISCIPLINE_TRAIT(type))
		var/obj/item/organ/eyes/kindred_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
		if(kindred_eyes)
			kindred_eyes.flash_protect = max(kindred_eyes.flash_protect += -2, FLASH_PROTECTION_HYPER_SENSITIVE)
	if(SENSE_HEARING in output_senses)
		ADD_TRAIT(owner, TRAIT_GOOD_HEARING, DISCIPLINE_TRAIT(type))
		var/obj/item/organ/ears/kindred_ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
		kindred_ears.damage_multiplier = kindred_ears.damage_multiplier + 1
	if(SENSE_SMELL in output_senses)
		owner.dna?.add_mutation(/datum/mutation/olfaction, DISCIPLINE_TRAIT(type))
	if(SENSE_TASTE in output_senses)
		ADD_TRAIT(owner, TRAIT_REAGENT_SCANNER, DISCIPLINE_TRAIT(type))
	if(SENSE_TOUCH in output_senses)
		RegisterSignals(owner, list(COMSIG_CARBON_HELP_ACT, COMSIG_ON_CARBON_SLIP, COMSIG_LIVING_DISARM_HIT, COMSIG_LIVING_TRYING_TO_PULL), PROC_REF(on_touch))
		owner.AddComponent(/datum/component/heartbeat_sensing, color_path = /datum/client_colour/psyker)

	owner.st_add_stat_mod(STAT_PERCEPTION, discipline.level, "heightened_senses")

/datum/discipline_power/auspex/heightened_senses/deactivate()
	. = ..()
	// Smell
	var/datum/mutation/mutation = owner.dna?.get_mutation(/datum/mutation/olfaction)
	if(mutation)
		owner.dna?.remove_mutation(mutation, mutation.sources)
	// Hearing
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, DISCIPLINE_TRAIT(type))
	var/obj/item/organ/ears/kindred_ears = owner.get_organ_slot(ORGAN_SLOT_EARS)
	kindred_ears.damage_multiplier = initial(kindred_ears.damage_multiplier)
	// Vision
	owner.client?.view_size?.resetToDefault()
	REMOVE_TRAIT(owner, TRAIT_REFLECTIVE_EYES, DISCIPLINE_TRAIT(type))
	var/obj/item/organ/eyes/kindred_eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	if(kindred_eyes)
		kindred_eyes.flash_protect = max(kindred_eyes.flash_protect += 2, FLASH_PROTECTION_NONE)
	// Taste
	REMOVE_TRAIT(owner, TRAIT_REAGENT_SCANNER, DISCIPLINE_TRAIT(type))
	// Touch
	UnregisterSignal(owner, list(COMSIG_CARBON_HELP_ACT, COMSIG_ON_CARBON_SLIP, COMSIG_LIVING_DISARM_HIT, COMSIG_LIVING_TRYING_TO_PULL))
	qdel(owner.GetComponent(/datum/component/heartbeat_sensing))

	owner.st_remove_stat_mod(STAT_PERCEPTION, "heightened_senses")

/datum/discipline_power/auspex/heightened_senses/proc/on_touch(datum/source)
	SIGNAL_HANDLER

	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "shiver", forced = TRUE)
	owner.Stun(0.5 SECONDS)


/datum/storyteller_roll/aura_perception
	bumper_text = "解读灵光"
	difficulty = 8
	applicable_stats = list(STAT_PERCEPTION, STAT_EMPATHY)
	roll_output_type = ROLL_FLAG_ROLLER

//AURA PERCEPTION
/datum/discipline_power/auspex/aura_perception
	name = "灵光感知"
	desc = "让你感知周围人的灵光。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS
	duration_length = 1 SCENES
	cooldown_length = 1 SCENES
	vitae_cost = 0

	cancelable = TRUE
	var/datum/storyteller_roll/aura_perception/aura_roll

/datum/discipline_power/auspex/aura_perception/pre_activation_checks(mob/living/target)
	. = ..()
	if(!aura_roll)
		aura_roll = new()
	switch(aura_roll.st_roll(owner, target))
		if(ROLL_SUCCESS)
			return TRUE
		else
			to_chat(owner, span_danger("你什么也没能解读出来……"))
			return FALSE

/datum/discipline_power/auspex/aura_perception/activate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.show_to(owner)

	var/list/heard = orange(DEFAULT_SIGHT_DISTANCE, owner)
	for(var/mob/living/hearer in heard)
		if(!HAS_TRAIT(src, TRAIT_FORCED_EMOTION))
			hearer.apply_status_effect(/datum/status_effect/question_emotion)

/datum/discipline_power/auspex/aura_perception/deactivate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_AUSPEX_AURAS]
	target_hud.hide_from(owner)

//THE SPIRIT'S TOUCH
/datum/discipline_power/auspex/the_spirits_touch
	name = "灵魂之触"
	desc = "让你感知周围人的身体状况。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS
	frenzy_usable = FALSE

	toggled = TRUE

/datum/discipline_power/auspex/the_spirits_touch/activate()
	. = ..()

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.show_to(owner)
	owner.update_sight()

	RegisterSignal(owner, COMSIG_MOB_EXAMINING, PROC_REF(scan))

/datum/discipline_power/auspex/the_spirits_touch/deactivate()
	. = ..()

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.hide_from(owner)
	owner.update_sight()

	UnregisterSignal(owner, COMSIG_MOB_EXAMINING)

/datum/discipline_power/auspex/the_spirits_touch/proc/scan(mob/user, atom/scanned_atom, list/examine_strings)
	// Can scan items we hold and store
	if(!(scanned_atom in user.get_all_contents()))
		// Can remotely scan objects and mobs.
		if((get_dist(scanned_atom, user) > 8) || (!(scanned_atom in view(8, user))))
			return TRUE

	// GATHER INFORMATION

	var/datum/detective_scanner_log/log_entry = new

	// Start gathering

	log_entry.scan_target = scanned_atom.name

	var/list/atom_fibers = GET_ATOM_FIBRES(scanned_atom)
	if(length(atom_fibers))
		log_entry.add_data_entry(DETSCAN_CATEGORY_FIBER, atom_fibers.Copy())

	var/list/blood = GET_ATOM_BLOOD_DNA(scanned_atom)
	if(length(blood))
		log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, blood.Copy())

	if(ishuman(scanned_atom))
		var/mob/living/carbon/human/scanned_human = scanned_atom
		if(!scanned_human.gloves)
			log_entry.add_data_entry(
				DETSCAN_CATEGORY_FINGERS,
				rustg_hash_string(RUSTG_HASH_MD5, scanned_human.dna?.unique_identity)
			)

	else if(!ismob(scanned_atom))

		var/list/atom_fingerprints = GET_ATOM_FINGERPRINTS(scanned_atom)
		if(length(atom_fingerprints))
			log_entry.add_data_entry(DETSCAN_CATEGORY_FINGERS, atom_fingerprints.Copy())

		// Only get reagents from non-mobs.
		for(var/datum/reagent/present_reagent as anything in scanned_atom.reagents?.reagent_list)
			log_entry.add_data_entry(DETSCAN_CATEGORY_REAGENTS, list(present_reagent.name = present_reagent.volume))

			// Get blood data from the blood reagent.
			if(!istype(present_reagent, /datum/reagent/blood))
				continue

			var/blood_DNA = present_reagent.data["blood_DNA"]
			var/blood_type = present_reagent.data["blood_type"]
			if(!blood_DNA || !blood_type)
				continue

			log_entry.add_data_entry(DETSCAN_CATEGORY_BLOOD, list(blood_DNA = blood_type))

	if(istype(scanned_atom, /obj/item/card/id))
		var/obj/item/card/id/user_id = scanned_atom
		for(var/region in DETSCAN_ACCESS_ORDER())
			var/access_in_region = SSid_access.accesses_by_region[region] & user_id.GetAccess()
			if(!length(access_in_region))
				continue
			var/list/access_names = list()
			for(var/access_num in access_in_region)
				access_names += SSid_access.get_access_desc(access_num)

			log_entry.add_data_entry(DETSCAN_CATEGORY_ACCESS, list("[region]" = english_list(access_names)))

	// sends it off to be modified by the items
	SEND_SIGNAL(scanned_atom, COMSIG_DETECTIVE_SCANNED, user, log_entry)

	// Perform sorting now, because probably this will be never modified
	log_entry.sort_data_entries()
	var/list/generated_report_text = log_entry.generate_report_text()
	var/output_report = generated_report_text.Join()

	examine_strings += boxed_message(output_report)
	return TRUE

//TELEPATHY
/datum/discipline_power/auspex/telepathy
	name = "心灵感应"
	desc = "将你的思绪投射到他人的心中。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS
	target_type = TARGET_PLAYER
	vitae_cost = 0
	cooldown_override = TRUE
	range = 7
	var/telepathy_types = list(TELEPATHY_MIND_READING, TELEPATHY_IMPLANT_THOUGHT)
	var/telepathy_type_selected
	var/successes
	var/disguised_voice
	var/datum/storyteller_roll/telepathy_success/telepathy_roll
	var/datum/storyteller_roll/disguise_voice_roll/disguise_roll
	COOLDOWN_DECLARE(mind_read_cd)
	COOLDOWN_DECLARE(implant_tht_cd)
	frenzy_usable = FALSE

/datum/storyteller_roll/telepathy_success
	bumper_text = "读心"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_SUBTERFUGE)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER

/datum/storyteller_roll/disguise_voice_roll
	bumper_text = "伪装声音"
	applicable_stats = list(STAT_MANIPULATION, STAT_SUBTERFUGE)
	numerical = FALSE
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/auspex/telepathy/pre_activation_checks(mob/living/target)
	. = ..()
		// need linebreaks... but \n and <br> arent working...
	var/telepathy_type = tgui_input_list(owner, "你想施展哪种心灵感应？读取超自然生物的思绪需要消耗 1 点临时意志力。", "选择心灵感应模式", telepathy_types, TELEPATHY_IMPLANT_THOUGHT)
	if(!telepathy_type) // prevents it from running anyway if you press cancel (a lot of disciplines do this), cancellable without cd.
		return FALSE
	switch(telepathy_type)
		if(TELEPATHY_MIND_READING)
			if(!COOLDOWN_FINISHED(src, mind_read_cd))
				to_chat(owner, span_warning("你的读心能力还需冷却[round(COOLDOWN_TIMELEFT(src, mind_read_cd) / 10, 0.1)]秒！"))
				return FALSE

			if(!telepathy_roll)
				telepathy_roll = new()
			telepathy_roll.difficulty = target.st_get_stat(STAT_TEMPORARY_WILLPOWER)
			successes = telepathy_roll.st_roll(owner, target)

			if(successes > 0)
				if(get_kindred_splat(target) || get_shifter_splat(target))
					owner.st_set_stat(STAT_TEMPORARY_WILLPOWER, owner.st_get_stat(STAT_TEMPORARY_WILLPOWER) - 1)
			else
				to_chat(owner, span_warning("你未能读取对方的思绪！"))
				COOLDOWN_START(src, mind_read_cd, 3 MINUTES)
				return FALSE
			//var/supernatural_splat = issupernatural(target)??? the current issupernatural just checks for a single splat, which doesnt qualify for the -1 willpower, think its just other 'undead' p137 V20

		if(TELEPATHY_IMPLANT_THOUGHT)
			if(!COOLDOWN_FINISHED(src, implant_tht_cd)) // No cd would be nice, but we also don't want spam.
				to_chat(owner, span_warning("你的植入思绪能力还需冷却[round(COOLDOWN_TIMELEFT(src, implant_tht_cd) / 10, 0.1)]秒！"))
				return FALSE

			var/disguise_voice_prompt = tgui_input_list(owner, "要尝试伪装植入思绪的来源吗？需要进行操控 + 诡诈掷骰，难度为目标的感知 + 灵觉。", "伪装声音", list("是", "否"), "否")
			switch(disguise_voice_prompt)
				if("是")
					if(!disguise_roll)
						disguise_roll = new()
					disguise_roll.difficulty = target.st_get_stat(STAT_PERCEPTION) + target.st_get_stat(STAT_AWARENESS)
					switch(disguise_roll.st_roll(owner, target))
						if(ROLL_SUCCESS)
							disguised_voice = tgui_input_text(owner, "这段植入的思绪会以谁的“声音”出现？", "选择植入的声音")
						if(ROLL_FAILURE, ROLL_BOTCH)
							to_chat(owner, span_danger("你未能伪装声音——对方在脑海中听到了你的声音！"))
							disguised_voice = owner.real_name
				if("否")
					disguised_voice = owner.real_name
	telepathy_type_selected = telepathy_type
	return TRUE


/datum/discipline_power/auspex/telepathy/activate(mob/living/target)
	. = ..()
	var/input_message
	var/specific_search
	switch(telepathy_type_selected)
		if(TELEPATHY_IMPLANT_THOUGHT)
			input_message = tgui_input_text(owner, "你想向对方传递什么信息？", "心灵传讯")
			if(!input_message)
				return

			if(!sanitize_input_message(input_message))
				return

			log_directed_talk(owner, target, input_message, LOG_SAY, "Telepathy")
			to_chat(owner, span_notice("你将思绪投射到[GET_GUESTBOOK_NAME(owner, target)]的脑海中：“[input_message]”"))
			to_chat(target, span_boldannounce("你的脑海中响起了[target?.mind?.guestbook?.get_known_name(target, disguised_voice) || disguised_voice]的声音：“[input_message]”"))
			COOLDOWN_START(src, implant_tht_cd, 5 SECONDS)

		if(TELEPATHY_MIND_READING)
			var/flavor_text_telepathy = "附近有人正在你毫不知情的情况下读取你的思绪。根据成功数，对方可能读到生动清晰的内心独白，也可能只能捕捉到零散的想法、情绪和象征意象。" + get_flavor_text(successes)
			var/mind_reading_search = tgui_input_list(owner, "你要在对方的思绪中寻找特定信息吗？深藏的秘密和久远的记忆需要更多成功数。", "读心目标", list("是", "否"), "否")
			if(mind_reading_search == "是")
				specific_search = tgui_input_text(owner, "你想从目标的思绪中读取什么？", "输入读心目标", max_length = (MAX_MESSAGE_LEN * 10))
				if(!specific_search)
					specific_search = "某项特定信息"

			var/prompt_message = flavor_text_telepathy
			if(specific_search)
				prompt_message += "读心者正在你的思绪中专门寻找：[specific_search]"
				message_admins("[owner.real_name] (ckey: [owner.key]) uses Auspex 4 'Telepathy' to read the mind of [target.real_name] (ckey: [target.key]) searching for '[specific_search]' with [successes] successes.")
			else
				prompt_message += "读心者正在探查你近期的想法和情绪……"

			input_message = tgui_input_text(target, prompt_message, "你的思绪正被读取")
			if(!input_message)
				input_message = "零碎而模糊的想法与印象。"

			if(!sanitize_input_message(input_message))
				return

			log_directed_talk(target, owner, input_message, LOG_SAY, "Telepathy (Mind Reading)")
			message_admins("[target.real_name]'s (ckey: [target.key]) mind is read by [owner.real_name] (ckey: [owner.key]) who searched their mind for '[specific_search ? specific_search : "recent thoughts and emotions"]'. The owner intercepted the following thoughts or memories : [input_message]")
			to_chat(owner, span_notice("你以[successes]个成功数读到了[GET_GUESTBOOK_NAME(owner, target)]的思绪：[input_message]"))
			COOLDOWN_START(src, mind_read_cd, 3 MINUTES)

/datum/discipline_power/auspex/telepathy/proc/get_flavor_text(successes)
	var/message = "此次读心取得了[successes]个成功数，"
	switch(successes)
		if(1)
			message += "最表层的想法或未说出口的话很容易被读到。不过，如果你的角色预料到自己会被读心，就可以设法掩饰真实的想法……"
		if(2)
			message += "读心者开始深入你的潜意识，揭露更深层或更清晰的想法……"
		if(3)
			message += "你的心灵开始受到深度探查，具体的内心独白、细节、秘密和近期记忆逐一显露……"
		if(4)
			message += "你的心灵正遭到深度入侵。隐藏的想法、压抑的情绪和你试图埋藏的秘密开始浮现。入侵者能在你毫不知情的情况下，触及连你自己都可能遗忘的记忆和感受……"
		if(5 to INFINITY)
			message += "你最深的秘密和埋藏最久的记忆已完全暴露。读心者可以触及创伤经历、早已遗忘的往事，以及你心灵最黑暗的角落。一切都无所遁形……"
	return message

/datum/discipline_power/auspex/telepathy/proc/sanitize_input_message(input_message)
	//sanitisation!
	input_message = CAN_BYPASS_FILTER(owner) ? strip_html_full(input_message, (MAX_MESSAGE_LEN * 10)) : input_message
	var/list/filter_result = CAN_BYPASS_FILTER(owner) ? null : is_ooc_filtered(input_message)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(owner, filter_result)
		log_filter("OOC", input_message, filter_result)
		return FALSE
	return TRUE

//PSYCHIC PROJECTION
/datum/discipline_power/auspex/psychic_projection
	name = "灵魂投射"
	desc = "脱离肉身，自由飞越大地。"

	willpower_cost = 1
	level = 5
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS
	frenzy_usable = FALSE

/datum/discipline_power/auspex/psychic_projection/activate()
	. = ..()
	var/roll = SSroll.storyteller_roll_datum(owner, difficulty = 7, applic_stats = list(STAT_PERCEPTION, STAT_AWARENESS))
	if(roll == ROLL_SUCCESS)
		owner.enter_avatar()
	else
		to_chat(owner, span_warning("你的意识未能脱离肉身。"))

#undef TELEPATHY_MIND_READING
#undef TELEPATHY_IMPLANT_THOUGHT
#undef SENSE_VISION
#undef SENSE_HEARING
#undef SENSE_SMELL
#undef SENSE_TASTE
#undef SENSE_TOUCH
