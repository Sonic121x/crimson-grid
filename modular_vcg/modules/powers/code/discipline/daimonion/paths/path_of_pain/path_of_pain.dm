/datum/discipline/path/pain
	name = "Path of Pain"
	desc = "一条能够操纵痛苦的黑暗血魔法道途。违反避世戒律。"
	icon = 'modular_vcg/modules/paths/icons/paths.dmi'
	icon_state = "pain"
	power_type = /datum/discipline_power/daimonion/path/pain

/datum/discipline_power/daimonion/path/pain
	name = "Dark Thaumaturgy: Path of Pain Power Name"
	desc = "Dark Thaumaturgy: Path of Pain Power Description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/thaum.ogg'

	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_TORPORED
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = FALSE
	range = 7

	cooldown_length = 3 TURNS
	var/success_count

/datum/storyteller_roll/path_of_pain
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER|ROLL_FLAG_TARGET

/datum/discipline_power/daimonion/path/pain/activate(atom/target)
	. = ..()
	success_count = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/path_of_pain, difficulty = (level + 3))
	if(success_count < 0)
		owner.visible_message(span_notice("[owner]痛苦地抽搐着，抓挠自己的皮肤。"), \
			span_notice("你痛苦地抽搐着，抓挠自己的皮肤。"))
		pain_botch_effect()
		return TRUE
	else if(success_count == 0)
		to_chat(owner, span_notice("你的法术消散了！"))
		return TRUE
	return FALSE

/datum/discipline_power/daimonion/path/pain/proc/pain_botch_effect()
	owner.apply_status_effect(/datum/status_effect/pain_botch)

/datum/discipline_power/daimonion/path/pain/numbing
	name = "麻痹"
	desc = "与痛苦融为一体，无视伤痛带来的负面影响。"

	level = 1
	aggravating = FALSE
	hostile = FALSE
	duration_length = 1 SCENES

/datum/discipline_power/daimonion/path/pain/numbing/activate(atom/target)
	if(..())
		return
	ADD_TRAIT(owner, TRAIT_PREVENT_HEALTH_UPDATES, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_AGEUSIA, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_IGNORESLOWDOWN, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, PATH_OF_PAIN_TRAIT)
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, PATH_OF_PAIN_TRAIT)
	owner.visible_message(span_notice("[owner]快意地抽搐着！"), \
			span_notice("你快意地抽搐着！"))

/datum/discipline_power/daimonion/path/pain/numbing/deactivate(atom/target)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_PREVENT_HEALTH_UPDATES, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_AGEUSIA, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_IGNORESLOWDOWN, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, PATH_OF_PAIN_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, PATH_OF_PAIN_TRAIT)

