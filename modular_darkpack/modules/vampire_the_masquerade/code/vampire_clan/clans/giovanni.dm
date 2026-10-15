/datum/subsplat/vampire_clan/giovanni
	name = "Giovanni"
	id = VAMPIRE_CLAN_GIOVANNI
	desc = "乔凡尼是篡夺卡帕多西亚地位的氏族，也是最年轻的氏族之一。历史上的乔凡尼既是氏族，也是家族。他们几乎只在家族内部施行初拥，专注于追求金钱与死灵术的力量。"
	icon = "giovanni"
	curse = "噬咬极其痛苦，会伤害猎物，使其惨叫，甚至死亡；其他氏族的噬咬则会让受害者陷入愉悦而朦胧的恍惚。"
	sense_the_sin_text = "认为为了家族，付出再大的代价也不为过。"
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	subsplat_traits = list(
		TRAIT_PAINFUL_VAMPIRE_KISS
	)
	male_clothes = /obj/item/clothing/under/vampire/suit
	female_clothes = /obj/item/clothing/under/vampire/suit/female

/datum/subsplat/vampire_clan/giovanni/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/italian)

/datum/subsplat/vampire_clan/giovanni/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("无声的话语侵入脑海，深沉的恐惧随之笼罩你。"))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	new /obj/effect/client_image_holder/baali_demon/spectre(get_turf(target), list(target))
