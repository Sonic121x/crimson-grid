/* Beds... get your mind out of the gutter, they're for sleeping!
 * Contains:
 * Beds
 * Medical beds
 * Roller beds
 * Pet beds
 */

/// Beds
/obj/structure/bed
	name = "床"
	desc = "用来躺卧、睡觉，也可以把人绑在上面。"
	icon_state = "bed"
	icon = 'modular_darkpack/master_files/icons/obj/bed.dmi' // DARKPACK EDIT CHANGE
	can_buckle = TRUE
	buckle_lying = 90
	buckle_dir = SOUTH
	resistance_flags = FLAMMABLE
	max_integrity = 100
	integrity_failure = 0.35
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	/// What material this bed is made of
	var/build_stack_type = /obj/item/stack/sheet/iron
	/// How many mats to drop when deconstructed
	var/build_stack_amount = 2
	/// Mobs standing on it are nudged up by this amount. Also used to align the person back when buckled to it after init.
	var/elevation = 8
	/// If this bed can be deconstructed using a wrench
	var/can_deconstruct = TRUE
	/// Directions in which the bed has its headrest on the left side.
	var/left_headrest_dirs = NORTHEAST

/obj/structure/bed/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/soft_landing)
	if(elevation)
		AddElement(/datum/element/elevation, pixel_shift = elevation)
	update_buckle_vars(dir)
	register_context()

