/datum/quirk/darkpack/monochrome_vision
	name = "Monochrome Vision"
	desc = {"你无法分辨颜色，眼中的世界只有深浅不同的黑、白和灰。这不同于通常所说的色盲，
	后者一般指无法分辨某些颜色，例如红色和绿色。这项缺陷在狼裔狼人中相当常见。"}
	ttrpg_sources = list(/datum/source_book/wta20 = 473)
	icon = FA_ICON_ADJUST
	allowed_splats = list(SPLAT_GAROU)
	value = -1
	medical_record_text = "患者几乎完全无法辨色。"

/datum/quirk/darkpack/monochrome_vision/add(client/client_source)
	quirk_holder.add_client_colour(/datum/client_colour/monochrome, QUIRK_TRAIT)

/datum/quirk/darkpack/monochrome_vision/remove()
	quirk_holder.remove_client_colour(QUIRK_TRAIT)
