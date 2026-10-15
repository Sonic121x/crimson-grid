/datum/subsplat/vampire_clan/brujah
	name = "Brujah"
	id = VAMPIRE_CLAN_BRUJAH
	desc = "布鲁赫是激进者与惹事者的氏族，青睐那些必要时敢于教训他人的凡人，将其初拥入族。大多数成员自认是为理想而战的斗士，受激情、力量与对信念的执着驱使，无论那信念究竟是什么。这些反叛者、哲学家和革命者近来大批离开密党，投身自由派。尽管许多人，尤其是长老，仍支持密党，氏族也仍被正式视为密党氏族，城中的布鲁赫却常在异议与职责之间谨慎行走。他们因暴躁而声名狼藉：氏族诅咒使他们比大多数血族更难抵抗狂乱。"
	icon = "brujah"
	curse = "更容易陷入狂乱，且狂乱持续时间更长。"
	roleplay_level = "Beginner Friendly"
	sense_the_sin_text = "因迦太基的耻辱而背负愤怒的诅咒……"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/potence,
		/datum/discipline/presence
	)
	subsplat_traits = list(
		TRAIT_DIFFICULT_FRENZY
	)
	male_clothes = /obj/item/clothing/under/vampire/brujah
	female_clothes = /obj/item/clothing/under/vampire/brujah/female
	subsplat_keys = /obj/item/vamp/keys/brujah


/datum/subsplat/vampire_clan/brujah/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* to_chat(target, span_warning("You see visions of an underground stone monument weeping blood."))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	to_chat(target, span_cult("THE BEAST RAGES AGAINST THIS VISION!!")) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
