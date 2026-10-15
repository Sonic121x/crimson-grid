/datum/subsplat/vampire_clan/toreador
	name = "Toreador"
	id = VAMPIRE_CLAN_TOREADOR
	desc = "托瑞多以诱人的天性、摄人的仪态和近乎痴迷的优雅口才著称。他们初拥艺术家与恋人，永远试图唤醒自己早已沉寂的心。这些拥有超自然魅力的骄子不断追逐下一次刺激，身后留下被抛弃的情人与受害者。托瑞多热爱美与一切艺术，常见于血族上流社会。他们坚定支持密党，关注文化与影响力；有人资助艺术，也有人痴迷于现代潮流与转瞬即逝的感受。只要托瑞多认定，任何事物都能成为艺术。氏族诅咒会使他们沉醉于美与情感，直至陷入危险。"
	icon = "toreador"
	curse = "人性增减幅度加倍。"
	roleplay_level = "Beginner Friendly"
	sense_the_sin_text = "执迷过度，难以自拔。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/celerity,
		/datum/discipline/presence
	)
	subsplat_traits = list(
		TRAIT_SENSITIVE_HUMANITY
	)
	male_clothes = /obj/item/clothing/under/vampire/toreador
	female_clothes = /obj/item/clothing/under/vampire/toreador/female
	subsplat_keys = /obj/item/vamp/keys/toreador

/datum/subsplat/vampire_clan/toreador/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh2.ogg", 50, FALSE)
	new /datum/hallucination/fire(target, TRUE)
	to_chat(target, span_cult("FLAMES ENGULF MY BEAUTY"))
	target.Paralyze(5 SECONDS) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
