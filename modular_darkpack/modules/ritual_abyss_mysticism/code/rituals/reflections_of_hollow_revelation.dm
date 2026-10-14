/datum/storyteller_roll/reflections_of_hollow
	difficulty = 7
	applicable_stats = list(STAT_PERCEPTION, STAT_OCCULT)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation
	name = "空寂启示之映"
	desc = "借助召出的夜幕之窗，从目标附近的暗影中窥视目标。"
	icon_state = "teleport"
	word = ""
	level = 4
	cost = 1
	var/datum/action/close_window/end_action
	var/mob/living/nocturne_user
	var/obj/shadow_window/shadow_window
	var/mob/living/carbon/human/window_target
	var/isactive = FALSE

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/complete()
	. = ..()
	var/mob/living/user = usr
	if(!user)
		return

	if(isactive)
		to_chat(user, span_warning("这扇夜幕之窗已在使用中！"))
		return

	// Target input
	var/target_name = tgui_input_text(user, "输入目标姓名：", "空寂启示之映")
	if(!target_name || !user.Adjacent(src))
		to_chat(user, span_warning("你必须指定一个目标，并留在符文附近！"))
		return

	user.say("VISTA'DE'SOMBRA")

	// Find the target
	for(var/mob/living/carbon/human/targ in GLOB.player_list)
		if(targ.real_name == target_name)
			window_target = targ
			break

	if(!window_target)
		to_chat(user, span_warning("未找到[target_name]。"))
		return

	var/roll_result = SSroll.storyteller_roll_datum(user, roll_datum = /datum/storyteller_roll/reflections_of_hollow)
	switch(roll_result)
		if(ROLL_SUCCESS)
			scry_target(window_target, user)
			playsound(user, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			isactive = TRUE
		if(ROLL_FAILURE)
			qdel(src)
			to_chat(user, span_warning("夜幕之窗崩塌了！"))
		if(ROLL_BOTCH)
			qdel(src)
			to_chat(user, span_warning("你感觉精力被抽空了……"))
			for(var/datum/st_stat/stat as anything in subtypesof(/datum/st_stat))
				user.st_add_stat_mod(stat, -2, "reflections_of_hollow_revelation")
			addtimer(CALLBACK(src, PROC_REF(restore_stats), user), 1 SCENES)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/restore_stats(mob/living/user)
	for(var/datum/st_stat/stat as anything in subtypesof(/datum/st_stat))
		user.st_remove_stat_mod(stat, "reflections_of_hollow_revelation")

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/scry_target(mob/living/carbon/human/target, mob/living/user)
	// If the target has Obtenebration or Auspex, roll to see if they detect the shadows
	if(get_kindred_splat(target))
		var/datum/splat/vampire/vampire = get_splat_with_discipline(target)
		if(vampire?.get_discipline(/datum/discipline/obtenebration) || vampire?.get_discipline(/datum/discipline/auspex))
			if(SSroll.storyteller_roll_datum(target, roll_datum = /datum/storyteller_roll/reflections_of_hollow, difficulty = 8) == ROLL_SUCCESS)
				to_chat(target, span_warning("你注意到附近的暗影闪烁不定……有什么东西正在窥视你。"))

	shadowview(target, user)
	to_chat(user, span_notice("你透过[target.name]附近的暗影窥视……"))

	addtimer(CALLBACK(src, PROC_REF(on_end),user), 1 SCENES) // 3 minute timer, AKA 1 Scene

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/shadowview(mob/living/target, mob/user)
	nocturne_user = user
	//user.notransform = TRUE

	// Create camera
	shadow_window = new(get_turf(target), src)
	user.reset_perspective(shadow_window)

	// Give button to end viewing
	end_action = new(src)
	end_action.Grant(user)

	RegisterSignal(user, COMSIG_MOB_RESET_PERSPECTIVE, PROC_REF(on_end))
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(check_target_distance))

	to_chat(user, span_notice("你正在透过暗影视物。使用“结束窥视”动作即可停止。"))

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/check_target_distance()
	SIGNAL_HANDLER
	if(!window_target || !shadow_window)
		return

	// Window closes when target leaves range
	if(get_dist(window_target, shadow_window) > 7)
		if(nocturne_user)
			to_chat(nocturne_user, span_warning("随着[window_target.name]远离暗影，夜幕之窗关闭了。"))
		on_end(nocturne_user)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/on_end(mob/user)
	SIGNAL_HANDLER
	if(user == nocturne_user)
		close_window(user)

/obj/ritual_rune/abyss/reflections_of_hollow_revelation/proc/close_window(mob/user)
	if(!user)
		return

	//user.notransform = FALSE

	if(user.client?.eye != user)
		user.reset_perspective()

	if(end_action)
		end_action.Remove(user)
		QDEL_NULL(end_action)

	if(window_target)
		UnregisterSignal(window_target, COMSIG_MOVABLE_MOVED)

	QDEL_NULL(shadow_window)
	qdel(src)
	UnregisterSignal(user, COMSIG_MOB_RESET_PERSPECTIVE)

	nocturne_user = null
	to_chat(user, span_notice("你停止透过召出的夜幕之窗观察。"))
	playsound(user, 'sound/effects/magic/ethereal_exit.ogg', 50, FALSE)

// Camera object
/obj/shadow_window
	name = "Shadow"
	desc = "A shadow..."
	icon = 'icons/effects/effects.dmi'
	icon_state = ""
	invisibility = INVISIBILITY_ABSTRACT
	layer = CAMERA_STATIC_PLANE
	var/obj/ritual_rune/abyss/reflections_of_hollow_revelation/parent_rune

/obj/shadow_window/Initialize(mapload, obj/ritual_rune/abyss/reflections_of_hollow_revelation/rune)
	. = ..()
	parent_rune = rune

/obj/shadow_window/Destroy()
	if(parent_rune && parent_rune.shadow_window == src)
		parent_rune.shadow_window = null
	parent_rune = null
	return ..()

// Action button
/datum/action/close_window
	name = "结束窥视"
	desc = "停止透过暗影观察。"
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "camera_off"
	var/obj/ritual_rune/abyss/reflections_of_hollow_revelation/parent_rune

/datum/action/close_window/New(obj/ritual_rune/abyss/reflections_of_hollow_revelation/rune)
	..()
	parent_rune = rune

/datum/action/close_window/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	if(!parent_rune || !usr)
		return
	parent_rune.close_window(usr)

/datum/action/close_window/Remove(mob/user)
	if(parent_rune && parent_rune.end_action == src)
		parent_rune.end_action = null
	parent_rune = null
	. = ..()
	qdel(src)
