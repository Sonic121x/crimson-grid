/datum/quirk/darkpack/seizures
	name = "Seizures"
	desc = {"面对巨大压力时，你会失去对身体的控制。
	重要检定出现大失败时，进行意志力检定（难度 8）。
	若取得的成功数少于三个，你就会不受控制地抽搐。"}
	icon = FA_ICON_BRAIN
	value = -4 // Made up since its not a "real" flaw and is instead listed in the crinos-born section
	gain_text = span_warning("你觉得自己的身体越来越不受控制……")
	lose_text = span_notice("你觉得自己更能控制身体了。")
	ttrpg_sources = list(/datum/source_book/wta20 = 75)
	COOLDOWN_DECLARE(seizure_cooldown)

/datum/quirk/darkpack/seizures/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_LIVING_DICE_ROLLED, PROC_REF(on_dice_rolled))

/datum/quirk/darkpack/seizures/remove()
	UnregisterSignal(quirk_holder, COMSIG_LIVING_DICE_ROLLED)

/datum/quirk/darkpack/seizures/proc/on_dice_rolled(mob/living/roller, datum/storyteller_roll/roll_datum, atom/target, output)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, seizure_cooldown))
		return

	if(roll_datum.spammy_roll)
		return

	if(roll_datum.numerical)
		if(output >= 0)
			return
	else
		if(output != ROLL_BOTCH)
			return

	var/datum/storyteller_roll/seizures/seizure_roll_datum = new()
	var/result = seizure_roll_datum.st_roll(roller)

	if(result == ROLL_SUCCESS)
		return

	roller.apply_status_effect(/datum/status_effect/seizure/flaw)
	COOLDOWN_START(src, seizure_cooldown, 1 SCENES)


/datum/status_effect/seizure/flaw
	dur_min = 25 SECONDS
	dur_max = 35 SECONDS


/datum/storyteller_roll/seizures
	bumper_text = "抽搐发作"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	difficulty = 8
	successes_needed = 3
	roll_output_type = ROLL_FLAG_ROLLER
