/datum/quirk/darkpack/grip_of_the_damned
	name = "Grip of the Damned"
	desc = "你的初拥毫无狂喜可言，只有恐惧和痛苦。你试图进食时，被你吸血的凡人会挣扎尖叫。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 495)
	icon = FA_ICON_DRUMSTICK_BITE
	value = -4
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_GIOVANNI)
	mob_trait = TRAIT_PAINFUL_VAMPIRE_KISS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
