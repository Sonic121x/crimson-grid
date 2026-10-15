/obj/ritual_rune/necromancy/zombie
	name = "邪灵附体"
	desc = "将怨灵置入尸体，使其作为拥有自我意识的僵尸复起。"
	icon_state = "rune7"
	word = "GI'TI FOA'HP"
	level = 5
	var/duration_length = 15 SECONDS

/obj/ritual_rune/necromancy/zombie/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("你不能对自己施行此仪式。"))
			return
		else if(targetbody.stat == DEAD)
			valid_bodies += targetbody
		else
			to_chat(usr, span_warning("目标还活着！"))
			return

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("没有可供施行此仪式的尸体。"))
		return

	usr.visible_message(span_notice("[usr]开始用邪恶的语言吟诵……"), span_notice("你开始施行复生仪式。"))
	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy2.ogg', 50, FALSE)

	if(do_after(usr, duration_length, usr))

		activated = TRUE
		last_activator = usr

		var/mob/living/target_body = pick(valid_bodies)

		var/old_name = target_body.real_name

		// Transform the body into a zombie
		if(!target_body || QDELETED(target_body) || target_body.stat > DEAD)
			return

		// Remove any vampiric actions
		for(var/datum/action/A in target_body.actions)
			if(A.vampiric)
				A.Remove(target_body)

		var/original_location = get_turf(target_body)

		// Revive the specimen and turn them into a zombie
		target_body.revive(HEAL_ALL)
		target_body.apply_status_effect(/datum/status_effect/zombie)
		target_body.real_name = old_name // the ritual for some reason is deleting their old name and replacing it with a random name.
		target_body.name = old_name
		target_body.update_name()

		if(target_body.loc != original_location)
			target_body.forceMove(original_location)

		playsound(loc, 'modular_darkpack/modules/powers/sounds/necromancy.ogg', 50, FALSE)

		// Handle key assignment
		if(!target_body.key)
			target_body.AddComponent(\
				/datum/component/ghost_direct_control,\
				poll_candidates = TRUE,\
				role_name = "有智僵尸",\
				poll_length = 30 SECONDS,\
				assumed_control_message = "你是一具有智僵尸，原是一名怨灵，蒙主人恩赐得以借尸还魂。好好侍奉主人，尽情品味那曾被夺走的生命。",\
				after_assumed_control = CALLBACK(src, PROC_REF(on_zombie_possess), target_body),\
			)
			qdel(src)
			return

		target_body.visible_message(span_ghostalert("[target_body.name]抽搐着化为不死之躯！"))
		qdel(src)

/obj/ritual_rune/necromancy/zombie/proc/on_zombie_possess(mob/living/carbon/human/zombie)
	zombie.visible_message(span_ghostalert("一名怨灵附上尸体，[zombie.name]抽搐着化为不死之躯！"))
	ask_zombie_name(zombie)
	qdel(src)

/obj/ritual_rune/necromancy/zombie/proc/ask_zombie_name(mob/living/carbon/human/zombie)
	var/choice = tgui_alert(zombie, "你想为僵尸身份取一个新名字吗？", "选择僵尸姓名", list("是", "否"), 10 SECONDS)
	if(choice == "是")
		var/chosen_zombie_name = tgui_input_text(zombie, "你的僵尸新名字是什么？", "输入僵尸姓名")
		if(chosen_zombie_name)
			zombie.real_name = chosen_zombie_name
			zombie.name = chosen_zombie_name
			zombie.update_name()
	else
		return
