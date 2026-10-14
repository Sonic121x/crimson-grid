GLOBAL_LIST_INIT(localized_discipline_names, list("Animalism" = "兽性术", "Auspex" = "灵视术", "Bloodheal" = "血疗术", "Celerity" = "迅捷术", "Daimonion" = "恶魔术", "Dementation" = "惑狂术", "Dominate" = "支配术", "Fortitude" = "坚韧术", "Melpominee" = "悲歌术", "Mytherceria" = "妖灵术", "Necromancy" = "死灵术", "Obeah" = "愈灵术", "Obfuscate" = "朦胧术", "Obtenebration" = "暗影术", "Potence" = "巨力术", "Presence" = "威仪术", "Protean" = "变形术", "Quietus" = "静谧术", "Serpentis" = "蛇形术", "Temporis" = "时流术", "Thanatosis" = "尸化术", "Thaumaturgy" = "血魔法", "Torpor" = "长眠", "Valeren" = "勇战术", "Vicissitude" = "塑形术", "Visceratika" = "岩肤术", "Lure of Flames" = "诱焰之道", "Path of the Levinbolt" = "雷霆之道", "Taking of Spirit" = "摄魂之道", "Path of Pain" = "痛苦之道", "Fires of Inferno" = "炼狱之火"))
GLOBAL_LIST_INIT(rare_discipline_types, list(
	/datum/discipline/quietus,
	/datum/discipline/temporis,
	/datum/discipline/serpentis,
	/datum/discipline/dementation,
	/datum/discipline/obtenebration,
	/datum/discipline/thaumaturgy,
	/datum/discipline/necromancy,
	/datum/discipline/valeren,
	/datum/discipline/obeah,
	/datum/discipline/daimonion,
	/datum/discipline/melpominee,
))

// warns a player if they have no discipline dots assigned before joining
// returns TRUE if they want to proceed, FALSE if they want to go back and fix their disciplines
/mob/dead/new_player/proc/check_discipline_warning()
	if(!client?.prefs)
		return TRUE
	var/splat = client.prefs.read_preference(/datum/preference/choiced/splats)
	if(!ispath(splat, /datum/splat/vampire))
		return TRUE

	// check for at least one discipline, store how many discipline points spent, count how many disciplines they have
	var/discipline_count
	var/discipline_points_spent
	var/has_any_discipline = FALSE
	for(var/disc in client.prefs.discipline_levels)
		var/level = client.prefs.discipline_levels[disc]
		discipline_points_spent += level
		discipline_count++
		if(level > 0 && !has_any_discipline)
			has_any_discipline = TRUE

	var/discipline_points_budget
	if(ispath(splat, /datum/splat/vampire/kindred))
		var/immortal_age = client.prefs.read_preference(/datum/preference/numeric/immortal_age)
		discipline_points_budget = get_discipline_point_budget(immortal_age)["points"]
	else if(ispath(splat, /datum/splat/vampire/ghoul))
		discipline_points_budget = get_ghoul_discipline_budget(discipline_count)["points"]

	// we are assuming that diablerists gain discipline points or disciplines.
	if(discipline_points_spent > discipline_points_budget && !client.prefs.read_preference(/datum/preference/toggle/diablerist))
		tgui_alert(src, "你已分配了[discipline_points_spent]点律能，但这个角色最多只能分配[discipline_points_budget]点！请先调整角色设置，再加入游戏。", "律能点数超额", list("确定"))
		return FALSE

	if(!has_any_discipline)
		var/choice = tgui_alert(src, "你还没有分配任何律能点数！为避免角色缺少能力，入场时系统会自动为你所属氏族的每项常见律能分配1点。", "尚未配置律能", list("我明白了", "返回"))
		return choice == "我明白了"
	return TRUE

