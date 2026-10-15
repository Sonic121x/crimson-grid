/datum/quirk/darkpack/ambidextrous
	name = "Ambidextrous"
	desc = {"你的非惯用手也十分灵巧，用“不顺手”的那只手做事不会受到惩罚。双持枪械的惩罚也会被抵消。"}
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_AMBIDEXTROUS
	gain_text = span_notice("你觉得自己的双手都很灵巧。")
	lose_text = span_notice("你的非惯用手不再像惯用手那样精准灵活。")
	icon = FA_ICON_HANDS
	failure_message = "你的非惯用手不再像惯用手那样精准灵活。"
