/datum/quirk/darkpack/calm_heart
	name = "Calm Heart"
	desc = {"你生性沉着，
不容易勃然大怒。抵抗狂乱时，
你获得两枚额外骰子。布鲁赫不能选择此优势。"}
	ttrpg_sources = list(/datum/source_book/vtm20 = 485)
	value = 3
	mob_trait = TRAIT_CALM_HEART
	icon = FA_ICON_HEART
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_BRUJAH)
