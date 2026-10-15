/datum/keybinding/living/item_pixel_shift
	hotkey_keys = list("Unbound")
	name = "item_pixel_shift"
	full_name = "物品像素微调"
	description = "调整正在拖拽的物品在格内的位置。"
	category = CATEGORY_MISC
	keybind_signal = COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_DOWN

/datum/keybinding/living/item_pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_DOWN)

/datum/keybinding/living/item_pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_ITEM_PIXEL_SHIFT_UP)

/datum/keybinding/living/pixel_shift
	hotkey_keys = list("Unbound")
	name = "pixel_shift"
	full_name = "角色像素微调"
	description = "调整角色在格内的位置。"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_LIVING_PIXEL_SHIFT_DOWN

/datum/keybinding/living/pixel_shift/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_SHIFT_DOWN)

/datum/keybinding/living/pixel_shift/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_SHIFT_UP)

/datum/keybinding/living/pixel_tilting
	hotkey_keys = list("Unbound")
	name = "Pixel Tilting"
	full_name = "角色倾斜"
	description = "调整角色的倾斜角度。"
	category = CATEGORY_MOVEMENT
	keybind_signal = COMSIG_KB_LIVING_PIXEL_TILT_DOWN

/datum/keybinding/living/pixel_tilting/down(client/user)
	. = ..()
	if(.)
		return
	user.mob.AddComponent(/datum/component/pixel_shift)
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_TILT_DOWN)

/datum/keybinding/living/pixel_tilting/up(client/user)
	. = ..()
	SEND_SIGNAL(user.mob, COMSIG_KB_LIVING_PIXEL_TILT_UP)
