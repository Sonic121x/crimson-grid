// necromancy zombies located in npc module, beastmaster/necromancy_zombies.dm

/datum/discipline/necromancy
	name = "Necromancy"
	desc = {"赋予你掌控另一个不死世界的力量。
● 冥幕视界：感知 + 灵觉（难度 7）
●● 幽魂群集：机敏 + 神秘学（难度 6）
●●● 尘归尘：机敏 + 神秘学（难度 6）
●●●● 坟冢之寒：机敏 + 神秘学（难度 6）
●●●●● 蹒跚尸群：机敏 + 神秘学（难度 6）"}
	icon_state = "necromancy"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/necromancy
	signature_clan = VAMPIRE_CLAN_GIOVANNI

/datum/discipline/necromancy/post_gain()
	. = ..()
	var/datum/action/ritual_drawing/necromancy/ritualist = new()
	ritualist.Grant(owner)
	ritualist.level = level

/datum/discipline/necromancy/post_loss()
	. = ..()
	for(var/datum/action/action as anything in owner.actions)
		if(istype(action, /datum/action/ritual_drawing/necromancy))
			qdel(action)

/datum/discipline_power/necromancy/pre_activation_checks(mob/living/target)
	. = ..()
	return SSroll.storyteller_roll_datum(owner, applic_stats = list(STAT_WITS, STAT_OCCULT))

/datum/discipline_power/necromancy
	name = "Necromancy power name"
	desc = "Necromancy power description"
	frenzy_usable = FALSE

//SHROUDSIGHT V20 p. 163
/datum/storyteller_roll/shroudsight
	bumper_text = "冥幕视界"
	applicable_stats = list(STAT_PERCEPTION, STAT_AWARENESS)
	difficulty = 7
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/necromancy/shroudsight
	name = "冥幕视界"
	desc = "在黑暗中清晰视物，并看见附近的幽灵。"
	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0

	activate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg'
	deactivate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1off.ogg'

	cooldown_length = 10 SECONDS
	duration_length = 1 SCENES

	var/datum/storyteller_roll/shroudsight/roll_datum

/datum/discipline_power/necromancy/shroudsight/pre_activation_checks(mob/living/target)
	if(!roll_datum)
		roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)
	if(roll_result == ROLL_SUCCESS)
		return TRUE

	do_cooldown(cooldown_length)
	return FALSE

/datum/discipline_power/necromancy/shroudsight/activate()
	. = ..()

	ADD_TRAIT(owner, TRAIT_GHOST_VISION, NECROMANCY_TRAIT)
	ADD_TRAIT(owner, TRAIT_LOCAL_SIXTHSENSE, NECROMANCY_TRAIT)
	owner.update_sight()

	to_chat(owner, span_notice("你窥见了冥幕彼端。"))

/datum/discipline_power/necromancy/shroudsight/deactivate()
	. = ..()

	REMOVE_TRAIT(owner, TRAIT_GHOST_VISION, NECROMANCY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_LOCAL_SIXTHSENSE, NECROMANCY_TRAIT)
	owner.update_sight()

	to_chat(owner, span_warning("你的视野重回凡世。"))

//ETHEREAL HORDE
/datum/discipline_power/necromancy/ethereal_horde
	name = "幽魂群集"
	desc = "从冥土召来两只无心怨灵，保护自己。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	vitae_cost = 1

	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy2.ogg'

	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
	grouped_powers = list(
		/datum/discipline_power/necromancy/ashes_to_ashes,
		/datum/discipline_power/necromancy/cold_of_the_grave,
		/datum/discipline_power/necromancy/shambling_horde
	)

/datum/discipline_power/necromancy/ethereal_horde/activate()
	. = ..()
	owner.visible_message(span_warning("哀嚎的幽魂从[owner]的影子中走出。"))
	owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level1)
	owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level1)

//ASHES TO ASHES
/datum/discipline_power/necromancy/ashes_to_ashes
	name = "尘归尘"
	desc = "分解尸体以汲取残余生命力，或从怨灵身上窃取生命力。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB | TARGET_GHOST
	range = 3 //to not wallbang people mid-surgery at the hospital
	vitae_cost = 0

	activate_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy3.ogg'

	violates_masquerade = TRUE

	cooldown_length = 10 SECONDS
	grouped_powers = list(
		/datum/discipline_power/necromancy/ethereal_horde,
		/datum/discipline_power/necromancy/cold_of_the_grave,
		/datum/discipline_power/necromancy/shambling_horde
	)

