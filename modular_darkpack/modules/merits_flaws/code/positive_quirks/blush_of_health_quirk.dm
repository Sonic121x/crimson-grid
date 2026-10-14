/datum/quirk/darkpack/blush_of_health
	name = "Blush of Health"
	desc = "有些血族能比同类更逼真地装出活人的模样。你只需稍加努力，就能显得面色红润、体表温暖且仍在呼吸，使旁人更难看出你的不死身份。启用时，你看起来更有生气。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_BLUSH_OF_HEALTH
	gain_text = span_notice("一丝暖意在皮肤上蔓延，你的面容泛起了健康的红润。")
	lose_text = span_notice("皮肤上的暖意消散，你再次变得苍白而冰冷。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_HEART

