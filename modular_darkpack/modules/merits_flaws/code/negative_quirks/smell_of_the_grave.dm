// V20 p. 481
/datum/quirk/darkpack/smell_of_the_grave
	name = "Smell Of The Grave"
	desc = {"你散发着潮湿与新翻泥土的气味，再多香料或香水也掩盖不住。
靠近你的凡人会感到不适，因此所有影响凡人的社交检定难度增加 1。"}
	value = -1
	mob_trait = TRAIT_GRAVE_SMELL
	gain_text = span_notice("你身上的气味很难闻。")
	lose_text = span_notice("你觉得自己身上的气味好多了。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_SPRAY_CAN
	failure_message = span_notice("你觉得自己身上的气味好多了。")
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
