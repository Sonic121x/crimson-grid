/datum/martial_art/jungle_arts
	name = "丛林搏击术"
	id = MARTIALART_JUNGLEARTS
	pacifist_style = TRUE

/datum/martial_art/jungle_arts/disarm_act(mob/living/attacker, mob/living/defender)
	return jungle_attack(attacker, defender)

/datum/martial_art/jungle_arts/grab_act(mob/living/attacker, mob/living/defender)
	return jungle_attack(attacker, defender, TRUE)

/datum/martial_art/jungle_arts/harm_act(mob/living/attacker, mob/living/defender)
	return jungle_attack(attacker, defender)

/datum/martial_art/jungle_arts/proc/jungle_attack(mob/living/attacker, mob/living/defender, grab_attack)
	var/atk_verb
	switch(rand(1,6))
		if(1)
			atk_verb = "dragged"
			var/obj/item/organ/tail/tail = attacker.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
			if(isnull(tail) && IS_UNCONSCIOUS_OR_CRIT(defender) || defender.IsParalyzed())
				return MARTIAL_ATTACK_INVALID

			attacker.do_attack_animation(defender, ATTACK_EFFECT_CLAW)
			attacker.emote("spin")
			defender.visible_message(
				span_danger("[attacker]的尾巴将[defender]拖倒在地！"),
				span_userdanger("[attacker]的尾巴将你拖倒在地，你的身体随之扭转！"),
				span_hear("你听到一声脆响，随后是重物落地的闷响！"),
				null,
				attacker,
			)
			to_chat(attacker, span_danger("你用尾巴缠住[defender]，将其拖倒在地！"))
			defender.apply_damage(rand(5, 10), attacker.get_attack_type())
			playsound(attacker, 'sound/items/weapons/whip.ogg', 50, TRUE, -1)
			defender.Knockdown(2 SECONDS)
			if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
				attacker.add_mood_event("bypassed_pacifism", /datum/mood_event/pacifism_bypassed)

		if(6)
			var/obj/item/organ/tail/tail = attacker.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
			if(isnull(tail))
				return MARTIAL_ATTACK_INVALID

			atk_verb = pick("whipped", "flogged", "lashed")
			attacker.do_attack_animation(defender, ATTACK_EFFECT_CLAW)
			defender.visible_message(
				span_danger("[attacker]的尾巴迅速[list("whipped" = "抽打", "flogged" = "鞭打", "lashed" = "猛抽")[atk_verb]]了[defender]！"),
				span_userdanger("你被[attacker][list("whipped" = "抽打", "flogged" = "鞭打", "lashed" = "猛抽")[atk_verb]]，感到一阵剧烈的刺痛！"),
				span_hear("你听到一声尖锐的鞭响！"),
				null,
				attacker,
			)
			to_chat(attacker, span_danger("你动作利落地[list("whipped" = "抽打", "flogged" = "鞭打", "lashed" = "猛抽")[atk_verb]]了[defender]！"))
			defender.apply_damage(rand(10, 15), attacker.get_attack_type())
			playsound(attacker, 'sound/items/weapons/whip.ogg', 50, TRUE, -1)
			defender.drop_all_held_items()
			if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
				attacker.add_mood_event("bypassed_pacifism", /datum/mood_event/pacifism_bypassed)

		else
			atk_verb = pick("chomp", "gnaw", "chew")
			if(defender.check_block(attacker, 0, "[attacker]的[list("chomp" = "猛咬", "gnaw" = "啃咬", "chew" = "嚼咬")[atk_verb]]", UNARMED_ATTACK))
				return MARTIAL_ATTACK_FAIL

			attacker.do_attack_animation(defender, ATTACK_EFFECT_BITE)
			defender.visible_message(
				span_danger("[attacker]凶猛地[list("chomp" = "猛咬", "gnaw" = "啃咬", "chew" = "嚼咬")[atk_verb]]着[defender]！"),
				span_userdanger("[attacker]凶狠地[list("chomp" = "猛咬", "gnaw" = "啃咬", "chew" = "嚼咬")[atk_verb]]着你！"),
				span_hear("你听到猛烈的啃咬声！"),
				null,
				attacker,
			)
			to_chat(attacker, span_danger("你凶狠地[list("chomp" = "猛咬", "gnaw" = "啃咬", "chew" = "嚼咬")[atk_verb]]着[defender]！"))
			defender.apply_damage(rand(10, 20), damagetype = BRUTE, sharpness = SHARP_POINTY, wound_bonus = 50)
			playsound(attacker, 'sound/items/weapons/bite.ogg', 50, TRUE, -1)
			if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
				attacker.add_mood_event("bypassed_pacifism", /datum/mood_event/pacifism_bypassed)

	if(atk_verb)
		log_combat(attacker, defender, "[atk_verb] (Jungle Arts)")
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_FAIL
