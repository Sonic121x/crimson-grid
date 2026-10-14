// V20 core rulebook pg. 233
/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk
	name = "夜鹰之眼"
	desc = "将渡鸦或其他猛禽置于仪式圈中，施术者即可通过此仪式将心智植入鸟的脑海。结束借鸟眼观察后，施术者必须毁去鸟的双眼并将其杀死，否则自己便会失明。"
	icon_state = "rune7"
	word = ""
	level = 2

/obj/ritual_rune/thaumaturgy/eyes_of_the_night_hawk/complete()
	. = ..()
	var/mob/living/basic/corvid/target = locate(/mob/living/basic/corvid) in get_turf(src) // expand beyond corvid when more bird types are added
	if(!target)
		to_chat(last_activator, span_warning("仪式圈中没有鸟。"))
		return

	var/datum/action/return_to_body/return_to_body_action = new(last_activator)
	return_to_body_action.Grant(target)
	return_to_body_action.possessor_ckey = last_activator.ckey
	return_to_body_action.possessor_original_mob = last_activator
	return_to_body_action.possessed_bird = target
	target.PossessByPlayer(last_activator.ckey)

/datum/action/return_to_body
	name = "回归肉身"
	desc = "切断你与渡鸦之间的心智联系，回到自己的身体。"
	button_icon = 'modular_darkpack/modules/powers/icons/actions.dmi'
	button_icon_state = "thaumaturgy"
	var/mob/living/possessor_original_mob
	var/possessor_ckey
	var/mob/living/possessed_bird

/datum/action/return_to_body/Trigger(mob/clicker, trigger_flags)
	. = ..()
	possessor_original_mob.PossessByPlayer(possessor_ckey)
	Remove(owner)
	to_chat(possessor_original_mob, span_cult("你感觉视野逐渐模糊、黯淡……"))
	addtimer(CALLBACK(src, PROC_REF(check_bird_dead)), 1 SCENES, TIMER_STOPPABLE)

/datum/action/return_to_body/proc/check_bird_dead()
	if(!possessed_bird || QDELETED(possessed_bird) || possessed_bird.stat == DEAD)
		return // bird is dead, all good
	possessor_original_mob.become_blind(MAGIC_TRAIT)
	to_chat(possessor_original_mob, span_warning("你的心智仍滞留在渡鸦体内。你失明了，直到下次日出才会恢复。也许你本该更仔细地研读这个仪式……"))
