/datum/discipline/obtenebration
	name = "Obtenebration"
	desc = {"操纵周围的黑暗。
● 弄影术：被动
●● 夜幕遮蔽：操控 + 神秘学（难度 7）
●●● 深渊之臂：操控 + 神秘学（难度 7）
●●●● 黑暗蜕变：操控 + 勇气（难度 7）
●●●●● 暗影形态：被动"}
	icon_state = "obtenebration"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/obtenebration
	signature_clan = VAMPIRE_CLAN_LASOMBRA

/datum/discipline/obtenebration/post_gain()
	. = ..()
	var/datum/action/ritual_drawing/mysticism/mystic = new()
	mystic.Grant(owner)
	mystic.level = level

/datum/discipline/obtenebration/post_loss()
	. = ..()
	for(var/datum/action/action as anything in owner.actions)
		if(istype(action, /datum/action/ritual_drawing/mysticism))
			qdel(action)

/datum/discipline_power/obtenebration
	name = "Obtenebration power name"
	desc = "Obtenebration power description"

	effect_sound = 'sound/effects/magic/voidblink.ogg'

/obj/item/ammo_casing/magic/tentacle/lasombra
	projectile_type = /obj/projectile/tentacle/lasombra
	icon_state = ""

/obj/projectile/tentacle/lasombra
	icon = 'icons/effects/beam.dmi'
	damage_type = BURN
	icon_state = "curse0"

/datum/discipline_power/obtenebration/shadow_play
	name = "弄影术"
	desc = "操纵阴影，遮挡视线。"

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_TURF | TARGET_MOB | TARGET_OBJ | TARGET_SELF
	range = 7
	vitae_cost = 1

	multi_activate = TRUE
	duration_length = 1 SCENES
	cooldown_length = 1 TURNS
	frenzy_usable = FALSE

	var/list/shadows = list() // A list of all active shadows
	var/datum/action/clear_shadows/cbutton // The button to clear everything

/datum/discipline_power/obtenebration/shadow_play/activate(target)
	. = ..()
	var/atom/movable/new_shadow = new(target)
	new_shadow.set_light(discipline.level+2, -10) // Ideally, the shadows would be a special thing impenetrable by anyone but the user, but this works for now
	shadows += new_shadow

	if(!cbutton) // Grant the button if it doesn't exist
		cbutton = new(src)
		cbutton.Grant(owner)

	addtimer(CALLBACK(src, .proc/remove_shadow, new_shadow), duration_length) // 3 minute timer per shadow

/datum/discipline_power/obtenebration/shadow_play/proc/remove_shadow(atom/movable/old_shadow)
	if(old_shadow && (old_shadow in shadows)) // Check if shadow still exists
		shadows -= old_shadow
		qdel(old_shadow)

	if(!length(shadows) && cbutton) // Remove the button if there are no shadows left
		cbutton.Remove(owner)
		QDEL_NULL(cbutton)

/datum/discipline_power/obtenebration/shadow_play/proc/remove_all_shadows()
	for(var/atom/movable/all_shadows in shadows)
		qdel(all_shadows)
	shadows.Cut()

	if(cbutton)
		cbutton.Remove(owner)
		QDEL_NULL(cbutton)

/datum/discipline_power/obtenebration/shroud_of_night
	name = "夜幕遮蔽"
	desc = "将阴影化作肢体，拖拽敌人。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_LYING | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB
	range = 7
	vitae_cost = 0

	aggravating = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS

/datum/discipline_power/obtenebration/shroud_of_night/pre_activation_checks(atom/target)
	if(SSroll.storyteller_roll_datum(owner, difficulty = 7, applic_stats = list(STAT_MANIPULATION, STAT_OCCULT)))
		return TRUE
	return FALSE

/datum/discipline_power/obtenebration/shroud_of_night/activate(mob/living/target)
	. = ..()
	target.Stun(1 SECONDS)
	var/obj/item/ammo_casing/magic/tentacle/lasombra/casing = new (owner.loc)
	casing.fire_casing(target, owner, null, null, null, ran_zone(), 0,  owner)

/datum/discipline_power/obtenebration/arms_of_the_abyss
	name = "深渊之臂"
	desc = "以阴影为臂，从远处伤害并抓住他人。"

	level = 3
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_TURF
	range = 7

	violates_masquerade = TRUE
	cooldown_length = 1 TURNS

	var/list/active_tentacles = list()
	var/aggro_mode = ABYSS_TENTACLE_MODE_AGGRESSIVE

/datum/discipline_power/obtenebration/arms_of_the_abyss/activate(atom/target)
	. = ..()
	var/turf/target_turf = get_turf(target)

	if(target_turf && target_turf.get_lumcount() <= 0.4)
		// Remove any existing tentacles first
		for(var/mob/living/basic/abyss_tentacle/T in active_tentacles)
			if(T && !QDELETED(T))
				T.release_grabbed_mob()
				qdel(T)
		active_tentacles.Cut()

		var/roll = SSroll.storyteller_roll_datum(owner, difficulty = 7, applic_stats = list(STAT_MANIPULATION, STAT_OCCULT), numerical = TRUE)
		var/has_action = !!(locate(/datum/action/aggro_mode) in owner.actions)

		if(!has_action)
			var/datum/action/aggro_mode/A = new(src)
			A.Grant(owner)

		// Create tentacles based on successes
		for(var/i in 1 to roll)
			var/mob/living/basic/abyss_tentacle/new_tentacle
			// For the first tentacle, use the target turf
			if(i == 1 && !target_turf.is_blocked_turf(exclude_mobs = TRUE))
				new_tentacle = new /mob/living/basic/abyss_tentacle(target_turf, owner)
			else
				// For additional tentacles, find nearby valid turfs
				var/list/open_turfs = list()
				for(var/turf/T in orange(3, target_turf))
					if(!T.is_blocked_turf(exclude_mobs = TRUE) && T.get_lumcount() <= 0.4)
						open_turfs += T
				if(open_turfs.len)
					new_tentacle = new /mob/living/basic/abyss_tentacle(pick(open_turfs), owner)

			// if we ended up making a new tentacle add it to our list and inherit set aggro_mode
			if(new_tentacle)
				new_tentacle.ai_controller?.set_blackboard_key(BB_ABYSS_TENTACLE_MODE, aggro_mode)
				active_tentacles += new_tentacle
	else
		to_chat(usr, span_warning("这片区域太亮，阴影无法显现！"))
		return FALSE

/datum/discipline_power/obtenebration/black_metamorphosis
	name = "黑暗蜕变"
	desc = "与内在的黑暗融合，获得暗影护甲。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	vitae_cost = 2

	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 999 SCENES

	var/activating = FALSE
	var/successful = FALSE

/datum/discipline_power/obtenebration/black_metamorphosis/pre_activation_checks()
	. = ..()
	if(activating) // Prevent multi-activation while the do_after is ongoing
		to_chat(owner, span_warning("你已经在尝试施展黑暗蜕变了！"))
		return FALSE

	if(owner.get_generation() >= 10)
		activating = TRUE
		to_chat(owner, span_warning("你的身体开始与阴影融合……"))
		if(do_after(owner, 2 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.get_generation() <= 9)
		activating = TRUE
		to_chat(owner, span_warning("你的身体开始迅速与阴影融合……"))
		if(do_after(owner, 1 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE

/datum/discipline_power/obtenebration/black_metamorphosis/activate()
	. = ..()
	activating = FALSE
	var/roll = SSroll.storyteller_roll_datum(owner, difficulty = 7, applic_stats = list(STAT_MANIPULATION, STAT_COURAGE))
	switch(roll)
		if(ROLL_SUCCESS)
			successful = TRUE
			owner.damage_resistance += 40 // CRIMSON EDIT ADD - Makes Obtenebration not as strong as some other stuff
			animate(owner, color = "#000000", time = 1 SECONDS, loop = 1)
			to_chat(owner, span_green("你成功与阴影融为一体！"))
		if(ROLL_FAILURE)
			to_chat(owner, span_warning("你未能控制住阴影！"))
			deactivate()
		if(ROLL_BOTCH)
			owner.apply_damage(60, BRUTE) // 2 levels of lethal damage on a botch
			to_chat(owner, span_danger("你未能与阴影融合，反遭它们袭击！"))
			deactivate()

/datum/discipline_power/obtenebration/black_metamorphosis/deactivate()
	. = ..()
	if(!successful)
		return
	to_chat(owner, span_notice("阴影从你的身体上褪去。"))
	playsound(owner.loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
	owner.damage_resistance -= 40 // CRIMSON EDIT - Reduces Strength of Obetenebration 4
	animate(owner, color = initial(owner.color), time = 1 SECONDS, loop = 1)

/datum/discipline_power/obtenebration/tenebrous_form
	name = "暗影形态"
	desc = "化身为阴影，抵御除火焰、阳光和魔法以外的一切伤害！"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	vitae_cost = 3
	duration_length = 999 SCENES
	toggled = TRUE

	violates_masquerade = TRUE

	cooldown_length = 1 TURNS
	var/activating = FALSE
	var/saved_density

/datum/discipline_power/obtenebration/tenebrous_form/pre_activation_checks()
	. = ..()
	if(activating) // Prevent multi-activation while the do_after is ongoing
		to_chat(owner, span_warning("你已经在尝试进入暗影形态了！"))
		return FALSE

	// do_after timer based on generation; gen 9 and below can spend more BP per turn, so it activates faster
	if(owner.get_generation() >= 10)
		activating = TRUE
		to_chat(owner, span_warning("你的身体开始缓缓化为一团墨色阴影……"))
		if(do_after(owner, 3 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.get_generation() == 9)
		activating = TRUE
		to_chat(owner, span_warning("你的身体开始化为一团墨色阴影……"))
		if(do_after(owner, 2 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE
	else if(owner.get_generation() <= 8)
		activating = TRUE
		to_chat(owner, span_warning("你的身体开始迅速化为一团墨色阴影……"))
		if(do_after(owner, 1 TURNS, timed_action_flags = (IGNORE_USER_LOC_CHANGE | IGNORE_TARGET_LOC_CHANGE | IGNORE_HELD_ITEM)))
			return TRUE

/datum/discipline_power/obtenebration/tenebrous_form/activate()
	. = ..()
	activating = FALSE
	playsound(owner.loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
	MODIFY_PHYSIOLOGY(owner, BRUTE, 0.1)
	MODIFY_PHYSIOLOGY(owner, BURN, 2)
	MODIFY_PHYSIOLOGY(owner, AGGRAVATED, 0.1)
	MODIFY_PHYSIOLOGY(owner, STAMINA, 0.1)
	MODIFY_PHYSIOLOGY(owner, BRAIN, 0.1)
	animate(owner, color = "#000000", time = 1 SECONDS, loop = 1)

	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOBLOOD, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_PACIFISM, MAGIC_TRAIT) // Can't physically attack while in this form
	//ADD_TRAIT(owner, TRAIT_MOVE_FLYING, MAGIC_TRAIT) // Flying to simulate being unaffected by gravity
	ADD_TRAIT(owner, TRAIT_PIERCEIMMUNE, MAGIC_TRAIT)	//Stops bullets from embedding and taser electrodes no longer connect
	owner.pass_flags |= (PASSDOORS | PASSTABLE | PASSSTRUCTURE) // Phase through doors & fences / tables / machines, dumpsters, barrels, lampposts


	saved_density = owner.density
	owner.density = FALSE

/datum/discipline_power/obtenebration/tenebrous_form/deactivate()
	. = ..()
	to_chat(owner, span_notice("你恢复了原本的形态。"))
	playsound(owner.loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
	MODIFY_PHYSIOLOGY(owner, BRUTE, 10)
	MODIFY_PHYSIOLOGY(owner, BURN, 0.5)
	MODIFY_PHYSIOLOGY(owner, AGGRAVATED, 10)
	MODIFY_PHYSIOLOGY(owner, STAMINA, 10)
	MODIFY_PHYSIOLOGY(owner, BRAIN, 10)
	animate(owner, color = initial(owner.color), time = 1 SECONDS, loop = 1)

	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOBLOOD, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, MAGIC_TRAIT)
	//REMOVE_TRAIT(owner, TRAIT_MOVE_FLYING, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_PIERCEIMMUNE, MAGIC_TRAIT)	//Stops bullets from embedding and taser electrodes no longer connect
	owner.pass_flags &= ~(PASSDOORS | PASSTABLE | PASSSTRUCTURE)

	owner.density = saved_density

//ACTIONS

// Aggro mode control for Arms of the Abyss
/datum/action/aggro_mode
	name = "触须控制"
	desc = "切换深渊之臂的攻击模式。"
	button_icon = 'modular_darkpack/master_files/icons/hud/screen_gen.dmi'
	button_icon_state = "harm"
	var/current_mode = ABYSS_TENTACLE_MODE_AGGRESSIVE
	var/datum/discipline_power/obtenebration/arms_of_the_abyss/abyss_power

/datum/action/aggro_mode/New(Target)
	. = ..()
	abyss_power = Target
	current_mode = abyss_power.aggro_mode

/datum/action/aggro_mode/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	if(!owner || !isliving(owner))
		return

	var/mob/living/carbon/human/tentacle_owner = owner

	if(!istype(tentacle_owner))
		return

	var/list/options = list(
		"攻击（抓住并伤害目标）" = ABYSS_TENTACLE_MODE_AGGRESSIVE,
		"控制（抓住并束缚目标，不造成伤害）" = ABYSS_TENTACLE_MODE_CONTROL,
		"被动（不攻击或抓取）" = ABYSS_TENTACLE_MODE_PASSIVE
	)

	var/select = options[tgui_input_list(tentacle_owner, "选择触须的行为", "触须模式", options)]
	if(!select || !tentacle_owner)
		return
	if(!abyss_power)
		return
	abyss_power.aggro_mode = select
	current_mode = select

	var/tentacles = 0
	for(var/mob/living/basic/abyss_tentacle/T in abyss_power?.active_tentacles)
		if(T && !QDELETED(T))
			var/was_passive = (T.ai_controller?.blackboard[BB_ABYSS_TENTACLE_MODE] == ABYSS_TENTACLE_MODE_PASSIVE)
			T.ai_controller?.set_blackboard_key(BB_ABYSS_TENTACLE_MODE, abyss_power.aggro_mode)
			tentacles++

			if(select == ABYSS_TENTACLE_MODE_PASSIVE && T.ai_controller?.blackboard[BB_ABYSS_TENTACLE_GRABBED])
				T.release_grabbed_mob()
			else if(was_passive && select != ABYSS_TENTACLE_MODE_PASSIVE)
				T.recently_released.Cut()

	if(tentacles)
		to_chat(tentacle_owner, span_notice("你将触须设为[list(ABYSS_TENTACLE_MODE_AGGRESSIVE = "攻击", ABYSS_TENTACLE_MODE_CONTROL = "控制", ABYSS_TENTACLE_MODE_PASSIVE = "被动")[select]]模式。"))
		update_button_icon()

/datum/action/aggro_mode/proc/update_button_icon()
	switch(current_mode)
		if(ABYSS_TENTACLE_MODE_AGGRESSIVE)
			button_icon_state = "harm"
		if(ABYSS_TENTACLE_MODE_CONTROL)
			button_icon_state = "grab"
		if(ABYSS_TENTACLE_MODE_PASSIVE)
			button_icon_state = "disarm"
	build_all_button_icons()

// Shadow removal button for Shadow Play
/datum/action/clear_shadows
	name = "消散阴影"
	desc = "消散当前所有由弄影术创造的阴影。"
	button_icon = 'icons/mob/effects/genetics.dmi'
	button_icon_state = "shadow_portal"
	var/datum/discipline_power/obtenebration/shadow_play/power

/datum/action/clear_shadows/New(Target)
	. = ..()
	power = Target

/datum/action/clear_shadows/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	if(!power)
		return FALSE
	power.remove_all_shadows()

