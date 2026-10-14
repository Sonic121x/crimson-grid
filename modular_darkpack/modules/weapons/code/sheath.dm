/obj/item/storage/belt/sheath/vamp
	name = "剑鞘"
	icon_state = "longsword_sheathe"
	base_icon_state = "longsword_sheathe"
	worn_icon_state = "longsword_sheathe"
	//inhand_icon_state = "longsword_sheathe"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	//lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	//righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_melee.dmi'
	custom_price = 1200

/obj/item/storage/belt/sheath/vamp/sabre
	desc = "用于收纳军官佩剑的华丽剑鞘。"
	icon_state = "sabre_sheathe"
	base_icon_state = "sabre_sheathe"
	worn_icon_state = "sabre_sheathe"
	//inhand_icon_state = "sabre_sheathe"
	storage_type = /datum/storage/sabre_belt_vamp
	stored_blade = /obj/item/melee/sabre/vamp
	custom_price = 1400

/obj/item/storage/belt/sheath/vamp/rapier
	desc = "用于收纳决斗者佩剑的华丽剑鞘。"
	icon_state = "rapier_sheathe"
	base_icon_state = "rapier_sheathe"
	worn_icon_state = "rapier_sheathe"
	//inhand_icon_state = "rapier_sheathe"
	storage_type = /datum/storage/rapier_belt_vamp
	stored_blade = /obj/item/melee/sabre/rapier

/obj/item/storage/belt/sheath/vamp/sword
	desc = "用于收纳骑士佩剑的华丽剑鞘。"
	icon_state = "longsword_sheathe"
	base_icon_state = "longsword_sheathe"
	worn_icon_state = "longsword_sheathe"
	//inhand_icon_state = "longsword_sheathe"
	storage_type = /datum/storage/sword_belt_vamp
	stored_blade = /obj/item/claymore/longsword
	custom_price = 1600


/datum/storage/sabre_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/sabre_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/melee/sabre)


/datum/storage/rapier_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/rapier_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/melee/sabre)


/datum/storage/sword_belt_vamp
	max_slots = 1
	do_rustle = FALSE
	max_specific_storage = WEIGHT_CLASS_BULKY
	click_alt_open = FALSE

/datum/storage/sword_belt_vamp/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(/obj/item/claymore)