/datum/discipline_power/necromancy/ashes_to_ashes/activate(mob/target)
	. = ..()

	if(isavatar(target))
		to_chat(owner, span_warning("这个灵体仍与肉身相连。")) // cant absorb auspex ghosts
		return

	if (isobserver(target))
		var/mob/dead/observer/ghost = target
		to_chat(target, span_notice("[owner]汲取着你的灵质，窃取你的存在来维系自身。"))

		if(!ghost.soul_taken)
			to_chat(owner, span_warning("怨灵的激情平息了你的饥渴。你获得了<b>鲜血</b>与<b>一个灵魂</b>。"))
			owner.adjust_blood_pool(1)
			if(isliving(owner))
				owner.collected_souls += 1
				to_chat(owner, span_cult("你将逝者的灵魂吸入死灵魔典。它的精魄如今能从冥幕彼端协助你的研究……"))

			ghost.soul_taken = TRUE
		else
			to_chat(owner, span_warning("怨灵的激情平息了你的饥渴。你获得了<b>鲜血</b>，但它的灵魂早已离去。"))
			owner.adjust_blood_pool(1)
		return

	if (isliving(target) && target.stat == DEAD)
		var/mob/living/dusted = target
		owner.visible_message(span_warning("[owner]朝[target]做了个手势。"))
		dusted.visible_message(span_danger("[target]的躯体在你眼前化为尘埃！"))
		to_chat(owner, span_warning("你吸收了尸体残余的生命力，获得了<b>鲜血</b>与<b>一个灵魂</b>。"))
		dusted.dust(just_ash = TRUE)
		owner.adjust_blood_pool(2) // corpses = 2 blood
		if(isliving(owner))
			owner.collected_souls += 1
			to_chat(owner, span_cult("你将逝者的灵魂吸入死灵魔典。它的精魄如今能从冥幕彼端协助你的研究……"))
		return

	to_chat(owner, span_warning("死亡尚未夺走这个生命，没有可供掠取的东西。"))


//COLD OF THE GRAVE
/datum/discipline_power/necromancy/cold_of_the_grave
	name = "坟冢之寒"
	desc = "使选定目标进入如同尸体般的状态，也可以对自己使用。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_SELF | TARGET_LIVING
	range = 5
	vitae_cost = 1

	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy4.ogg'

	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	multi_activate = TRUE
	cooldown_length = 20 SECONDS
	duration_length = 20 SECONDS
	grouped_powers = list(
		/datum/discipline_power/necromancy/ethereal_horde,
		/datum/discipline_power/necromancy/ashes_to_ashes,
		/datum/discipline_power/necromancy/shambling_horde
	)

/datum/movespeed_modifier/corpsebuff
	multiplicative_slowdown = 0.4

/datum/movespeed_modifier/corpsenerf
	multiplicative_slowdown = 0.8 //lasts for a while

/datum/discipline_power/necromancy/cold_of_the_grave/activate(mob/living/target)
	. = ..()

	owner.visible_message(span_warning("[owner]朝[target]做了个手势。"))
	if(iscarbon(target))
		var/mob/living/carbon/human/corpsebuff = target
		// removed iscathayan(target) || from line 183 DARKPACK TODO - readd KJs Kuei-Jin
		if(get_kindred_splat(target) || target.has_status_effect(/datum/status_effect/zombie)) //undead become spongier, but move slightly slower
			corpsebuff.visible_message(span_danger("[target]的身体因尸僵而变得僵硬。"), span_danger("你对疼痛和其他一切的感知都变得迟钝。"))

			for(var/obj/item/bodypart/part as anything in corpsebuff.bodyparts)
				part.brute_modifier = max(0.2, part.brute_modifier - 0.3)

			ADD_TRAIT(corpsebuff, TRAIT_NOSOFTCRIT, NECROMANCY_TRAIT)
			ADD_TRAIT(corpsebuff, TRAIT_NOHARDCRIT, NECROMANCY_TRAIT)
			ADD_TRAIT(corpsebuff, TRAIT_ANALGESIA, NECROMANCY_TRAIT)
			corpsebuff.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			corpsebuff.add_movespeed_modifier(/datum/movespeed_modifier/corpsebuff)
			corpsebuff.do_jitter_animation(2 SECONDS)
		else //everyone else eats tox and CC
			corpsebuff.visible_message(span_danger("[target]的皮肤变得灰白，身体被可怕的病痛侵袭。"), span_userdanger("你感到极度不适。"))
			corpsebuff.vomit()

			corpsebuff.apply_status_effect(/datum/status_effect/dizziness, 10 SECONDS)

			corpsebuff.apply_status_effect(/datum/status_effect/confusion, 10 SECONDS)

			corpsebuff.apply_damage(50, TOX)
			corpsebuff.Stun(3 SECONDS) // ignored by tough flesh and shapeshifted werewolves
			corpsebuff.add_movespeed_modifier(/datum/movespeed_modifier/corpsenerf)
			corpsebuff.do_jitter_animation(2 SECONDS)

	else
		target.apply_damage(100, BRUTE)
		target.visible_message(span_danger("[target]干瘪枯萎了！"))

