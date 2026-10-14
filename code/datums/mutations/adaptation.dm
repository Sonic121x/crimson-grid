/datum/mutation/adaptation
	name = "环境适应"
	desc = "受试者可免受极端温度伤害，但无法抵御真空环境。"
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = span_notice("你的身体感觉一切正常！")
	instability = NEGATIVE_STABILITY_MAJOR
	locked = TRUE // fake parent
	conflicts = list(/datum/mutation/adaptation)
	mutation_traits = list(TRAIT_WADDLING)
	offset_location = ENTIRE_BODY

/datum/mutation/adaptation/New(datum/mutation/copymut)
	. = ..()
	conflicts = typesof(/datum/mutation/adaptation)

/datum/mutation/adaptation/cold
	name = "低温适应"
	desc = "受试者可免受低温环境伤害，并能在冰面上稳步行走。"
	text_gain_indication = span_notice("你的身体感到一阵清爽的凉意。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTCOLD, TRAIT_NO_SLIP_ICE)
	mutation_icon_state = "cold"
	locked = FALSE

/datum/mutation/adaptation/heat
	name = "高温适应"
	desc = "受试者可免受高温伤害（包括火焰），还能抵御灰烬风暴。"
	text_gain_indication = span_notice("你的身体感到暖意涌动，精神为之一振。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_ASHSTORM_IMMUNE)
	mutation_icon_state = "fire"
	locked = FALSE

/datum/mutation/adaptation/thermal
	name = "温度适应"
	desc = "受试者可免受低温及高温环境伤害。\
		但无法抵御高压或低压环境，也不能防止冰面打滑或抵御灰烬风暴。"
	difficulty = 32
	text_gain_indication = span_notice("你的身体感觉如同身处室温中，舒适宜人。")
	instability = POSITIVE_INSTABILITY_MAJOR
	mutation_traits = list(TRAIT_RESISTHEAT, TRAIT_RESISTCOLD)
	mutation_icon_state = "thermal"
	locked = TRUE // recipe

/datum/mutation/adaptation/pressure
	name = "气压适应"
	desc = "受试者可免受低压及高压环境伤害。\
		但无法抵御温度伤害，包括太空中的严寒。"
	text_gain_indication = span_notice("你的身体感到充足的内压。")
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_icon_state = "pressure"
	mutation_traits = list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTHIGHPRESSURE)
	locked = FALSE
