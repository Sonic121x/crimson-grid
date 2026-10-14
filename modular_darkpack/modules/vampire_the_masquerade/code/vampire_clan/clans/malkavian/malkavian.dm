GLOBAL_LIST_EMPTY(madness_network)

/datum/subsplat/vampire_clan/malkavian
	name = "Malkavian"
	id = VAMPIRE_CLAN_MALKAVIAN
	desc = "魔卡维被其他吸血鬼讥为疯子，但其血脉让他们能够感知、预言旁人无从知晓的真相。如同诗歌中睿智的狂人，他们破碎的视角源于同时看见太多、理解太深，以及感受过于强烈而难以承受。超自然疯狂的诅咒带给他们令人不安的洞见、幻象与预感。他们大多忠于密党，既是先知、操纵者与预言家，也可能扮演愚者。大恶作剧被解除后，惑狂术重回氏族，但仍有些成员不知为何保留了支配术，见“支配派魔卡维”。每名魔卡维都承受着独特的精神失常，由此形成各自感受世界的方式。"
	icon = "malkavian"
	curse = "精神失常。"
	roleplay_level = "Advanced"
	sense_the_sin_text = "令周围的人感到恐惧。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dementation,
		/datum/discipline/obfuscate,
	)
	male_clothes = /obj/item/clothing/under/vampire/malkavian
	female_clothes = /obj/item/clothing/under/vampire/malkavian/female
	subsplat_keys = /obj/item/vamp/keys/malkav

/datum/subsplat/vampire_clan/malkavian/dominate
	name = "Dominate Malkavian"
	id = VAMPIRE_CLAN_DOMINATE_MALKAVIAN
	icon = "dominate_malkavian"
	roleplay_level = "Beginner Friendly"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/obfuscate,
	)

/datum/subsplat/vampire_clan/malkavian/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	var/datum/action/cooldown/malk_hivemind/hivemind = new(gaining_mob)
	hivemind.Grant(gaining_mob)
	var/datum/action/cooldown/malk_speech/malk_font = new(gaining_mob)
	malk_font.Grant(gaining_mob)

	gaining_mob.add_quirk(/datum/quirk/darkpack/derangement)

	GLOB.madness_network += gaining_mob
	RegisterSignal(gaining_mob, COMSIG_MOB_SAY, PROC_REF(handle_say))
	RegisterSignal(gaining_mob, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hear))

/datum/subsplat/vampire_clan/malkavian/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()

	for (var/datum/action/cooldown/malkavian_action in losing_mob.actions)
		if (!istype(malkavian_action, /datum/action/cooldown/malk_hivemind) && !istype(malkavian_action, /datum/action/cooldown/malk_speech))
			continue
		malkavian_action.Remove(losing_mob)

	losing_mob.remove_quirk(/datum/quirk/darkpack/derangement)

	GLOB.madness_network -= losing_mob
	UnregisterSignal(losing_mob, COMSIG_MOB_SAY)
	UnregisterSignal(losing_mob, COMSIG_MOVABLE_HEAR)

/datum/subsplat/vampire_clan/malkavian/proc/handle_say(mob/living/source, list/speech_args)
	SIGNAL_HANDLER

	if (!prob(20))
		return

	say_in_madness_network(speech_args[SPEECH_MESSAGE])

/datum/subsplat/vampire_clan/malkavian/proc/handle_hear(mob/living/source, list/hearing_args)
	SIGNAL_HANDLER

	if(!prob(3))
		return

	say_in_madness_network(hearing_args[HEARING_RAW_MESSAGE])

/datum/subsplat/vampire_clan/malkavian/proc/say_in_madness_network(message)
	for (var/mob/living/malkavian in GLOB.madness_network)
		to_chat(malkavian, span_ghostalert(message))

/datum/action/cooldown/malk_hivemind
	name = "集体心智"
	desc = "交谈"
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "hivemind"
	check_flags = AB_CHECK_CONSCIOUS
	vampiric = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/malk_hivemind/Trigger(mob/clicker, trigger_flags, atom/target)
	. = ..()
	var/mob/living/carbon/human/malk = clicker
	if (!malk.is_clan(/datum/subsplat/vampire_clan/malkavian))
		return
	var/datum/subsplat/vampire_clan/malkavian/clan_malkavian = malk.get_clan()
	var/new_thought = tgui_input_text(clicker, "魔卡维集体心智")
	if(!new_thought)
		return
	StartCooldown()
	clan_malkavian.say_in_madness_network(new_thought)
	message_admins("[ADMIN_LOOKUPFLW(usr)] said \"[new_thought]\" through the Madness Network.")
	log_game("[key_name(usr)] said \"[new_thought]\" through the Madness Network.")

/datum/action/cooldown/malk_speech
	name = "疯狂低语"
	desc = "释放内心深处的思绪"
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "malk_speech"
	check_flags = AB_CHECK_CONSCIOUS
	vampiric = TRUE
	cooldown_time = 5 SECONDS

/datum/action/cooldown/malk_speech/Trigger(mob/clicker, trigger_flags, atom/target)
	. = ..()
	var/malkavian_spans = list("singing", "bold")
	var/mad_speak = tgui_input_text(clicker, "魔卡维疯狂低语", encode = FALSE)
	if(CAN_BYPASS_FILTER(clicker) ? null : is_ic_filtered(mad_speak))
		//before we inadvertently obfuscate the message to pass filters, filter it first.
		//as funny as malkavians saying "amogus" would be, the filter also includes slurs... how unfortunate.
		to_chat(clicker, span_warning("该消息包含角色内聊天禁用的词语！请查阅服务器规则。\n<span replaceRegex='show_filtered_ic_chat'>\"[mad_speak]\"</span>"))
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, LOWER_TEXT(config.ic_filter_regex.match))
		return
	if(!mad_speak)
		return
	StartCooldown()
	mad_speak = spooky_font_replace(mad_speak) // replace some letters to make the font more closely resemble that of vtm: bloodlines' malkavian dialogue
	clicker.say(mad_speak, spans = list(malkavian_spans))

/datum/subsplat/vampire_clan/malkavian/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg", 50, FALSE)
	target.Paralyze(6 SECONDS)
	target.visible_message(span_warning("[target] repeatedly bashes their head against the ground"), span_cult("THE WHISPERS ARE OVERTAKING ME"))
	target.apply_damage(50, BRUTE, BODY_ZONE_HEAD) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
