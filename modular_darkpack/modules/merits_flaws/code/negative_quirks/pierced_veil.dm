/datum/quirk/darkpack/pierced_veil
	name = "Pierced Veil"
	// A little unsure who to do the logic on the social roll rn.
	desc = {"与大多数狼人不同，你的战斗形态不会令凡人陷入谵妄。
		这让狼人猎手更容易对付你，也更容易追踪你返回圣地，使你的圣地社群成员陷入极大危险。"}
	ttrpg_sources = list(/datum/source_book/wta20 = 484)
	value = -3
	mob_trait = TRAIT_PIERCED_VEIL
	icon = FA_ICON_MASKS_THEATER
	allowed_splats = SPLAT_SHIFTERS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