// discipline weights (trusted players arent affected by these)
// 5 possible total disciplines
// no greater than 2 non-clan rare disciplines
// 1 rare in addition to non-clan means you get max 1 common additional on top of that
// no rare additionals means you get a max of 2 common additionals
/proc/validate_discipline_sheet(list/discipline_levels, list/clan_disciplines, is_trusted = FALSE)
	var/list/result = list()
	var/list/violations = list()
	var/total = 0
	var/additional = 0
	var/additional_rare = 0

	for(var/disc_path in discipline_levels)
		if(!discipline_levels[disc_path])
			continue
		total++
		if(!(disc_path in clan_disciplines))
			additional++
			if(text2path(disc_path) in GLOB.rare_discipline_types)
				additional_rare++

	if(!is_trusted)
		if(total > 5)
			violations += "Total disciplines ([total]) exceeds the limit of 5."
		if(additional_rare > 2)
			violations += "Has [additional_rare] rare additional disciplines! The maximum for non-trusted players is 2.\n"
		else if(additional_rare == 1 && additional > 2)
			violations += "With 1 rare additional discipline, only 1 common additional is permitted ([additional - 1] common found).\n"
		else if(additional_rare == 0 && additional > 2)
			violations += "Has [additional] additional common disciplines! The maximum for non-trusted players is 2 without a rare."

	result["total"] = total
	result["additional"] = additional
	result["additional_rare"] = additional_rare
	result["valid"] = !length(violations)
	result["violations"] = violations
	return result

// for validating a mob's sheet before teaching them a new one
// validated against the above criteria
/proc/validate_mob_sheet(mob/living/carbon/human/human, discipline_type_to_add = null)
	var/datum/splat/vampire/vamp_splat = get_splat_with_discipline(human)
	if(!vamp_splat)
		return null

	var/list/discipline_levels = list()
	for(var/datum/action/discipline/disc_action as anything in vamp_splat.powers)
		var/datum/discipline/disc = disc_action.discipline
		if(!disc?.selectable)
			continue
		if(ispath(disc.type, /datum/discipline/path))
			continue
		discipline_levels["[disc.type]"] = disc.level

	if(discipline_type_to_add)
		var/disc_key = "[discipline_type_to_add]"
		if(!discipline_levels[disc_key])
			discipline_levels[disc_key] = 1

	var/list/clan_disciplines = list()
	var/datum/subsplat/vampire_clan/clan = human.get_clan()
	if(clan)
		for(var/disc_type in clan.clan_disciplines)
			if(ispath(disc_type, /datum/discipline))
				clan_disciplines += "[disc_type]"

	var/is_trusted = human.client?.prefs?.discipline_trusted || FALSE

	return validate_discipline_sheet(discipline_levels, clan_disciplines, is_trusted)

/datum/preference_middleware/disciplines
	action_delegations = list(
		"set_discipline_level" = PROC_REF(set_discipline_level),
		"clear_discipline_levels" = PROC_REF(clear_discipline_levels)
	)

/datum/preference_middleware/disciplines/get_ui_data(mob/user)
	if(preferences.current_window != PREFERENCE_TAB_CHARACTER_PREFERENCES)
		return list()

	var/list/data = list()
	data["discipline_levels"] = list()
	var/points_spent = 0
	for(var/discipline in preferences.discipline_levels)
		var/level = preferences.discipline_levels[discipline]
		data["discipline_levels"]["[discipline]"] = level
		points_spent += level

	var/is_ghoul = ispath(preferences.read_preference(/datum/preference/choiced/splats), /datum/splat/vampire/ghoul)
	data["clan_disciplines"] = list()
	data["clan_name"] = null
	var/clan_value = preferences.read_preference(/datum/preference/choiced/subsplat/vampire_clan)

	var/discipline_count = 0
	var/list/counted_discs = list()
	for(var/disc in preferences.discipline_levels)
		if(preferences.discipline_levels[disc] > 0)
			discipline_count++
			counted_discs[disc] = TRUE

	if(is_ghoul && clan_value)
		var/datum/subsplat/vampire_clan/ghoul_clan_datum = get_vampire_clan(clan_value)
		if(ghoul_clan_datum)
			for(var/disc_type in ghoul_clan_datum.clan_disciplines)
				if(ispath(disc_type, /datum/discipline) && !("[disc_type]" in counted_discs))
					discipline_count++

	var/immortal_age = preferences.read_preference(/datum/preference/numeric/immortal_age)
	var/list/budget_info = is_ghoul ? get_ghoul_discipline_budget(discipline_count) : get_discipline_point_budget(immortal_age)
	data["discipline_points_available"] = budget_info["points"]
	data["discipline_points_spent"] = points_spent
	data["discipline_tier"] = budget_info["tier"]
	data["discipline_tier_details"] = budget_info["details"]
	data["is_trusted"] = preferences?.has_whitelist(WHITELIST_TRUSTED)
	data["max_trusted_generation"] = MAX_TRUSTED_GENERATION
	data["max_public_generation"] = MAX_PUBLIC_GENERATION
	data["highest_generation_limit"] = HIGHEST_GENERATION_LIMIT

	return data

