// W20 p. 161
/datum/action/cooldown/power/gift/blur_of_the_milky_eye
	name = "朦胧之眼"
	desc = "狼人的身形化作微光闪烁的朦胧影像，使其能够在人群中悄然穿行。"
	button_icon_state = "blur_of_the_milky_eye"
	cooldown_time = 1 SCENES
	rank = 1

/datum/action/cooldown/power/gift/blur_of_the_milky_eye/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)

	var/datum/storyteller_roll/roll_datum = new()
	roll_datum.applicable_stats = list(STAT_MANIPULATION, STAT_STEALTH)
	roll_datum.difficulty = 8
	roll_datum.roll_output_type = ROLL_FLAG_ROLLER
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result == ROLL_SUCCESS)
		living_owner?.apply_status_effect(/datum/status_effect/blur_of_the_milky_eye)

/datum/status_effect/blur_of_the_milky_eye
	id = "blur_of_the_milky_eye"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/blur_of_the_milky_eye

/datum/status_effect/blur_of_the_milky_eye/on_apply()
	. = ..()
	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/milky_blur.ogg', 75, FALSE)
	owner.alpha = 50
	apply_wibbly_filters(owner)

/datum/status_effect/blur_of_the_milky_eye/on_remove()
	owner.alpha = initial(owner.alpha)
	remove_wibbly_filters(owner)
	return ..()

/atom/movable/screen/alert/status_effect/gift/blur_of_the_milky_eye
	name = /datum/action/cooldown/power/gift/blur_of_the_milky_eye::name
	desc = /datum/action/cooldown/power/gift/blur_of_the_milky_eye::desc
	overlay_state = /datum/action/cooldown/power/gift/blur_of_the_milky_eye::button_icon_state


/datum/action/cooldown/power/gift/infectious_laughter
	name = "传染之笑"
	desc = "新月诡术者发笑时，周围的人也会不由自主地跟着笑，忘却怨恨。此能力使用你最后说出的一句话。"
	button_icon_state = "infectious_laughter"
	rank = 1
	// I dont acctually see anything in the book that is causes rage.
	// rage_cost = 1
	var/last_spoken_message
	var/when_spoken = 0

/datum/action/cooldown/power/gift/infectious_laughter/Grant(mob/granted_to)
	. = ..()

	RegisterSignal(granted_to, COMSIG_MOB_SAY, PROC_REF(on_mob_say))

/datum/action/cooldown/power/gift/infectious_laughter/Remove(mob/removed_from)
	. = ..()

	UnregisterSignal(removed_from, COMSIG_MOB_SAY)

/datum/action/cooldown/power/gift/infectious_laughter/proc/on_mob_say(datum/source, list/speech_args)
	SIGNAL_HANDLER

	last_spoken_message = speech_args[SPEECH_MESSAGE]
	when_spoken = world.time
	build_all_button_icons(UPDATE_BUTTON_STATUS)

/datum/action/cooldown/power/gift/infectious_laughter/IsAvailable(feedback)
	. = ..()
	if(!last_spoken_message || (when_spoken + 3 TURNS < world.time))
		if(feedback)
			to_chat(owner, span_warning("你刚才没有说过调侃当前情景的话！"))
		return FALSE

/datum/action/cooldown/power/gift/infectious_laughter/Activate(atom/target)
	if(!last_spoken_message || (when_spoken + 3 TURNS < world.time))
		return

	. = ..()

	owner.emote("laugh")
	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/infectious_laughter.ogg', 50, FALSE)
	var/list/hearers = oviewers(DEFAULT_MESSAGE_RANGE, owner)
	var/highest_diff = 0
	for(var/mob/living/dice_guy in hearers)
		var/datum/splat/werewolf/rage_haver = get_werewolf_splat(dice_guy)
		if(!rage_haver)
			continue
		highest_diff = max(highest_diff, rage_haver.rage)
	var/datum/storyteller_roll/roll_datum = new()
	roll_datum.applicable_stats = list(STAT_MANIPULATION, STAT_EMPATHY)
	roll_datum.difficulty = highest_diff
	var/roll = roll_datum.st_roll(owner)
	if(roll == ROLL_SUCCESS)
		for(var/mob/living/hearer in hearers)
			to_chat(hearer, span_hypnophrase("那句话在你脑海中回荡：“[last_spoken_message]”。你几乎想不起自己刚才为何生气。"))
			hearer.emote("laugh")

	last_spoken_message = null
	when_spoken = 0

	// laughers.emote("laugh")


/datum/storyteller_roll/gift/open_seal
	roll_output_type = ROLL_FLAG_ROLLER

/datum/action/cooldown/power/gift/open_seal
	name = "启封"
	desc = "凭借此天赋，狼人几乎能打开任何封闭或上锁的实体装置。"
	button_icon_state = "open_seal"
	click_to_activate = TRUE
	rank = 1
	gnosis_cost = 1

/datum/action/cooldown/power/gift/open_seal/Activate(atom/target)
	. = ..()

	var/datum/splat/werewolf/our_splat = get_werewolf_splat(owner)

	var/roll_result = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/gift/open_seal, bonus = our_splat.permanent_gnosis, difficulty = target.get_gauntlet_rating())
	if(roll_result == ROLL_SUCCESS)
		var/turf/target_turf = get_turf(target)
		SEND_SIGNAL(target_turf, COMSIG_ATOM_MAGICALLY_UNLOCKED, src, owner)
		playsound(owner, 'sound/effects/magic/knock.ogg', 50, FALSE)

	StartCooldown()
	return TRUE
