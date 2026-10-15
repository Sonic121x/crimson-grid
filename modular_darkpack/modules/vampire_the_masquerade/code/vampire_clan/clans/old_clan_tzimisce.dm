/datum/subsplat/vampire_clan/old_clan_tzimisce
	name = "Old Clan Tzimisce"
	id = VAMPIRE_CLAN_OLD_CLAN_TZIMISCE
	desc = "古派茨密希是一小群早在血肉塑形术出现之前便已存在的氏族成员。他们视塑形术为灵魂的疾病，拒绝学习或使用。不过，在其他大多数方面，他们与氏族其余成员并无不同。"
	icon = "old_clan_tzimisce"
	curse = "受物质领地束缚，离不开故土。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		/datum/discipline/dominate
	)
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	//restricted_disciplines = list(/datum/discipline/vicissitude)
	whitelisted = FALSE

/datum/subsplat/vampire_clan/old_clan_tzimisce/on_join_round(mob/living/carbon/human/joining)
	. = ..()

	var/obj/item/ground_heir/heirloom = new(get_turf(joining))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	joining.equip_in_one_of_slots(heirloom, slots, FALSE)
	joining.AddComponent(/datum/component/needs_home_soil, heirloom)
