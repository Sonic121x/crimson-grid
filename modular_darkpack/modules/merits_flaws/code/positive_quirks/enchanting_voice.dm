/datum/quirk/darkpack/enchanting_voice
	name = "Enchanting Voice"
	desc = "你的声音有种令人无法忽视的力量。你发号施令时，旁人心生畏惧；你出言诱惑时，他们为之倾倒。无论怒喝、安抚、劝说还是闲谈，你总能引人倾听。所有借助声音进行劝说、魅惑或命令的检定，例如威仪术、支配术或悲歌术，难度均降低 2。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 2
	mob_trait = TRAIT_ENCHANTING_VOICE
	gain_text = span_notice("你的声音似乎更有分量了，开口时一定能引人倾听。")
	lose_text = span_notice("你的声音恢复了平常的样子。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_PODCAST

