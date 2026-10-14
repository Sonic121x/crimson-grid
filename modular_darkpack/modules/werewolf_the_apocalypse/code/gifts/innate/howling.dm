/datum/action/cooldown/power/gift/howling
	name = "呼嚎"
	desc = "狼人可将呼嚎传至远超正常听觉的范围，向全城其他狼人传递一个词语或概念。"
	button_icon_state = "call_of_the_wyld"
	rage_cost = 1
	check_flags = null
	innate_ability = TRUE
	var/static/list/howls = list(
		"attack" = list(
			"menu" = "进攻",
			SPLAT_GAROU = "一匹狼以激烈的嚎叫号召进攻",
			SPLAT_CORAX = "一只渡鸦以尖厉的嘶鸣号召进攻"
		),
		"retreat" = list(
			"menu" = "撤退",
			SPLAT_GAROU = "一匹狼以嚎叫发出撤退警告",
			SPLAT_CORAX = "一只渡鸦以啼叫发出撤退警告"
		),
		"help" = list(
			"menu" = "求救",
			SPLAT_GAROU = "一匹狼以绝望的嚎叫求救",
			SPLAT_CORAX = "一只渡鸦以绝望的尖叫求救"
		),
		"gather" = list(
			"menu" = "集合",
			SPLAT_GAROU = "一匹狼以嚎叫召集狼群",
			SPLAT_CORAX = "一只渡鸦正在召集鸦群"
		),
		"victory" = list(
			"menu" = "胜利",
			SPLAT_GAROU = "一匹狼以嚎叫欢庆胜利",
			SPLAT_CORAX = "一只渡鸦以鸣叫欢庆胜利"
		),
		"dying" = list(
			"menu" = "濒死",
			SPLAT_GAROU = "一匹狼在痛苦与绝望中哀嚎",
			SPLAT_CORAX = "一只渡鸦在痛苦与绝望中尖叫"
		),
		"mourning" = list(
			"menu" = "哀悼",
			SPLAT_GAROU = "一匹狼以哀嚎深切悼念逝者",
			SPLAT_CORAX = "一只渡鸦正在哀悼逝者"
		)
	)

/datum/action/cooldown/power/gift/howling/IsAvailable(feedback)
	. = ..()
	if(istype(get_area(owner), /area/vtm/interior/penumbra))
		if(feedback)
			to_chat(owner, span_warning("你的呼嚎在影界中回荡、消散，声音被绒幕暗影的灵性能量吞没。"))
		return FALSE

/datum/action/cooldown/power/gift/howling/Activate(atom/target)
	. = ..()

	var/mob/living/living_mob = owner
	var/datum/splat/werewolf/shifter/shifter = get_shifter_splat(owner)
	var/list/menu_options = list()
	for(var/howl_key in howls)
		menu_options += howls[howl_key]["menu"]

	var/choice = tgui_input_list(owner, "选择要发出的呼嚎！", "选择呼嚎", menu_options)
	if(!choice)
		return

	var/howl
	for(var/howl_key in howls)
		if(howls[howl_key]["menu"] == choice)
			howl = howls[howl_key]
			break

	var/garou_message = howl[shifter.id]
	/*
	var/tribe = living_mob.auspice.tribe.name
	if (tribe)
		garou_message = replacetext(garou_message, "tribe", tribe)
	*/
	var/origin_turf = get_turf(living_mob)
	ADD_TRAIT(living_mob, TRAIT_LOUD_WARCRY, GIFT_TRAIT)
	living_mob.emote(shifter.warcry_emote)
	REMOVE_TRAIT(living_mob, TRAIT_LOUD_WARCRY, GIFT_TRAIT)

	var/howl_details
	var/final_message
	for(var/mob/living/howled_at in GLOB.player_list - owner)
		if(get_shifter_splat(howled_at))
			howl_details = get_message(howled_at, origin_turf)
			final_message = garou_message + howl_details
			to_chat(howled_at, span_boldnotice(final_message))


/datum/action/cooldown/power/gift/howling/proc/get_message(mob/living/howled_at, turf/origin_turf)
	var/distance = get_dist(howled_at, origin_turf)
	var/dirtext = "方向为"
	var/direction = get_dir(howled_at, origin_turf)

	if(dir2text(direction))
		dirtext += list("north" = "北方", "south" = "南方", "east" = "东方", "west" = "西方", "northeast" = "东北方", "southeast" = "东南方", "northwest" = "西北方", "southwest" = "西南方")[dir2text(direction)]
	else
		dirtext = "但你无法辨明具体方向"

	var/disttext
	switch(distance)
		if(0 to 20)
			disttext = "距离在 20 英尺以内"
		if(20 to 40)
			disttext = "距离为 20 至 40 英尺"
		if(40 to 80)
			disttext = "距离为 40 至 80 英尺"
		if(80 to 160)
			disttext = "距离较远"
		else
			disttext = "距离很远"

	var/place = get_area_name(origin_turf)

	var/returntext = "；[disttext]，[dirtext]，地点是[place]。"

	return returntext
