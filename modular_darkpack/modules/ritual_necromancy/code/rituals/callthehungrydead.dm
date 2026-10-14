/obj/ritual_rune/necromancy/question //No bloodpack requirement, but the wraiths aren't implied to owe answers.
	name = "呼唤饥饿亡者"
	desc = "从冥土召来一名怨灵，与其交谈。"
	icon_state = "rune4"
	word = "METEH' GHM'IEN"
	level = 2

/mob/living/basic/ghost/giovanni
	maxHealth = 100 //Can be annoying right back if they're pestered for nothing.
	health = 100
	melee_damage_lower = 30
	melee_damage_upper = 30
	faction = list(VAMPIRE_CLAN_GIOVANNI)

/obj/ritual_rune/necromancy/question/complete()
	var/text_question = tgui_input_text(last_activator, "输入你向怨灵发出的召唤：", "呼唤饥饿亡者", encode = FALSE)
	visible_message(span_notice("符文中响起了对亡者的呼唤……"))
	var/mob/living/basic/ghost/TR = new(loc)
	TR.AddComponent(\
		/datum/component/ghost_direct_control,\
		poll_candidates = TRUE,\
		role_name = "受缚怨灵",\
		poll_length = 30 SECONDS,\
		poll_question = "你愿意与一位死灵术士交谈吗？\n对方的召唤是：[text_question]",\
		assumed_control_message = "你是一名受召前来回答问题的祖灵：[text_question]",\
		after_assumed_control = CALLBACK(src, PROC_REF(ghost_name_prompt), TR)\
	)
	//TR.key = TR.key
	//TR.name = TR.name
	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy2.ogg', 50, FALSE)
	visible_message(span_notice("[TR.name]在符文上方缓缓显现……"))
	qdel(src)

/obj/ritual_rune/necromancy/question/proc/ghost_name_prompt(mob/living/basic/ghost/tremere/ghost_mob)
	message_admins("[key_name_admin(ghost_mob)] has become a Bound Wraith.")

	var/choice = tgui_alert(ghost_mob, "你想为怨灵身份取一个新名字吗？", "选择怨灵姓名", list("是", "否"), 10 SECONDS)
	if(choice == "是")
		var/chosen_ghost_name = tgui_input_text(ghost_mob, "你的怨灵新名字是什么？", "输入怨灵姓名")
		if(chosen_ghost_name)
			ghost_mob.real_name = chosen_ghost_name
			ghost_mob.name = chosen_ghost_name
