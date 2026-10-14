/datum/quirk/darkpack/banned_transformation
	name = "Banned Transformation"
	//For the sake of actually being able to implement, only the 3-point version from the book.
	desc = {"某种条件、事件或情境会阻碍你
	改变形态，恢复出身形态则不受
	影响。若要在不消耗怒火点数的情况下变形，
	你必须消耗一点意志力，并成功通过
	意志力检定（难度 8）。"}
	ttrpg_sources = list(/datum/source_book/wta20 = 483)
	value = -3
	mob_trait = TRAIT_BANNED_TRANSFORMATION
	icon = FA_ICON_PERSON
	allowed_splats = SPLAT_SHIFTERS
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
