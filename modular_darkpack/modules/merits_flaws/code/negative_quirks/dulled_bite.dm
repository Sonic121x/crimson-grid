/datum/quirk/darkpack/dulled_bite
	name = "Dulled Bite"
	desc = "不知为何，你的獠牙始终发育不全，甚至可能根本没有长出。进食时，你必须另想办法让血液流出来。一些无氏族者和高世代吸血鬼常有这一缺陷。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 481)
	value = -2
	mob_trait = TRAIT_DULLFANGS
	gain_text = span_notice("你觉得自己的獠牙变钝了。")
	lose_text = span_notice("你觉得自己的獠牙变锋利了。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_TEETH
	failure_message = "你觉得自己的獠牙变锋利了。"
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/status_effect/dull_fangs // Applied when pliers are used on vampires without the dulled bite quirk.
	id = "dulled_fangs"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 SCENES // Around 30 minutes
	remove_on_fullheal = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/dull_fangs

/atom/movable/screen/alert/status_effect/dull_fangs
	name = "牙齿被拔除"
	desc = "你的犬齿被拔掉了！"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "default"

/datum/status_effect/dull_fangs/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_DULLFANGS, TRAIT_GENERIC)

/datum/status_effect/dull_fangs/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_DULLFANGS, TRAIT_GENERIC)

/datum/status_effect/dull_fangs/permanent // Applied when pliers are used on vampires without the dulled bite quirk.
	id = "dulled_fangs_permanent"
	status_type = STATUS_EFFECT_UNIQUE
	duration = -1 // Lasts all round.
	remove_on_fullheal = FALSE // Doesn't remove on fullheal.
	alert_type = /atom/movable/screen/alert/status_effect/dull_fangs
