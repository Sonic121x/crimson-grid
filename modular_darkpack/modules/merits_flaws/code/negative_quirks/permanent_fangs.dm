// V20 p. 482
/datum/quirk/darkpack/permafangs
	name = "Permanent Fangs"
	desc = "你的獠牙无法收回，让你无法掩盖真实身份。虽然有些凡人可能以为你把牙齿磨尖了，或戴着假牙，但你迟早会遇到认得出你真面目的人。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 482)
	// TTRPG accurate would be -3? But this is also missing the max Appearance lock..
	value = -1
	mob_trait = TRAIT_PERMAFANGS
	gain_text = span_notice("你的獠牙卡住，收不回去了。")
	lose_text = span_notice("你感觉獠牙又能收回了。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_TEETH
	failure_message = "你感觉獠牙收了回去。"
