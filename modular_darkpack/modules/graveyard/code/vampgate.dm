/obj/structure/vampgate
	name = "墓园大门"
	desc = "可以打开，也可以关上。"
	icon = 'modular_darkpack/modules/graveyard/icons/gate.dmi'
	icon_state = "gate"
	pixel_x = -32
	base_pixel_x = -32
	anchored = TRUE
	density = TRUE
	max_integrity = 500
	prevent_destruction = TRUE

	var/repairing = FALSE

/obj/structure/vampgate/Initialize(mapload)
	. = ..()
	var/turf/right_turf = get_step(src, EAST)
	var/turf/left_turf = get_step(src, WEST)
	if(right_turf)
		right_turf.set_density(TRUE)
	if(left_turf)
		left_turf.set_density(TRUE)

/obj/structure/vampgate/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(!broken)
		if(sound_effect)
			playsound(get_turf(src), 'modular_darkpack/master_files/sounds/effects/door/get_bent.ogg', 100, FALSE)

		shake_gate()

		if(atom_integrity <= 0)
			break_open()

/obj/structure/vampgate/atom_destruction(damage_flag)
	. = ..()
	break_open()

/obj/structure/vampgate/proc/shake_gate()
	pixel_z += rand(-1, 1)
	pixel_w += rand(-1, 1)
	addtimer(CALLBACK(src, PROC_REF(reset_position)), 0.2 SECONDS)

/obj/structure/vampgate/proc/reset_position()
	pixel_z = initial(pixel_z)
	pixel_w = initial(pixel_w)

/obj/structure/vampgate/proc/break_open()
	if(broken)
		return

	broken = TRUE
	density = FALSE
	icon_state = "gate-open"
	visible_message(span_boldwarning("[src]破损，敞开了！"))

/obj/structure/vampgate/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/melee/vamp/tire))
		attempt_repair(user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/vamp/keys/graveyard))
		if(!density && broken)
			to_chat(user, span_warning("大门已经损坏，歪斜地敞着，急需修理。"))
			return ITEM_INTERACT_SUCCESS
		if(!density && !broken)
			to_chat(user, span_notice("你开始关门……"))
			if(do_after(user, 5 SECONDS, src))
				density = TRUE
				icon_state = "gate"
				to_chat(user, span_notice("你关上了大门。"))
			else
				to_chat(user, span_notice("你走开了。"))
		else
			to_chat(user, span_notice("你开始开门……"))
			if(do_after(user, 5 SECONDS, src))
				density = FALSE
				icon_state = "gate-open"
				to_chat(user, span_notice("你打开了大门。"))
			else
				to_chat(user, span_notice("你走开了。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/vampgate/proc/attempt_repair(mob/living/user)
	if(repairing)
		to_chat(user, span_warning("已经有人在修理[src]了！"))
		return

	if(atom_integrity >= max_integrity)
		to_chat(user, span_notice("[src]已经完好如初了。"))
		return

	repairing = TRUE

	if(do_after(user, 5 SECONDS, src))
		repair_damage(50)

		if(atom_integrity > 0 && broken)
			broken = FALSE
			density = TRUE
			icon_state = "gate"
			visible_message(span_notice("[src]修好了，重新关上了！"))

		playsound(src, 'modular_darkpack/master_files/sounds/effects/repair.ogg', 50, TRUE)
		to_chat(user, span_notice("你修复了[src]的部分损伤。（[atom_integrity]/[max_integrity]）"))
	else
		to_chat(user, span_warning("你停止修理[src]。"))

	repairing = FALSE
