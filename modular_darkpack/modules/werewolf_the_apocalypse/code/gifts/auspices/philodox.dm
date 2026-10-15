
/datum/action/cooldown/power/gift/resist_pain
	name = "抵抗疼痛"
	desc = "半月仲裁者凭借意志忽略伤口的疼痛，继续正常行动。"
	button_icon_state = "resist_pain"
	rank = 1
	willpower_cost = 1

/datum/action/cooldown/power/gift/resist_pain/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)

	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/resist_pain.ogg', 75, FALSE)
	living_owner.apply_status_effect(/datum/status_effect/resist_pain)

/datum/status_effect/resist_pain
	id = "resist_pain"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/resist_pain

/datum/status_effect/resist_pain/on_apply()
	. = ..()

	to_chat(owner, span_notice("你感到皮肤正在变厚……"))
	owner.add_traits(list(TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA), GIFT_TRAIT)
	owner.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)

/datum/status_effect/resist_pain/on_remove()
	owner.remove_traits(list(TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA), GIFT_TRAIT)
	owner.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	to_chat(owner, span_warning("你的皮肤又变薄了……"))

	return ..()

/atom/movable/screen/alert/status_effect/gift/resist_pain
	name = /datum/action/cooldown/power/gift/resist_pain::name
	desc = /datum/action/cooldown/power/gift/resist_pain::desc
	overlay_state = /datum/action/cooldown/power/gift/resist_pain::button_icon_state


/datum/storyteller_roll/gift/scent_of_the_true_form
	applicable_stats = list(STAT_PERCEPTION)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER

/datum/action/cooldown/power/gift/scent_of_the_true_form
	name = "真形之嗅"
	desc = "此天赋让狼人辨明一个人的真实本质。"
	button_icon_state = "scent_of_the_true_form"
	click_to_activate = TRUE
	rank = 1
	var/static/list/wyld_descriptors = list(
		"臭氧",
		"欣喜若狂",
		"鲜花",
		"无形微风",
		"雨后泥土",
		"雷雨后的宁静",
		"原始海洋",
		"对无限可能的期待"
	)
	var/static/list/weaver_descriptors = list(
		"规律声响",
		"清洁剂",
		"洗手液",
		"蛛网",
		"丝线",
		"金属",
		"骤然流失的能量",
		"闪烁灯光",
		"警报与汽笛"
	)
	var/static/list/wyrm_descriptors = list(
		"腐烂",
		"衰败",
		"恐惧",
		"在恐惧中死去的动物",
		"消沉",
		"绝望",
		"痛苦",
		"不断拉长的阴影"
	)

/datum/action/cooldown/power/gift/scent_of_the_true_form/set_click_ability(mob/on_who)
	. = ..()
	SEND_SOUND(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/scent_of_the_true_form.ogg') // Vulture sound mixed with fleshtostone.ogg

/datum/action/cooldown/power/gift/scent_of_the_true_form/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(3, owner)))
		to_chat(owner, span_warning("你在这里闻不到[target]的气味。"))
		return

	. = ..()

	var/mob/living/victim = target
	var/mob/living/caster = owner
	var/datum/splat/werewolf/target_splat = get_werewolf_splat(victim)

	if(istype(target_splat))
		var/secondary_descriptor = "[pick(wyld_descriptors)]"
		switch(target_splat.tribe?.name)
			if(TRIBE_GLASS_WALKERS)
				secondary_descriptor = "[pick(weaver_descriptors)]"
			if(TRIBE_BONE_GNAWERS)
				secondary_descriptor = "[pick(weaver_descriptors)]"
			if(TRIBE_BLACK_SPIRAL_DANCERS)
				secondary_descriptor = "[pick(wyrm_descriptors)]"
		to_chat(owner, span_purple("[victim]散发着同类的气息[secondary_descriptor ? "……<br>……还带着[secondary_descriptor]的气息。" : "。"]"))
	else
		var/successes = SSroll.storyteller_roll_datum(owner, null, /datum/storyteller_roll/gift/scent_of_the_true_form, bonus = PRIMAL_URGE_PLACEHOLDER)
		// CRIMSON EDIT ADD START - true_form oversuccess fix
		if (successes > 4)
			successes = 4
		// CRIMSON EDIT ADD END - true_form oversuccess fix
		switch(successes)
			if(0)
				to_chat(owner, span_purple("你无法准确辨别[victim]的气味。"))
			if(1)
				to_chat(owner, span_purple("[victim]的气息很平凡。"))
			if(2 to 3)
				if(get_kindred_splat(victim))
					to_chat(owner, span_purple("[victim]散发着[HAS_TRAIT(victim, TRAIT_HIDDEN_WYRMTAINT) ? pick(wyld_descriptors) : pick(wyrm_descriptors)]的气息。")) // CRIMSON EDIT CHANGE - ORIGINAL: to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
				if(get_shifter_splat(victim) && !get_garou_splat(victim))
					to_chat(owner, span_purple("对方有同类的气息，但并非狼人。"))
