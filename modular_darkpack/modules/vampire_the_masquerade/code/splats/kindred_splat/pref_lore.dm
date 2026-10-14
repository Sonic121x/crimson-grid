/datum/splat/vampire/kindred/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#333333", update = FALSE)
	human.set_hairstyle("Undercut Left", update = TRUE)
	human.set_eye_color("#ff0000")
	human.undershirt = "T-Shirt (Red)"
	human.update_body()
	human.equipOutfit(/datum/outfit/job/vampire/prince, TRUE)

// note - we have unused desc vars on splats
/datum/splat/vampire/kindred/get_splat_description()
	return "这些不朽的掠食者受诅咒，只能生活在黑夜之中。他们以人血为生，用所谓的避世戒律掩盖自身的存在。氏族、派系与宿怨将他们分割，在凡人社会的表象之下，政治与理念之争永无休止。\n\n许多城市虽然名义上由密党掌控，却也容纳着自由派、魔宴同盟和独立势力。这种脆弱的平衡时刻受到彼此争斗、外部势力和内部冲突的威胁。每一名血族都在与内心心兽的原始冲动抗争；只要一次失误，便可能陷入血腥狂乱，堕为怪物。"

// Pulled straight from the wiki https://whitewolf.fandom.com/wiki/Vampire_(WOD)
/datum/splat/vampire/kindred/get_splat_lore()
	return list(
		"潜行于黑暗世界的饮血者大多自称血族、舔血者，或该隐后裔。在极乐境的常客和自由派乌托邦理论家看来，“吸血鬼”这个称呼有失身份，让人想到汉默影业俗套的续集电影，以及迎合游客的陈旧民间传说。然而，近几十年接受初拥的新生代越来越常以这个词互称，试图“夺回吸血鬼这个称呼”，宣示即使血脉稀薄，自己也有资格拥有这一身份。",
	)

/datum/splat/vampire/kindred/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
			SPECIES_PERK_ICON = FA_ICON_BOOK_DEAD,
			SPECIES_PERK_NAME = "血族氏族",
			SPECIES_PERK_DESC = "血族分属许多氏族，你可以在设置中选择。每个氏族都有独特的能力与弱点！",
		),
	)

	return to_add

/*
// Vampire blood is special, so it needs to be handled with its own entry.
/datum/splat/vampire/kindred/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Example Negative Perk",
		SPECIES_PERK_DESC = "Lorem Ipsum",
	))

	return to_add
*/

// There isn't a "Minor Undead" biotype, so we have to explain it in an override (see: dullahans)
/datum/splat/vampire/kindred/create_pref_biotypes_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = FA_ICON_SKULL,
		SPECIES_PERK_NAME = "半不死生物",
		SPECIES_PERK_DESC = "血族属于半不死生物。\
			半不死生物享有死亡带来的部分好处，\
			例如无需呼吸或进食，但无法像完全的不死生物那样\
			免疫许多环境危害。",
	))

	return to_add
