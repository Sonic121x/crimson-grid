/obj/ritual_rune/thaumaturgy/gargoyle
	name = "奉吾等之命而生"
	desc = "用吸血鬼的躯体创造石像鬼。一具躯体可创造普通石像鬼，两具则可创造完美石像鬼。"
	icon_state = "rune9"
	word = "FORMA-GARGONEM"
	level = 5
	var/duration_length = 60 SECONDS

/obj/ritual_rune/thaumaturgy/gargoyle/complete()
	// vampire bodies only
	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/H in loc)
		if(get_kindred_splat(H))
			if(H == usr)
				to_chat(usr, span_warning("你不能把自己变成石像鬼！"))
				return
			else if(H.is_clan(/datum/subsplat/vampire_clan/gargoyle))
				to_chat(usr, span_warning("你不能对石像鬼使用此仪式！"))
				return
			else if(IS_UNCONSCIOUS(H))
				valid_bodies += H
			else
				H.adjust_agg_loss(50)
				to_chat(usr, "实验对象必须失去行动能力！仪式只伤害了对方！")
				return


	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("仪式至少需要一具吸血鬼的躯体！"))
		return

	// Begin the ritual
	var/body_count = valid_bodies.len
	to_chat(usr, span_notice("你开始用[body_count]具吸血鬼躯体施行创造石像鬼的仪式……"))
	usr.visible_message(span_notice("[usr]开始用[body_count]具吸血鬼躯体施行仪式……"))

	playsound(loc, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, FALSE)

	// Apply stun so that they cant just crawl away in crit - caster must also stay still
	for(var/mob/living/carbon/human/H in valid_bodies)
		H.Stun(600)
		H.emote("twitch")

	// Start the transformation process
	if(do_after(usr, duration_length, usr))
		activated = TRUE
		last_activator = usr

		// Determine if we're creating a perfect gargoyle (2+ bodies) or regular (1 body)
		var/perfect_gargoyle = (body_count >= 2)

		var/transformation_message
		if(perfect_gargoyle)
			transformation_message = span_cult("这些躯体开始融合，石化成一个庞大的岩石身躯！")
		else
			transformation_message = span_cult("躯体开始石化，变成岩石身躯！")
		visible_message(transformation_message)

		// Complete the transformation
		addtimer(CALLBACK(src, PROC_REF(gargoyle_transform), valid_bodies, perfect_gargoyle), 1 SECONDS)
	else
		to_chat(usr, span_warning("你的仪式被打断了！"))
		// Unstun the bodies if interrupted
		for(var/mob/living/carbon/human/H in valid_bodies)
			H.Stun(5) // Brief stun to recover

