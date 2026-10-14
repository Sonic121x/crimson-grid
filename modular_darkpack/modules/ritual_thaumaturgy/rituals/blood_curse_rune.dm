/obj/ritual_rune/thaumaturgy/curse
	name = "鲜血诅咒"
	desc = "从远处诅咒敌人。在符文上放置多颗心脏可延长诅咒的持续时间。"
	icon_state = "rune7"
	word = "MAL'DICTO-SANGUINIS"
	level = 5
	sacrifices = list() //checking for number of hearts in the function
	var/channeling = FALSE
	var/mob/living/channeler = null
	var/curse_target = null

/obj/ritual_rune/thaumaturgy/curse/complete()
	. = ..()
	if(!activated)
		color = rgb(255,0,0)
		activated = TRUE

/obj/ritual_rune/thaumaturgy/curse/attack_hand(mob/user)
	if(!activated)
		var/mob/living/living_user = astype(user)
		if(!living_user || !living_user.get_discipline(/datum/discipline/thaumaturgy))
			return
		living_user.say(word)
		living_user.Immobilize(30)
		last_activator = user
		activator_bonus = living_user.thaum_damage_plus
		animate(src, color = rgb(255, 64, 64), time = 10)
		complete()
		addtimer(CALLBACK(src, PROC_REF(start_curse), user), 1 SECONDS)
		return

	// If already activated but not channeling, allow restarting
	if(!channeling && last_activator == user)
		start_curse(user)
		return

	// only the activator can use the activated rune
	if(last_activator != user)
		to_chat(user, span_warning("这道符文不是由你激活的！"))
		return

	// check if already channeling
	if(channeling)
		to_chat(user, span_warning("诅咒已在引导中！"))
		return

/obj/ritual_rune/thaumaturgy/curse/proc/start_curse(mob/user)
	if(!user || !activated || channeling)
		return

	// Count heart sacrifices
	var/list/hearts = list()
	for(var/obj/item/organ/heart/H in get_turf(src))
		hearts += H

	// at least one heart for the ritual
	if(hearts.len == 0)
		to_chat(user, span_warning("至少需要一颗心脏才能引导诅咒！"))
		return

	// target name input
	var/target_name = tgui_input_text(user, "输入目标姓名：", "诅咒符文")
	if(!target_name || !user.Adjacent(src)) // Check if user is still nearby
		to_chat(user, span_warning("你必须指定一个目标，并留在符文附近！"))
		return

	// begin channeling
	curse_target = target_name
	channeler = user
	channeling = TRUE

	// Begin the curse ritual
	to_chat(user, span_warning("你开始通过[hearts.len]颗心脏引导黑暗能量……"))
	channel_curse(hearts)
	do_after(hearts.len * 5)

/obj/ritual_rune/thaumaturgy/curse/proc/channel_curse(list/hearts)
	if(!channeling || !channeler || !curse_target)
		return

	if(!hearts.len)
		to_chat(channeler, span_warning("仪式已无心脏可用！"))
		channeling = FALSE
		qdel(src)
		return

	if(!channeler.Adjacent(src))
		to_chat(channeler, span_warning("你离开了符文附近，诅咒仪式因此中断！"))
		channeling = FALSE
		return

	// Take the first heart
	var/obj/item/organ/heart/heart = hearts[1]
	if(!heart || QDELETED(heart) || heart.loc != get_turf(src))
		hearts -= heart
		if(hearts.len > 0)
			channel_curse(hearts) // Skip this heart and continue
		else
			to_chat(channeler, span_warning("已无可用的心脏，诅咒仪式结束了！"))
			channeling = FALSE
			qdel(src)
		return

	hearts -= heart

	// Apply visual effects
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 25, FALSE)
	animate(src, color = rgb(255, 0, 0), time = 1.5)
	animate(color = rgb(128, 0, 0), time = 1.5)

	// Find the target and apply damage
	var/found_target = FALSE
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H.real_name == curse_target)
			found_target = TRUE
			H.adjust_agg_loss(25 + activator_bonus)
			log_combat(last_activator, curse_target, "bloodcursed")
			playsound(H.loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
			to_chat(H, span_warning("你感觉黑暗能量正在撕裂你的存在！"))
			H.Stun(2)
			break

	if(!found_target)
		to_chat(channeler, span_warning("城里没有这个名字的人！"))
		channeling = FALSE
		qdel(heart)
		return

	// Consume the heart
	qdel(heart)

	// Display feedback
	to_chat(channeler, span_warning("仪式消耗了一颗心脏，还剩[hearts.len]颗。"))

	// If we still have hearts, continue the channel
	if(hearts.len > 0)
		// After 4 seconds, process the next heart
		channeler.visible_message(span_warning("[channeler.name]继续向符文中引导黑暗能量！"))

		addtimer(CALLBACK(src, PROC_REF(channel_curse), hearts), 4 SECONDS)
	else
		// after using all hearts
		to_chat(channeler, span_warning("最后一颗心脏被消耗，诅咒仪式完成了！"))
		channeling = FALSE
		qdel(src)