/obj/structure/bed/buckle_feedback(mob/living/being_buckled, mob/buckler)
	if(HAS_TRAIT(being_buckled, TRAIT_RESTRAINED))
		return ..()

	if(being_buckled == buckler)
		being_buckled.visible_message(
			span_notice("[buckler]躺到了[src]上。"),
			span_notice("你躺到了[src]上。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_buckled.visible_message(
			span_notice("[buckler]将[being_buckled]放到[src]上躺好。"),
			span_notice("[buckler]将你放到[src]上躺好。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/unbuckle_feedback(mob/living/being_unbuckled, mob/unbuckler)
	if(HAS_TRAIT(being_unbuckled, TRAIT_RESTRAINED))
		return ..()

	if(being_unbuckled == unbuckler)
		being_unbuckled.visible_message(
			span_notice("[unbuckler]从[src]上起身。"),
			span_notice("你从[src]上起身。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
	else
		being_unbuckled.visible_message(
			span_notice("[unbuckler]将[being_unbuckled]从[src]上拉了起来。"),
			span_notice("[unbuckler]将你从[src]上拉了起来。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

/obj/structure/bed/examine(mob/user)
	. = ..()
	if (can_deconstruct)
		. += span_notice("它由几个<b>螺栓</b>固定。")

/obj/structure/bed/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(held_item)
		if(held_item.tool_behaviour != TOOL_WRENCH)
			return

		context[SCREENTIP_CONTEXT_RMB] = "拆卸"
		return CONTEXTUAL_SCREENTIP_SET

	else if(has_buckled_mobs())
		context[SCREENTIP_CONTEXT_LMB] = "解开束缚"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/bed/setDir(newdir)
	. = ..()
	update_buckle_vars(newdir)

/obj/structure/bed/proc/update_buckle_vars(newdir)
	buckle_lying = newdir & left_headrest_dirs ? 270 : 90

/obj/structure/bed/atom_deconstruct(disassembled = TRUE)
	if(build_stack_type)
		new build_stack_type(loc, build_stack_amount)

/obj/structure/bed/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/bed/wrench_act_secondary(mob/living/user, obj/item/weapon)
	if (!can_deconstruct)
		return NONE
	..()
	weapon.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TRUE

/// Medical beds
/obj/structure/bed/medical
	name = "医用病床"
	icon = 'icons/obj/medical/medical_bed.dmi'
	desc = "带轮子的医用病床，可用于转运病人，或举办医务室竞速大赛。"
	icon_state = "med_down"
	base_icon_state = "med"
	anchored = FALSE
	left_headrest_dirs = SOUTHWEST
	buckle_lying = 270
	resistance_flags = NONE
	build_stack_type = /obj/item/stack/sheet/mineral/titanium
	build_stack_amount = 1
	elevation = 0
	buckle_sound = SFX_SEATBELT_BUCKLE
	unbuckle_sound = SFX_SEATBELT_UNBUCKLE
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.7, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.7)
	/// The item it spawns when it's folded up.
	var/foldable_type

/obj/structure/bed/medical/anchored
	anchored = TRUE

/obj/structure/bed/medical/emergency
	name = "急救病床"
	desc = "一张紧凑的医用病床。这款急救型号可以折叠携带，便于快速转运。"
	icon_state = "emerg_down"
	base_icon_state = "emerg"
	foldable_type = /obj/item/emergency_bed

/obj/structure/bed/medical/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noisy_movement)
	if(anchored)
		update_appearance()

/obj/structure/bed/medical/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "[anchored ? "松开刹车" : "拉紧刹车"]"
	if(!isnull(foldable_type) && !has_buckled_mobs())
		context[SCREENTIP_CONTEXT_RMB] = "折叠"

	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/bed/medical/examine(mob/user)
	. = ..()
	if(anchored)
		. += span_notice("刹车已拉紧。按住Alt点击可松开刹车。")
	else
		. += span_notice("按住Alt点击可拉紧刹车。")

	if(!isnull(foldable_type))
		. += span_notice("你可以右键点击将其折叠。")

/obj/structure/bed/medical/click_alt(mob/user)
	if(has_buckled_mobs() && (user in buckled_mobs))
		return CLICK_ACTION_BLOCKING

	anchored = !anchored
	balloon_alert(user, "刹车已[anchored ? "拉紧" : "松开"]")
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/structure/bed/medical/post_buckle_mob(mob/living/buckled)
	. = ..()
	set_density(TRUE)
	update_appearance()

/obj/structure/bed/medical/post_unbuckle_mob(mob/living/buckled)
	. = ..()
	set_density(FALSE)
	update_appearance()

/obj/structure/bed/medical/update_icon_state()
	. = ..()
	if(has_buckled_mobs())
		icon_state = "[base_icon_state]_up"
		// Push them up from the normal lying position
		if(buckled_mobs.len > 1)
			for(var/mob/living/patient as anything in buckled_mobs)
				patient.pixel_y = patient.base_pixel_y
		else
			buckled_mobs[1].pixel_y = buckled_mobs[1].base_pixel_y
	else
		icon_state = "[base_icon_state]_down"

/obj/structure/bed/medical/update_overlays()
	. = ..()
	if(!anchored)
		return

	if(has_buckled_mobs())
		. += mutable_appearance(icon, "brakes_up")
		. += emissive_appearance(icon, "brakes_up", src, alpha = src.alpha)
	else
		. += mutable_appearance(icon, "brakes_down")
		. += emissive_appearance(icon, "brakes_down", src, alpha = src.alpha)

/obj/structure/bed/medical/emergency/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/emergency_bed/silicon))
		return NONE
	var/obj/item/emergency_bed/silicon/silicon_bed = tool
	if(silicon_bed.loaded)
		to_chat(user, span_warning("你已经收纳了一张医用病床！"))
		return ITEM_INTERACT_BLOCKING

	if(has_buckled_mobs())
		if(buckled_mobs.len == 1)
			user_unbuckle_mob(buckled_mobs[1],user)
			return ITEM_INTERACT_SUCCESS

		unbuckle_all_mobs()
		user.visible_message(span_notice("[user]解开了[src]上所有生物的束缚。"))
		return ITEM_INTERACT_SUCCESS


	silicon_bed.loaded = src
	forceMove(silicon_bed)
	user.visible_message(span_notice("[user]收起了[src]。"), span_notice("你收起了[src]。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/bed/medical/emergency/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(!ishuman(user) || !user.can_perform_action(src))
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(has_buckled_mobs())
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	user.visible_message(span_notice("[user]折叠了[src]。"), span_notice("你折叠了[src]。"))
	var/obj/structure/bed/medical/emergency/folding_bed = new foldable_type(get_turf(src))
	user.put_in_hands(folding_bed)
	qdel(src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/emergency_bed
	name = "担架床"
	desc = "一张折叠起来的医用病床，可以随身携带。"
	icon = 'icons/obj/medical/medical_bed.dmi'
	icon_state = "emerg_folded"
	inhand_icon_state = "emergencybed"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL // No more excuses, stop getting blood everywhere
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.7, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.7)

/obj/item/emergency_bed/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/emergency_bed/silicon))
		return NONE

	var/obj/item/emergency_bed/silicon/silicon_bed = tool
	if(silicon_bed.loaded)
		to_chat(user, span_warning("[silicon_bed]里已经装着一张担架床！"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user]装入了[src]。"), span_notice("你将[src]装入了[silicon_bed]。"))
	silicon_bed.loaded = new/obj/structure/bed/medical/emergency(silicon_bed)
	qdel(src) //"Load"
	return ITEM_INTERACT_SUCCESS


/obj/item/emergency_bed/attack_self(mob/user)
	deploy_bed(user, user.loc)

/obj/item/emergency_bed/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(isopenturf(interacting_with))
		deploy_bed(user, interacting_with)
		return ITEM_INTERACT_SUCCESS
	return NONE


/obj/item/emergency_bed/proc/deploy_bed(mob/user, atom/location)
	var/obj/structure/bed/medical/emergency/deployed = new /obj/structure/bed/medical/emergency(location)
	deployed.add_fingerprint(user)
	qdel(src)

/obj/item/emergency_bed/silicon // ROLLER ROBO DA!
	name = "急救病床收纳装置"
	desc = "收纳着一张折叠医用病床，可弹出供急救使用。用完后必须收回或补充病床。"
	var/obj/structure/bed/medical/emergency/loaded = null

/obj/item/emergency_bed/silicon/Initialize(mapload)
	. = ..()
	loaded = new(src)

/obj/item/emergency_bed/silicon/examine(mob/user)
	. = ..()
	. += "收纳装置[loaded ? "已装入病床" : "是空的"]。"

/obj/item/emergency_bed/silicon/deploy_bed(mob/user, atom/location)
	if(loaded)
		loaded.forceMove(location)
		user.visible_message(span_notice("[user]展开了[loaded]。"), span_notice("你展开了[loaded]。"))
		loaded = null
	else
		to_chat(user, span_warning("收纳装置是空的！"))

/// Dog bed
/obj/structure/bed/dogbed
	name = "狗窝"
	icon_state = "dogbed"
	desc = "一个看起来很舒服的狗窝。你甚至可以把宠物系在里面，以防重力消失。"
	anchored = FALSE
	build_stack_type = /obj/item/stack/sheet/mineral/wood
	build_stack_amount = 10
	elevation = 0
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)
	var/owned = FALSE

/obj/structure/bed/dogbed/ian
	desc = "伊恩的窝！看起来很舒服。"
	name = "伊恩的窝"
	anchored = TRUE

/obj/structure/bed/dogbed/cayenne
	desc = "似乎有点……鱼腥味。"
	name = "卡宴的窝"
	anchored = TRUE

/obj/structure/bed/dogbed/misha
	desc = "上面到处都是毛，还有些血迹……"
	name = "米莎的窝"
	anchored = TRUE

/obj/structure/bed/dogbed/lia
	desc = "似乎有点……鱼腥味。"
	name = "莉娅的窝"
	anchored = TRUE

/obj/structure/bed/dogbed/renault
	desc = "雷诺的窝！看起来很舒服。精明如狐的人，需要一只同样机灵的宠物。"
	name = "雷诺的窝"
	anchored = TRUE

/obj/structure/bed/dogbed/mcgriff
	desc = "麦格里夫的窝，毕竟打击犯罪的英雄有时也得打个盹。"
	name = "麦格里夫的窝"

/obj/structure/bed/dogbed/runtime
	desc = "一个看起来很舒服的猫窝。你甚至可以把宠物系在里面，以防重力消失。"
	name = "运行时的窝"
	anchored = TRUE

///Used to set the owner of a dogbed, returns FALSE if called on an owned bed or an invalid one, TRUE if the possesion succeeds
/obj/structure/bed/dogbed/proc/update_owner(mob/living/furball)
	if(owned || type != /obj/structure/bed/dogbed) //Only marked beds work, this is hacky but I'm a hacky man
		return FALSE //Failed

	owned = TRUE
	name = "[furball]的窝"
	desc = "[furball]的窝！看起来很舒服。"
	return TRUE // Let any callers know that this bed is ours now

/obj/structure/bed/dogbed/buckle_mob(mob/living/furball, force, check_loc)
	. = ..()
	update_owner(furball)

/obj/structure/bed/maint
	name = "脏床垫"
	desc = "一张又旧又脏的床垫。你尽量不去想那些污渍是怎么来的。"
	icon_state = "dirty_mattress"
	elevation = 7

/obj/structure/bed/maint/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2,4), 25)

// Double Beds, for luxurious sleeping, i.e. the captain and maybe heads- if people use this for ERP, send them to skyrat
/obj/structure/bed/double
	name = "双人床"
	desc = "一张豪华双人床，专供那些连做梦都不能小气的大人物使用。"
	icon_state = "bed_double"
	build_stack_amount = 4
	max_buckled_mobs = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4)
	/// The mob who buckled to this bed second, to avoid other mobs getting pixel-shifted before he unbuckles.
	var/mob/living/goldilocks

/obj/structure/bed/double/post_buckle_mob(mob/living/target)
	. = ..()
	if(buckled_mobs.len > 1 && !goldilocks) // Push the second buckled mob a bit higher from the normal lying position
		target.pixel_y += 6
		goldilocks = target

/obj/structure/bed/double/post_unbuckle_mob(mob/living/target)
	. = ..()
	if(target == goldilocks)
		target.pixel_y -= 6
		goldilocks = null
