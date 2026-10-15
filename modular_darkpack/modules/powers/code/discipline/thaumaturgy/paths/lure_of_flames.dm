/datum/discipline/path/flames
	name = "Lure of Flames"
	desc = "一条能够召唤火焰的神秘血魔法道途。违反避世戒律。"
	icon_state = "flames"
	power_type = /datum/discipline_power/thaumaturgy/path/flames


/datum/discipline_power/thaumaturgy/path/flames
	name = "Lure of Flames Power Name"
	desc = "Lure of Flames Power Description"

	effect_sound = 'modular_darkpack/modules/paths/sounds/fireball.ogg'
	var/ranged = FALSE
	var/range_successes
	var/flames_range

//V20 core rulebook states that lure of flames can only conjure flames so far depending on successes.
/datum/discipline_power/thaumaturgy/path/flames/pre_activation_checks(atom/target, ranged)
	. = ..()
	if(src.ranged == FALSE)
		return TRUE
	range_successes = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/thaumaturgy, difficulty = (level + 3))
	switch(range_successes)
		if(-INFINITY to 0)
			to_chat(owner, "你无法在手掌以外的地方召出火焰。")
			return FALSE
		if(1)
			flames_range = 2
		if(2)
			flames_range = 3
		if(3)
			flames_range = 5
		if(4 to INFINITY)
			flames_range = 12
	to_chat(owner, span_cult("你掷出了[range_successes]个成功，可在[flames_range]格以内召出火焰。"))

	if (get_dist(owner, target) > flames_range)
		to_chat(owner, span_warning("[target]超出了范围！"))
		return FALSE

//CANDLE - LEVEL 1
/datum/discipline_power/thaumaturgy/path/flames/one
	name = "烛火"
	desc = "召出烛火大小的火苗。可以用来点火，除此之外用处不大。"

	level = 1
	violates_masquerade = TRUE
	toggled = TRUE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/flames/two,
		/datum/discipline_power/thaumaturgy/path/flames/three,
		/datum/discipline_power/thaumaturgy/path/flames/four,
		/datum/discipline_power/thaumaturgy/path/flames/five
	)
	var/list/conjured_candles = list()

/datum/discipline_power/thaumaturgy/path/flames/one/activate()
	. = ..()
	if(.)
		try_deactivate()
		return
	owner.drop_all_held_items()
	var/right_candle = new /obj/item/lighter/conjured/flame/candle(owner)
	var/left_candle = new /obj/item/lighter/conjured/flame/candle(owner)

	owner.put_in_r_hand(right_candle)
	owner.put_in_l_hand(left_candle)

	conjured_candles += WEAKREF(right_candle)
	conjured_candles += WEAKREF(left_candle)

/datum/discipline_power/thaumaturgy/path/flames/one/deactivate()
	. = ..()
	for(var/datum/weakref/candle_ref in conjured_candles)
		var/obj/item/lighter/conjured/flame/candle/candle = candle_ref.resolve()
		if(candle)
			qdel(candle)
	conjured_candles.Cut()

//PALM OF FLAME - Level 2
/datum/discipline_power/thaumaturgy/path/flames/two
	name = "掌中焰"
	desc = "以超自然火焰点燃双手，使拳击附带灼烧伤害。"
	level = 2
	check_flags = DISC_CHECK_CAPABLE
	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 2 TURNS


	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/flames/one,
		/datum/discipline_power/thaumaturgy/path/flames/three,
		/datum/discipline_power/thaumaturgy/path/flames/four,
		/datum/discipline_power/thaumaturgy/path/flames/five
	)

	var/list/conjured_flames = list()

/datum/discipline_power/thaumaturgy/path/flames/two/activate()
	. = ..()
	if(.)
		try_deactivate()
		return

	owner.drop_all_held_items()

	var/right_flame = new /obj/item/lighter/conjured/flame/palm_of_flame(owner)
	var/left_flame = new /obj/item/lighter/conjured/flame/palm_of_flame(owner)

	owner.put_in_r_hand(right_flame)
	owner.put_in_l_hand(left_flame)

	conjured_flames += WEAKREF(right_flame)
	conjured_flames += WEAKREF(left_flame)

/datum/discipline_power/thaumaturgy/path/flames/two/deactivate()
	. = ..()
	for(var/datum/weakref/flame_ref in conjured_flames)
		var/obj/item/lighter/conjured/flame/palm_of_flame/flame = flame_ref.resolve()
		if(flame)
			qdel(flame)
	conjured_flames.Cut()

//CAMPFIRE - Level 3
/datum/discipline_power/thaumaturgy/path/flames/three
	name = "篝火"
	desc = "召出一团篝火大小的火焰，从手中掷出。"

	level = 3
	cooldown_length = 5 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_LIVING
	range = 10
	ranged = TRUE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/flames/one,
		/datum/discipline_power/thaumaturgy/path/flames/two,
		/datum/discipline_power/thaumaturgy/path/flames/four,
		/datum/discipline_power/thaumaturgy/path/flames/five
	)

/datum/discipline_power/thaumaturgy/path/flames/three/activate(mob/living/target)
	. = ..()
	if(.)
		return
	var/turf/start = get_turf(owner)
	var/obj/projectile/flames/H = new(start)
	H.firer = owner
	H.damage = 25 + owner.thaum_damage_plus + success_count
	var/angle = get_angle(owner, target)
	H.fire(angle, target)
	to_chat(target, span_danger("一道灼热的火焰朝你飞来！"))

//ENGULF - Level 4
/datum/discipline_power/thaumaturgy/path/flames/four
	name = "烈焰吞没"
	desc = "让熊熊烈火包围目标，持续造成灼烧伤害。"

	level = 4
	cooldown_length = 10 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_LIVING
	range = 12
	ranged = TRUE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/flames/one,
		/datum/discipline_power/thaumaturgy/path/flames/two,
		/datum/discipline_power/thaumaturgy/path/flames/three,
		/datum/discipline_power/thaumaturgy/path/flames/five
	)

