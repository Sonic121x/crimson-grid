/datum/subsplat/vampire_clan/baali
	name = "Baali"
	id = VAMPIRE_CLAN_BAALI
	desc = "巴力是与恶魔崇拜有联系的吸血鬼血系。由于亲近邪秽之物，他们尤其畏惧圣像、圣地与圣水，真信的力量更是其致命弱点。"
	icon = "baali"
	curse = "畏惧宗教的神圣力量。"
	sense_the_sin_text = "畏惧主的临在。"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/daimonion
	)

	subsplat_traits = list(
		TRAIT_REPELLED_BY_HOLINESS
	)
	male_clothes = /obj/item/clothing/under/vampire/baali
	female_clothes = /obj/item/clothing/under/vampire/baali/female
	enlightenment = TRUE
	whitelisted = TRUE
	subsplat_keys = /obj/item/vamp/keys/baali

/datum/subsplat/vampire_clan/baali/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* to_chat(target, span_notice("The sacred icons appearing before you lack the true substance of faith"))
	new /datum/hallucination/delusion(target, TRUE, "repent", 200, 0)
	to_chat(owner, span_notice("Your illusions are easily dispelled by [target]")) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY
