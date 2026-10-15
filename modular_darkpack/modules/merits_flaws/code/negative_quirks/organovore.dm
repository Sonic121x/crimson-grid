/datum/quirk/darkpack/organovore
	name = "Organovore"
	desc = "你只能通过食用人肉恢复血点。纳迦拉贾本就需要食肉，因此不能选择此特质。"
	value = -5
	mob_trait = TRAIT_ORGANOVORE
	gain_text = span_notice("你对血肉产生了无法满足的渴望。")
	lose_text = span_notice("你觉得自己又能正常进食了。")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_NAGARAJA)
	icon = FA_ICON_TEETH
	failure_message = "你觉得自己又能正常进食了。"
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
