/datum/quirk/darkpack/speech_impediment
	name = "Speech Impediment"
	desc = "你有口吃，说话交流时会受到妨碍。"
	icon = FA_ICON_COMMENT_SLASH
	ttrpg_sources = list(/datum/source_book/vtm20 = 485)
	value = -1
	gain_text = span_danger("你开始担心自己说话时的表现。")
	lose_text = span_notice("你又能更轻松地说话了。")

/datum/quirk/darkpack/speech_impediment/add(client/client_source)
	quirk_holder.apply_status_effect(/datum/status_effect/speech/stutter/impediment, INFINITY)

/datum/quirk/darkpack/speech_impediment/remove()
	quirk_holder.remove_status_effect(/datum/status_effect/speech/stutter/impediment)


/datum/status_effect/speech/stutter/impediment
	id = "speech_impediment_stutter"
	stutter_prob = 10
	remove_on_fullheal = FALSE
