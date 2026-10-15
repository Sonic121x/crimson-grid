/datum/quirk/darkpack/weak_willed
	name = "Weak Willed"
	desc = {"你几乎无力抵抗他人的支配或威吓。
		支配术等以控制为主的能力对你自动成功。
		你抵抗改变心智的法术或魔法时，难度增加 2。"}
	/* Need to implement the other effects still.....
		desc = {"You have little resistance to attempts to dominate or intimidate you.
		Domination-focused Powers such as Dominate, Staredown, Roll Over, etc. automatically succeed against you.
		Your difficulties to resist Social Talents such as Intimidation or Leadership, as well as mind-altering spells or magic, are increased by two.
		Your Willpower may never rise above 4"}
	*/
	ttrpg_sources = list(
		/datum/source_book/vtm20 = 486,
		/datum/source_book/wta20 = 478,
	)
	value = -1
	mob_trait = TRAIT_WEAK_WILLED
	icon = FA_ICON_BRAIN

