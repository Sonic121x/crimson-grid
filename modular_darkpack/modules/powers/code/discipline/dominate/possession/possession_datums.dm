/datum/possession_controller
	var/datum/weakref/vampire_original
	var/datum/weakref/mortal_body
	var/datum/weakref/mortal_observer
	var/possession_active = FALSE

/datum/possession_controller/New(mob/living/carbon/human/vampire, mob/living/carbon/human/mortal)
	vampire_original = WEAKREF(vampire)
	mortal_body = WEAKREF(mortal)
	start_possession()

/datum/possession_controller/proc/start_possession()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()

	var/mob/living/possession_observer/observer = new(mortal, src)
	mortal_observer = WEAKREF(observer)
	observer.ckey = mortal.ckey
	observer.name = mortal.real_name
	observer.real_name = mortal.real_name
	if(mortal.mind)
		observer.mind = mortal.mind

	mortal.ckey = vamp.ckey
	mortal.mind = vamp.mind

	var/datum/action/end_possession/end_action = new(src)
	end_action.Grant(mortal)

	vamp.toggle_resting()
	vamp.visible_message(span_warning("[vamp]双眼翻白，瘫倒在地，陷入僵直失神的状态！"))
	possession_active = TRUE
	RegisterSignal(mortal, COMSIG_LIVING_DEATH, PROC_REF(handle_death_during_possession))

/datum/possession_controller/proc/end_possession()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()

	if(mortal.stat == DEAD)
		handle_death_during_possession()
		return

	to_chat(vamp, span_warning("你退出了[mortal.real_name]的心灵，回到自己的肉身。"))

	vamp.ckey = mortal.ckey
	if(mortal.mind)
		vamp.mind = mortal.mind

	var/mob/living/possession_observer/observer = mortal_observer?.resolve()
	if(observer?.ckey)
		mortal.ckey = observer.ckey
		if(observer.mind)
			mortal.mind = observer.mind
		to_chat(mortal, span_notice("外来的意识退去，你的意识重新回到了自己的身体。"))
	log_combat(vamp, mortal, "Has ended their Possession ")
	mortal.possessed = FALSE
	cleanup()
	UnregisterSignal(mortal, COMSIG_LIVING_DEATH)

/datum/possession_controller/proc/handle_death_during_possession()
	SIGNAL_HANDLER
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()
	var/mob/living/possession_observer/observer = mortal_observer?.resolve()

	to_chat(vamp, span_boldwarning("宿主的死亡将你从其心灵中猛地驱逐了出来！"))
	vamp.ckey = mortal.ckey
	if(mortal.mind)
		vamp.mind = mortal.mind

	vamp.adjust_brute_loss(50)
	vamp.visible_message(span_danger("[vamp]突然剧烈抽搐，随即陷入了仿佛昏迷的状态！"))
	to_chat(vamp, span_boldwarning("宿主死亡带来的精神冲击使你陷入长眠！"))
	vamp.torpor(DAMAGE_TRAIT)

	if(observer)
		to_chat(observer, span_boldwarning("你离体期间，肉身已经死亡。你的意识渐渐消逝于虚无……"))
		observer.ghostize()

	cleanup()

/datum/possession_controller/proc/cleanup()
	var/mob/living/carbon/human/vamp = vampire_original?.resolve()
	var/mob/living/carbon/human/mortal = mortal_body?.resolve()
	var/mob/living/possession_observer/observer = mortal_observer?.resolve()
	possession_active = FALSE
	if(vamp)
		for(var/datum/action/end_possession/action in vamp.actions)
			action.controller = null
			action.Remove(action.owner)
			qdel(action)
	if(mortal)
		UnregisterSignal(mortal, COMSIG_LIVING_DEATH)
		for(var/datum/action/end_possession/action in mortal.actions)
			action.controller = null
			action.Remove(action.owner)
			qdel(action)
	if(observer)
		observer.controller = null
		qdel(observer)
	qdel(src)

/mob/living/possession_observer
	name = "离体意识"
	real_name = "离体意识"
	var/datum/weakref/possessed_body
	var/datum/weakref/controller

/mob/living/possession_observer/Initialize(mapload, datum/possession_controller/possessor)
	if(iscarbon(loc))
		possessed_body = WEAKREF(loc)
		controller = WEAKREF(possessor)
	return ..()

/mob/living/possession_observer/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	to_chat(src, span_warning("一股超自然力量将你的意识逐出了肉身。另一个心灵控制着你的身体，你只能旁观。"))
	to_chat(src, span_notice("你无法行动，但仍能观察和思考。祈祷入侵者早日放弃控制吧……"))

/mob/living/possession_observer/say(message,bubble_type,list/spans = list(),sanitize = TRUE,datum/language/language,ignore_spam = FALSE,forced,filterproof = FALSE,message_range = 7,datum/saymode/saymode,list/message_mods = list())
	to_chat(src, span_warning("意识离体时，你无法发出声音！"))
	return FALSE

/mob/living/possession_observer/emote(act, m_type = null, message = null, intentional = FALSE)
	to_chat(src, span_warning("意识离体时，你无法做出任何表情动作！"))
	return FALSE

/datum/action/end_possession
	name = "结束附身"
	desc = "放弃对被附身者身体的控制，回到自己的肉身。"
	button_icon_state = "possession_end"
	check_flags = NONE
	var/datum/weakref/controller

/datum/action/end_possession/New(datum/possession_controller/possessor)
	controller = WEAKREF(possessor)
	..()

/datum/action/end_possession/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	var/datum/possession_controller/possessor = controller?.resolve()
	if(!possessor)
		Remove(owner)
		qdel(src)
		return FALSE
	possessor.end_possession()
