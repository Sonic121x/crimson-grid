/*
The contents of this file were originally licensed under CC-BY-NC-SA 3.0 as part of Goonstation(https://ss13.co).
However, /tg/station and derivative codebases have been granted the right to use this code under the terms of the AGPL.
The original authors are: cogwerks, pistoleer, spyguy, angriestibm, marquesas, and stuntwaffle.
If you make a derivative work from this code, you must include this notification header alongside it.
*/

/datum/martial_art/wrestling
	name = "摔跤"
	id = MARTIALART_WRESTLING
	VAR_PRIVATE/datum/action/slam/slam
	VAR_PRIVATE/datum/action/throw_wrassle/throw_wrassle
	VAR_PRIVATE/datum/action/kick/kick
	VAR_PRIVATE/datum/action/strike/strike
	VAR_PRIVATE/datum/action/drop/drop

/datum/martial_art/wrestling/New()
	. = ..()
	slam = new(src)
	throw_wrassle = new(src)
	kick = new(src)
	strike = new(src)
	drop = new(src)

/datum/martial_art/wrestling/Destroy()
	slam = null
	throw_wrassle = null
	kick = null
	strike = null
	drop = null
	return ..()

/datum/martial_art/wrestling/proc/check_streak(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 10, "[attacker]的[list("drop" = "坠腿压击", "strike" = "打击", "kick" = "踢击", "throw" = "抛投", "slam" = "抱摔")[streak] || "攻击"]", UNARMED_ATTACK))
		return FALSE

	switch(streak)
		if("drop")
			streak = ""
			drop(attacker, defender)
			return TRUE
		if("strike")
			streak = ""
			strike(attacker, defender)
			return TRUE
		if("kick")
			streak = ""
			kick(attacker, defender)
			return TRUE
		if("throw")
			streak = ""
			throw_wrassle(attacker, defender)
			return TRUE
		if("slam")
			streak = ""
			slam(attacker, defender)
			return TRUE
	return FALSE

/datum/action/slam
	name = "抱摔（需抱锁）——将抱住的对手摔在地上。"
	button_icon_state = "wrassle_slam"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/slam/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	owner.visible_message(span_danger("[owner]准备使出抱摔！"), "<b><i>你的下一次攻击将使出抱摔。</i></b>")
	source.streak = "slam"

/datum/action/throw_wrassle
	name = "抛投（需抱锁）——抱着对手旋转，然后将其扔出。"
	button_icon_state = "wrassle_throw"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/throw_wrassle/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	owner.visible_message(span_danger("[owner]准备使出抛投！"), "<b><i>你的下一次攻击将使出抛投。</i></b>")
	source.streak = "throw"

/datum/action/kick
	name = "踢击——强力的一脚，能将对手踢飞，也可用于摆脱困境。"
	button_icon_state = "wrassle_kick"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_CONSCIOUS // This is supposed to be usable while cuffed but it probably isn't

/datum/action/kick/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	owner.visible_message(span_danger("[owner]准备使出踢击！"), "<b><i>你的下一次攻击将使出踢击。</i></b>")
	source.streak = "kick"

/datum/action/strike
	name = "打击——快速攻击附近的对手。"
	button_icon_state = "wrassle_strike"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/strike/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	owner.visible_message(span_danger("[owner]准备使出打击！"), "<b><i>你的下一次攻击将使出打击。</i></b>")
	source.streak = "strike"

/datum/action/drop
	name = "坠腿压击——从上方猛压对手。"
	button_icon_state = "wrassle_drop"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED

/datum/action/drop/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	owner.visible_message(span_danger("[owner]准备使出坠腿压击！"), "<b><i>你的下一次攻击将使出坠腿压击。</i></b>")
	source.streak = "drop"

/datum/martial_art/wrestling/activate_style(mob/living/new_holder)
	. = ..()
	to_chat(new_holder, span_userdanger("来一口瘦蒂姆！"))
	to_chat(new_holder, span_danger("将鼠标移到屏幕上方的招式图标上，即可查看其效果。"))
	drop.Grant(new_holder)
	kick.Grant(new_holder)
	slam.Grant(new_holder)
	throw_wrassle.Grant(new_holder)
	strike.Grant(new_holder)

/datum/martial_art/wrestling/deactivate_style(mob/living/remove_from)
	to_chat(remove_from, span_userdanger("你不再觉得自己这座力量之塔完美得无可挑剔……"))
	drop?.Remove(remove_from)
	kick?.Remove(remove_from)
	slam?.Remove(remove_from)
	throw_wrassle?.Remove(remove_from)
	strike?.Remove(remove_from)
	return ..()

/datum/martial_art/wrestling/harm_act(mob/living/attacker, mob/living/defender)
	return check_streak(attacker, defender) ? MARTIAL_ATTACK_SUCCESS : MARTIAL_ATTACK_INVALID

