/atom/movable/screen/alert/discipline_active
	clickable_glow = TRUE
	var/datum/weakref/power_ref

/atom/movable/screen/alert/discipline_active/proc/set_power(datum/discipline_power/power)
	if(!power?.discipline)
		return

	power_ref = WEAKREF(power)
	name = "[power.name]已启用"
	desc = "正在消耗你的血液以维持效果。点击可关闭。"
	icon = power.discipline.icon
	icon_state = power.discipline.icon_state

/atom/movable/screen/alert/discipline_active/Click(location, control, params)
	. = ..()
	if(!.)
		return

	var/datum/discipline_power/power = power_ref?.resolve()
	if(!power)
		return

	power.try_deactivate(direct = TRUE, alert = TRUE)