/proc/get_discipline_point_budget(immortal_age)
	if(immortal_age <= 10)
		return list(
			"points" = DISCIPLINE_BUDGET_FLEDGLING,
			"tier" = "雏血",
			"details" ="作为雏血，你还在学习控制新获得的力量，应对随之而来的麻烦。无论好坏，你与初拥前的自己仍相差无几。人们常说“活着受罪，到头来还是一死”，却没说死后也同样难熬，而你正开始亲身体会这一点。你可能刚被宣告死亡或被报失踪，失去了生前的人际支持，只能艰难地拼凑自己的不死生活。许多规则与习俗令你陌生，年长的血族也瞧不起你。也许你在初拥后接连杀人，引起了执法机关和密党的注意，如今正独自躲藏；也许你正受血亲严密看管，在其庇护下学习自制。无论如何，要应付这一切，你都需要帮助。")
	if(immortal_age <= 100)
		return list(
			"points" = DISCIPLINE_BUDGET_NEONATE,
			"tier" = "新血",
			"details" = "作为新血，你开始适应自己的不死生活。你已学会约束冲动，大体能独立行事，但年长的血族依然一眼就能看穿你的稚嫩。昔日亲友逐渐衰老、寿终，他们的离去留下难以磨灭的伤痕。那些仍与你往来、却不知道你已接受初拥的人，想必会怀疑你为何容颜不老、白天又不见踪影。因此，你学会了保持镇定、谨言慎行，尤其是在与凡人相处时。随着维系你人性的凡人日渐凋零，甚至全部离去，你将开始从其他人身上寻找慰藉……否则，你的人性也可能随他们一同消逝。")
	if(immortal_age <= 200)
		return list(
			"points" = DISCIPLINE_BUDGET_ANCILLAE,
			"tier" = "资深者",
			"details" = "作为资深者，你是血族社会中受人尊重的一员。在自由派眼里你已十分古老，在密党看来却只是中年。一个多世纪前亲友的离世，早已让你与生前生活的联系逐渐淡去。在漫长岁月中，你找到了新的家人：或是亲自初拥的子嗣，或是相交多年、始终维系着的挚友。你是一位沉着而成熟的吸血鬼，人们需要商议决策或处理要事时，往往会求助于你。")
	return list("points" = DISCIPLINE_BUDGET_ELDER,
			"tier" = "长老",
			"details" = "作为氏族长老，你是一部活着的史书。你已学会对自己的真实年龄与来历守口如瓶，也很可能结下了许多仇敌，其中有些尚存，有些早已死去。你如蜿蜒的蜈蚣般穿行于时间，爬入一个又一个陌生的世纪，不断学习并适应变迁的文化。也许多年前的一场战斗令你陷入长眠，如今你醒来，却置身于一个不认识的世界，连那场战斗都未必还记得。你很可能因数百年前的一些事而声名在外，或褒或贬，至于那些事是否真是你做的，早已难以分辨。有人因你这张熟悉的面孔而感到慰藉，也有人为了几辈子以前的微末恩怨，恨不得将你化为灰烬。若你的真实年龄暴露，密党很可能看中你的力量，试图招揽你充当执行者……也可能有野心勃勃的舔血者找上门来，想通过血噬夺走你的力量。能存活至今，你必定谨慎、老练而狡黠。你重视自己的习惯，也尽可能远离年轻血族的小打小闹。")