/datum/martial_art/wrestling/proc/throw_wrassle(mob/living/attacker, mob/living/defender)
	if(!defender)
		return
	if(!attacker.pulling || attacker.pulling != defender)
		to_chat(attacker, span_warning("你得先抱锁住[defender]！"))
		return
	defender.forceMove(attacker.loc)
	defender.setDir(get_dir(defender, attacker))

	defender.Stun(8 SECONDS)
	defender.visible_message(span_danger("[attacker]抱着[defender]开始旋转！"), \
					span_userdanger("[attacker]抱着你转起圈来！"), span_hear("你听到激烈的扭打声！"), null, attacker)
	to_chat(attacker, span_danger("你抱着[defender]开始旋转！"))
	attacker.emote("scream")

	for (var/i in 1 to 20)
		var/delay = 5
		switch (i)
			if (18 to INFINITY)
				delay = 0.25
			if (15 to 17)
				delay = 0.5
			if (10 to 14)
				delay = 1
			if (6 to 9)
				delay = 2
			if (1 to 5)
				delay = 3

		if (attacker && defender)

			if (get_dist(attacker, defender) > 1)
				to_chat(attacker, span_warning("[defender]离得太远了！"))
				return

			if (!isturf(attacker.loc) || !isturf(defender.loc))
				to_chat(attacker, span_warning("你无法在这里将[defender]扔出！"))
				return

			attacker.setDir(turn(attacker.dir, 90))
			var/turf/T = get_step(attacker, attacker.dir)
			var/turf/S = defender.loc
			var/direction = get_dir(defender, attacker)
			if ((S && isturf(S) && S.Exit(defender, direction)) && (T && isturf(T) && T.Enter(attacker)))
				defender.forceMove(T)
				defender.setDir(direction)
		else
			return

		sleep(delay)

	if (attacker && defender)
		// These are necessary because of the sleep call.

		if (get_dist(attacker, defender) > 1)
			to_chat(attacker, span_warning("[defender]离得太远了！"))
			return

		if (!isturf(attacker.loc) || !isturf(defender.loc))
			to_chat(attacker, span_warning("你无法在这里将[defender]扔出！"))
			return

		defender.forceMove(attacker.loc) // Maybe this will help with the wallthrowing bug.

		defender.visible_message(span_danger("[attacker]将[defender]扔了出去！"), \
						span_userdanger("你被[attacker]扔了出去！"), span_hear("你听到激烈的扭打声，随后是一声巨大的闷响！"), null, attacker)
		to_chat(attacker, span_danger("你将[defender]扔了出去！"))
		playsound(attacker.loc, SFX_SWING_HIT, 50, TRUE)
		var/turf/T = get_edge_target_turf(attacker, attacker.dir)
		if (T && isturf(T))
			if (!IS_UNCONSCIOUS_OR_CRIT(defender))
				defender.emote("scream")
			defender.throw_at(T, 10, 4, attacker, TRUE, TRUE, callback = CALLBACK(defender, TYPE_PROC_REF(/mob/living, Paralyze), 20))
	log_combat(attacker, defender, "has thrown with wrestling")
	return

