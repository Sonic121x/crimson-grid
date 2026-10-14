/datum/quirk/darkpack/coldly_logical
	name = "Coldly Logical"
	desc = "尽管有人可能称你为“冷血动物”，你却擅长从情绪化或歇斯底里的渲染中辨明事实。无论你自己是否感情丰富，都能看穿他人用情绪掩盖事实的行为。所有通过情绪影响你的律能，例如威仪术和悲歌术，难度均增加 1。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 484)
	value = 1
	mob_trait = TRAIT_COLDLY_LOGICAL
	gain_text = span_notice("你清楚地知道，事实和感受是截然不同的两回事。")
	lose_text = span_notice("偏见是什么？")
	icon = FA_ICON_FACE_MEH
	failure_message = "偏见是什么？"
