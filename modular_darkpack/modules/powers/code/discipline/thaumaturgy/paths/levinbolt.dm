/datum/discipline/path/levinbolt
	name = "Path of the Levinbolt"
	desc = "一条能够操纵雷电的基础血魔法道途。违反避世戒律。"
	icon_state = "levinbolt"
	power_type = /datum/discipline_power/thaumaturgy/path/levinbolt

/datum/discipline_power/thaumaturgy/path/levinbolt
	name = "Path of the Levinbolt Power Name"
	desc = "Path of the Levinbolt Power Description"

	effect_sound = 'sound/effects/magic/lightningbolt.ogg'

	var/light_range = 0
	var/light_power = 0
	var/light_color = null
	var/electricity_overlay_state = null

/datum/discipline_power/thaumaturgy/path/levinbolt/activate()
	. = ..()
	if(.)
		return

	if(electricity_overlay_state)
		var/mutable_appearance/electricity = mutable_appearance('icons/effects/effects.dmi', electricity_overlay_state, EFFECTS_LAYER)
		owner.add_overlay(electricity)

	if(light_range && light_power)
		owner.light_system = OVERLAY_LIGHT
		owner.AddComponent(/datum/component/overlay_lighting, light_range, light_power, light_color, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/deactivate()
	. = ..()

	if(electricity_overlay_state && owner)
		var/mutable_appearance/electricity = mutable_appearance('icons/effects/effects.dmi', electricity_overlay_state, EFFECTS_LAYER)
		owner.cut_overlay(electricity)

	if(owner)
		var/datum/component/overlay_lighting/light_comp = owner.GetComponent(/datum/component/overlay_lighting)
		if(light_comp)
			qdel(light_comp)
		owner.light_system = initial(owner.light_system)

/datum/discipline_power/thaumaturgy/path/levinbolt/Destroy()
	if(owner)
		var/datum/component/overlay_lighting/light_comp = owner.GetComponent(/datum/component/overlay_lighting)
		if(light_comp)
			qdel(light_comp)
		owner.light_system = initial(owner.light_system)
	return ..()


// levinbolt allows for the user to click on certain electronics, disabling them, like radios while people are still wearing them, warehouse computer, fuseboxes.
/datum/discipline_power/thaumaturgy/path/levinbolt/proc/levinbolt_target_click(mob/source, atom/target, params, include_radio_effects = FALSE)
	if(!active || !toggled)
		return

	if(!target || get_dist(owner, target) > 1)
		return

	// disable radios, only used in levinbolt 3 and 5
	if(include_radio_effects && ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/disabled_any = FALSE

		for(var/obj/item/radio/headset/darkpack/radio in human_target.get_contents())
			if(radio.is_on())
				radio.set_on(FALSE)
				human_target.visible_message(
					span_warning("[human_target]的[radio.name]爆出猛烈的电火花，随后关机了！"),
					span_warning("你的[radio.name]爆出猛烈的电火花，随后关机了！"),
				)
				playsound(human_target, 'sound/effects/sparks/sparks4.ogg', 60, TRUE)
				disabled_any = TRUE
			else
				radio.set_on(TRUE)
				human_target.visible_message(
					span_warning("电流涌入[human_target]的[radio.name]，将它启动了！"),
					span_warning("电流涌入你的无线电，将它启动了！"),
				)
				playsound(human_target, 'sound/effects/sparks/sparks4.ogg', 60, TRUE)
				disabled_any = TRUE

		if(disabled_any)
			var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(human_target), 5, 1)
			spark_system.start()
			return TRUE

	// Warehouse computer 'hacking'
	if(istype(target, /obj/machinery/computer/cargo/express))
		var/obj/machinery/computer/cargo/express/cargo_comp = target
		cargo_comp.locked = !cargo_comp.locked

		// sparks
		var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(target), 3, 1)
		spark_system.start()
		playsound(target, 'sound/effects/sparks/sparks4.ogg', 50, TRUE)

		owner.visible_message(span_warning("[owner]将电火花注入[target]！"))
		return TRUE

	// Fusebox short-circuiting
	if(istype(target, /obj/fusebox))
		var/obj/fusebox/fuse = target

		// Break the fusebox
		fuse.take_damage(101)
		fuse.power_off()

		var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(target), 5, 1)
		spark_system.start()
		playsound(target, 'sound/effects/sparks/sparks2.ogg', 75, TRUE)

		owner.visible_message(span_warning("[owner]将一股强电流注入[target]！"))

		if(prob(15))
			owner.electrocute_act(10, target, siemens_coeff = 1, flags = NONE)
			to_chat(owner, span_warning("回流的电流击中了你！"))

		return TRUE

	return FALSE

