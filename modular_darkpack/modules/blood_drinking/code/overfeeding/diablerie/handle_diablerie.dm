/mob/living/carbon/human/proc/handle_diablerie(mob/living/victim)

	var/diablerie_prompt = tgui_alert(src, "尝试对[victim]实施血噬？", "血噬", list("是", "否"), "否")
	switch(diablerie_prompt)
		if("是")
			var/datum/splat/vampire/kindred/kindred = get_kindred_splat(src)
			var/generation = get_generation()
			var/victim_generation = victim.get_generation()

			if(kindred)
				SEND_SIGNAL(victim, COMSIG_PATH_HIT, -1, 0, FALSE)
			if(victim_generation >= generation)
				message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(victim)]")
				log_attack("[key_name(src)] successfully Diablerized [key_name(victim)].")
				if(victim.client)
					var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
					trauma.friend.key = victim.key
			else
				var/start_prob = 10
				if(HAS_TRAIT(src, TRAIT_DIABLERIE))
					start_prob = 30
				if(prob(min(99, start_prob+((generation-victim_generation)*10))))
					to_chat(src, span_userdanger(span_bold("[victim]的灵魂压倒了你的灵魂，夺取了身体的控制权！")))
					message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(victim)] and was overtaken.")
					log_attack("[key_name(src)] tried to Diablerize [key_name(victim)] and was overtaken.")
					kindred.set_generation(victim_generation)
					if(victim.mind)
						victim.mind.transfer_to(src, TRUE)
					else
						death()
					return
				message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(victim)]")
				log_attack("[key_name(src)] successfully Diablerized [key_name(victim)].")
				if(victim.client)
					var/datum/brain_trauma/special/imaginary_friend/diablerie/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend/diablerie)
					trauma.friend.key = victim.key

			make_diablerist()
			adjust_brute_loss(-50, TRUE)
			adjust_fire_loss(-50, TRUE)
			victim.death()
		if("否")	//Defaults to this if no if option not chosen to avoid issue.
			return FALSE
