/obj/ritual_rune/necromancy/truth
	name = "祈求暗影恩典"
	desc = "唤出受害者心中的暗影，逼其吐露最黑暗的真相。"
	icon_state = "rune8"
	word = "MIKHH' AHPP"
	level = 3

/obj/ritual_rune/necromancy/truth/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("你不能对自己施行此仪式。"))
			return
		if(targetbody.stat == DEAD)
			to_chat(usr, span_warning("目标已经死去，将秘密一同带进了坟墓！"))
			return
		else
			valid_bodies += targetbody

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("仪式的受害者必须留在符文上。"))
		return

	var/mob/living/carbon/victim = pick(valid_bodies)
	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

	to_chat(usr, span_ghostalert("你驱使[victim.name]的暗影反噬其自身；对方现在无法对你说谎。"))

	playsound(victim,'sound/effects/hallucinations/veryfar_noise.ogg',50,TRUE)
	playsound(victim,'sound/music/antag/bloodcult/ghost_whisper.ogg',50,TRUE)

	victim.emote("scream")
	victim.AdjustKnockdown(2 SECONDS)
	victim.do_jitter_animation(3 SECONDS)

	to_chat(victim, span_revenboldnotice("你的嘴猛然张开，吸入的空气似乎怎么也留不住。"))
	to_chat(victim, span_revenboldnotice("你藏着的所有黑暗秘密，还没来得及想起，便已脱口而出。"))
	to_chat(victim, span_hypnophrase("你无法说谎。"))

	visible_message(span_danger("[victim.name]的影子在其身下剧烈挣扎，仿佛另一个独立的生命！"))
	addtimer(CALLBACK(victim, TYPE_PROC_REF(/datum/necrorune/truth, wearoff), victim), 2 MINUTES)
	qdel(src)

/datum/necrorune/truth/proc/wearoff(mob/living/carbon/victim)
	if(!victim)
		return
	to_chat(victim, span_notice("灵魂受到的束缚松开了，你感觉自己又能守住秘密了。"))