//SPARK - Level 1
/datum/discipline_power/thaumaturgy/path/levinbolt/one
	name = "电火花"
	desc = "受到攻击时释放微弱电流，也可对物品施展以干扰其电子元件。"

	level = 1
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_CONSCIOUS
	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 2 TURNS

	light_range = 2
	light_power = 1
	light_color = "#f1fdfd"
	electricity_overlay_state = "electricity"

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/levinbolt/three,
		/datum/discipline_power/thaumaturgy/path/levinbolt/five
	)

/datum/discipline_power/thaumaturgy/path/levinbolt/one/activate()
	. = ..()
	if(.)
		try_deactivate()
		return

	//signal for counterattack
	RegisterSignal(owner, COMSIG_ATOM_ATTACKBY, PROC_REF(spark_counter))

	//signal for disabling electronics
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(spark_target_click))

	to_chat(owner, span_notice("细小的电火花开始在你周围噼啪作响！现在你只需触碰便能关闭某些电气系统，攻击你的人也可能受到轻微电击。"))

/datum/discipline_power/thaumaturgy/path/levinbolt/one/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_ATOM_ATTACKBY)
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)
	to_chat(owner, span_notice("你周围的电流消散了。"))

/datum/discipline_power/thaumaturgy/path/levinbolt/one/proc/spark_counter(mob/source, obj/item/weapon, mob/living/attacker)
	SIGNAL_HANDLER

	if(prob(30))
		attacker.adjust_jitter_up_to(4 SECONDS, 15)
		if(ishuman(attacker))
			var/mob/living/carbon/human/H = attacker
			H.electrocution_animation(40)
		attacker.Stun(1 SECONDS)

/datum/discipline_power/thaumaturgy/path/levinbolt/one/proc/spark_target_click(mob/source, atom/target, params)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(levinbolt_target_click), source, target, params, FALSE)

//ILLUMINATE - Level 2
/datum/discipline_power/thaumaturgy/path/levinbolt/two
	name = "照明"
	desc = "将一股适量的电能注入手中。"
	level = 2
	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 2 TURNS

	var/list/conjured_illuminates = list()

/datum/discipline_power/thaumaturgy/path/levinbolt/two/activate(mob/living/target)
	. = ..()
	if(.)
		try_deactivate()
		return
	owner.drop_all_held_items()

	var/right_illuminate = new /obj/item/lighter/conjured/levinbolt_arm(owner)
	var/left_illuminate = new /obj/item/lighter/conjured/levinbolt_arm(owner)

	owner.put_in_r_hand(right_illuminate)
	owner.put_in_l_hand(left_illuminate)

	conjured_illuminates += WEAKREF(right_illuminate)
	conjured_illuminates += WEAKREF(left_illuminate)

/datum/discipline_power/thaumaturgy/path/levinbolt/two/deactivate()
	. = ..()
	for(var/datum/weakref/illuminate_ref in conjured_illuminates)
		var/obj/item/lighter/conjured/levinbolt_arm/illuminate = illuminate_ref.resolve()
		if(illuminate)
			qdel(illuminate)
	conjured_illuminates.Cut()

