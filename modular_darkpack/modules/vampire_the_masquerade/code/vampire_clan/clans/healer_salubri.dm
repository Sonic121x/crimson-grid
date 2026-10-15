/datum/subsplat/vampire_clan/salubri
	name = "Salubri"
	id = VAMPIRE_CLAN_HEALER_SALUBRI
	desc = "萨鲁布里是该隐吸血鬼后裔最初的十三氏族之一。他们相信吸血鬼的存在是一种折磨，唯有达到超脱之境或死亡才能解脱。因此，现代萨鲁布里会初拥子嗣，教授求道的基础，留下通往超脱之境的线索，随后让子嗣对自己施行血噬。"
	icon = "salubri"
	curse = "遭到追猎，且取食必须获得对方同意。"
	sense_the_sin_text = "受制于他人的允诺。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/obeah
	)
	subsplat_traits = list(
		TRAIT_CONSENSUAL_FEEDING_ONLY,
		TRAIT_IRRESISTIBLE_VITAE
	)
	male_clothes = /obj/item/clothing/under/vampire/salubri
	female_clothes = /obj/item/clothing/under/vampire/salubri/female
	enlightenment = FALSE
	subsplat_keys = /obj/item/vamp/keys/salubri

/datum/subsplat/vampire_clan/salubri/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()

	var/obj/item/organ/eyes/salubri/three_eyes = new()
	three_eyes.Insert(gaining_mob, TRUE, DELETE_IF_REPLACED)

/datum/subsplat/vampire_clan/salubri/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()

	// replace eyes
	var/eye_type = /obj/item/organ/eyes
	if(losing_mob.dna.species && losing_mob.dna.species.mutanteyes)
		eye_type = losing_mob.dna.species.mutanteyes
	var/obj/item/organ/eyes/new_eyes = new eye_type()
	new_eyes.Insert(losing_mob, TRUE, DELETE_IF_REPLACED)

/obj/item/organ/eyes/salubri
	eye_icon = 'modular_darkpack/modules/vampire_the_masquerade/icons/human_eyes.dmi'
	eye_icon_state = "salubri"

	blink_animation = FALSE

/datum/subsplat/vampire_clan/salubri/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg", 50, FALSE)
	to_chat(target, span_warning("My third eye begins to reflexively open.."))
	target.visible_message(span_warning("[target] tightly grasps their forehead, trying to conceal something"), span_cult("I MUST HIDE MY NATURE"))
	target.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
	target.Paralyze(6 SECONDS) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
