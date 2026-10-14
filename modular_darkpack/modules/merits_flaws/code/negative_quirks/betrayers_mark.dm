/datum/quirk/darkpack/betrayers_mark
	name = "Betrayer's Mark"
	desc = "你的额头上烙着一个神秘的“T”字，标示你身为睿魔尔却参加过共血仪式。这道只有其他睿魔尔能看见的烙印，将你标记为逆族。即使你已重回氏族，甚至从未参加共血仪式、始终忠诚却莫名带着这道烙印，其他族人仍会对你极为警惕。"
	value = -3
	mob_trait = TRAIT_BETRAYERS_MARK
	gain_text = span_notice("一个神秘的“T”字烙在你的额头上。背叛者的烙印。")
	lose_text = span_notice("你额头上的“T”字似乎正在消退……哦不……别再来一次！！！") // look up what happened to the antitribu tremeres in 1998
	icon = FA_ICON_T
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)
	failure_message = "你额头上的“T”字似乎正在消退……哦不……别再来一次！！！"
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
