/obj/machinery/computer/stockexchange
	name = "证券交易电脑"
	desc = "连接银河证券市场的终端。股票交易存在重大亏损风险，并非适合所有货运技师。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = MAP_SWITCH("oldcomp", "/obj/machinery/computer/pod/old")
	icon_screen = "stock_computer"
	icon_keyboard = null
	var/logged_in = "Millenium Stock Department"
	var/vmode = 1
	interaction_flags_atom = INTERACT_ATOM_REQUIRES_DEXTERITY | INTERACT_ATOM_UI_INTERACT | INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_REQUIRES_ANCHORED

	light_color = LIGHT_COLOR_GREEN

//i just removed all the stupid flavcode shit that was here. it was not worth looking at.
// DARKPACK TODO - Stock market rework