//POWER ARRAY - Level 3
/datum/discipline_power/thaumaturgy/path/levinbolt/three
	name = "电能阵列"
	desc = "向周围释放更强的电能。"

	level = 3
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_CONSCIOUS
	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 2 TURNS

	light_range = 3
	light_power = 2
	light_color = "#e9ffff"
	electricity_overlay_state = "electricity3"

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/levinbolt/one,
		/datum/discipline_power/thaumaturgy/path/levinbolt/five
	)

/datum/discipline_power/thaumaturgy/path/levinbolt/three/activate()
	. = ..()
	if(.)
		try_deactivate()
		return
	//proc for counterattack
	RegisterSignal(owner, COMSIG_ATOM_ATTACKBY, PROC_REF(power_array_counter))

	//proc for clicking on objects to disable electronics
	RegisterSignal(owner, COMSIG_MOB_CLICKON, PROC_REF(powerarray_target_click))

	to_chat(owner, span_notice("强烈的电流在你周身涌动！"))


/datum/discipline_power/thaumaturgy/path/levinbolt/three/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_ATOM_ATTACKBY)
	UnregisterSignal(owner, COMSIG_MOB_CLICKON)
	to_chat(owner, span_notice("你周身的电流消散了。"))

/datum/discipline_power/thaumaturgy/path/levinbolt/three/proc/power_array_counter(mob/source, obj/item/weapon, mob/living/attacker)
	SIGNAL_HANDLER

	if(prob(30))
		addtimer(CALLBACK(attacker, TYPE_PROC_REF(/mob, emote), "scream"), 1)
		if(ishuman(attacker))
			var/mob/living/carbon/human/H = attacker
			H.electrocution_animation(40)
		attacker.adjust_jitter_up_to(2 SECONDS, 15)
		attacker.Stun(3 SECONDS)
		attacker.adjust_fire_loss(30)

/datum/discipline_power/thaumaturgy/path/levinbolt/three/proc/powerarray_target_click(mob/source, atom/target, params)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(levinbolt_target_click), source, target, params, TRUE)

//ZEUS' FURY - Level 4
/datum/discipline_power/thaumaturgy/path/levinbolt/four
	name = "宙斯之怒"
	desc = "积聚能量，将其化为在目标间连续跳跃的闪电。"

	level = 4
	cooldown_length = 30 SECONDS
	violates_masquerade = TRUE
	target_type = TARGET_LIVING
	range = 7
	electricity_overlay_state = "lightning"

	var/static/mutable_appearance/electric_halo

/datum/discipline_power/thaumaturgy/path/levinbolt/four/activate(mob/living/target)
	. = ..()
	if(.)
		return

	owner.visible_message(span_danger("[owner.name]周身电能不断积聚，噼啪作响！"),
		span_danger("你开始引导宙斯之怒，电弧在你周身跃动！"))

	electric_halo = electric_halo || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
	owner.add_overlay(electric_halo)

	if(do_after(owner, 3 SECONDS, timed_action_flags = (IGNORE_USER_LOC_CHANGE|IGNORE_HELD_ITEM)))
		if(get_dist(owner, target) <= range)
			execute_zeus_fury(target)
		else
			cancel_fury("目标已移出范围。")
	else
		cancel_fury("引导被打断了。")

/datum/discipline_power/thaumaturgy/path/levinbolt/four/proc/execute_zeus_fury(mob/living/primary_target)
	owner.cut_overlay(electric_halo)

	var/max_bounces = success_count // Lightning chain dependent upon successes - two successes, two targets hit
	var/bolt_damage = 20 + (success_count * 4)

	playsound(get_turf(owner), 'sound/effects/magic/lightningbolt.ogg', min(50 + (success_count * 10), 100), TRUE, extrarange = success_count)

	// bolt of lightning to the first target
	owner.Beam(primary_target, icon_state="lightning[rand(1,12)]", time = (5 + success_count))

	chain_bolt(owner, primary_target, bolt_damage, max_bounces, list(owner))

