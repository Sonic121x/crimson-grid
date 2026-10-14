/datum/quirk/darkpack/victim_of_the_masquerade
	name = "Victim of the Masquerade"
	desc = "密党的宣传在你身上大获成功。即使经历初拥，你仍拒绝相信自己是吸血鬼。你坚信自身状况必有合理解释，并尽可能花时间为之辩解。每次进食以及每从受害者身上吸取一个血点时，你都必须进行意志力检定。失败时，你会昏厥五秒，同时失去一点人性。你应当通过角色扮演体现此缺陷，例如坚持吃普通食物、拒绝吸血。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 486)
	value = -2
	mob_trait = TRAIT_VICTIM_OF_THE_MASQUERADE
	gain_text = span_notice("切，我才不是吸血鬼。那种东西根本不存在。")
	lose_text = span_notice("我可能真是个吸血鬼。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_DIZZY
	failure_message = "我可能真是个吸血鬼。"
	var/datum/storyteller_roll/victim_of_the_masquerade/victim_of_the_masquerade_roll
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/storyteller_roll/victim_of_the_masquerade
	bumper_text = "避世戒律的受害者"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	difficulty = 6
	roll_output_type = ROLL_FLAG_ROLLER
