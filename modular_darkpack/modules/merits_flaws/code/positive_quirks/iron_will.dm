/datum/quirk/darkpack/iron_will
	name = "Iron Will"
	desc = "一旦你下定决心，便没有什么能阻止你达成目标。惑狂术、支配术以及其他改变心智的律能对你施展时，难度增加 3；威仪术不在此列。" // TODO: no check exists for characters under 8 wp
	ttrpg_sources = list(/datum/source_book/vtm20 = 485)
	value = 3
	mob_trait = TRAIT_IRON_WILL
	gain_text = span_notice("你的意志坚如钢铁。")
	lose_text = span_notice("你的意志不再坚如钢铁。")
	icon = FA_ICON_USER_SHIELD
	failure_message = "你的意志不再坚如钢铁。"
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_GARGOYLE)

/datum/quirk/darkpack/iron_will/human
	name = "Iron Will (Non-Vampire)"
	ttrpg_sources = list(/datum/source_book/huntershunted1 = 60) // Hunters Hunted 1st edition
	value = 4
	allowed_splats = null
	forbidden_splats = list(SPLAT_KINDRED)