//				if(ishungrydead(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
//				if(ischangeling(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(isdemon(victim))
//					to_chat(owner, span_purple("[victim] smells of brimstone."))
//				if(ismummy(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
				else
					to_chat(owner, span_purple("[victim]的气息很平凡。"))
			if(4)
				if(get_kindred_splat(victim))
					to_chat(owner, span_purple("[victim]散发着[HAS_TRAIT(victim, TRAIT_HIDDEN_WYRMTAINT) ? pick(wyld_descriptors) : pick(wyrm_descriptors)]的气息。")) // CRIMSON EDIT CHANGE - ORIGINAL: to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
				if(get_ghoul_splat(victim))
					to_chat(owner, span_purple("[victim]散发着[pick(wyrm_descriptors)]的气息。"))
				if(get_shifter_splat(victim) && !get_garou_splat(victim))
					to_chat(owner, span_purple("对方有同类的气息，但并非狼人。"))
//				if(isfomor(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
//				if(ischangeling(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(isdemon(victim))
//					to_chat(owner, span_purple("[victim] smells of brimstone."))
//				if(ismummy(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(ismage(victim))
//					to_chat(owner, span_purple("[victim] smells of pure energy."))
				else
					to_chat(owner, span_purple("[victim]的气息很平凡。"))

	caster.emote("sniff")

	StartCooldown()
	return TRUE


/datum/action/cooldown/power/gift/truth_of_gaia
	name = "盖亚之真"
	desc = "作为律诫的裁决者，半月仲裁者能够感知他人的话语是真是假。"
	button_icon_state = "truth_of_gaia"
	click_to_activate = TRUE
	rank = 1

/datum/action/cooldown/power/gift/truth_of_gaia/Activate(atom/target)
	var/mob/living/living_target = astype(target)
	if(!living_target)
		return FALSE

	. = ..()

	var/datum/storyteller_roll/roll_datum = new()
	roll_datum.applicable_stats = list(STAT_INTELLIGENCE, STAT_EMPATHY)
	roll_datum.difficulty = living_target.st_get_stat(STAT_MANIPULATION) + living_target.st_get_stat(STAT_SUBTERFUGE)
	roll_datum.roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_TARGET
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result != ROLL_SUCCESS)
		return

	SEND_SOUND(target, sound('sound/effects/magic/clockwork/invoke_general.ogg', volume = 50)) // LOOK OUT! A WEREWOLF IS SMELLING YOU!

	ASYNC
		var/response_w = tgui_input_list(target, "你的角色认为自己刚才所说的是真话吗？", name, list("是", "否", "不确定"))
		switch(response_w)
			if("是")
				to_chat(owner, span_notice("[target]的气味中透着诚实。"))
			if("否") // Lying!
				to_chat(owner, span_notice("[target]的气味中透着欺骗。"))
			else // Dunno
				to_chat(owner, span_notice("[target]的气息犹疑不定，你无法判断真假。"))

	StartCooldown()
	return TRUE