// Proced each time a lightning bolt is sent
/datum/discipline_power/thaumaturgy/path/levinbolt/four/proc/chain_bolt(atom/origin, mob/living/current_target, bolt_energy, bounces_left, list/already_hit)
	current_target.electrocute_act(bolt_energy, "宙斯之怒", flags = SHOCK_NOGLOVES)
	playsound(get_turf(current_target), 'sound/effects/magic/lightningshock.ogg', 60, TRUE)

	// Animation
	current_target.adjust_jitter_up_to(5 SECONDS, 20 + (success_count * 5))
	if(ishuman(current_target))
		var/mob/living/carbon/human/H = current_target
		H.electrocution_animation(40 + (success_count * 10))

	// Better chance to stun with more successes
	var/stun_chance = min(30 + (success_count * 15), 85)
	if(bolt_energy >= 20 && prob(stun_chance))
		var/stun_duration = (success_count) SECONDS
		current_target.Paralyze(stun_duration)
		current_target.visible_message(span_warning("[current_target]遭到电击，剧烈抽搐！"))

	already_hit += current_target

	if(bounces_left <= 0)
		return

	var/list/possible_targets = list()
	for(var/mob/living/L in view(range, current_target))
		if(L in already_hit)
			continue
		possible_targets += L

	if(!possible_targets.len)
		return

	// Pick closest target so the chain lightning is realistic
	var/mob/living/next_target = null
	var/shortest_distance = INFINITY //starts at infinity, then looks at each target and says 'is this distance shorter than the last guy'
	for(var/mob/living/potential in possible_targets)
		var/distance = get_dist(current_target, potential)
		if(distance < shortest_distance)
			shortest_distance = distance
			next_target = potential

	if(next_target)
		var/chain_delay = max(5 - success_count, 1) // slight delay for coolness
		addtimer(CALLBACK(src, PROC_REF(continue_chain), current_target, next_target, bolt_energy, bounces_left, already_hit), chain_delay)

//reduces damage and bounces_left for each subsequent bolt
/datum/discipline_power/thaumaturgy/path/levinbolt/four/proc/continue_chain(atom/origin, mob/living/next_target, bolt_energy, bounces_left, list/already_hit)
	origin.Beam(next_target, icon_state="lightning[rand(1,12)]", time = (5 + success_count))
	// With more successes, damage loss per bounce is reduced
	var/energy_retention = 0.8 + (success_count * 0.05)
	var/reduced_energy = max(bolt_energy * energy_retention, 10)

	// Continue the chain, applying reduced damage and bounces, while retaining the already_hit list
	chain_bolt(origin, next_target, reduced_energy, bounces_left - 1, already_hit)

/datum/discipline_power/thaumaturgy/path/levinbolt/four/proc/cancel_fury(reason)
	if(electric_halo)
		owner.cut_overlay(electric_halo)

	to_chat(owner, span_warning("宙斯之怒消散了。[reason]"))

//EYE OF THE STORM - Level 5
/datum/discipline_power/thaumaturgy/path/levinbolt/five
	name = "风暴之眼"
	desc = "让身体充满惊人的电能。"

	level = 5
	violates_masquerade = TRUE
	toggled = TRUE
	duration_length = 1 TURNS
	vitae_cost = 2
	cooldown_length = 30 SECONDS

	light_range = 5
	light_power = 4
	light_color = "#e9ffff"
	electricity_overlay_state = "electricity3"

	var/lightning_timer
	var/spark_timer

	grouped_powers = list(
		/datum/discipline_power/thaumaturgy/path/levinbolt/one,
		/datum/discipline_power/thaumaturgy/path/levinbolt/three
	)


