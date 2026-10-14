/datum/quirk/darkpack/unbondable
	name = "Unbondable"
	desc = "你免疫血缚。睿魔尔不能选择此优势。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 494)
	value = 5
	mob_trait = TRAIT_UNBONDABLE
	icon = FA_ICON_CHAIN_BROKEN
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_TREMERE)


/datum/quirk/darkpack/unbondable/ghoul
	name = "Unbondable (Ghoul)"
	desc = "你免疫血缚。"
	value = 6
	allowed_splats = list(SPLAT_GHOUL)
