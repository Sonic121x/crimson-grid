// Contains:
// Gavel
// Sound Block

/obj/item/gavelhammer
	name = "法槌"
	desc = "肃静，肃静！我的法庭里不准放炸弹。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "gavelhammer"
	icon_angle = -135
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("猛砸", "殴打", "审判", "敲击")
	attack_verb_simple = list("猛砸", "殴打", "审判", "敲击")
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/gavelhammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/gavelhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]用[src]判了自己死刑！看起来是想自杀！"))
	playsound(loc, 'sound/items/gavel.ogg', 50, TRUE, -1)
	return BRUTELOSS

/obj/item/gavelblock
	name = "法槌垫"
	desc = "助理闹起来时，用法槌狠狠敲它。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "gavelblock"
	force = 2
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT)

/obj/item/gavelblock/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/gavelhammer))
		return NONE
	playsound(loc, 'sound/items/gavel.ogg', 100, TRUE)
	user.visible_message(span_warning("[user]用[tool]敲击[src]。"))
	user.changeNext_move(CLICK_CD_MELEE)
	return ITEM_INTERACT_SUCCESS