/obj/ritual_rune/thaumaturgy/gargoyle/proc/gargoyle_transform(list/bodies, perfect_gargoyle = FALSE)
	if(!bodies || bodies.len < 1)
		return

	if(perfect_gargoyle)
		// Create perfect gargoyle (2+ bodies) -- you'd have to frag two different kindred players to create a perfect gargoyle.
		var/mob/living/basic/gargoyle/perfect/G = new /mob/living/basic/gargoyle/perfect(loc)
		G.visible_message(span_cult("一个庞大的完美石像鬼从仪式中站起！"))

		// Ensure perfect gargoyle is at full health
		G.revive(TRUE)
		G.health = G.maxHealth

		// Handle the other bodies
		for(var/mob/living/carbon/human/H in bodies)
			if(!QDELETED(H))
				for(var/datum/action/A in H.actions)
					if(A && A.vampiric)
						A.Remove(H)

				H.gib(FALSE, FALSE, TRUE)

		// Add ghost control component
		G.AddComponent(\
			/datum/component/ghost_direct_control,\
			poll_candidates = TRUE,\
			role_name = "完美石像鬼",\
			poll_length = 30 SECONDS,\
			assumed_control_message = "你是完美石像鬼！睿魔尔魔法造就的庞大岩石造物。",\
			after_assumed_control = CALLBACK(src, PROC_REF(perfect_gargoyle_player_controlled), G)\
		)
		//poll_ignore_key = POLL_IGNORE_PERFECT_GARGOYLE,


		// Set up timer to give AI if no one takes control
		addtimer(CALLBACK(src, PROC_REF(perfect_gargoyle_check_ai), G, last_activator), 31 SECONDS)

		playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
		playsound(loc, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, FALSE)
	else
		// Create normal sentient gargoyle (1 body)
		var/mob/living/carbon/human/target_body = bodies[1]
		var/old_name = target_body.real_name

		// Transform the body into a gargoyle
		if(!target_body || QDELETED(target_body) || target_body.stat > DEAD)
			return

		// Remove any vampiric actions
		for(var/datum/action/A in target_body.actions)
			if(A && A.vampiric)
				A.Remove(target_body)

		var/original_location = get_turf(target_body)

		// Revive the specimen and turn them into a gargoyle kindred
		target_body.revive(TRUE)
		target_body.adjust_agg_loss(-100)
		target_body.set_clan(/datum/subsplat/vampire_clan/gargoyle)
		target_body.blood_bond(usr)
		target_body.real_name = old_name // the ritual for some reason is deleting their old name and replacing it with a random name.
		target_body.name = old_name
		target_body.update_name()

		target_body.give_st_powers(target_body.get_clan().clan_disciplines)

		if(target_body.loc != original_location)
			target_body.forceMove(original_location)

		playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
		playsound(target_body.loc, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, FALSE)

		// Handle key assignment
		if(!target_body.key)
			target_body.AddComponent(\
				/datum/component/ghost_direct_control,\
				poll_candidates = TRUE,\
				role_name = "有智石像鬼",\
				poll_length = 30 SECONDS,\

				assumed_control_message = "你已被转化为石像鬼！",\
				after_assumed_control = CALLBACK(src, PROC_REF(sentient_gargoyle_name_prompt), target_body)\
			)

		//poll_ignore_key = POLL_IGNORE_SENTIENT_GARGOYLE,

		target_body.visible_message(span_cult("一个石像鬼从仪式中站起！"))

	qdel(src)

/obj/ritual_rune/thaumaturgy/gargoyle/proc/perfect_gargoyle_player_controlled(mob/living/basic/gargoyle/perfect/G)
	message_admins("[key_name_admin(G)] has become a Perfect Gargoyle.")

/obj/ritual_rune/thaumaturgy/gargoyle/proc/perfect_gargoyle_check_ai(mob/living/basic/gargoyle/perfect/G, mob/living/carbon/human/activator)
	// Check if someone took control, if not give it AI
	if(!G || QDELETED(G))
		return
	if(!G.key || !G.client)
		QDEL_NULL(G.ai_controller)
		G.ai_controller = new /datum/ai_controller/basic_controller/beastmaster_summon(G)
		if(activator)
			activator.add_beastmaster_minion(G)

/obj/ritual_rune/thaumaturgy/gargoyle/proc/sentient_gargoyle_name_prompt(mob/living/carbon/human/target_body)
	message_admins("[key_name_admin(target_body)] has become a Sentient Gargoyle.")

	var/choice = tgui_alert(target_body, "你想为石像鬼身份取一个新名字吗？", "选择石像鬼姓名", list("是", "否"), 10 SECONDS)
	if(choice == "是")
		var/chosen_gargoyle_name = tgui_input_text(target_body, "你的石像鬼新名字是什么？", "输入石像鬼姓名")
		if(chosen_gargoyle_name)
			target_body.real_name = chosen_gargoyle_name
			target_body.name = chosen_gargoyle_name
			target_body.update_name()

// Perfect Gargoyle definition
/mob/living/basic/gargoyle/perfect
	name = "完美石像鬼"
	desc = "一个拥有岩石皮肤的庞大怪物，力量与坚韧程度都得到了强化。"
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "gargoyle_m"
	icon_living = "gargoyle_m"
	mob_size = MOB_SIZE_LARGE
	speed = -2
	maxHealth = 600
	health = 600
	//harm_intent_damage = 8
	melee_damage_lower = 35
	melee_damage_upper = 60
	attack_verb_continuous = "残暴地碾压"
	attack_verb_simple = "残暴地碾压"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	bloodpool = 15
	maxbloodpool = 15
	ai_controller = null // Start with no AI, will be assigned if no player takes it

/mob/living/basic/gargoyle/perfect/Initialize(mapload)
	. = ..()
	// Make the perfect gargoyle slightly larger
	transform = transform.Scale(1.10, 1.10)
