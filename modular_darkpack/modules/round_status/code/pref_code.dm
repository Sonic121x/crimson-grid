/// Preliminary wrapper for the prefs write_preference_midround that ensures your acctually on the same character as the one you spawned in as.
/mob/living/carbon/human/proc/write_preference_midround(datum/preference/preference, preference_value)
	if(!(client?.prefs))
		return FALSE
	var/fail_to_save_reason = cant_save_midround_reason()
	return client.prefs.write_preference_midround(GLOB.preference_entries[preference], preference_value, src, fail_to_save_reason)

/// Wrapper for write_preference to prevent writing for non-canon events like EORG
/// Returns TRUE for a successful preference application.
/// Returns FALSE if it is invalid or the round was not canon.
/datum/preferences/proc/write_preference_midround(datum/preference/preference, preference_value, mob/user, fail_to_save_reason)
	if(fail_to_save_reason)
		to_chat(parent, span_warning("无法保存偏好设置：[preference.savefile_key]；[fail_to_save_reason]"))
		user.log_message("failed to write pref: [preference.savefile_key] due to; [fail_to_save_reason]", LOG_STATS)
		return FALSE

	to_chat(parent, span_info("已将偏好设置[preference.savefile_key]保存为\"[preference_value]\"。"))
	user.log_message("wrote to pref '[preference.savefile_key]' midround. set to '[preference_value]'", LOG_STATS)
	var/result = write_preference(preference, preference_value)
	save_character()
	return result

/mob/living/carbon/human/proc/cant_save_midround_reason()
	if(!GLOB.canon_event)
		return "当前回合不计入正史。"
	if(HAS_TRAIT(src, TRAIT_NO_CANON))
		return "当前角色不计入正史。"

	if(!(client?.prefs))
		return "没有偏好设置数据。"
	if(!(mind?.original_character_slot_index))
		return "心智缺少原始角色栏位索引。"

	var/mob/living/carbon/human/original_human = mind.original_character.resolve()
	if(!original_human || (original_human != src))
		return "当前角色并非最初加入回合的角色。"

	else if(!("[client.prefs.default_slot]" in persistent_client.joined_as_slots))
		return "所选角色卡尚未用于加入本回合。"

	return FALSE
