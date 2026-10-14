/datum/quirk/darkpack/thirst_of_ages
	name = "Methuselah's Thirst"
	desc = "有些极为古老的吸血鬼发现，凡人的血液已无法维持自己的存在。你只能从超自然生物身上进食。"
	ttrpg_sources = list(/datum/source_book/gt_tmr = 177)
	value = -7
	mob_trait = TRAIT_THIRST_OF_AGES
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)	//Eating organs for vitae would bypass this downside.
	icon = FA_ICON_TEETH
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

