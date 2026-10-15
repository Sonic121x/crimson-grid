/obj/item/shield/door
	name = "\improper 门"
	desc = "能开也能关。"
	icon_state = "door"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	force = 15
	block_chance = 25
	throwforce = 10
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = NONE
	attack_verb_continuous = list("推撞", "猛砸")
	attack_verb_simple = list("推撞", "猛砸")
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)
