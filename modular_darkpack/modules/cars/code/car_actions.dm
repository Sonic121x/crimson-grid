/datum/action/darkpack_car
	button_icon = 'modular_darkpack/modules/cars/icons/car_actions.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_CONSCIOUS
/datum/action/darkpack_car/get_display_name(action_name = name) { return list("Toggle Light" = "开关车灯", "Signal" = "鸣笛", "Toggle Transmission" = "切换挡位", "Lock Baggage" = "锁定后备箱", "Toggle Engine" = "开关引擎", "Exit" = "下车")[action_name] || ..(); }
/datum/action/darkpack_car/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!owner)
		return FALSE
	if(!istype(owner.loc, /obj/darkpack_car))
		return FALSE

/datum/action/darkpack_car/headlight
	name = "Toggle Light"
	desc = "开启或关闭车灯。"
	button_icon_state = "lights"

/datum/action/darkpack_car/headlight/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/obj/darkpack_car/owned_car = owner.loc
	owned_car.set_headlight_on(!owned_car.headlight_on)
	to_chat(owner, span_notice("你切换了[owned_car]的车灯开关。"))
	playsound(owned_car, 'sound/items/weapons/magout.ogg', 40, TRUE)

/datum/action/darkpack_car/beep
	name = "Signal"
	desc = "嘀嘀。"
	button_icon_state = "beep"

/datum/action/darkpack_car/beep/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/obj/darkpack_car/owned_car = owner.loc
	if(COOLDOWN_FINISHED(owned_car, beep_cooldown))
		COOLDOWN_START(owned_car, beep_cooldown, 1 SECONDS)
		playsound(owned_car.loc, owned_car.beep_sound, 60, FALSE)

/datum/action/darkpack_car/stage
	name = "Toggle Transmission"
	desc = "在1、2、3挡之间切换。"
	button_icon_state = "stage"

/datum/action/darkpack_car/stage/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/obj/darkpack_car/owned_car = owner.loc
	if(owned_car.stage < 3)
		owned_car.stage = owned_car.stage+1
	else
		owned_car.stage = 1
	to_chat(owner, span_notice("你将[owned_car]挂入了[owned_car.stage]挡。"))

/datum/action/darkpack_car/baggage
	name = "Lock Baggage"
	desc = "锁上或解锁后备箱。"
	button_icon_state = "baggage"

/datum/action/darkpack_car/baggage/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/obj/darkpack_car/vamp_car = owner.loc
	var/datum/storage/trunk_datum = vamp_car.atom_storage
	trunk_datum.set_locked(trunk_datum.locked ? STORAGE_NOT_LOCKED : STORAGE_FULLY_LOCKED)

	//vamp_car.balloon_alert(owner, trunk_datum.locked ? "locked" : "unlocked")
	to_chat(owner, span_notice("你[trunk_datum.locked ? "锁上" : "解锁"]了[vamp_car]的后备箱。"))

	playsound(vamp_car, 'modular_darkpack/master_files/sounds/effects/door/door.ogg', 50, TRUE)

/datum/action/darkpack_car/engine
	name = "Toggle Engine"
	desc = "启动或关闭引擎。"
	button_icon_state = "keys"

/datum/action/darkpack_car/engine/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(isliving(owner))
		var/mob/living/driver = owner
		if(CONFIG_GET(flag/punishing_zero_dots) && driver.st_get_stat(STAT_DRIVE) < 1)
			to_chat(owner, span_danger("你根本不知道该怎么操作！"))
			return FALSE

	if(!ISADVANCEDTOOLUSER(clicker))
		return

	var/obj/darkpack_car/owned_car = owner.loc
	if(!owned_car.on)
		if((owned_car.get_integrity() == owned_car.max_integrity) || (prob(100*(owned_car.get_integrity()/owned_car.max_integrity))))
			owned_car.start_engine()
			to_chat(owner, span_notice("你成功启动了[owned_car]的引擎。"))
			return
		else
			to_chat(owner, span_warning("你没能启动[owned_car]的引擎。"))
			return
	else
		owned_car.stop_engine()
		to_chat(owner, span_notice("你关闭了[owned_car]的引擎。"))
		return

/datum/action/darkpack_car/exit_car
	name = "Exit"
	desc = "离开车辆。"
	button_icon_state = "exit"

/datum/action/darkpack_car/exit_car/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/obj/darkpack_car/owned_car = owner.loc
	if(owned_car.driver == owner)
		owned_car.driver = null
	if(owner in owned_car.passengers)
		owned_car.passengers -= owner
	owner.forceMove(owned_car.loc)

	var/list/exit_side = list(
		SIMPLIFY_DEGREES(owned_car.movement_vector + 90),
		SIMPLIFY_DEGREES(owned_car.movement_vector - 90)
	)
	for(var/angle in exit_side)
		if(get_step(owner, angle2dir(angle)).density)
			exit_side.Remove(angle)
	var/list/exit_alt = GLOB.alldirs.Copy()
	for(var/dir in exit_alt)
		if(get_step(owner, dir).density)
			exit_alt.Remove(dir)
	if(length(exit_side))
		owner.Move(get_step(owner, angle2dir(pick(exit_side))))
	else if(length(exit_alt))
		owner.Move(get_step(owner, exit_alt))

	to_chat(owner, span_notice("你离开了[owned_car]。"))
	if(owner?.client)
		owner.client.pixel_x = 0
		owner.client.pixel_y = 0
	playsound(owned_car, 'modular_darkpack/master_files/sounds/effects/door/door.ogg', 50, TRUE)
	for(var/datum/action/darkpack_car/C in owner.actions)
		qdel(C)
