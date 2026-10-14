/obj/item/clothing/mask/bandana
	name = "面巾"
	desc = "一条带有纳米科技衬里的精致面巾。"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana"
	post_init_icon_state = "bandana"
	inhand_icon_state = "greyscale_bandana"
	w_class = WEIGHT_CLASS_TINY
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	slot_flags = ITEM_SLOT_MASK
	adjusted_flags = ITEM_SLOT_HEAD
	species_exception = list(/datum/species/golem)
	dying_key = DYE_REGISTRY_BANDANA
	flags_1 = IS_PLAYER_COLORABLE_1

	greyscale_config = /datum/greyscale_config/bandana
	greyscale_config_worn = /datum/greyscale_config/bandana/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/inhands_right
	greyscale_colors = "#2e2e2e"

/obj/item/clothing/mask/bandana/examine(mob/user)
	. = ..()
	if(up)
		. += "在手中使用可将它解开，当作面巾佩戴！"
		return
	if(slot_flags & ITEM_SLOT_NECK)
		. += "按住Alt点击可将它解开，当作面巾佩戴！"
	else
		. += "在手中使用可将它系成头巾！"
		. += "按住Alt点击可将它系成领巾！"

/obj/item/clothing/mask/bandana/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/bandana/adjust_visor(mob/living/user)
	if(slot_flags & ITEM_SLOT_NECK)
		to_chat(user, span_warning("你必须先解开[src]，才能将它系成头巾！"))
		return FALSE
	return ..()

/obj/item/clothing/mask/bandana/visor_toggling()
	. = ..()
	if(up)
		undyeable = TRUE
	else
		undyeable = initial(undyeable)

/obj/item/clothing/mask/bandana/click_alt(mob/user)
	if(!iscarbon(user))
		return NONE

	var/mob/living/carbon/char = user
	var/matrix/widen = matrix()
	if((char.get_item_by_slot(ITEM_SLOT_NECK) == src) || (char.get_item_by_slot(ITEM_SLOT_MASK) == src) || (char.get_item_by_slot(ITEM_SLOT_HEAD) == src))
		to_chat(user, span_warning("佩戴时无法重新系好[src]！"))
		return CLICK_ACTION_BLOCKING
	else if(slot_flags & ITEM_SLOT_HEAD)
		to_chat(user, span_warning("你必须先解开[src]，才能将它系成领巾！"))
		return CLICK_ACTION_BLOCKING
	else if(!user.is_holding(src))
		to_chat(user, span_warning("你必须把[src]拿在手中才能系它！"))
		return CLICK_ACTION_BLOCKING

	if(slot_flags & ITEM_SLOT_MASK)
		undyeable = TRUE
		slot_flags = ITEM_SLOT_NECK
		worn_y_offset = -3
		widen.Scale(1.25, 1)
		transform = widen
		user.visible_message(span_notice("[user]将[src]系成领巾。"), span_notice("你将[src]系成领巾。"))
		flags_inv = NONE
		flags_cover = NONE
		return CLICK_ACTION_SUCCESS

	undyeable = initial(undyeable)
	slot_flags = initial(slot_flags)
	worn_y_offset = initial(worn_y_offset)
	transform = initial(transform)
	user.visible_message(span_notice("[user]解开了领巾。"), span_notice("你解开了领巾。"))
	flags_inv = initial(flags_inv)
	flags_cover = initial(flags_cover)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/bandana/red
	name = "红色面巾"
	desc = "一条带有纳米科技衬里的精致红色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/red"
	greyscale_colors = "#A02525"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/blue
	name = "蓝色面巾"
	desc = "一条带有纳米科技衬里的精致蓝色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/blue"
	greyscale_colors = "#294A98"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/purple
	name = "紫色面巾"
	desc = "一条带有纳米科技衬里的精致紫色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/purple"
	greyscale_colors = "#9900CC"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/green
	name = "绿色面巾"
	desc = "一条带有纳米科技衬里的精致绿色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/green"
	greyscale_colors = "#3D9829"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/gold
	name = "金色面巾"
	desc = "一条带有纳米科技衬里的精致金色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/gold"
	greyscale_colors = "#DAC20E"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/orange
	name = "橙色面巾"
	desc = "一条带有纳米科技衬里的精致橙色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/orange"
	greyscale_colors = "#da930e"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/black
	name = "黑色面巾"
	desc = "一条带有纳米科技衬里的精致黑色面巾。"
	greyscale_colors = "#2e2e2e"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // Same color as the basetype

