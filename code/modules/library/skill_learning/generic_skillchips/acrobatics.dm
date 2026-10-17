/obj/item/skillchip/acrobatics
	name = "旧款福斯贝里技能芯片"
	desc = "曾经最尖端的技能芯片，赋予使用者奥运选手级别的翻腾、旋转运动感知能力，除此之外毫无用途。\
		上市不久便被召回，因为用户过度翻腾会损坏芯片，引发致命故障。这下背越式跳高真成了背运式摔倒！"
	skill_name = "旋转美学"
	skill_description = "让你以危险且违法的速度翻腾和旋转。"
	skill_icon = FA_ICON_WHEELCHAIR_ALT
	activate_message = span_notice("你突然对如何优雅地旋转和翻腾有了极其高深复杂的感悟。")
	deactivate_message = span_notice("你对旋转美学神乎其技的领悟彻底消失了。")
	custom_premium_price = PAYCHECK_CREW * 4
	/// set integrity to 1 when mapping for !!FUN!!
	max_integrity = 100
	/// list of emotes whose cd is overridden by this skillchip. can be edited in mapping or ingame
	var/list/affected_emotes = list("spin", "flip", "backflip")
	var/datum/effect_system/basic/spark_spread/sparks
	/// you can use this without lowering integrity! let's be honest. nobody's doing that
	var/allowed_usage = 5
	/// How many seconds does it take for it to recover one allowed usage
	var/reload_charge = 10 SECONDS
	/// current particle effect used for smoking brain
	var/obj/effect/abstract/particle_holder/particle_effect

/obj/item/skillchip/acrobatics/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOB_EMOTE_COOLDOWN_CHECK, PROC_REF(whowee))
	AddElement(/datum/element/obj_regen, 0.01) // 1% regen per SSobj tick.

/obj/item/skillchip/acrobatics/on_deactivate(mob/living/carbon/user, silent)
	. = ..()
	UnregisterSignal(user, COMSIG_MOB_EMOTE_COOLDOWN_CHECK)
	RemoveElement(/datum/element/obj_regen, 0.01)

/obj/item/skillchip/acrobatics/Destroy(force)
	QDEL_NULL(sparks)
	QDEL_NULL(particle_effect)
	return ..()

