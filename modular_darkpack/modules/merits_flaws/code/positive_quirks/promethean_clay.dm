// V20 Lore of the Clans - pages 238-239
/datum/quirk/darkpack/promethean_clay
	name = "Promethean Clay"
	desc = "（注意：此优势目前仅供角色扮演，实际功能仍在开发中。）你的血肉顺应超自然意志自行起伏塑形，几乎先于你的自觉念头。对自己使用任何塑形术能力时，难度降低 2；你还可以在采取其他行动时，以完整骰池反射性地发动塑形术。需要多轮才能发动的能力仍须经过原有时长，只是变化无需有意识地引导。此外，对自己使用塑形术前三个等级的能力时，你无需动手雕塑，血肉便会自行蠕动、伸展成预期形状。只有塑形术至少达到一点的角色可以购买此优势。"
	ttrpg_sources = list(/datum/source_book/vtm20/lotc = 238)
	value = 5
	mob_trait = TRAIT_PROMETHEAN_CLAY
	gain_text = span_notice("你感到自己与不死之躯深深融为一体。你在皮肤之下蠕动，血肉随之颤动，渴望回应你的意志，如泥土般塑成你心中的模样。")
	lose_text = span_notice("有什么……不对劲。你与血肉之间的联系断开了。意志与不死之躯曾经牢不可分的结合变得勉强，血肉超自然的响应能力渐渐消退。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TZIMISCE)
	icon = FA_ICON_PERSON_BURST
	failure_message = "有些不对劲。你血肉超自然的响应能力渐渐消退。"
	roleplay_only = TRUE // REMOVE THIS WHEN PROMETHEAN CLAY MERIT IS IMPLEMENTED IN FULL

// hey, have you removed roleplay only after fully developing this merit? remove this too. did you remove it yet?
