/datum/quirk/darkpack/amnesia
	name = "Amnesia"
	desc = "你无法记起自己的过去、身份或家人，无论他们是凡人还是血族，但过去仍可能回来纠缠你。你连自己的名字都难以想起，记忆中最重要的细节也已永久消失。这是一项不影响游戏机制的角色扮演特质；选择后，你应当扮演角色失忆的状态。"
	value = -1 // -2 in tabletop, but lets be real
	gain_text = span_notice("你忘记了关于自己和过去的一切。")
	lose_text = span_notice("哦，我想起来了。")
	icon = FA_ICON_BRAIN
	failure_message = "哦，我想起来了。"
	ttrpg_sources = list(
		/datum/source_book/vtm20 = 486,
		/datum/source_book/wta20 = 477,
		)
	roleplay_only = TRUE
