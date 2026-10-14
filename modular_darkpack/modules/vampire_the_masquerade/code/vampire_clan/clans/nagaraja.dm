/datum/subsplat/vampire_clan/nagaraja
	name = "Nagaraja"
	id = VAMPIRE_CLAN_NAGARAJA
	desc = "纳迦拉贾是由仪式创造的神秘血系，并没有可奉为始祖的上古者。他们既精通死灵术，又渴食血肉，因此备受畏惧与憎恶。"
	curse = "纳迦拉贾无法像大多数血族那样以鲜血维生，只能吞食猎物的血肉与内脏，因此被同族称为“食肉者”。"
	icon = "nagaraja"
	sense_the_sin_text = "渴望吞食血肉。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	subsplat_traits = list(TRAIT_ORGANOVORE)
	male_clothes = /obj/item/clothing/under/vampire/emo
	female_clothes = /obj/item/clothing/under/vampire/emo
	whitelisted = FALSE

/datum/subsplat/vampire_clan/nagaraja/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	var/obj/item/ritual_tome/necromancy/necrotome = new()
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	gaining_mob.equip_in_one_of_slots(necrotome, slots, FALSE)
