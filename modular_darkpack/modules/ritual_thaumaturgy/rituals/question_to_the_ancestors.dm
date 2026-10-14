/obj/ritual_rune/thaumaturgy/question
	name = "问询祖灵"
	desc = "召来亡者的灵魂，提出问题并获取回答。需要一袋血。"
	icon_state = "rune5"
	word = "VOCA-ANI'MA"
	level = 3
	sacrifices = list(/obj/item/reagent_containers/blood)

/mob/living/basic/ghost/tremere
	maxHealth = 1
	health = 1
	melee_damage_lower = 1
	melee_damage_upper = 1
	faction = list(VAMPIRE_CLAN_TREMERE)
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "ghost_animated"
	icon_living = "ghost_animated"

/obj/ritual_rune/thaumaturgy/question/complete()
	. = ..()
	var/text_question = tgui_input_text(usr, "输入你要向祖灵提出的问题：", "问询祖灵")
	if(!text_question)
		return

	visible_message(span_notice("[src.name]中响起了对亡者的呼唤……"))

	var/mob/living/basic/ghost/tremere/TR = new(loc)

	TR.AddComponent(\
		/datum/component/ghost_direct_control,\
		poll_candidates = TRUE,\
		role_name = "祖灵",\
		poll_length = 30 SECONDS,\
		poll_question = "你愿意回答一个问题吗？\n问题是：[text_question]",\
		assumed_control_message = "你是一名受召前来回答问题的祖灵：[text_question]",\
		after_assumed_control = CALLBACK(src, PROC_REF(ghost_name_prompt), TR)\
	)

	qdel(src)

/obj/ritual_rune/thaumaturgy/question/proc/ghost_name_prompt(mob/living/basic/ghost/tremere/ghost_mob)
	message_admins("[key_name_admin(ghost_mob)] has become a Tremere Ghost.")

	var/choice = tgui_alert(ghost_mob, "你想为幽灵身份取一个新名字吗？", "选择幽灵姓名", list("是", "否"), 10 SECONDS)
	if(choice == "是")
		var/chosen_ghost_name = tgui_input_text(ghost_mob, "你的幽灵新名字是什么？", "输入幽灵姓名")
		if(chosen_ghost_name)
			ghost_mob.real_name = chosen_ghost_name
			ghost_mob.name = chosen_ghost_name

	//poll_ignore_key = POLL_IGNORE_ANCESTOR_SPIRIT,
