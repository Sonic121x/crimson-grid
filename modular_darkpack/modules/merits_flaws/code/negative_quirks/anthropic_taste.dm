/datum/quirk/darkpack/anthropic_taste
	name = "Anthropic Taste"
	desc = "你无法饮用猫、鹿或血肉战仆等简单生物的血液。"
	value = -2
	mob_trait = TRAIT_ANTHROPIC_TASTE
	gain_text = span_notice("你发现自己无法忍受简单生物的血液。")
	lose_text = span_notice("你觉得自己又能从简单生物身上进食了。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_CAT
	failure_message = "你觉得自己又能从简单生物身上进食了。"