/proc/get_ghoul_discipline_budget(discipline_count = 0)
	return list(
		"points" = max(3, discipline_count), // pool expands for each additional discipline they've been taught, but they can never assign more than 1 per
		"tier" = "血仆",
		"details" = "作为血仆，你是血族社会中的劳苦阶层。你既不完全是凡人，也算不上血族，在两个世界里都是局外人。你可能侍奉着一位血主，或所谓的“雇主”：一名定期赐予你血液的血族，借此维系你漫长不老的生命与超自然能力。更少见的情况是，你是四处寻找血族之血的自由血仆。这种做法极受鄙视，一旦被密党发现，甚至可能招来杀身之祸。你大多时候低头听命，因为哪怕只是一个不合宜的眼神，也可能让血族杀了你，而其代价不过是欠你的主人一个小小的人情。你能在白天替血主跑腿，也能运用所饮之血赋予的基础超自然能力……但只要你继续饮血，也就会继续承受他们的氏族诅咒。")

/datum/preference_middleware/disciplines/get_constant_data()
	var/list/data = list()

	for(var/discipline_type in subtypesof(/datum/discipline))
		var/datum/discipline/discipline = new discipline_type

		if(!discipline.selectable) // default disciplines like bloodheal arent selectable, and dont belong here
			qdel(discipline)
			continue

		if(ispath(discipline_type, /datum/discipline/path)) // avoids giving tremere 50 different discs because thaum has like 50 subtypes
			qdel(discipline)
			continue

		var/list/disc_data = list()
		disc_data["name"] = DISCIPLINE_DISPLAY_NAME(discipline.name)
		disc_data["desc"] = discipline.desc
		disc_data["max_level"] = discipline.max_selectable_level || length(discipline.all_powers)
		disc_data["icon"] = initial(discipline.icon)
		disc_data["icon_state"] = discipline.icon_state
		disc_data["rarity"] = (discipline_type in GLOB.rare_discipline_types) ? "rare" : "common"
		data["[discipline_type]"] = disc_data
		qdel(discipline)

	return data


