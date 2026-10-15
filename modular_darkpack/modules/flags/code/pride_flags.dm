/obj/structure/sign/flag/pride
	name = "coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_darkpack/modules/flags/icons/pride_flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride, 32)

/obj/structure/sign/flag/pride/click_alt(mob/user)
	var/init_icon_state = initial(icon_state)
	if(icon_state == init_icon_state)
		icon_state = "[icon_state]_vertical"
	else
		icon_state = init_icon_state
	return CLICK_ACTION_SUCCESS

/obj/structure/sign/flag/pride/gay
	name = "彩虹骄傲旗"
	desc = "象征同性恋骄傲的旗帜。"
	icon_state = "flag_pride"
	item_flag = /obj/item/sign/flag/pride/gay

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/gay, 32)

/obj/structure/sign/flag/pride/ace
	name = "无性恋骄傲旗"
	desc = "象征无性恋骄傲的旗帜。"
	icon_state = "flag_ace"
	item_flag = /obj/item/sign/flag/pride/ace

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/ace, 32)

/obj/structure/sign/flag/pride/bi
	name = "双性恋骄傲旗"
	desc = "象征双性恋骄傲的旗帜。"
	icon_state = "flag_bi"
	item_flag = /obj/item/sign/flag/pride/bi

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/bi, 32)

/obj/structure/sign/flag/pride/lesbian
	name = "女同性恋骄傲旗"
	desc = "象征女同性恋骄傲的旗帜。"
	icon_state = "flag_lesbian"
	item_flag = /obj/item/sign/flag/pride/lesbian

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/lesbian, 32)

/obj/structure/sign/flag/pride/pan
	name = "泛性恋骄傲旗"
	desc = "象征泛性恋骄傲的旗帜。"
	icon_state = "flag_pan"
	item_flag = /obj/item/sign/flag/pride/pan

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/pan, 32)

/obj/structure/sign/flag/pride/trans
	name = "跨性别骄傲旗"
	desc = "象征跨性别骄傲的旗帜。"
	icon_state = "flag_trans"
	item_flag = /obj/item/sign/flag/pride/trans

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/trans, 32)

/obj/structure/sign/flag/pride/mlm
	name = "男爱男骄傲旗"
	desc = "象征男爱男群体骄傲的旗帜。"
	icon_state = "flag_mlm"
	item_flag = /obj/item/sign/flag/pride/mlm

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/mlm, 32)

/obj/structure/sign/flag/pride/rabies
	name = "狂犬病骄傲旗"
	desc = "象征狂犬病骄傲的旗帜。"
	icon_state = "flag_rabies"
	item_flag = /obj/item/sign/flag/pride/rabies

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/rabies, 32)

/obj/structure/sign/flag/pride/enby
	name = "非二元性别骄傲旗"
	desc = "象征非二元性别骄傲的旗帜。"
	icon_state = "flag_enby"
	item_flag = /obj/item/sign/flag/pride/enby

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/enby, 32)

/obj/structure/sign/flag/pride/inter
	name = "间性人骄傲旗"
	desc = "象征间性人骄傲的旗帜。"
	icon_state = "flag_inter"
	item_flag = /obj/item/sign/flag/pride/inter

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/pride/inter, 32)

// FOLDED

/obj/item/sign/flag/pride
	name = "folded coder pride flag"
	desc = "You probably shouldn't be seeing this. Yell at the coders about it."
	icon = 'modular_darkpack/modules/flags/icons/pride_flags.dmi'

/obj/item/sign/flag/pride/choose
	name = "折叠的未知骄傲旗"
	desc = "点击手中的旗帜即可选择款式。"

/obj/item/sign/flag/pride/choose/attack_hand(mob/user)
	. = ..(); var/list/flag_choices = list(); for(var/obj/item/flag_type as anything in subtypesof(/obj/item/sign/flag/pride) - /obj/item/sign/flag/pride/choose) { flag_choices[initial(flag_type.name)] = flag_type; }
	var/obj/item/chosen_flag = flag_choices[tgui_input_list(user, "你带的是哪一种骄傲旗来着？", "选择旗帜", flag_choices)]
	if(!ispath(chosen_flag))
		return
	var/obj/item/created_flag = new chosen_flag(loc)
	qdel(src)
	user.put_in_hands(created_flag)

/obj/item/sign/flag/pride/gay
	name = "折叠的彩虹骄傲旗"
	desc = "折叠起来的同性恋骄傲旗帜。"
	icon_state = "folded_pride"
	sign_path = /obj/structure/sign/flag/pride/gay

/obj/item/sign/flag/pride/ace
	name = "折叠的无性恋骄傲旗"
	desc = "折叠起来的无性恋骄傲旗帜。"
	icon_state = "folded_pride_ace"
	sign_path = /obj/structure/sign/flag/pride/ace

/obj/item/sign/flag/pride/bi
	name = "折叠的双性恋骄傲旗"
	desc = "折叠起来的双性恋骄傲旗帜。"
	icon_state = "folded_pride_bi"
	sign_path = /obj/structure/sign/flag/pride/bi

/obj/item/sign/flag/pride/lesbian
	name = "折叠的女同性恋骄傲旗"
	desc = "折叠起来的女同性恋骄傲旗帜。"
	icon_state = "folded_pride_lesbian"
	sign_path = /obj/structure/sign/flag/pride/lesbian

/obj/item/sign/flag/pride/pan
	name = "折叠的泛性恋骄傲旗"
	desc = "折叠起来的泛性恋骄傲旗帜。"
	icon_state = "folded_pride_pan"
	sign_path = /obj/structure/sign/flag/pride/pan

/obj/item/sign/flag/pride/trans
	name = "折叠的跨性别骄傲旗"
	desc = "折叠起来的跨性别骄傲旗帜。"
	icon_state = "folded_pride_trans"
	sign_path = /obj/structure/sign/flag/pride/trans

/obj/item/sign/flag/pride/mlm
	name = "折叠的男爱男骄傲旗"
	desc = "折叠起来的男爱男骄傲旗帜。"
	icon_state = "folded_pride_mlm"
	sign_path = /obj/structure/sign/flag/pride/mlm

/obj/item/sign/flag/pride/rabies
	name = "折叠的狂犬病骄傲旗"
	desc = "折叠起来的狂犬病骄傲旗帜。"
	icon_state = "folded_pride_rabies"
	sign_path = /obj/structure/sign/flag/pride/rabies

/obj/item/sign/flag/pride/enby
	name = "折叠的非二元性别骄傲旗"
	desc = "折叠起来的非二元性别骄傲旗帜。"
	icon_state = "folded_pride_enby"
	sign_path = /obj/structure/sign/flag/pride/enby

/obj/item/sign/flag/pride/inter
	name = "折叠的间性人骄傲旗"
	desc = "折叠起来的间性人骄傲旗帜。"
	icon_state = "folded_pride_inter"
	sign_path = /obj/structure/sign/flag/pride/inter
