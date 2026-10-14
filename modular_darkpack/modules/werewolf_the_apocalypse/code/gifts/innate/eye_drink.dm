/datum/storyteller_roll/eye_drink
	bumper_text = "饮眼"
	applicable_stats = list(STAT_PERCEPTION, STAT_EMPATHY)
	numerical = TRUE

/datum/action/cooldown/power/gift/eye_drink
	name = "饮眼"
	desc = "吞饮尸体的眼睛，揭开死者临终的秘密。"
	button_icon_state = "eye_drink"
	cooldown_time = 1 SCENES
	innate_ability = TRUE
	click_to_activate = TRUE

/datum/action/cooldown/power/gift/eye_drink/Activate(atom/target)
	var/mob/living/carbon/human/human_target = astype(target)
	if(!human_target)
		return
	if(!(human_target in range(1, owner)))
		return
	if(human_target.stat != DEAD)
		to_chat(owner, span_warning("[target]必须是尸体。"))
		return
	var/obj/item/organ/eyes/victim_eyeballs = human_target.get_organ_slot(ORGAN_SLOT_EYES)
	if(!victim_eyeballs)
		to_chat(owner, span_warning("这具尸体没有眼睛，无法施展饮眼！"))
		return

	. = ..()

	if(!do_after(owner, 1 TURNS))
		return TRUE

	var/datum/storyteller_roll/eye_drink/roll_datum = new()
	var/successes = roll_datum.st_roll(owner, human_target)

	var/mob/prompting_mob
	if(human_target.client)
		prompting_mob = human_target
	else
		prompting_mob = human_target.get_ghost(TRUE, TRUE)

	if(prompting_mob)
		var/permission = tgui_alert(prompting_mob, "是否允许[owner.real_name]看见你的死亡过程？对方的感知＋共情检定获得了 [successes] 个成功数（注意：请如实描述你的角色亲眼所见的情景！）", "请选择", list("允许","拒绝","我不记得了") ,"允许", 1 MINUTES)
		if(permission != "允许")
			to_chat(owner, span_warning("亡魂似乎不愿让你吞饮其眼睛……于是你停下了。"))
			return TRUE
	else
		if(successes <= 0)
			return TRUE

	to_chat(owner, span_notice("你吞饮了[human_target]的眼睛，幻象随之涌入脑海……"))
	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

	var/deathdesc
	if(prompting_mob)
		deathdesc = tgui_input_text(
			prompting_mob,
			"饮眼",
			"请描述死亡前一刻的幻象。[owner]获得了 [successes] 个成功数。成功数越多，描述应越清晰。",
			max_length = 300,
			multiline = TRUE,
			timeout = 5 MINUTES
		)
	else if(human_target.last_death_info)
		var/datum/death_report/death_info = human_target.last_death_info
		var/list/info_list = list()
		if(death_info.area)
			info_list += "画面从[death_info.area]开始。"
		if(death_info.last_attacker_name)
			info_list += "一个外貌与[death_info.last_attacker_name]相同的人袭击了死者。"
		if(death_info.last_words)
			info_list += "死者嘴唇翕动，但你听不见话语。"

		if(death_info.suicide)
			info_list += "一幕惨烈的画面呈现了死者自尽的不幸经过。"
		else
			info_list += "死亡的具体情形尚未显现，画面便结束了。"
		deathdesc += jointext(info_list, " ")

	if(!deathdesc)
		to_chat(owner, span_warning("幻象朦胧不清，你无法辨明太多细节……"))
	else
		to_chat(owner, "幻象涌入你的脑海：<i>[deathdesc]</i>")

	if(isnpc(human_target)) // Dont have granuliaty for removing one eye and this shows the empty sockets
		qdel(victim_eyeballs)
	else // Fuck a real player a little less.
		victim_eyeballs.apply_scar(pick(LEFT_EYE_SCAR, RIGHT_EYE_SCAR))

	return TRUE
