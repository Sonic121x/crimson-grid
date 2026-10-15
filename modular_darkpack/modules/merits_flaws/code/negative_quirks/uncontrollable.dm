//Clanbook: Brujah Revised (69)
/datum/quirk/darkpack/uncontrollable
	name = "Uncontrollable"
	desc = {"在暴躁的布鲁赫灵魂中，怒火与激情
		永不停息地交战。也许你在初拥之前就
		脾气恶劣，也许是布鲁赫的血脉唤醒了
		潜藏的愤怒。无论如何，你比其他
		族人更容易陷入狂乱。你抵抗
		狂乱的难度始终为 10。准备迎接
		一段短暂而地狱般的旅程吧。"}
	value = -5
	mob_trait = TRAIT_UNCONTROLLABLE
	icon = FA_ICON_HEART_CRACK
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_BRUJAH)
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS
