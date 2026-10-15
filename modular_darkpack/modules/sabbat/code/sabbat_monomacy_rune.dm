#define MONOMACY_COOLDOWN_DURATION (10 MINUTES)

/obj/sabbatrune
	name = "决斗仪式符文"
	desc = "决斗仪式用于解决战团成员之间的争端。向那条恶犬发起决斗吧！"
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "rune9"
	color = rgb(64, 64, 64)
	anchored = TRUE
	var/activated = FALSE
	var/mob/living/last_activator
	var/list/sacrifices = list()
	var/MONOMACY_CHALLENGE_COOLDOWN

/obj/sabbatrune/attack_hand(mob/living/user)
	. = ..()

	if(!is_sabbatist(user.mind.assigned_role))
		to_chat(user, span_warning("你无法理解这道符文的力量。"))
		return

	if(!COOLDOWN_FINISHED(src, MONOMACY_CHALLENGE_COOLDOWN))
		to_chat(user, span_warning("这道符文仍处于上一次挑战后的冷却期。"))
		return

	last_activator = user
	issue_challenge(user)

/obj/sabbatrune/proc/issue_challenge(mob/living/challenger)
	var/challenged_name = tgui_input_text(challenger, "输入你想发起决斗仪式挑战的对象姓名：", "决斗仪式挑战")
	if(!challenged_name)
		return

	var/mob/living/target = null
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		// if the target is not dead, is the challenger isnt targeting themselves, if the target is a sabbatist, and if one of the name datums match the name input
		if(H.stat != DEAD && H != challenger && is_sabbatist(H.mind?.assigned_role) && (findtext(H.real_name, challenged_name) || findtext(H.name, challenged_name)))
			target = H

	if(!target)
		to_chat(challenger, span_cult("找不到这个名字的挑战对象！只有魔宴同盟成员才能参与决斗仪式。"))
		return


	to_chat(challenger, span_cult("你已向[target.real_name]发起决斗仪式挑战！"))
	SEND_SOUND(challenger, sound('modular_darkpack/master_files/sounds/announce.ogg'))

	to_chat(target, span_cult("[challenger.real_name]向你发起了决斗仪式挑战！立刻返回巢穴！"))
	SEND_SOUND(target, sound('modular_darkpack/master_files/sounds/announce.ogg'))

	for(var/mob/living/carbon/human/M in viewers(7, src))
		if(M != challenger && M != target)
			to_chat(M, span_cult("[challenger.real_name]已向[target.real_name]发起决斗仪式挑战！"))
			SEND_SOUND(M, sound('modular_darkpack/master_files/sounds/announce.ogg'))

	for(var/mob/living/carbon/human/priest in GLOB.player_list)
		if(is_sabbat_priest(priest))
			to_chat(priest, span_cult("[challenger.real_name]已向[target.real_name]发起决斗仪式挑战！立刻返回巢穴，确保该隐的意志得以贯彻。"))
			SEND_SOUND(priest, sound('modular_darkpack/master_files/sounds/announce.ogg'))

	animate(src, color = rgb(192, 192, 192), time = 2)
	animate(color = rgb(64, 64, 64), time = 3)
	playsound(src, 'sound/effects/magic/smoke.ogg', 20, TRUE)

	COOLDOWN_START(src, MONOMACY_CHALLENGE_COOLDOWN, MONOMACY_COOLDOWN_DURATION)

	log_game("[key_name(challenger)] has challenged [key_name(target)] to Monomacy via sabbatrune.")

#undef MONOMACY_COOLDOWN_DURATION
