/datum/discipline/mytherceria
	name = "Mytherceria"
	desc = {"妖灵术显现于奇亚希德、梅加尔等具有妖精血脉的吸血鬼身上。它赋予吸血鬼神秘感官、窃取知识的能力，以及其他属于妖精的力量。
● 妖精视界：被动
●● 暗妖诡术：被动
●●● 地精召唤：被动
●●●● 换生灵符印：被动
●●●●● 幻奇谜题：被动"}
	icon_state = "mytherceria"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/mytherceria

/datum/discipline_power/mytherceria
	name = "Mytherceria power name"
	desc = "Mytherceria power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/kiasyd.ogg'

//FEY SIGHT
/datum/discipline_power/mytherceria/fey_sight
	name = "妖精视界"
	desc = "感知他人携带的魔法物品。"

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	target_type = TARGET_MOB
	range = 7
	frenzy_usable = FALSE

	cooldown_length = 10 SECONDS

/datum/discipline_power/mytherceria/fey_sight/activate(mob/living/target)
	. = ..()
	to_chat(owner, span_purple("你的妖精感官向外延伸，探查对方携带的物品……"))
	for(var/obj/item/item in target.get_all_contents())
		/* Magic limbs.... should be fine?
		if(isorgan(item) || isbodypart(item))
			continue
		*/
		var/list/magic_sources = item.get_magic_sources()
		if(!length(magic_sources))
			continue
		to_chat(owner, span_purple("- [item.examine_title(owner)]"))

//DARKLING TRICKERY
/datum/discipline_power/mytherceria/darkling_trickery
	name = "暗妖诡术"
	desc = "从远处窃取受害者身上的小物件。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND | DISC_CHECK_LYING
	target_type = TARGET_LIVING
	range = 3
	frenzy_usable = FALSE

	cooldown_length = 30 SECONDS

/datum/discipline_power/mytherceria/darkling_trickery/activate(mob/living/target)
	. = ..()

	var/list/choices = list()
	for(var/obj/item/thing in target.get_all_contents())
		if(isorgan(thing) || isbodypart(thing) || HAS_TRAIT(thing, TRAIT_NODROP))
			continue
		choices[thing.name] = thing

	if(!length(choices))
		to_chat(owner, span_warning("[target]身上没有可偷的东西。"))
		return

	var/picked_name = tgui_input_list(owner, "选择要窃取的物品", "暗妖诡术", choices)
	var/obj/item/stolen_item = choices[picked_name]
	if(QDELETED(stolen_item) || !(stolen_item in target.get_all_contents()))
		return

	stolen_item.remove_item_from_storage(get_turf(owner), owner)
	owner.put_in_hands(stolen_item)

//GOBLINISM
/datum/discipline_power/mytherceria/goblinism
	name = "地精召唤"
	desc = "召唤一只顽劣的地精，让它扒住敌人的脸。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_MOB
	range = 5
	frenzy_usable = FALSE

	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 10 SECONDS

/datum/discipline_power/mytherceria/goblinism/activate(mob/living/target)
	. = ..()
	var/obj/item/clothing/mask/facehugger/kiasyd/goblin = new (get_turf(owner))
	goblin.throw_at(target, 10, 14, owner)

/obj/item/clothing/mask/facehugger/kiasyd
	name = "地精"
	desc = "一只绿色的换生灵生物。"
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "goblin"
	base_icon_state = "goblin"
	worn_icon_state = "goblin"
	sterile = TRUE
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/icons.dmi')

/obj/item/clothing/mask/facehugger/kiasyd/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.adjust_brute_loss(5)
		to_chat(user, span_warning("[src]咬人了！"))
		return
	. = ..()

/obj/item/clothing/mask/facehugger/kiasyd/die()
	qdel(src)

/obj/item/clothing/mask/facehugger/kiasyd/leap_to(mob/living/hit_mob)
	var/mob/living/carbon/human/target = astype(hit_mob)
	if(target)
		return FALSE
	if(target.wear_mask && istype(target.wear_mask, /obj/item/clothing/mask/facehugger/kiasyd))
		return FALSE
	target.visible_message(span_danger("[src]跃向[target]的脸！"), \
		span_userdanger("[src]跃向你的脸！"))

	if(target.head)
		var/obj/item/clothing/W = target.head
		target.dropItemToGround(W, TRUE)

	if(target.wear_mask)
		var/obj/item/clothing/W = target.wear_mask
		if(target.dropItemToGround(W, TRUE))
			target.visible_message(
				span_danger("[src]从[target]脸上扯下了[W]！"), \
				span_userdanger("[src]从你脸上扯下了[W]！"))
	target.equip_to_slot_if_possible(src, ITEM_SLOT_MASK, 0, 1, 1)
	var/datum/cb = CALLBACK(src,/obj/item/clothing/mask/facehugger/kiasyd/proc/eat_head)
	for(var/i in 1 to 10)
		addtimer(cb, (i - 1) * 1.5 SECONDS)
	spawn(16 SECONDS)
		qdel(src)
	return TRUE

/obj/item/clothing/mask/facehugger/kiasyd/proc/eat_head()
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc
		to_chat(C, span_warning("[src]正在啃食你的脸！"))
		C.apply_damage(5, BRUTE)

//CHANJELIN WARD
/datum/discipline_power/mytherceria/chanjelin_ward
	name = "换生灵符印"
	desc = "创造一道符印，使受害者迷失方向。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 5
	frenzy_usable = FALSE

	aggravating = TRUE
	hostile = TRUE

	duration_length = 5 SECONDS
	cooldown_length = 10 SECONDS

/datum/discipline_power/mytherceria/chanjelin_ward/activate(mob/living/target)
	. = ..()
	target.apply_status_effect(/datum/status_effect/confusion, 10 SECONDS)


//RIDDLE PHANTASTIQUE
/datum/discipline_power/mytherceria/riddle_phantastique
	name = "幻奇谜题"
	desc = "向受害者提出一道令人困惑的谜题，迫使其先作答才能做其他事情。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_SPEAK
	target_type = TARGET_LIVING
	range = 7
	frenzy_usable = FALSE

	cooldown_length = 0

	var/list/datum/riddle/stored_riddles = list()

/datum/discipline_power/mytherceria/riddle_phantastique/activate(mob/living/target)
	. = ..()
	if(length(stored_riddles))
		var/list/riddle_list = list("创建新谜题……")
		for(var/datum/riddle/riddle in stored_riddles)
			riddle_list += riddle.riddle_text
		var/try_riddle = tgui_input_list(owner, "选择一道谜题：", "谜题", riddle_list)
		if(try_riddle)
			if(try_riddle == "创建新谜题……")
				var/datum/riddle/riddle = new ()
				if(riddle.create_riddle(owner))
					stored_riddles += riddle
					riddle.ask(target)
					owner.say(riddle.riddle_text)
				return
			var/datum/riddle/actual_riddle
			for(var/datum/riddle/RIDDLE in stored_riddles)
				if(RIDDLE.riddle_text == try_riddle)
					actual_riddle = RIDDLE
			target.add_movespeed_modifier(/datum/movespeed_modifier/riddle)
			actual_riddle.ask(target)
			owner.say(actual_riddle.riddle_text)
	else
		var/datum/riddle/riddle = new ()
		if(riddle.create_riddle(owner))
			stored_riddles += riddle
			riddle.ask(target)
			owner.say(riddle.riddle_text)
		else
			qdel(riddle)

/datum/movespeed_modifier/riddle
	multiplicative_slowdown = 5

/datum/riddle
	var/riddle_text
	var/list/riddle_options = list()
	var/riddle_answer

/atom/movable/screen/alert/riddle
	name = "谜题"
	desc = "你有一道谜题需要解答！"
	icon_state = "riddle"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	var/datum/riddle/riddle
	var/bad_answers = 0

/atom/movable/screen/alert/riddle/Click()
	. = ..()
	if(iscarbon(usr) && (usr == owner))
		var/mob/living/carbon/M = usr
		if(riddle)
			riddle.try_answer(M, src)

/datum/riddle/proc/try_answer(mob/living/answerer, atom/movable/screen/alert/riddle/new_alert)
	var/try_answer = tgui_input_list(answerer, riddle_text, "谜题", shuffle(riddle_options.Copy()))
	if(try_answer)
		answer_riddle(answerer, try_answer, new_alert)

/datum/riddle/proc/ask(mob/living/asking)
	var/atom/movable/screen/alert/riddle/alert = asking.throw_alert("riddle", /atom/movable/screen/alert/riddle)
	alert.riddle = src

/datum/riddle/proc/create_riddle(mob/living/carbon/human/riddler)
	var/proceed = FALSE
	var/text_riddle = tgui_input_text(riddler, "创建一道谜题：", "谜题", "它是什么东西？")
	if(text_riddle)
		riddle_text = trim(copytext_char(sanitize(text_riddle), 1, MAX_MESSAGE_LEN))
		var/right_answer = tgui_input_text(riddler, "填写正确答案：", "谜题", "某样东西")
		if(right_answer)
			riddle_answer = trim(copytext_char(sanitize(right_answer), 1, MAX_MESSAGE_LEN))
			riddle_options += trim(copytext_char(sanitize(right_answer), 1, MAX_MESSAGE_LEN))
			proceed = TRUE
			var/answer1 = tgui_input_text(riddler, "填写另一个答案：", "谜题", "任何东西")
			if(answer1)
				riddle_options += trim(copytext_char(sanitize(answer1), 1, MAX_MESSAGE_LEN))
				var/answer2 = tgui_input_text(riddler, "填写另一个答案：", "谜题", "任何东西")
				if(answer2)
					riddle_options += trim(copytext_char(sanitize(answer2), 1, MAX_MESSAGE_LEN))
					var/answer3 = tgui_input_text(riddler, "填写另一个答案：", "谜题", "任何东西")
					if(answer3)
						riddle_options += trim(copytext_char(sanitize(answer3), 1, MAX_MESSAGE_LEN))
						var/answer4 = tgui_input_text(riddler, "填写另一个答案：", "谜题", "任何东西")
						if(answer4)
							riddle_options += trim(copytext_char(sanitize(answer4), 1, MAX_MESSAGE_LEN))
	if(proceed)
		to_chat(riddler, "新谜题已创建。")
		return src
	else
		to_chat(riddler, span_danger("你的谜题太复杂了。"))
		return FALSE

/datum/riddle/proc/answer_riddle(mob/living/answerer, the_answer, atom/movable/screen/alert/riddle/alert)
	if(the_answer != riddle_answer)
		alert.bad_answers++
		to_chat(answerer,
			span_danger("回答错误。"))
		if(alert.bad_answers >= round(length(riddle_options)/2))
			if(iscarbon(answerer))
				var/mob/living/carbon/C = answerer
				var/obj/item/organ/tongue/tongue = locate(/obj/item/organ/tongue) in C.organs
				if(tongue)
					tongue.Remove(C)
			to_chat(answerer,
				span_danger("谜题消散时，扯走了你说谎的舌头。"))
			answerer.remove_movespeed_modifier(/datum/movespeed_modifier/riddle)
			alert.bad_answers = 0
			alert.riddle = null
			answerer.clear_alert("riddle")
	else
		to_chat(answerer,
			span_nicegreen("你感觉谜题对你的束缚消失了。"))
		alert.riddle = null
		answerer.remove_movespeed_modifier(/datum/movespeed_modifier/riddle)
		answerer.say(the_answer)
		answerer.clear_alert("riddle")
