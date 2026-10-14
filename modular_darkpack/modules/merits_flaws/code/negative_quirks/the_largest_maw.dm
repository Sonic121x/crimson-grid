/datum/quirk/darkpack/the_largest_maw
	name = "The Largest Maw"
	desc = "你那一排排鲨鱼般的牙齿过于巨大，令你难以开口交流。说话时唾沫横流，有时牙齿还会互相磕碰。这使你比其他纳迦拉贾更安静，始终只能低声耳语。"
	icon = FA_ICON_COMMENT
	value = -2
	mob_trait = TRAIT_FORCE_WHISPER
	gain_text = span_danger("你的牙齿令人不适地挪动，挤占了更多口腔空间，说话似乎变得困难了。")
	lose_text = span_notice("你的牙齿似乎缩回了一些，声音也比之前响亮了。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_NAGARAJA)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
