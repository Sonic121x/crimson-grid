/mob/proc/start_blood_hunt(reason)
	SSbloodhunt.hunted |= src
	ADD_TRAIT(src, TRAIT_HUNTED, "bloodhunt")
	SSbloodhunt.update_alert()
	for(var/player_mob in GLOB.kindred_list)
		to_chat(player_mob, span_bold("已宣布对[span_warning("[real_name]")]发起血猎！<br>理由：[reason]"))
		SEND_SOUND(player_mob, sound('modular_darkpack/master_files/sounds/announce.ogg'))


/mob/proc/clear_blood_hunt()
	SSbloodhunt.hunted -= src
	REMOVE_TRAIT(src, TRAIT_HUNTED, "bloodhunt")
	SSbloodhunt.update_alert()
	for(var/player_mob in GLOB.kindred_list)
		to_chat(player_mob, span_bold("针对[span_green("[real_name]")]的血猎已结束！"))
		SEND_SOUND(player_mob, sound('modular_darkpack/master_files/sounds/announce.ogg'))
