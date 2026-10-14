/datum/quirk/darkpack/beacon_of_the_unholy
	name = "Beacon of the Unholy"
	desc = {"你散发着令人切实感受到的邪恶。神职人员和虔诚的凡人
	会本能地察觉你身上存在某种可怕的
	异常，并作出相应反应。"}
	ttrpg_sources = list(/datum/source_book/vtm20 = 494)
	value = -2
	mob_trait = TRAIT_BEACON_OF_THE_UNHOLY
	icon = FA_ICON_LIGHTBULB
	allowed_splats = list(SPLAT_KINDRED)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
