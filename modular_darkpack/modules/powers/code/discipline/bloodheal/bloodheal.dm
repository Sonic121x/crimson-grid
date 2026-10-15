#define HEAL_BASHING_LETHAL_DAMAGE 30
#define HEAL_AGGRAVATED_DAMAGE 6

/datum/discipline/bloodheal
	name = "Bloodheal"
	desc = {"借助血粹的力量修复血肉。
● 血疗术：耐力 + 生存（难度 8）——仅在施术被打断时掷骰"}
	icon_state = "bloodheal"
	power_type = /datum/discipline_power/bloodheal
	selectable = FALSE

/datum/storyteller_roll/bloodheal
	bumper_text = "血疗术"
	difficulty = 8
	applicable_stats = list(STAT_STAMINA, STAT_SURVIVAL)
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/bloodheal
	name = "Bloodheal power name"
	desc = "Bloodheal power description"

	activate_sound = 'modular_darkpack/modules/vampire_the_masquerade/sounds/bloodhealing.ogg'

	level = 1
	check_flags = DISC_CHECK_TORPORED
	vitae_cost = 1

	violates_masquerade = FALSE

	cooldown_length = 1 TURNS

	grouped_powers = list(
		/datum/discipline_power/bloodheal/one,
		/datum/discipline_power/bloodheal/two,
		/datum/discipline_power/bloodheal/three,
		/datum/discipline_power/bloodheal/four,
		/datum/discipline_power/bloodheal/five,
		/datum/discipline_power/bloodheal/six,
		/datum/discipline_power/bloodheal/seven,
		/datum/discipline_power/bloodheal/eight,
		/datum/discipline_power/bloodheal/nine,
		/datum/discipline_power/bloodheal/ten,
	)

	var/datum/storyteller_roll/bloodheal/bloodheal_roll

#define BLOODHEAL_INTERACTION_KEY "bloodheal_key"

/datum/discipline_power/bloodheal/pre_activation_checks(atom/target)
	. = ..()
	if(do_after(owner, 1 TURNS, timed_action_flags = DO_AFTER_CHECK_NEXT_MOVE | IGNORE_INCAPACITATED, interaction_key = BLOODHEAL_INTERACTION_KEY))
		return TRUE
	if(!bloodheal_roll)
		bloodheal_roll = new()
	var/roll_result = bloodheal_roll.st_roll(owner, src)
	to_chat(owner, span_warning("你的专注被打断了……"))
	switch(roll_result)
		if(ROLL_SUCCESS)
			to_chat(owner, span_notice("但你仍成功修复了伤口。"))
			return TRUE
		if(ROLL_FAILURE)
			to_chat(owner, span_warning("你没能掌控血液的力量。"))
			return FALSE
		if(ROLL_BOTCH)
			to_chat(owner, span_danger("你的伤势反而加重了。"))
			owner.adjust_blood_pool(-1)
			owner.apply_damage(1 TTRPG_DAMAGE, BRUTE)
			return FALSE

#undef BLOODHEAL_INTERACTION_KEY

/datum/discipline_power/bloodheal/activate()
	. = ..()

	//normal bashing/lethal damage
	owner.heal_ordered_damage(HEAL_BASHING_LETHAL_DAMAGE * vitae_cost, list(BRUTE, TOX, OXY, STAMINA))

	if(length(owner.all_wounds))
		for (var/i in 1 to min(vitae_cost, length(owner.all_wounds)))
			var/datum/wound/wound = owner.all_wounds[i]
			wound.remove_wound()

	//aggravated damage
	owner.heal_ordered_damage(HEAL_AGGRAVATED_DAMAGE * vitae_cost, list(BURN, AGGRAVATED))

	//brain damage and traumas healing
	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (brain)
		brain.apply_organ_damage(-HEAL_BASHING_LETHAL_DAMAGE * vitae_cost)

		for (var/i in 1 to min(vitae_cost, length(brain.get_traumas_type())))
			var/datum/brain_trauma/healing_trauma = pick(brain.get_traumas_type())
			brain.cure_trauma_type(healing_trauma, resilience = TRAUMA_RESILIENCE_WOUND)

	// Let core species logic handle restoring/healing organs so missing eyes are rebuilt correctly.
	owner.regenerate_organs()
	var/obj/item/organ/eyes/eyes = owner.get_organ_slot(ORGAN_SLOT_EYES)
	if (!eyes)
		var/eyes_type = owner.dna?.species?.get_mutant_organ_type_for_slot(ORGAN_SLOT_EYES) || /obj/item/organ/eyes
		eyes = new eyes_type()
		eyes.Insert(owner, special = TRUE, movement_flags = DELETE_IF_REPLACED)
	owner.cure_blind(NO_EYES)
	owner.cure_blind(EYE_DAMAGE)
	owner.cure_nearsighted(EYE_DAMAGE)
	if(!owner.has_quirk(/datum/quirk/item_quirk/scarred_eye))
		if (eyes)
			eyes.fix_scar(LEFT_EYE_SCAR)
			eyes.fix_scar(RIGHT_EYE_SCAR)
	owner.remove_status_effect(/datum/status_effect/temporary_blindness)
	owner.remove_status_effect(/datum/status_effect/eye_blur)

	if(get_kindred_splat(owner) && length(owner.get_missing_limbs()))
		owner.regenerate_limbs()
		violates_masquerade = TRUE

	//healing too quickly attracts attention
	if (violates_masquerade)
		owner.visible_message(
			span_warning("[owner]的伤口以超乎常理的速度愈合！"),
			span_warning("你的伤口正以肉眼可见的异常速度愈合！")
		)

	//update UI
	owner.update_damage_overlays()
	owner.update_health_hud()

/datum/discipline_power/bloodheal/spend_resources()
	adjust_vitae_cost()

	. = ..()

/datum/discipline_power/bloodheal/proc/adjust_vitae_cost()
	vitae_cost = initial(vitae_cost)
	//tally up damage
	var/total_bashing_lethal_damage = owner.get_brute_loss() + owner.get_tox_loss() + owner.get_oxy_loss()
	var/total_aggravated_damage = owner.get_agg_loss() + owner.get_fire_loss()

	//lower blood expenditure to what's necessary
	var/vitae_to_heal_bashing_lethal = ceil(total_bashing_lethal_damage / HEAL_BASHING_LETHAL_DAMAGE)
	var/vitae_to_heal_aggravated = ceil(total_aggravated_damage / HEAL_AGGRAVATED_DAMAGE)

	var/vitae_needed = max(vitae_to_heal_bashing_lethal, vitae_to_heal_aggravated)

	//vitae used to heal is the smaller of max vitae expenditure and what's needed to heal the damage
	vitae_cost = max(min(vitae_cost, vitae_needed), 1)

	//healing is a masquerade breach if it's done at level 3 and above
	if (vitae_cost > 2)
		violates_masquerade = TRUE
	else
		violates_masquerade = FALSE

//BLOODHEAL 1
/datum/discipline_power/bloodheal/one
	name = "初级血疗术"
	desc = "缓慢修复你的不死之躯。"

	level = 1
	vitae_cost = 1

	violates_masquerade = FALSE

//BLOODHEAL 2
/datum/discipline_power/bloodheal/two
	name = "血疗术"
	desc = "修复你的不死之躯。"

	level = 2
	vitae_cost = 2

	violates_masquerade = FALSE

//BLOODHEAL 3
/datum/discipline_power/bloodheal/three
	name = "迅速血疗术"
	desc = "以超乎常理的速度修复你的不死之躯。"

	level = 3
	vitae_cost = 3

	violates_masquerade = TRUE

//BLOODHEAL 4
/datum/discipline_power/bloodheal/four
	name = "强力血疗术"
	desc = "即使伤势极其严重，也能在短时间内治愈。"

	level = 4
	vitae_cost = 4

	violates_masquerade = TRUE

//BLOODHEAL 5
/datum/discipline_power/bloodheal/five
	name = "高等血疗术"
	desc = "轻而易举地再生完整肢体。"

	level = 5
	vitae_cost = 5

	violates_masquerade = TRUE

//BLOODHEAL 6
/datum/discipline_power/bloodheal/six
	name = "宏大血疗术"
	desc = "轻而易举地再生完整肢体。"

	level = 6
	vitae_cost = 6

	violates_masquerade = TRUE

//BLOODHEAL 7
/datum/discipline_power/bloodheal/seven
	name = "宏大血疗术"
	desc = "即使身体几乎荡然无存，也能重新构筑。"

	level = 7
	vitae_cost = 7

	violates_masquerade = TRUE

//BLOODHEAL 8
/datum/discipline_power/bloodheal/eight
	name = "神迹血疗术"
	desc = "在终亡边缘，让血液向外迸发，重塑你的身躯。"

	level = 8
	vitae_cost = 8

	violates_masquerade = TRUE

//BLOODHEAL 9
/datum/discipline_power/bloodheal/nine
	name = "超凡血疗术"
	desc = "即便化身庞然巨兽，你也能迅速恢复肉身。"

	level = 9
	vitae_cost = 9

	violates_masquerade = TRUE

//BLOODHEAL 10
/datum/discipline_power/bloodheal/ten
	name = "升华血疗术"
	desc = "只要还能获得血液，你就不会死去。你的诅咒不容许死亡。"

	level = 10
	vitae_cost = 10

	violates_masquerade = TRUE

#undef HEAL_BASHING_LETHAL_DAMAGE
#undef HEAL_AGGRAVATED_DAMAGE