/datum/discipline_power/thaumaturgy/path/flames/four/activate(mob/living/target)
	. = ..()
	if(.)
		return

	var/damage_amount = 25 + owner.thaum_damage_plus + success_count
	target.adjust_fire_loss(damage_amount)

	target.adjust_fire_stacks(4 + success_count)
	target.ignite_mob()

	to_chat(target, span_userdanger("超自然火焰吞没了你！"))
	playsound(get_turf(target), effect_sound, 100, TRUE)

//INFERNO - Level 5
/datum/discipline_power/thaumaturgy/path/flames/five
	name = "火海"
	desc = "释放毁灭性的火焰风暴，波及范围内的多个目标。"

	level = 5
	cooldown_length = 20 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_TURF | TARGET_LIVING
	range = 12
	ranged = TRUE

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/flames/one,
		/datum/discipline_power/thaumaturgy/path/flames/two,
		/datum/discipline_power/thaumaturgy/path/flames/three,
		/datum/discipline_power/thaumaturgy/path/flames/four
	)

/datum/discipline_power/thaumaturgy/path/flames/five/activate(atom/target)
	. = ..()
	if(.)
		return

	to_chat(owner, span_notice("你开始引导一场毁灭性的火焰风暴……"))

	var/turf/center = get_turf(target)

	// minimum one tile away from the center, maximum 3 tiles away from the center
	var/area_range = clamp(success_count, 1, 4)

	// create the inferno warning on all affected turfs in area_range from center
	var/list/affected_turfs = list()
	for(var/turf/T in range(area_range, center))
		affected_turfs += T
		new /obj/effect/temp_visual/inferno_warning(T)
	owner.visible_message(span_warning("火星四溅，温度不断攀升……究竟要发生什么？！"))

	if(!do_after(owner, 4 SECONDS))
		to_chat(owner, span_warning("你的火焰风暴施法被打断了！"))
		for(var/turf/T in affected_turfs) // delete all inferno warnings if casting was interrupted
			for(var/obj/effect/temp_visual/inferno_warning/W in T)
				qdel(W)
		return

	// damage dealt to those standing in the zone is based on successes and so are the fire stacks
	var/base_damage = 20 + (success_count * 5) + owner.thaum_damage_plus
	var/fire_stacks_amount = 3 + success_count
	var/ignite_chance = min(60 + (success_count * 10), 95) // 60% base, +10% per success, max 95%

	// casting succeeded
	for(var/turf/T in affected_turfs)
		// remove inferno warning and insert the actual fire objects
		for(var/obj/effect/temp_visual/inferno_warning/W in T)
			qdel(W)
		new /obj/effect/abstract/turf_fire(T)

		// Damage all mobs on each tile
		for(var/mob/living/L in T)
			if(L == owner) // Don't damage self - but caster still gets set on fire
				continue

			L.adjust_fire_loss(base_damage)

			// Chance to ignite based on successes
			if(prob(ignite_chance))
				L.adjust_fire_stacks(fire_stacks_amount)
				L.ignite_mob()

			to_chat(L, span_userdanger("你被卷入了超自然的火焰风暴！"))

	playsound(center, effect_sound, 100, TRUE)
	owner.visible_message(span_danger("[owner]释放了一场毁灭性的火焰风暴！"))

	// Show success-based feedback to caster
	switch(success_count)
		if(1)
			to_chat(owner, span_bolddanger("你的火焰风暴燃烧着，火势尚不猛烈。"))
		if(2)
			to_chat(owner, span_bolddanger("你的火焰风暴猛烈肆虐。"))
		if(3 to INFINITY)
			to_chat(owner, span_bolddanger("你的火焰风暴以毁灭性的超自然怒焰熊熊燃烧！"))

// Warning overlay object
/obj/effect/temp_visual/inferno_warning
	name = "烈火将至"
	desc = "危险的高温使空气扭曲。这里即将发生可怕的事情！"
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	alpha = 150
	duration = 2 SECONDS // Matches the channel time

/obj/effect/temp_visual/inferno_warning/Initialize(mapload)
	. = ..()
	// pulsing animation
	animate(src, alpha = 50, time = 10, loop = -1)
	animate(alpha = 200, time = 10)

	// warning message sent to mobs that stand on the tile
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(warn_entering_mob))

/obj/effect/temp_visual/inferno_warning/proc/warn_entering_mob(datum/source, atom/movable/entered)
	SIGNAL_HANDLER

	if(isliving(entered))
		var/mob/living/L = entered
		to_chat(L, span_warning("你感到强烈的超自然热量正在这片区域积聚！"))

// Projectile for Flame Bolt
/obj/projectile/flames
	name = "火焰"
	icon = 'icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "fireball"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 20
	damage_type = BURN
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	//flag = LASER
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_ORANGE
	ricochets_max = 0
	ricochet_chance = 0

/obj/projectile/flames/on_hit(atom/target, blocked = FALSE, pierce_hit)
	. = ..()
	if(!isliving(target))
		return
	var/mob/living/L = target
	// Chance to ignite target
	if(prob(10))
		L.adjust_fire_stacks(2)
		L.ignite_mob()
	if(prob(10))
		var/target_turf = get_turf(L)
		new /obj/effect/abstract/turf_fire(target_turf)
	L.visible_message(span_danger("超自然火焰击中了[target]！"), span_userdanger("超自然火焰灼烧着你！"))
	playsound(get_turf(target), 'modular_darkpack/modules/paths/sounds/fireball.ogg', 50, TRUE)