/datum/martial_art/wrestling/proc/FlipAnimation(mob/living/defender)
	set waitfor = FALSE
	if (defender)
		animate(defender, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	sleep(1.5 SECONDS)
	if (defender)
		animate(defender, transform = null, time = 1, loop = 0)

/datum/martial_art/wrestling/proc/slam(mob/living/attacker, mob/living/defender)
	if(!defender)
		return
	if(!attacker.pulling || attacker.pulling != defender)
		to_chat(attacker, span_warning("你得先抱锁住[defender]！"))
		return
	defender.forceMove(attacker.loc)
	attacker.setDir(get_dir(attacker, defender))
	defender.setDir(get_dir(defender, attacker))

	defender.visible_message(span_danger("[attacker]举起了[defender]！"), \
					span_userdanger("你被[attacker]举了起来！"), span_hear("你听到激烈的扭打声！"), null, attacker)
	to_chat(attacker, span_danger("你举起了[defender]！"))

	FlipAnimation()

	for (var/i in 1 to 3)
		if (attacker && defender)
			attacker.pixel_y += 3
			defender.pixel_y += 3
			attacker.setDir(turn(attacker.dir, 90))
			defender.setDir(turn(defender.dir, 90))

			switch (attacker.dir)
				if (NORTH)
					defender.pixel_x = attacker.pixel_x
				if (SOUTH)
					defender.pixel_x = attacker.pixel_x
				if (EAST)
					defender.pixel_x = attacker.pixel_x - 8
				if (WEST)
					defender.pixel_x = attacker.pixel_x + 8

			if (get_dist(attacker, defender) > 1)
				to_chat(attacker, span_warning("[defender]离得太远了！"))
				attacker.pixel_x = attacker.base_pixel_x
				attacker.pixel_y = attacker.base_pixel_y
				defender.pixel_x = defender.base_pixel_x
				defender.pixel_y = defender.base_pixel_y
				return

			if (!isturf(attacker.loc) || !isturf(defender.loc))
				to_chat(attacker, span_warning("你无法在这里抱摔[defender]！"))
				attacker.pixel_x = attacker.base_pixel_x
				attacker.pixel_y = attacker.base_pixel_y
				defender.pixel_x = defender.base_pixel_x
				defender.pixel_y = defender.base_pixel_y
				return
		else
			if (attacker)
				attacker.pixel_x = attacker.base_pixel_x
				attacker.pixel_y = attacker.base_pixel_y
			if (defender)
				defender.pixel_x = defender.base_pixel_x
				defender.pixel_y = defender.base_pixel_y
			return

		sleep(0.1 SECONDS)

	if (attacker && defender)
		attacker.pixel_x = attacker.base_pixel_x
		attacker.pixel_y = attacker.base_pixel_y
		defender.pixel_x = defender.base_pixel_x
		defender.pixel_y = defender.base_pixel_y

		if (get_dist(attacker, defender) > 1)
			to_chat(attacker, span_warning("[defender]离得太远了！"))
			return

		if (!isturf(attacker.loc) || !isturf(defender.loc))
			to_chat(attacker, span_warning("你无法在这里抱摔[defender]！"))
			return

		defender.forceMove(attacker.loc)

		var/fluff = "抱摔"
		switch(pick(2,3))
			if (2)
				fluff = "涡轮[fluff]"
			if (3)
				fluff = "原子[fluff]"

		defender.visible_message(span_danger("[attacker]对[defender]使出了一记[fluff]！"), \
						span_userdanger("[attacker]对你使出了一记[fluff]！"), span_hear("你听到肉体撞击的骇人闷响！"), COMBAT_MESSAGE_RANGE, attacker)
		to_chat(attacker, span_danger("你对[defender]使出了一记[fluff]！"))
		playsound(attacker.loc, SFX_SWING_HIT, 50, TRUE)
		if (!IS_UNCONSCIOUS_OR_CRIT(defender))
			defender.emote("scream")
			defender.Paralyze(4 SECONDS)

			switch(rand(1,3))
				if (2)
					defender.adjust_brute_loss(rand(20,30))
				if (3)
					EX_ACT(defender, EXPLODE_LIGHT)
				else
					defender.adjust_brute_loss(rand(10,20))
		else
			EX_ACT(defender, EXPLODE_LIGHT)

	else
		if (attacker)
			attacker.pixel_x = attacker.base_pixel_x
			attacker.pixel_y = attacker.base_pixel_y
		if (defender)
			defender.pixel_x = defender.base_pixel_x
			defender.pixel_y = defender.base_pixel_y


	log_combat(attacker, defender, "body-slammed")
	return

/datum/martial_art/wrestling/proc/CheckStrikeTurf(mob/living/attacker, turf/T)
	if (attacker && (T && isturf(T) && get_dist(attacker, T) <= 1))
		attacker.forceMove(T)

/datum/martial_art/wrestling/proc/strike(mob/living/attacker, mob/living/defender)
	if(!defender)
		return
	var/turf/T = get_turf(attacker)
	if (T && isturf(T) && defender && isturf(defender.loc))
		for (var/i in 1 to 4)
			attacker.setDir(turn(attacker.dir, 90))

		attacker.forceMove(defender.loc)
		addtimer(CALLBACK(src, PROC_REF(CheckStrikeTurf), attacker, T), 0.4 SECONDS)

		defender.visible_message(span_danger("[attacker]用头槌撞中了[defender]！"), \
						span_userdanger("你被[attacker]的头槌撞中了！"), span_hear("你听到肉体撞击的骇人闷响！"), COMBAT_MESSAGE_RANGE, attacker)
		to_chat(attacker, span_danger("你用头槌撞中了[defender]！"))
		defender.adjust_brute_loss(rand(10,20))
		playsound(attacker.loc, SFX_SWING_HIT, 50, TRUE)
		defender.Unconscious(2 SECONDS)
	log_combat(attacker, defender, "headbutted")

/datum/martial_art/wrestling/proc/kick(mob/living/attacker, mob/living/defender)
	if(!defender)
		return
	attacker.emote("scream")
	attacker.emote("flip")
	attacker.setDir(turn(attacker.dir, 90))

	defender.visible_message(span_danger("[attacker]用回旋踢踢中了[defender]！"), \
					span_userdanger("你被[attacker]的回旋踢踢中了！"), span_hear("你听到肉体撞击的骇人闷响！"), COMBAT_MESSAGE_RANGE, attacker)
	to_chat(attacker, span_danger("你用回旋踢踢中了[defender]！"))
	playsound(attacker.loc, SFX_SWING_HIT, 50, TRUE)
	defender.adjust_brute_loss(rand(10,20))

	var/turf/T = get_edge_target_turf(attacker, get_dir(attacker, get_step_away(defender, attacker)))
	if (T && isturf(T))
		defender.Paralyze(2 SECONDS)
		defender.throw_at(T, 3, 2)
	log_combat(attacker, defender, "roundhouse-kicked")

/datum/martial_art/wrestling/proc/drop(mob/living/attacker, mob/living/defender)
	if(!defender)
		return
	var/obj/surface = null
	var/turf/ST = null
	var/falling = 0

	for (var/obj/O in oview(1, attacker))
		if (O.density == 1)
			if (O == attacker)
				continue
			if (O == defender)
				continue
			if (O.opacity)
				continue
			else
				surface = O
				ST = get_turf(O)
				break

	if (surface && (ST && isturf(ST)))
		attacker.forceMove(ST)
		attacker.visible_message(span_danger("[attacker]爬上了[surface]！"), \
						span_danger("你爬上了[surface]！"))
		attacker.pixel_y = attacker.base_pixel_y + 10
		falling = 1
		sleep(1 SECONDS)

	if (attacker && defender)
		// These are necessary because of the sleep call.

		if ((falling == 0 && get_dist(attacker, defender) > 1) || (falling == 1 && get_dist(attacker, defender) > 2)) // We climbed onto stuff.
			attacker.pixel_y = attacker.base_pixel_y
			if (falling == 1)
				attacker.visible_message(span_danger("……随后一头栽到了地上，好疼！"), \
								span_userdanger("……随后你一头栽到了地上，好疼！"))
				attacker.adjust_brute_loss(rand(10,20))
				attacker.Paralyze(60)
			to_chat(attacker, span_warning("[defender]离得太远了！"))
			return

		if (!isturf(attacker.loc) || !isturf(defender.loc))
			attacker.pixel_y = attacker.base_pixel_y
			to_chat(attacker, span_warning("你无法从这里跃下压击[defender]！"))
			return

		if(attacker)
			animate(attacker, transform = matrix(90, MATRIX_ROTATE), time = 1, loop = 0)
		sleep(1 SECONDS)
		if(attacker)
			animate(attacker, transform = null, time = 1, loop = 0)

		attacker.forceMove(defender.loc)

		defender.visible_message(span_danger("[attacker]对[defender]使出了坠腿压击！"), \
						span_userdanger("[attacker]对你使出了坠腿压击！"), span_hear("你听到肉体撞击的骇人闷响！"), null, attacker)
		to_chat(attacker, span_danger("你对[defender]使出了坠腿压击！"))
		playsound(attacker.loc, SFX_SWING_HIT, 50, TRUE)
		attacker.emote("scream")

		if (falling == 1)
			if (prob(33) || IS_UNCONSCIOUS_OR_CRIT(defender))
				EX_ACT(defender, EXPLODE_LIGHT)
			else
				defender.adjust_brute_loss(rand(20,30))
		else
			defender.adjust_brute_loss(rand(20,30))

		defender.Paralyze(4 SECONDS)

		attacker.pixel_y = attacker.base_pixel_y

	else
		if (attacker)
			attacker.pixel_y = attacker.base_pixel_y
	log_combat(attacker, defender, "leg-dropped")
	return

/datum/martial_art/wrestling/disarm_act(mob/living/attacker, mob/living/defender)
	return check_streak(attacker, defender) ? MARTIAL_ATTACK_SUCCESS : MARTIAL_ATTACK_INVALID

/datum/martial_art/wrestling/grab_act(mob/living/attacker, mob/living/defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	if(defender.check_block(attacker, 0, "[attacker]的抓取", UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL
	if(attacker.pulling == defender)
		return MARTIAL_ATTACK_FAIL
	attacker.start_pulling(defender)
	defender.visible_message(
		span_danger("[attacker]抱锁住了[defender]！"),
		span_userdanger("你被[attacker]抱锁住了！"),
		span_hear("你听到激烈的扭打声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你抱锁住了[defender]！"))
	defender.Stun(rand(6 SECONDS, 10 SECONDS))
	log_combat(attacker, defender, "cinched")
	return MARTIAL_ATTACK_SUCCESS

/obj/item/storage/belt/champion/wrestling
	name = "摔跤腰带"

/obj/item/storage/belt/champion/wrestling/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/wrestling)
