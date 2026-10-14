/datum/subsplat/vampire_clan/tzimisce
	name = "Tzimisce"
	id = VAMPIRE_CLAN_TZIMISCE
	desc = "若有人称茨密希毫无人性、嗜好施虐，他们大概会先赞赏对方的敏锐，再亲自展示凡人对“施虐”的理解有多么浅薄可笑。茨密希欣然抛弃了人类状态，如今专注于超越吸血鬼存在本身的局限。乍看之下，或只是短暂交谈时，茨密希似乎是相当和善的吸血鬼：礼貌、聪慧、充满求知欲，与咆哮的魔宴暴徒，甚至看似更有人性的布鲁赫或诺斯费拉图都形成鲜明对照。但仔细观察便会发现，这不过是一张面具，掩盖着异质而可怖的本性。"
	curse = "受物质领地束缚，离不开故土。"
	icon = "tzimisce"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		/datum/discipline/vicissitude

	)
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/spines,
		/datum/bodypart_overlay/simple/clan_mark/spines_slim,
		/datum/bodypart_overlay/simple/clan_mark/animal_skull,
	)

/datum/subsplat/vampire_clan/tzimisce/psychomania_effect(mob/living/target, mob/living/owner)
	// CRIMSON GRID ADD: DARK THAUMATURGY. BEFORE:
	/* target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
	to_chat(target, span_cult("I SEE VISIONS OF FLAME ENGULFING MY DOMAIN"))
	new /datum/hallucination/fire(target, TRUE)
	target.Paralyze(6 SECONDS) */
	to_chat(target, span_cult("心兽在我脑海中尖叫，催促我逃跑！"))
	new /obj/effect/client_image_holder/baali_demon(get_turf(target), list(target))
	// CRIMSON GRID ADD END: DARK THAUMATURGY

/datum/subsplat/vampire_clan/tzimisce/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	sense_the_sin_text = "[joining.name]被唯一的欲望吞噬。"
	var/obj/item/ground_heir/heirloom = new(get_turf(joining))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	joining.equip_in_one_of_slots(heirloom, slots, FALSE)
	joining.AddComponent(/datum/component/needs_home_soil, heirloom)

/datum/movespeed_modifier/centipede
	multiplicative_slowdown = -0.6
