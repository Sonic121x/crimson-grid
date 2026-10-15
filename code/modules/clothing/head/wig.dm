/obj/item/clothing/head/wig
	name = "假发"
	desc = "一团没有连着脑袋的头发。"
	icon = 'icons/mob/human/human_face.dmi'   // default icon for all hairs
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "hair_vlong"
	inhand_icon_state = "pwig"
	worn_icon_state = "wig"
	flags_inv = HIDEHAIR
	color = COLOR_BLACK
	var/hairstyle = "Very Long Hair"
	var/adjustablecolor = TRUE //can color be changed manually?

/obj/item/clothing/head/wig/Initialize(mapload)
	. = ..()
	update_appearance()
	AddComponent(/datum/component/hat_stabilizer, loose_hat = FALSE)

/obj/item/clothing/head/wig/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user) && (slot & ITEM_SLOT_HEAD))
		ADD_TRAIT(src, TRAIT_EXAMINE_SKIP, CLOTHING_TRAIT)

/obj/item/clothing/head/wig/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(src, TRAIT_EXAMINE_SKIP, CLOTHING_TRAIT)

/obj/item/clothing/head/wig/update_icon_state()
	var/datum/sprite_accessory/hair/hair_style = SSaccessories.hairstyles_list[hairstyle]
	if(hair_style)
		icon = hair_style.icon
		icon_state = hair_style.icon_state
	return ..()

/obj/item/clothing/head/wig/worn_overlays(mutable_appearance/standing, isinhands = FALSE, icon_file, bodyshape = NONE)
	. = ..()
	if(isinhands)
		return

	var/datum/sprite_accessory/hair/hair = SSaccessories.hairstyles_list[hairstyle]
	if(!hair)
		return

	var/mutable_appearance/hair_overlay = mutable_appearance(hair.icon, hair.icon_state, layer = -HAIR_LAYER, appearance_flags = RESET_COLOR)
	hair_overlay.color = color
	hair_overlay.pixel_z = hair.y_offset
	. += hair_overlay

	// So that the wig actually blocks emissives.
	hair_overlay.overlays += emissive_blocker(hair_overlay.icon, hair_overlay.icon_state, src, alpha = hair_overlay.alpha)

/obj/item/clothing/head/wig/attack_self(mob/user)
	var/new_style = localized_accessory_input(user, "选择发型", "假发造型", SSaccessories.hairstyles_list - "Bald")
	var/newcolor = adjustablecolor ? tgui_color_picker(usr,"","选择颜色",color) : null
	if(!user.can_perform_action(src))
		return
	if(new_style && new_style != hairstyle)
		hairstyle = new_style
		user.visible_message(span_notice("[user]将[src]的发型改为[localized_accessory_names(list(new_style))[new_style]]。"), span_notice("你将[src]的发型改为[localized_accessory_names(list(new_style))[new_style]]。"))
	if(newcolor && newcolor != color) // only update if necessary
		add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	update_appearance()

/obj/item/clothing/head/wig/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	return interact_with_atom(interacting_with, user, modifiers)

/obj/item/clothing/head/wig/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with) || interacting_with == user)
		return NONE
	var/mob/living/carbon/human/target = interacting_with
	if(target.head)
		var/obj/item/clothing/head = target.head
		if((head.flags_inv & HIDEHAIR) && !istype(head, /obj/item/clothing/head/wig))
			to_chat(user, span_warning("你无法看清对方的头发！"))
			return ITEM_INTERACT_BLOCKING
	var/obj/item/bodypart/head/noggin = target.get_bodypart(BODY_ZONE_HEAD)
	if(!noggin)
		to_chat(user, span_warning("对方没有头！"))
		return ITEM_INTERACT_BLOCKING

	var/selected_hairstyle = null
	var/selected_hairstyle_color = null
	if(istype(target.head, /obj/item/clothing/head/wig))
		var/obj/item/clothing/head/wig/wig = target.head
		selected_hairstyle = wig.hairstyle
		selected_hairstyle_color = wig.color
	else if((noggin.head_flags & HEAD_HAIR) && target.hairstyle != "Bald")
		selected_hairstyle = target.hairstyle
		selected_hairstyle_color = "[target.hair_color]"

	if(selected_hairstyle)
		to_chat(user, span_notice("你调整[src]，使其与[target.name]的[localized_accessory_names(list(selected_hairstyle))[selected_hairstyle]]发型一模一样。"))
		add_atom_colour(selected_hairstyle_color, FIXED_COLOUR_PRIORITY)
		hairstyle = selected_hairstyle
		update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/head/wig/random/Initialize(mapload)
	hairstyle = pick(SSaccessories.hairstyles_list - "Bald") //Don't want invisible wig
	add_atom_colour("#[random_short_color()]", FIXED_COLOUR_PRIORITY)
	. = ..()

/obj/item/clothing/head/wig/natural
	name = "自然假发"
	desc = "一团没有连着脑袋的头发。它会改变颜色，与佩戴者的发色一致。这可一点也不自然。"
	color = COLOR_WHITE
	adjustablecolor = FALSE
	custom_price = PAYCHECK_COMMAND

/obj/item/clothing/head/wig/natural/Initialize(mapload)
	hairstyle = pick(SSaccessories.hairstyles_list - "Bald")
	. = ..()

/obj/item/clothing/head/wig/natural/visual_equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(ishuman(user) && (slot & ITEM_SLOT_HEAD))
		if(color != user.hair_color) // only update if necessary
			add_atom_colour(user.hair_color, FIXED_COLOUR_PRIORITY)
			update_appearance()
		user.update_worn_head()
