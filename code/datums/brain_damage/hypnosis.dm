/datum/brain_trauma/hypnosis
	name = "催眠"
	desc = "患者的潜意识完全受某个词语或句子支配，思想与行动都围绕它展开。"
	scan_desc = "循环思维模式"
	symptoms = "执着于某个特定的词语或短句。这种执念可能改变行为，\
		例如优先采取与该短句有关的行动，而忽视工作、自身需求或社交。"
	gain_text = ""
	lose_text = ""
	resilience = TRAUMA_RESILIENCE_SURGERY
	/// Associated antag datum, used for displaying objectives and antag hud
	var/datum/antagonist/hypnotized/antagonist
	var/hypnotic_phrase = ""
	var/regex/target_phrase

/datum/brain_trauma/hypnosis/New(phrase)
	if(!phrase)
		qdel(src)
		return
	hypnotic_phrase = phrase
	try
		target_phrase = new("(\\b[REGEX_QUOTE(hypnotic_phrase)]\\b)","ig")
	catch(var/exception/e)
		stack_trace("[e] on [e.file]:[e.line]")
		qdel(src)
	..()

/datum/brain_trauma/hypnosis/on_gain()
	message_admins("[ADMIN_LOOKUPFLW(owner)] was hypnotized with the phrase '[hypnotic_phrase]'.")
	owner.log_message("was hypnotized with the phrase '[hypnotic_phrase]'.", LOG_GAME)
	to_chat(owner, span_reallybig(span_hypnophrase("[hypnotic_phrase]")))
	to_chat(owner, span_notice("[pick(list(
			"不知为何，这些话听起来……很对。你觉得自己应该照着做。",
			"这些话在你的脑海中不断回响。你发现自己完全着了迷。",
			"你感觉脑海中有一部分在一遍遍重复这些话。你必须照着做。",
			"你的思绪不断集中到这句话上……怎么也无法将它抛诸脑后。",
			"你的头很痛，但脑中只有这些话。它们一定至关重要。",
	))]"))
	to_chat(owner, span_boldwarning("你被这句话催眠了，必须遵照其中的意思行动。\
		如果它不是明确的命令，你可以自由理解该如何执行，但必须将它视为最高优先事项。"))
	var/atom/movable/screen/alert/hypnosis/hypno_alert = owner.throw_alert(ALERT_HYPNOSIS, /atom/movable/screen/alert/hypnosis)
	owner.mind.add_antag_datum(/datum/antagonist/hypnotized)
	antagonist = owner.mind.has_antag_datum(/datum/antagonist/hypnotized)
	antagonist.trauma = src

	// Add the phrase to objectives
	var/datum/objective/fixation = new ()
	fixation.explanation_text = hypnotic_phrase
	fixation.completed = TRUE
	antagonist.objectives = list(fixation)

	hypno_alert.desc = "“[hypnotic_phrase]”……你的心思似乎完全被这个念头占据了。"
	. = ..()

/datum/brain_trauma/hypnosis/on_lose()
	message_admins("[ADMIN_LOOKUPFLW(owner)] is no longer hypnotized with the phrase '[hypnotic_phrase]'.")
	owner.log_message("is no longer hypnotized with the phrase '[hypnotic_phrase]'.", LOG_GAME)
	to_chat(owner, span_userdanger("你突然从催眠中清醒过来。“[hypnotic_phrase]”这句话对你而言已不再重要。"))
	owner.clear_alert(ALERT_HYPNOSIS)
	..()
	if (!isnull(antagonist))
		antagonist.trauma = null
	owner.mind.remove_antag_datum(/datum/antagonist/hypnotized)
	antagonist = null

/datum/brain_trauma/hypnosis/on_life(seconds_per_tick)
	..()
	if(SPT_PROB(1, seconds_per_tick))
		if(prob(50))
			to_chat(owner, span_hypnophrase("<i>...[LOWER_TEXT(hypnotic_phrase)]...</i>"))
		else
			owner.cause_hallucination( \
				/datum/hallucination/chat, \
				"hypnosis", \
				force_radio = TRUE, \
				specific_message = span_hypnophrase("[hypnotic_phrase]"), \
			)

/datum/brain_trauma/hypnosis/handle_hearing(datum/source, list/hearing_args)
	if(HAS_TRAIT(owner, TRAIT_DEAF) || owner == hearing_args[HEARING_SPEAKER])
		return
	hearing_args[HEARING_RAW_MESSAGE] = target_phrase.Replace(hearing_args[HEARING_RAW_MESSAGE], span_hypnophrase("$1"))
