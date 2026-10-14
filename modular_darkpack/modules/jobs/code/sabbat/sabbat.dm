/datum/antagonist/sabbatist
	name = "Sabbatist"
	roundend_category = "sabbattites"
	antagpanel_category = FACTION_SABBAT
	pref_flag = ROLE_SABBAT
	antag_moodlet = /datum/mood_event/revolution
	antag_hud_name = "pack"
	ui_name = null
	hud_icon = 'modular_darkpack/modules/jobs/icons/sabbat.dmi'

/datum/antagonist/sabbatist/apply_innate_effects(mob/living/mob_override)
	. = ..()
	add_team_hud(owner.current, /datum/antagonist/sabbatist)

/datum/antagonist/sabbatist/on_removal()
	to_chat(owner.current, span_userdanger("你不再是魔宴同盟的一员！"))
	return ..()

/datum/antagonist/sabbatist/greet()
	to_chat(owner.current, span_alertsyndie("你现在是魔宴同盟的一员了。"))
	//owner.announce_objectives()
