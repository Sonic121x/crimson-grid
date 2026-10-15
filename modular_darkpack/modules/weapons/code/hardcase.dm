/obj/item/storage/fancy/hardcase
	name = "弹匣硬盒"
	desc = "用于携带弹匣的小型金属硬盒。"
	icon = 'modular_darkpack/modules/weapons/icons/storage.dmi'
	icon_state = "hardcasebox"
	base_icon_state = "hardcasebox"
	inhand_icon_state = "ammobox"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

	obj_flags = CONDUCTS_ELECTRICITY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)

	storage_type = /datum/storage/hardcase
	spawn_count = 4

/datum/storage/hardcase
	max_slots = 4

/datum/storage/hardcase/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	// Old behavoir restricted to only the spawn_type mag. Changed to be any mag.
	set_holdable(/obj/item/ammo_box/magazine)

/obj/item/storage/fancy/hardcase/mag_556
	name = "5.56弹匣硬盒"
	desc = "专门用于携带5.56弹匣的小型金属硬盒。"
	spawn_type = /obj/item/ammo_box/magazine/darkpack556

/obj/item/storage/fancy/hardcase/mag_mp5
	name = "MP5弹匣硬盒"
	desc = "专门用于携带MP5弹匣的小型金属硬盒。"
	spawn_type = /obj/item/ammo_box/magazine/darkpack9mp5