/datum/discipline_power/thaumaturgy/path/levinbolt/five/activate(atom/target)
	. = ..()
	if(.)
		try_deactivate()
		return

	//signal for clicking electronics to disable them
	RegisterSignal(owner, COMSIG_CLICK, PROC_REF(storm_target_click))

	//signal for counterattack from being struck
	RegisterSignal(owner, COMSIG_ATOM_ATTACKBY, PROC_REF(storm_counter))

	//create sparks every few seconds for coolness
	spark_timer = addtimer(CALLBACK(src, PROC_REF(create_sparks)), 2 SECONDS, TIMER_STOPPABLE | TIMER_LOOP)

	//fire lightning bolt at a random nearby mob
	lightning_timer = addtimer(CALLBACK(src, PROC_REF(fire_lightning_bolt)), 5 SECONDS, TIMER_STOPPABLE | TIMER_LOOP)
	owner.visible_message(span_danger("噼啪作响的电流环绕着[owner]！"))
	to_chat(owner, span_notice("你感到惊人的电能流遍全身！"))
	playsound(owner, 'sound/effects/sparks/sparks4.ogg', 75, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/five/proc/create_sparks()
	if(!owner)
		return

	var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(owner), rand(3,7), 1)
	spark_system.start()

	if(prob(50))
		playsound(owner, pick('sound/effects/sparks/sparks1.ogg', 'sound/effects/sparks/sparks2.ogg', 'sound/effects/sparks/sparks3.ogg', 'sound/effects/sparks/sparks4.ogg'), 40, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/five/proc/fire_lightning_bolt()
	if(!owner)
		return

	var/list/potential_targets = list()
	for(var/mob/living/L in range(7, owner))
		if(L != owner && L.stat != DEAD)
			potential_targets += L

	if(!length(potential_targets))
		return

	var/mob/living/target = pick(potential_targets)

	owner.Beam(target, icon_state="lightning[rand(1,12)]", time = 10)

	target.adjust_fire_loss(20)
	target.adjust_jitter_up_to(3 SECONDS, 15)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.electrocution_animation(50)

	if(prob(60))
		target.Stun(1 SECONDS)
		target.visible_message(span_warning("[target]遭到电击，抽搐起来！"))

	var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(target), 8, 1)
	spark_system.start()

	owner.visible_message(span_danger("闪电从[owner]身上跃向[target]！"))
	playsound(target, 'sound/effects/magic/lightningshock.ogg', 75, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/five/proc/storm_counter(mob/source, obj/item/weapon, mob/living/attacker)
	SIGNAL_HANDLER

	if(prob(40))
		return
	attacker.adjust_jitter_up_to(3 SECONDS, 15)
	if(ishuman(attacker))
		var/mob/living/carbon/human/H = attacker
		H.electrocution_animation(60)
	addtimer(CALLBACK(attacker, TYPE_PROC_REF(/mob, emote), "scream"), 1)
	attacker.Stun(4 SECONDS)
	attacker.electrocute_act(rand(10,20), owner, siemens_coeff = 1, flags = NONE)
	var/datum/effect_system/basic/spark_spread/spark_system = new(get_turf(attacker), 5, 1)
	spark_system.start()
	playsound(attacker, 'sound/effects/sparks/sparks4.ogg', 60, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/five/proc/storm_target_click(mob/source, atom/target, params)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(levinbolt_target_click), source, target, params, TRUE)

/datum/discipline_power/thaumaturgy/path/levinbolt/five/deactivate()
	if(!owner)
		return

	UnregisterSignal(owner, list(COMSIG_CLICK, COMSIG_ATOM_ATTACKBY))

	if(spark_timer)
		deltimer(spark_timer)
		spark_timer = null
	if(lightning_timer)
		deltimer(lightning_timer)
		lightning_timer = null

	owner.visible_message(span_notice("[owner]周围的电能消散了。"))
	to_chat(owner, span_notice("你体内的风暴平息了。"))
	. = ..()

/datum/discipline_power/thaumaturgy/path/levinbolt/five/Destroy()
	if(spark_timer)
		deltimer(spark_timer)
	if(lightning_timer)
		deltimer(lightning_timer)
	. = ..()
