/datum/mutation/cindikinesis
	name = "凝灰"
	desc = "受试者能够从空气中汲取热量，随意生成一堆灰烬。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的手感到温暖。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 10
	synchronizer_coeff = 1
	locked = TRUE
	power_path = /datum/action/cooldown/spell/conjure_item/ash

/datum/action/cooldown/spell/conjure_item/ash
	name = "Create Ash"
	desc = "凝聚火焰之力生成灰烬，基本没什么用。"
	button_icon_state = "ash"

	cooldown_time = 5 SECONDS
	spell_requirements = NONE

	item_type = /obj/effect/decal/cleanable/ash
	delete_old = FALSE
	delete_on_failure = FALSE

/datum/mutation/pyrokinesis
	name = "控火"
	desc = "受试者能够从环境中汲取正能量，随意发射灼热能量弹。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的手感到灼热！")
	instability = POSITIVE_INSTABILITY_MODERATE
	difficulty = 12
	synchronizer_coeff = 1
	energy_coeff = 1
	locked = TRUE
	power_path = /datum/action/cooldown/spell/pointed/projectile/pyro

/datum/action/cooldown/spell/pointed/projectile/pyro
	name = "Pyrobeam"
	desc = "向目标发射一枚灼热能量弹。"
	button_icon_state = "firebeam"
	base_icon_state = "firebeam"
	active_overlay_icon_state = "bg_spell_border_active_blue"
	cast_range = 9
	cooldown_time = 30 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE

	active_msg = "你开始凝聚火焰之力！"
	deactive_msg = "你冷静了下来。"
	projectile_type = /obj/projectile/temp/pyro
