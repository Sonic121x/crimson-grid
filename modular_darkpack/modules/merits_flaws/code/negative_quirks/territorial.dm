GLOBAL_LIST_INIT(territorial_type_choices, init_territorial_type_choices())

/proc/init_territorial_type_choices()
	var/list/choices = list()
	for(var/area/vtm/area_type as anything in subtypesof(/area/vtm))
		var/area/vtm/typed = area_type
		var/area/vtm/parent = area_type::parent_type
		if(initial(typed.domain) && !initial(parent.domain))
			choices[initial(typed.name)] = area_type
	return choices

/datum/preference/choiced/territorial
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "territorial"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/territorial/init_possible_values()
	return GLOB.territorial_type_choices

/datum/preference/choiced/territorial/create_default_value()
	return /area/vtm/outside/financialdistrict::name

/datum/preference/choiced/territorial/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE
	return /datum/quirk/darkpack/territorial::name in preferences.all_quirks

/datum/preference/choiced/territorial/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/datum/quirk/darkpack/territorial/terr = target.get_quirk(/datum/quirk/darkpack/territorial)
	if(!terr)
		return
	terr.territory = GLOB.territorial_type_choices[value] || /area/vtm/outside/financialdistrict

/datum/quirk/darkpack/territorial
	name = "Territorial"
	desc = "你的领地意识极强，只能在某个特定区域进食。其他吸血鬼若未经告知进入你的领地，你会抱以敌意；若未经许可就在此进食，冲突更是不可避免，因为他们正在夺走你的食物和资源。除非必要，你不愿离开自己的领地。你只能在领地内进食。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 486)
	value = -2
	mob_trait = TRAIT_VAMPIRE_TERRITORIAL
	gain_text = span_notice("你必须保护自己的猎场、血源人群和领地。")
	lose_text = span_notice("谁会在乎别人在什么地方进食呢？")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_MAP_LOCATION_DOT
	failure_message = "谁会在乎别人在什么地方进食呢？"
	var/territory
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk_constant_data/territorial
	associated_typepath = /datum/quirk/darkpack/territorial
	customization_options = list(/datum/preference/choiced/territorial)

/datum/quirk/darkpack/territorial/add(client/client_source)
	territory = GLOB.territorial_type_choices[client_source?.prefs.read_preference(/datum/preference/choiced/territorial)] || /area/vtm/outside/financialdistrict
