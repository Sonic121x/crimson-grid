/datum/preference/choiced/vtm_morality
	savefile_key = "morality_path"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_TABLETOP
	main_feature_name = "道途" // KUKU：按术语对照表显示角色的道德体系名称
	relevant_inherent_trait = TRAIT_VTM_MORALITY
	must_have_relevant_trait = TRUE
	can_randomize = FALSE

/datum/preference/choiced/vtm_morality/create_default_value()
	return /datum/morality/humanity

/datum/preference/choiced/vtm_morality/init_possible_values()
	var/list/values = list()
	for(var/morality_type in subtypesof(/datum/morality))
		var/datum/morality/M = morality_type
		values[initial(M.name)] = morality_type
	return values
/datum/preference/choiced/vtm_morality/compile_constant_data() { return ..() + list("display_names" = list("Path of Humanity" = "人性之道", "Path of Power and the Inner Voice" = "权力与心声之道", "Path of Heaven" = "天堂之道", "Path of Metamorphosis" = "蜕变之道", "Path of Blood" = "鲜血之道", "Path of the Hive" = "蜂巢之道", "Road of Kings" = "诸王之路", "Path of the Scorched Heart" = "焦心之道", "Path of Typhon" = "堤丰之道", "Path of Ecstasy" = "极乐之道", "Path of the Warrior" = "战士之道", "Path of the Bones" = "骸骨之道", "Path of Death and the Soul" = "死亡与灵魂之道", "Path of Night" = "黑夜之道", "Road of Night" = "黑夜之路", "Path of Honorable Accord" = "荣誉盟约之道", "Path of the Feral Heart" = "野性之心之道", "Path of Harmony" = "和谐之道", "Code of Samiel" = "萨米尔法典", "Path of Caine" = "该隐之道", "Path of Cathari" = "清洁派之道", "Path of Lilith" = "莉莉丝之道", "Path of the Serpent's Seed" = "蛇种之道", "Path of the Red Midwives" = "赤红助产士之道", "Path of the Thorn Garden" = "荆棘花园之道", "Path of the Lilin Witches" = "莉琳女巫之道", "Path of Redemption" = "救赎之道", "Path of Evil Revelations" = "邪恶启示之道", "Path of Entelechy" = "圆成之道", "Sharia El-Sama" = "天国律法", "Path of Paradox" = "悖论之道", "Path of Self-Focus" = "自省之道", "Path of Asakku" = "阿萨库之道")); } // KUKU：为全部道途下拉选项及当前选中值提供中文显示名，保留英文存档键和选择逻辑
/datum/preference/choiced/vtm_morality/is_valid(value)
	return ispath(value, /datum/morality)

/datum/preference/choiced/vtm_morality/serialize(input)
	if(ispath(input))
		var/datum/morality/input_morality = input
		return input_morality::name
	return input

/datum/preference/choiced/vtm_morality/deserialize(input, datum/preferences/preferences)
	var/list/choices = get_choices()
	if(input in choices)
		return choices[input]
	return choices[serialize(create_default_value())]

/datum/preference/choiced/vtm_morality/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/datum/st_stat/morality_path/morality/stat_morality = target.storyteller_stats[STAT_MORALITY]
	if(!stat_morality)
		return

	stat_morality.morality_path = new value(target)

/datum/preference/choiced/vtm_morality/post_set_preference(mob/user, value)
	. = ..()
	if(!user)
		return

	var/datum/morality/morality_path = GLOB.morality_paths[value]
	if(!morality_path)
		return

	morality_path.show_lore(user)

/mob/living/proc/is_enlightenment()
	var/datum/st_stat/morality_path/morality/stat_morality = storyteller_stats[STAT_MORALITY]
	if(!stat_morality?.morality_path)
		return FALSE

	if(stat_morality.morality_path.alignment == MORALITY_ENLIGHTENMENT)
		return TRUE
	return FALSE
