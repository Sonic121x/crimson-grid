/datum/subsplat/vampire_clan/gargoyle
	name = "Gargoyle"
	id = VAMPIRE_CLAN_GARGOYLE
	desc = "石像鬼是睿魔尔创造的仆从血系。严格说来，他们并非睿魔尔的血脉分支，却大多受其控制。终末之夜中，石像鬼的数量似乎迅速增长：年长的自由石像鬼走出隐匿，加入密党；更多受奴役者挣脱睿魔尔的掌控；获得自由的石像鬼也开始自行初拥更多凡人。"
	icon = "gargoyle"
	curse = "所有石像鬼都与诺斯费拉图一样面目可憎，这是秘术造物身份及混杂血族血统的结果。他们必须向普通凡人隐瞒存在，因为仅仅露面就会违反避世戒律。此外，石像鬼极易受到任何来源的精神控制。这是睿魔尔刻意植入的缺陷，目的是让他们更易受控、更难反叛。"
	sense_the_sin_text = "心智宛如门户大开、毫无防备的堡垒。"
	clan_disciplines = list(
		/datum/discipline/fortitude,
		/datum/discipline/potence,
		/datum/discipline/visceratika
	)
	subsplat_traits = list(
		TRAIT_CANNOT_RESIST_MIND_CONTROL,
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_WEAK_TO_DOMINATE,
	)
	alt_sprite = "gargoyle"
	male_clothes = /obj/item/clothing/under/vampire/malkavian
	female_clothes = /obj/item/clothing/under/vampire/malkavian
	default_accessory = "gargoyle_full"
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/full,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/left,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/right,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/broken,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/round,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/oni,
		/datum/bodypart_overlay/simple/clan_mark/gargoyle/devil,
	)
	whitelisted = TRUE

	// Type to use for the extra clan mark they get.
	var/datum/bodypart_overlay/simple/clan_mark/gargy_tail_type = /datum/bodypart_overlay/simple/clan_mark/gargoyle/tail

/datum/subsplat/vampire_clan/gargoyle/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	MODIFY_PHYSIOLOGY(gaining_mob, BRUTE, 0.8)

	var/obj/item/organ/wings/functional/gargoyle/wings = new()
	wings.Insert(gaining_mob)

/datum/subsplat/vampire_clan/gargoyle/on_lose(mob/living/carbon/human/losing_mob)
	. = ..()
	MODIFY_PHYSIOLOGY(losing_mob, BRUTE, 1.25)

	var/obj/item/organ/wings/functional/gargoyle/wings = losing_mob.get_organ_slot(ORGAN_SLOT_EXTERNAL_WINGS)
	if(wings)
		wings.Remove(losing_mob)
		qdel(wings)

	var/obj/item/bodypart/part = losing_mob.get_bodypart(BODY_ZONE_CHEST)
	part.remove_bodypart_overlay(gargy_tail_type)
