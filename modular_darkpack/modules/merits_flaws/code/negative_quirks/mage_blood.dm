/datum/quirk/darkpack/mage_blood
	name = "Mage Blood"
	desc = "你的血液与魔法联系过于紧密，使你无法使用血魔法及其相关道途以外的律能。进入游戏时，所有非血魔法律能都会被移除。"
	value = -5
	icon = FA_ICON_MAGIC_WAND_SPARKLES
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/mage_blood/add(client/client_source)
	var/datum/splat/vampire/kindred/kindred_splat = get_kindred_splat(quirk_holder)
	if(!kindred_splat)
		return
	for(var/datum/action/discipline/action as anything in kindred_splat.powers)
		// Unselectable Disciplines have special handling (e.g. Bloodheal) and are excluded
		if(!istype(action.discipline, /datum/discipline/thaumaturgy) && action.discipline.selectable)
			kindred_splat.remove_power(action.discipline.type)

