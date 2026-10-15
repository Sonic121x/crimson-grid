/datum/quirk/darkpack/vengeful
	name = "Vengeful"
	desc = "你有一笔旧账未清，或结于凡人时期，或结于初拥之时。你一心要向某个人或群体复仇，无论身处何种情境，这都是你的头等大事。这是一项不涉及游戏机制的角色扮演特质；选择后，你应当扮演一个执着于复仇的角色。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 486)
	value = -1 // its a 2pt flaw in tabletop but lets be honest bro
	gain_text = span_notice("复仇成了你的执念。")
	lose_text = span_notice("你不再那么在乎复仇了。")
	icon = FA_ICON_FACE_ANGRY
	failure_message = "你不再那么在乎复仇了。"
	roleplay_only = TRUE
