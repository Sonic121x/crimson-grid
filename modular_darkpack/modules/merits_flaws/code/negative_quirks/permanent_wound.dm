// VTM pg. 482-483
/datum/quirk/darkpack/permanent_wound
	name = "Permanent Wound"
	desc = {"你在初拥时受了伤，不知为何，转化并未修复这些伤势。
每晚开始时，你都会带着重伤从沉睡中醒来。"}
	value = -3
	gain_text = span_notice("一处未愈合的伤口隐隐作痛。")
	lose_text = span_notice("你不再感到伤口的疼痛。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_USER_INJURED
	failure_message = span_notice("你不再感到伤口的疼痛。")
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/*You suffered injuries during your Embrace which your transformation somehow failed to repair.
At the beginning of each night,
you rise from sleep at the Wounded health level, though this may be healed by spending blood points.*/

/datum/quirk/darkpack/permanent_wound/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.adjust_agg_loss(90, TRUE)
