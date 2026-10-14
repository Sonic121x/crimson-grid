/datum/subsplat/vampire_clan/nosferatu
	name = "Nosferatu"
	id = VAMPIRE_CLAN_NOSFERATU
	desc = "诺斯费拉图的诅咒显露于外。他们的身体在初拥中可怕地扭曲变形，只能潜伏于城市边缘，充当间谍与情报掮客。借助动物和超自然隐匿能力，几乎没有什么能逃过这些“下水道老鼠”的眼睛。他们依靠隐秘行事与情报交易生存。在许多城市，诺斯费拉图仍与密党关系密切，但也有人效力其他派系、独立行动，或维持跨派系联系。无论所属派系为何，他们首先忠于氏族。诅咒使他们永远保持怪物般的形貌，无法冒充人类。"
	icon = "nosferatu"
	curse = "外貌会暴露血族身份，违反避世戒律。"
	roleplay_level = "Intermediate"
	sense_the_sin_text = "沉迷于未知之物。"
	alt_sprite = "nosferatu"
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/potence,
		/datum/discipline/obfuscate
	)
	subsplat_traits = list(
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_VENTCRAWLER_ALWAYS,
		TRAIT_TRUE_NIGHT_VISION //CRIMSON GRID ADDITION - NOSFERATU GET NIGHT VISION

	)
	male_clothes = /obj/item/clothing/under/vampire/nosferatu
	female_clothes = /obj/item/clothing/under/vampire/nosferatu/female
	clan_marks = list(/datum/bodypart_overlay/simple/clan_mark/nosferatu_ears)
	default_accessory = /datum/bodypart_overlay/simple/clan_mark/nosferatu_ears
	subsplat_keys = /obj/item/vamp/keys/nosferatu

//CRIMSON GRID ADDITION - NOSFERATU GET NIGHT VISION
/datum/subsplat/vampire_clan/nosferatu/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. =  ..()
	gaining_mob.update_sight()

/datum/subsplat/vampire_clan/nosferatu/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()
	if(!QDELETED(losing_mob))
		losing_mob.update_sight()