/datum/discipline_power/daimonion/path/pain/anguish
	name = "苦痛"
	desc = "向他人施加痛楚，使其在剧痛中挣扎。"
	level = 2
	range = 1
	target_type = TARGET_MOB
	aggravating = FALSE
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/agony_within,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/anguish/activate(mob/living/target)
	if(..())
		return
	var/stamina_loss = success_count TTRPG_DAMAGE
	target.apply_damage(stamina_loss, STAMINA)
	target.visible_message(span_notice("[target]痛苦地捂住胸口！"), \
			span_notice("你捂住胸口，感到灼烧般的剧痛！"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(stamina_loss, STAMINA)
		owner.visible_message(span_notice("[owner]痛苦地捂住胸口！"), \
			span_notice("你捂住胸口，感到灼烧般的剧痛！"))

/datum/discipline_power/daimonion/path/pain/shattering
	name = "碎骨"
	desc = "对他人造成严重创伤，让其承受切实的痛苦。"
	level = 3
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/agony_within,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/shattering/activate(mob/living/target)
	if(..())
		return
	owner.apply_damage(1 TTRPG_DAMAGE, BRUTE)
	var/will_resist = SSroll.storyteller_roll_datum(target, target, /datum/storyteller_roll/path_of_pain, difficulty = 6)
	target.apply_damage(max(0, (success_count - will_resist)) TTRPG_DAMAGE, BRUTE)
	playsound(target, "sound/effects/wounds/crack1.ogg", 50)
	target.visible_message(span_warning("[target]体内传出骇人的骨裂声！"), \
			span_warning("你听见自己体内传出骇人的骨裂声！"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count TTRPG_DAMAGE, BRUTE)
		playsound(owner, "sound/effects/wounds/crack2.ogg", 50)
		owner.visible_message(span_warning("[owner]体内传出骇人的骨裂声！"), \
			span_warning("你听见自己体内传出骇人的骨裂声！"))

/datum/discipline_power/daimonion/path/pain/agony_within
	name = "内在剧痛"
	desc = "以自身付出一定代价为交换，让他人承受剧痛。"
	level = 4
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/hundred_deaths
	)

/datum/discipline_power/daimonion/path/pain/agony_within/activate(mob/living/target)
	if(..())
		return
	var/list/damage_choices = list(0, 10, 20, 30, 40)
	var/self_mutilation_bonus = tgui_input_list(owner, "你愿意对自己造成多少伤害？（这会提高目标的掷骰难度）", "内在剧痛", damage_choices)
	if(!self_mutilation_bonus)
		self_mutilation_bonus = 0
	self_mutilation_bonus /= 10
	owner.apply_damage(self_mutilation_bonus TTRPG_DAMAGE, BRUTE)
	success_count += self_mutilation_bonus
	var/will_success_count = SSroll.storyteller_roll_datum(target, target, /datum/storyteller_roll/path_of_pain, difficulty = 6+self_mutilation_bonus)
	var/will_endure = floor(will_success_count / 2)
	target.apply_damage(max(0, (success_count - will_endure)) TTRPG_DAMAGE, BRUTE)
	playsound(target, 'sound/items/weapons/whip.ogg', 50)
	target.visible_message(span_warning("血色荆棘丝线撕裂了[target]的血肉！"), \
			span_warning("血色荆棘丝线撕裂了你的血肉！"))
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count TTRPG_DAMAGE, BRUTE)
		playsound(owner, 'sound/items/weapons/whip.ogg', 50)
		owner.visible_message(span_warning("血色荆棘丝线撕裂了[owner]的血肉！"), \
			span_warning("血色荆棘丝线撕裂了你的血肉！"))
	// There should be fortitude soak too but it's not implemented on cg and I'm not coding it

/datum/discipline_power/daimonion/path/pain/hundred_deaths
	name = "百死折磨"
	desc = "仅凭一瞥或一言，便可剥离血肉、碾碎骨骼、撕裂内脏。"
	level = 5
	target_type = TARGET_MOB
	grouped_powers = list(
		/datum/discipline_power/daimonion/path/pain/anguish,
		/datum/discipline_power/daimonion/path/pain/shattering,
		/datum/discipline_power/daimonion/path/pain/agony_within,
	)

/datum/discipline_power/daimonion/path/pain/hundred_deaths/activate(mob/living/target)
	var/will_success = SSroll.storyteller_roll_datum(owner, owner, /datum/storyteller_roll/path_of_pain, difficulty = 6)
	if(will_success <= 0)
		return
	owner.apply_damage(1 LETHAL_TTRPG_DAMAGE, AGGRAVATED)
	if(..())
		return
	target.apply_damage(success_count LETHAL_TTRPG_DAMAGE, AGGRAVATED)
	target.visible_message(span_warning("[target]全身裂开了深深的伤口！"), \
			span_warning("你全身裂开了深深的伤口，剧痛难忍！"))
	target.emote("scream")
	if(HAS_TRAIT(owner, TRAIT_PAIN_BOTCH))
		owner.apply_damage(success_count LETHAL_TTRPG_DAMAGE, AGGRAVATED)
		owner.visible_message(span_warning("[owner]全身裂开了深深的伤口！"), \
			span_warning("你全身裂开了深深的伤口，剧痛难忍！"))
		owner.emote("scream")
	// There should be fortitude soak too but it's not implemented on cg and I'm not coding it
