/obj/structure/closet/crate/cardboard
	name = "纸箱"
	desc = "一个能装东西的箱子。我知道，真是革命性的发明。"
	material_drop = /obj/item/stack/sheet/cardboard
	material_drop_amount = 4
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT * 4)
	icon_state = "cardboard"
	base_icon_state = "cardboard"
	open_sound = 'sound/items/poster/poster_ripped.ogg'
	close_sound = 'sound/machines/cardboard_box.ogg'
	open_sound_volume = 25
	close_sound_volume = 25
	paint_jobs = null
	cutting_tool = /obj/item/wirecutters
	can_weld_shut = FALSE
	lid_icon_state = "cardboardopen"

/obj/structure/closet/crate/cardboard/mothic
	name = "\improper 蛾人船队纸箱"
	desc = "大概是用来装蛾人的。"
	icon_state = "cardboard_moth"
	base_icon_state = "cardboard_moth"

/obj/structure/closet/crate/cardboard/tiziran
	name = "\improper 提兹拉货运纸箱"
	desc = "大概是用来装蜥蜴人的。"
	icon_state = "cardboard_tiziran"
	base_icon_state = "cardboard_tiziran"

/obj/structure/closet/crate/cardboard/update_icon_state()
	. = ..()
	if(opened)
		icon_state = "[base_icon_state]"