/obj/item/clothing/mask/bandana/white
	name = "白色面巾"
	desc = "一条带有纳米科技衬里的精致白色面巾。"
	icon_state = "/obj/item/clothing/mask/bandana/white"
	greyscale_colors = "#DCDCDC"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/durathread
	name = "耐久纤维面巾"
	desc = "一条用耐久纤维制成的面巾。你希望它能保护佩戴者，可它实在太薄了……"
	icon_state = "/obj/item/clothing/mask/bandana/durathread"
	greyscale_colors = "#5c6d80"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped
	name = "条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，上面横贯着一道条纹。"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana/striped"
	post_init_icon_state = "bandstriped"
	greyscale_config = /datum/greyscale_config/bandana/striped
	greyscale_config_worn = /datum/greyscale_config/bandana/striped/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/striped/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/striped/inhands_right
	greyscale_colors = "#2e2e2e#C6C6C6"
	undyeable = TRUE

/obj/item/clothing/mask/bandana/striped/black
	name = "条纹面巾"
	desc = "一条带有纳米科技衬里的精致黑白面巾，上面横贯着一道条纹。"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // same exact icon/color as the base type

/obj/item/clothing/mask/bandana/striped/security
	name = "安保条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用安保部配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/security"
	greyscale_colors = "#A02525#2e2e2e"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/science
	name = "科研条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用科研部配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/science"
	greyscale_colors = "#DCDCDC#8019a0"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/engineering
	name = "工程条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用工程部配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/engineering"
	greyscale_colors = "#dab50e#ec7404"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/medical
	name = "医疗条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用医疗部配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/medical"
	greyscale_colors = "#DCDCDC#5995BA"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/cargo
	name = "货运条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用货运部配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/cargo"
	greyscale_colors = "#967032#5F350B"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/striped/botany
	name = "植物条纹面巾"
	desc = "一条带有纳米科技衬里的精致面巾，饰有横向条纹，采用植物部门配色。"
	icon_state = "/obj/item/clothing/mask/bandana/striped/botany"
	greyscale_colors = "#3D9829#294A98"
	flags_1 = NONE

/obj/item/clothing/mask/bandana/skull
	name = "骷髅面巾"
	desc = "一条带有纳米科技衬里的精致面巾，印着骷髅图案。"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/bandana/skull"
	post_init_icon_state = "bandskull"
	greyscale_config = /datum/greyscale_config/bandana/skull
	greyscale_config_worn = /datum/greyscale_config/bandana/skull/worn
	greyscale_config_inhand_left = /datum/greyscale_config/bandana/skull/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/bandana/skull/inhands_right
	greyscale_colors = "#2e2e2e#C6C6C6"
	undyeable = TRUE

/obj/item/clothing/mask/bandana/skull/black
	desc = "一条带有纳米科技衬里的精致黑色面巾，印着骷髅图案。"
	greyscale_colors = "#2e2e2e#C6C6C6"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // same as the basetype

/obj/item/clothing/mask/facescarf
	name = "蒙面围巾"
	desc = "像牛仔电影里那样遮住你的脸。它还带有呼吸管，让你走到哪儿都能戴！"
	actions_types = list(/datum/action/item_action/adjust)
	inhand_icon_state = "greyscale_facescarf"
	alternate_worn_layer = BACK_LAYER
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#eeeeee"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/facescarf"
	post_init_icon_state = "facescarf"
	greyscale_config = /datum/greyscale_config/facescarf
	greyscale_config_worn = /datum/greyscale_config/facescarf/worn
	greyscale_config_inhand_left = /datum/greyscale_config/facescarf/inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/facescarf/inhands_right
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING

/obj/item/clothing/mask/facescarf/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/facescarf/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS


/obj/item/clothing/mask/facescarf/examine(mob/user)
	. = ..()
	. += span_notice("按住Alt点击[src]可调整佩戴方式。")
