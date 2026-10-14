/obj/item/smartphone/payphone
	name = "公用电话"
	desc = "铃铃。铃铃。铃铃。"
	ONFLOOR_ICON_HELPER(null)
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	base_icon_state = "payphone"
	icon_state = "payphone"
	anchored = TRUE
	opened = TRUE
	always_open = TRUE
	default_sim_card_type = /obj/item/sim_card/landline

/obj/item/smartphone/payphone/attack_hand(mob/user, list/modifiers)
	. = ..()
	ui_interact(user)

/obj/item/smartphone/clean
	name = "清洁公司电话"
	desc = "清洁公司用来联系员工的普通电话。"
	ONFLOOR_ICON_HELPER(null)
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	base_icon_state = "phone_black"
	icon_state = "phone_black"
	anchored = TRUE
	opened = TRUE
	always_open = TRUE
	default_sim_card_type = /obj/item/sim_card/cleaner

/obj/item/smartphone/clean/attack_hand(mob/user, list/modifiers)
	. = ..()
	ui_interact(user)

/obj/item/smartphone/emergency
	name = "911 接警电话"
	desc = "用于接听紧急求助来电的电话。"
	ONFLOOR_ICON_HELPER(null)
	icon = 'modular_darkpack/modules/phones/icons/phone.dmi'
	base_icon_state = "phone_red"
	icon_state = "phone_red"
	anchored = TRUE
	opened = TRUE
	always_open = TRUE
	default_sim_card_type = /obj/item/sim_card/emergency

/obj/item/smartphone/emergency/attack_hand(mob/user, list/modifiers)
	. = ..()
	ui_interact(user)