/datum/discipline_power/necromancy/cold_of_the_grave/deactivate(mob/living/target)
	. = ..()

	if(iscarbon(target))
		var/mob/living/carbon/human/corpsebuff = target
		// || iscathayan(target) removed that from line 211 DARKPACK TODO -- readd KJS Kuei-Jin
		if(get_kindred_splat(target))
			corpsebuff.visible_message(span_notice("[target]的身体恢复了光泽。"), span_notice("知觉重新涌回了你的身体。"))
			for(var/obj/item/bodypart/part as anything in corpsebuff.bodyparts)
				part.brute_modifier = initial(part.brute_modifier)
			REMOVE_TRAIT(corpsebuff, TRAIT_NOSOFTCRIT, NECROMANCY_TRAIT)
			REMOVE_TRAIT(corpsebuff, TRAIT_NOHARDCRIT, NECROMANCY_TRAIT)
			REMOVE_TRAIT(corpsebuff, TRAIT_ANALGESIA, NECROMANCY_TRAIT)
			corpsebuff.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
			corpsebuff.remove_movespeed_modifier(/datum/movespeed_modifier/corpsebuff)
		else
			corpsebuff.remove_movespeed_modifier(/datum/movespeed_modifier/corpsenerf)
			corpsebuff.visible_message(span_notice("[target]的身体恢复了光泽。"), span_notice("你那反常的病痛消退了。"))


//SHAMBLING HORDE
/datum/discipline_power/necromancy/shambling_horde
	name = "蹒跚尸群"
	desc = "将尸体唤起为凶残的僵尸，其杀伤力取决于原本的躯体。也可攻击生者，或修复有意识的不死生物。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB
	range = 5 //less range than thaum, nerf if 2stronk

	effect_sound = 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy5.ogg'

	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

	cooldown_length = 5 SECONDS
	grouped_powers = list(
		/datum/discipline_power/necromancy/ethereal_horde,
		/datum/discipline_power/necromancy/ashes_to_ashes,
		/datum/discipline_power/necromancy/cold_of_the_grave

	)

/datum/discipline_power/necromancy/shambling_horde/activate(mob/living/target)
	. = ..()
	if (target.stat == DEAD)
		owner.visible_message(span_warning("[owner]在[target]的尸体上方做着手势。"))
		target.visible_message(span_danger("[target]抽搐着站起身，被一股无形的力量操纵着。"))
		if(iscarbon(target))
			owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level4)
			qdel(target)
		else
			switch(target.maxHealth)
				if (-INFINITY to 20) //rats and whatnot
					owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level2)
					qdel(target)
				if (20 to 70) //cats and whatnot
					owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level3)
					qdel(target)
				if (70 to 150) //dogs/biters and whatnot
					owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level4)
					qdel(target)
				if (150 to INFINITY) //szlachta and whatnot
					owner.add_beastmaster_minion(/mob/living/basic/beastmaster/giovanni_zombie/level5)
					qdel(target)

	else if(target.has_status_effect(/datum/status_effect/zombie))
		owner.visible_message(span_warning("[owner]凶狠地朝[target]做出手势！"))
		target.visible_message(span_warning("[target]的血肉重新缝合在一起！"), span_danger("你腐烂的血肉重新凝聚起来！"))
		var/mob/living/carbon/human/zombie = target
		zombie.heal_ordered_damage(120, list(BRUTE, TOX, BURN, AGGRAVATED, OXY, BRAIN))
		zombie.adjust_blood_pool(3)
		if(length(zombie.all_wounds))
			var/datum/wound/wound = pick(zombie.all_wounds)
			wound.remove_wound()
	else
		owner.visible_message(span_warning("[owner]凶狠地朝[target]做出手势！"))
		target.visible_message(span_warning("[target]遭到死灵力量的侵袭！"), span_danger("你感到自己正从体内开始腐烂！"))
		target.apply_damage(55, AGGRAVATED, owner.zone_selected) // 1/5 of a 5-dot "healthbar" in aggravated damage, on level with thaumaturgy's average output
		target.emote("scream")

