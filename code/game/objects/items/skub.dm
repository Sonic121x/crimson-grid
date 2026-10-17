/obj/item/skub
	desc = "这是斯库布。"
	name = "斯库布"
	icon = 'icons/obj/maintenance_loot.dmi'
	icon_state = "skub"
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("斯库布击")
	attack_verb_simple = list("斯库布击")
	brand = "badcode" // DARKPACK EDIT ADD - COMPANY_LOGOS - Proof of concept. I kinda like it. Leave it?

/obj/item/skub/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/container_item/tank_holder, "holder_skub", FALSE)

/obj/item/skub/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]宣称自己反对斯库布！斯库布将其撕成碎片！"))
	user.gib(DROP_ALL_REMAINS)
	playsound(src, 'sound/items/eatfood.ogg', 50, TRUE, -1)
	return MANUAL_SUICIDE
