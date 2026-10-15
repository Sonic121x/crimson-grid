/obj/item/occult_artifact/werewolf/dagger_of_retribution
	name = "铁刀"
	desc = "一把粗糙的铁制小刀。"
	true_name = "复仇短匕"
	true_desc = "一把丑陋的铁匕首，寄宿着复仇之灵。"
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	worn_icon_state = "knife"
	icon_state = "dagger"
	force = 1 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 4
	wound_bonus = 5
	exposed_wound_bonus = 15
	demolition_mod = 0.75
	tool_behaviour = TOOL_KNIFE
	throw_speed = 3
	throw_range = 6
	throwforce = 10
	attack_verb_continuous = list("劈砍", "切割", "撕裂", "划伤", "扯裂", "剁砍", "割伤")
	attack_verb_simple = list("劈砍", "切割", "撕裂", "划伤", "扯裂", "剁砍", "割伤")
	hitsound = 'sound/items/weapons/slash.ogg'
	sharpness = SHARP_EDGED
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	obj_flags = CONDUCTS_ELECTRICITY
	operating_sound = SFX_KNIFE_SLICE
	pickup_sound = SFX_KNIFE_PICKUP
	drop_sound = SFX_KNIFE_DROP
	subsystem_type = /datum/controller/subsystem/processing/fastprocess

	spirit_type = SPIRIT_VENGEANCE

	var/obj/bound_item
	var/spinning = FALSE


/obj/item/occult_artifact/werewolf/dagger_of_retribution/Initialize(mapload)
	. = ..()
	spirit_name = generate_spirit_name(spirit_type)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/Destroy(force)
	stop_live_tracking()
	. = ..()

/obj/item/occult_artifact/werewolf/dagger_of_retribution/identify()
	. = ..()
	say("我是[spirit_name]……失落之物，终将寻回……")

/obj/item/occult_artifact/werewolf/dagger_of_retribution/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("握住匕首，集中精神想着遗失的物品；它会轻轻将你牵向物品所在的方向，直到你将其取回。")
		. += span_purple("其中寄宿着[spirit_name]。")
		if(bound_item)
			. += span_purple("已与[bound_item]绑定。")
			if(iscarbon(loc))
				var/mob/living/carbon/C = loc

				var/obj/item/mainhand = C.get_active_held_item()
				var/obj/item/offhand = C.get_inactive_held_item()

				if(mainhand == src || offhand == src)
					. += span_notice("它正将你牵向[list("north" = "北方", "south" = "南方", "east" = "东方", "west" = "西方", "northeast" = "东北方", "southeast" = "东南方", "northwest" = "西北方", "southwest" = "西南方")[angle2text(targets_angle())]]。")

		. += span_notice("<br/>手持[src]<b>点击</b>物品即可绑定。右键点击[src]可解除绑定。")



/obj/item/occult_artifact/werewolf/dagger_of_retribution/pickup(mob/user)
	. = ..()
	if(bound_item)
		start_live_tracking(user)


/obj/item/occult_artifact/werewolf/dagger_of_retribution/dropped(mob/user, silent = FALSE)
	. = ..()
	stop_live_tracking(user)



/obj/item/occult_artifact/werewolf/dagger_of_retribution/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!identified)
		return NONE

	if(user.combat_mode)
		return NONE

	if(!istype(interacting_with, /obj)) // is it an object?
		if(!istype(interacting_with, /turf))
			to_chat(user, span_warning("[src]拒绝与[interacting_with]绑定！"))
			return ITEM_INTERACT_BLOCKING
		return NONE

	if(bound_item) // do we have an item bound to us already?
		to_chat(user, span_warning("[src]已经与[bound_item]绑定了！"))
		return ITEM_INTERACT_BLOCKING

	// We are clicking on an object, we're on the right intent, and we're not bound.
	bound_item = interacting_with
	start_live_tracking(user)
	return ITEM_INTERACT_SUCCESS


/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/start_live_tracking(mob/user)
	RegisterSignal(bound_item, COMSIG_QDELETING, PROC_REF(stop_live_tracking))

	if(bound_item && user)
		to_chat(user, span_notice("[src]开始将你牵向[bound_item]。"))

/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/stop_live_tracking(mob/user)
	if(!bound_item)
		return

	UnregisterSignal(bound_item, COMSIG_QDELETING)

	if(QDELING(bound_item))
		bound_item = null

	if(user)
		to_chat(user, span_warning("[src]停止了牵引。"))

	var/matrix/M = matrix(0, MATRIX_ROTATE)
	animate(src, transform = M, time = 5, loop = 0)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/process(seconds_per_tick)
	. = ..()
	if(!bound_item)
		return

	var/turf/our_turf = get_turf(src)
	var/turf/bound_item_turf = get_turf(bound_item)

	if(our_turf.z == bound_item_turf.z)
		point_to_target()
		spinning = FALSE
	else if(!spinning)
		SpinAnimation(5, -1)
		spinning = TRUE

/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/point_to_target()
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc

		var/obj/item/mainhand = C.get_active_held_item()
		var/obj/item/offhand = C.get_inactive_held_item()

		if(mainhand == src || offhand == src)
			var/bound_dir = targets_angle()-135
			if(bound_item)
				var/matrix/M = matrix(bound_dir, MATRIX_ROTATE)
				animate(src, transform = M, time = 5, loop = 0)
			else
				stop_live_tracking(C)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/proc/targets_angle()
	var/datum/point/point_a = RETURN_PRECISE_POINT(get_turf(src))
	var/datum/point/point_b = RETURN_PRECISE_POINT(get_turf(bound_item))

	return angle_between_points(point_a, point_b)

/obj/item/occult_artifact/werewolf/dagger_of_retribution/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(bound_item)
		to_chat(user, span_warning("你开始解除[bound_item]与[src]的绑定。"))

		if(do_after(user, 3 SECONDS, src))
			stop_live_tracking(user)
			bound_item = null
