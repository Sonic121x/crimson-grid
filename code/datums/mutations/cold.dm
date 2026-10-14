/datum/mutation/geladikinesis
	name = "凝雪"
	desc = "受试者能够随意将空气中的水分凝结成雪。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的手感到冰凉。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 10
	synchronizer_coeff = 1
	power_path = /datum/action/cooldown/spell/conjure_item/snow

/datum/action/cooldown/spell/conjure_item/snow
	name = "Create Snow"
	desc = "凝聚寒冰之力造雪，可用于堆砌雪制建筑。"
	button_icon_state = "snow"

	cooldown_time = 5 SECONDS
	spell_requirements = NONE

	item_type = /obj/item/stack/sheet/mineral/snow
	delete_old = FALSE
	delete_on_failure = FALSE

/datum/mutation/cryokinesis
	name = "控冰"
	desc = "受试者能够从虚空中汲取负能量，随意发射冰冻能量弹。"
	quality = POSITIVE //upsides and downsides
	text_gain_indication = span_notice("你的手感到冰凉。")
	instability = POSITIVE_INSTABILITY_MODERATE
	difficulty = 12
	synchronizer_coeff = 1
	energy_coeff = 1
	power_path = /datum/action/cooldown/spell/pointed/projectile/cryo

/datum/action/cooldown/spell/pointed/projectile/cryo
	name = "Cryobeam"
	desc = "向目标发射一枚冰冻能量弹。"
	button_icon_state = "icebeam"
	base_icon_state = "icebeam"
	active_overlay_icon_state = "bg_spell_border_active_blue"
	cast_range = 9
	cooldown_time = 16 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE

	active_msg = "你开始凝聚寒冰之力！"
	deactive_msg = "你放松了下来。"
	projectile_type = /obj/projectile/temp/cryo
