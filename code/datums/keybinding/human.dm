/datum/keybinding/human
	category = CATEGORY_HUMAN
	weight = WEIGHT_MOB

/datum/keybinding/human/can_use(client/user)
	return ishuman(user.mob)

/datum/keybinding/human/quick_equip
	hotkey_keys = list("E")
	name = "quick_equip"
	full_name = "快速装备"
	description = "将物品快速放入最合适的可用装备栏位"
	keybind_signal = COMSIG_KB_HUMAN_QUICKEQUIP_DOWN

/datum/keybinding/human/quick_equip/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = user.mob
	H.quick_equip()
	return TRUE

/datum/keybinding/human/quick_equip_belt
	hotkey_keys = list("ShiftE")
	name = "quick_equip_belt"
	full_name = "快速存取腰带"
	description = "将手持物品放入腰带，或取出腰带中最后放入的物品"
	///which slot are we trying to quickdraw from/quicksheathe into?
	var/slot_type = ITEM_SLOT_BELT
	///what we should call slot_type in messages (including failure messages)
	var/slot_item_name = "腰带"
	keybind_signal = COMSIG_KB_HUMAN_QUICKEQUIPBELT_DOWN

/datum/keybinding/human/quick_equip_belt/down(client/user, turf/target, mousepos_x, mousepos_y)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/H = user.mob
	H.smart_equip_targeted(slot_type, slot_item_name)
	return TRUE

/datum/keybinding/human/quick_equip_belt/quick_equip_bag
	hotkey_keys = list("ShiftB")
	name = "quick_equip_bag"
	full_name = "快速存取背包"
	description = "将手持物品放入背包，或取出背包中最后放入的物品"
	slot_type = ITEM_SLOT_BACK
	slot_item_name = "背包"
	keybind_signal = COMSIG_KB_HUMAN_BAGEQUIP_DOWN

/datum/keybinding/human/quick_equip_belt/quick_equip_suit_storage
	hotkey_keys = list("ShiftQ")
	name = "quick_equip_suit_storage"
	full_name = "快速存取外套储物栏"
	description = "将手持物品放入外套储物栏中的容器，或从中取出最后放入的物品"
	slot_type = ITEM_SLOT_SUITSTORE
	slot_item_name = "外套储物栏中的容器"
	keybind_signal = COMSIG_KB_HUMAN_SUITEQUIP_DOWN

/datum/keybinding/human/quick_equip_belt/quick_equip_lpocket
	hotkey_keys = list("Ctrl1")
	name = "quick_equip_lpocket"
	full_name = "快速存取左口袋"
	description = "将物品放入左口袋，或从中取出物品"
	slot_type = ITEM_SLOT_LPOCKET
	slot_item_name = "左口袋"
	keybind_signal = COMSIG_KB_HUMAN_LPOCKETEQUIP_DOWN

/datum/keybinding/human/quick_equip_belt/quick_equip_rpocket
	hotkey_keys = list("Ctrl2")
	name = "quick_equip_rpocket"
	full_name = "快速存取右口袋"
	description = "将物品放入右口袋，或从中取出物品"
	slot_type = ITEM_SLOT_RPOCKET
	slot_item_name = "右口袋"
	keybind_signal = COMSIG_KB_HUMAN_RPOCKETEQUIP_DOWN
