/datum/quirk/darkpack/efficient_digestion
	name = "Efficient Digestion"
	desc = "你能从血液中汲取比常人更多的养分。进食时，每摄取两点血液，血池就会额外增加一点。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 3
	mob_trait = TRAIT_EFFICIENT_DIGESTION
	gain_text = span_notice("你觉得自己的饥渴很容易得到满足。")
	lose_text = span_notice("你感到空虚，仿佛要吞下更多才能填满这片空洞……")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_FILL_DRIP
	failure_message = "你感到空虚，仿佛要吞下更多才能填满这片空洞……"