/obj/item/skillchip/acrobatics/proc/whowee(mob/living/carbon/bozo, emote_key, emote_intentional)
	SIGNAL_HANDLER

	if(!(emote_key in affected_emotes))
		return

	if(allowed_usage)
		allowed_usage--
		addtimer(CALLBACK(src, PROC_REF(charge)), reload_charge)
		return COMPONENT_EMOTE_COOLDOWN_BYPASS

	take_damage(1, sound_effect = FALSE)

	if(!sparks)
		sparks = new(src, 5, FALSE)
		sparks.attach(src)

	// minimum roll is by default capped at 50, with the min value lowering as integrity is reduced.
	var/mintegrity = clamp(50 - (100 - get_integrity()), 1, 100)
	switch(rand(mintegrity, get_integrity())) // 1 to 100 but gets worse every time
		// CRIT FAIL
		if(1)
			bozo.visible_message(span_userdanger("[bozo]的头突然向外炸开了！"))

			explosion(bozo, light_impact_range = 2, adminlog = TRUE, explosion_cause = src)
			// WITNESS THE GORE
			for(var/mob/living/splashed in view(2, bozo))
				if(bozo.has_status_effect(/datum/status_effect/grouped/blindness))
					to_chat(splashed, span_userdanger("有什么东西溅到了你身上"))
				else
					to_chat(splashed, span_userdanger("飞溅的鲜血遮住了你的视线！"))
				splashed.Stun(1 SECONDS)
				splashed.Knockdown(2 SECONDS)
				splashed.set_eye_blur_if_lower(15 SECONDS)
				splashed.adjust_confusion(4 SECONDS)

			// GORE
			var/obj/item/bodypart/bozopart = bozo.get_bodypart(BODY_ZONE_HEAD)
			if(bozopart)
				var/datum/wound/cranial_fissure/crit_wound = new()
				crit_wound.apply_wound(bozopart)
			/*
				var/list/droppage_candidates = bozo.get_organs_for_zone(BODY_ZONE_HEAD, include_children = TRUE)
				if(droppage_candidates)
					var/obj/thing_to_drop = pick(droppage_candidates)
					thing_to_drop.forceMove(bozo.drop_location())
			*/ //WHY DOESNTY IT OWRK

			// does not necessarily kill you directly. instead it causes cranial fissure + something to drop from your head. could be eyes, tongue, ears, brain, even implants
			new /obj/effect/gibspawner/generic(get_turf(bozo), bozo)
			sparks.amount = 15
			sparks.start()

			qdel(src)
		// last chance to stop
		if(7 to 9)
			bozo.visible_message(
				span_danger("[bozo]似乎短路了！"),
				span_userdanger("你的大脑短路了！"),
			)
			// if they're susceptible to electrocution, confuse them
			if(bozo.electrocute_act(15, bozo, 1, SHOCK_NOGLOVES|SHOCK_NOSTUN))
				bozo.adjust_confusion(15 SECONDS)
				bozo.set_eye_blur_if_lower(10 SECONDS)
			// but the rest of the effects will happen either way
			bozo.adjust_organ_loss(ORGAN_SLOT_BRAIN, 20 - get_integrity())
			sparks.amount = 5
			sparks.start()

		// brain Smoking. you should probably stop now
		if(13 to 15)
			// if already hot, light 'em up
			var/particle_path = /particles/smoke/steam/mild
			if(bozo.has_status_effect(/datum/status_effect/temperature_over_time/chip_overheat))
				bozo.adjust_fire_stacks(11 - get_integrity())
				bozo.ignite_mob()
				bozo.visible_message(
					span_danger("[bozo]的头着火了！"),
					span_userdanger("你的头疼得厉害，仿佛烧起来了！"),
				)
				ASYNC
					bozo.emote("scream")
				if(particle_effect?.type == particle_path)
					return
				particle_path = /particles/smoke/steam/bad
			else
				bozo.visible_message(
					span_danger("[bozo]的头开始冒烟了！"),
					span_userdanger("你感觉大脑正在燃烧！"),
				)

				// increase smokiness if already smoking
				if(particle_effect?.type == /particles/smoke/steam/mild)
					particle_path = /particles/smoke/steam
				else
					particle_path = /particles/smoke/steam/mild

			bozo.adjust_confusion(4 SECONDS)
			bozo.set_eye_blur_if_lower(3 SECONDS)

			particle_effect = new(bozo, particle_path)
			// roughly head position.
			// dont know how to make this not hardcoded
			particle_effect.set_particle_position(-2, 12, 0)
			bozo.apply_status_effect(/datum/status_effect/temperature_over_time/chip_overheat, 15 SECONDS)
			QDEL_IN(particle_effect, 15 SECONDS)
			sparks.amount = 10
			sparks.start()

		// hey, something isn't right...
		if(16 to 50)
			bozo.visible_message(
				span_warning("[bozo]的头冒出了火花。"),
			)

			sparks.amount = rand(1, 2)
			sparks.start()

	return COMPONENT_EMOTE_COOLDOWN_BYPASS

/obj/item/skillchip/acrobatics/proc/charge()
	allowed_usage++

/obj/item/skillchip/acrobatics/kiss
	name = "prototype N. 807 - K1SS skillchip"
	desc = "An idle experiment when developing skillchips led to this catastrophe. Everyone involved swore to keep it a secret until death, but it looks like someone has let loose this mistake into the world."
	skill_name = "ERROERERROROROEROEORROER"
	skill_description = "NULL DESCRIPTION NOT FOUND"
	skill_icon = FA_ICON_KISS_BEAM
	activate_message = span_userdanger("This was a mistake.")
	deactivate_message = span_userdanger("The mistake is over.")
	custom_premium_price = PAYCHECK_CREW * 500
	max_integrity = 25
	affected_emotes = list("kiss")
	allowed_usage = 1
	reload_charge = 30 SECONDS