// sets the character's level in a given discipline
// if you dont put any dots in it, aka level 0, it means you don't spawn in with that discipline
/datum/preference_middleware/disciplines/proc/set_discipline_level(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	if(!isnewplayer(user) && ("[user.client.prefs.default_slot]" in user.persistent_client.joined_as_slots))
		to_chat(user, span_warning("本回合已经入场的角色无法调整律能点数。")) // so people dont mess up their saves
		return FALSE

	var/discipline = params["discipline"]
	var/new_level = text2num(params["level"])

	if(!discipline || isnull(new_level))
		return FALSE

	new_level = round(new_level)
	if(new_level < 0 || new_level > 5)
		return FALSE

	if(ispath(preferences.read_preference(/datum/preference/choiced/splats), /datum/splat/vampire/ghoul) && new_level > 1)
		var/clan_value = preferences.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
		var/datum/subsplat/vampire_clan/clan_datum = clan_value ? get_vampire_clan(clan_value) : null
		if(clan_datum)
			for(var/disc_type in clan_datum.clan_disciplines)
				if("[disc_type]" == discipline)
					return FALSE

	var/immortal_age = preferences.read_preference(/datum/preference/numeric/immortal_age)
	var/list/budget_info = get_discipline_point_budget(immortal_age)
	var/point_budget = budget_info["points"]
	var/old_level = preferences.discipline_levels[discipline] || 0
	var/current_total = 0

	for(var/disc in preferences.discipline_levels)
		current_total += preferences.discipline_levels[disc]
	var/new_total = current_total - old_level + new_level

	if(new_level > old_level && new_total > point_budget) // you can go down, but not up, if you're overbudget. for when adminbus gives you more than you can chew
		return FALSE

	preferences.discipline_levels[discipline] = new_level

	preferences.save_character()
	return TRUE

/datum/preference_middleware/disciplines/proc/clear_discipline_levels(list/params, mob/user)
	SHOULD_NOT_SLEEP(TRUE)

	if(!isnewplayer(user) && ("[user.client.prefs.default_slot]" in user.persistent_client.joined_as_slots))
		to_chat(user, span_warning("本回合已经入场的角色无法调整律能点数。"))
		return FALSE
	var/clan_value = preferences.read_preference(/datum/preference/choiced/subsplat/vampire_clan)
	if(!clan_value)
		return FALSE
	preferences.discipline_levels = list() // restore them to default
	var/datum/subsplat/vampire_clan/clan_datum = get_vampire_clan(clan_value) // then give them their default clan discs. clear_discipline_levels fires from changing clans
	if(clan_datum)
		for(var/disc_type in clan_datum.clan_disciplines)
			if(ispath(disc_type, /datum/discipline))
				preferences.discipline_levels += disc_type
	preferences.save_character()
	return TRUE

/datum/preferences/apply_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, list/do_not_apply)
	if(!isnull(character))
		RegisterSignal(character, COMSIG_HUMAN_PREFS_APPLIED, PROC_REF(on_prefs_applied_disciplines), override = TRUE)
	. = ..()

/datum/preferences/proc/on_prefs_applied_disciplines(mob/living/carbon/human/character)
	SIGNAL_HANDLER
	UnregisterSignal(character, COMSIG_HUMAN_PREFS_APPLIED)

	if(isdummy(character))
		return

	var/datum/splat/vampire/vampire_splat = get_splat_with_discipline(character)

	if(!vampire_splat)
		return

	var/has_any = FALSE // does this hoe even HAVE ANY
	for(var/disc_path in discipline_levels)
		if(discipline_levels[disc_path])
			has_any = TRUE
			break

	if(!has_any)
		var/datum/subsplat/vampire_clan/clan = character.get_clan()
		if(clan)
			for(var/disc_type in clan.clan_disciplines)
				if(!ispath(disc_type, /datum/discipline))
					continue
				discipline_levels["[disc_type]"] = 1
				var/result = character.change_st_power_level(disc_type, 1)
				if(!result)
					character.give_st_power(disc_type, 1)
		save_character()
	else
		for(var/disc_path in discipline_levels)
			var/discipline = text2path(disc_path)
			if(!discipline)
				continue
			var/level = character.get_splat(/datum/splat/vampire/ghoul) ? 1 : discipline_levels[disc_path]
			if(!level)
				continue // prevent removing the disc by stopping here if they put 0 in it
			var/result = character.change_st_power_level(discipline, level)
			if(!result)
				character.give_st_power(discipline, level) // load em up

	//SSticker.OnRoundend(CALLBACK(src, PROC_REF(save_disciplines), character))

/datum/preferences/proc/save_disciplines(mob/living/carbon/human/character)
	if(QDELETED(character))
		return

	var/datum/splat/vampire/vampire_splat = get_splat_with_discipline(character)
	if(!vampire_splat)
		return

	var/changed = FALSE
	for(var/datum/action/discipline/disc_action as anything in vampire_splat.powers)
		var/datum/discipline/disc = disc_action.discipline
		if(!disc?.selectable)
			continue
		if(ispath(disc.type, /datum/discipline/path))
			continue
		var/disc_key = "[disc.type]"
		var/in_game_level = disc.level
		var/prefs_level = discipline_levels[disc_key] || 0
		if(in_game_level > prefs_level)
			discipline_levels[disc_key] = in_game_level
			changed = TRUE

	if(changed)
		save_character()
