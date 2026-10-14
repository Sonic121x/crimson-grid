/obj/item/storage/ashtray
	name = "烟灰缸"
	desc = "用于放置和处理烟草制品的小碟子。"
	icon = 'modular_darkpack/modules/ashtray/icons/ashtray.dmi'
	icon_state = "ashtray"
	base_icon_state = "ashtray"
	color = "#303030"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound = 'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = 30
	var/recolored = FALSE

/obj/item/storage/ashtray/update_overlays()
	. = ..()
	if(contents.len == atom_storage.max_slots)
		. += mutable_appearance(icon, "[base_icon_state]_overlay-full", appearance_flags = RESET_COLOR|KEEP_APART)
	else if(contents.len && (contents.len >= atom_storage.max_slots/2))
		. += mutable_appearance(icon, "[base_icon_state]_overlay-half", appearance_flags = RESET_COLOR|KEEP_APART)

/obj/item/storage/ashtray/Entered()
	. = ..()
	update_icon(UPDATE_OVERLAYS)

/obj/item/storage/ashtray/Exited()
	. = ..()
	update_icon(UPDATE_OVERLAYS)

/obj/item/storage/ashtray/attack_self(mob/user)
	. = ..()

	if(!recolored)
		var/option_select = tgui_alert(user, "请选择操作", "[src]", list("倒空", "重新着色", "不再询问"))
		switch(option_select)
			if("重新着色")
				var/input_color = input(user, "请选择颜色。","[src]",color) as color

				var/list/skin_hsv = rgb2hsv(input_color)
				if(skin_hsv[3] < 20)
					to_chat(user, span_warning("给这种东西涂这么暗的颜色？还是算了吧……"))
					return

				color = input_color
				recolored = TRUE
			if("不再询问")
				recolored = TRUE
			if("倒空")
				dump_ashtray(user)
	else
		dump_ashtray(user)


/obj/item/storage/ashtray/proc/dump_ashtray(mob/user)
	var/ciggie_butts = 0

	if(!contents.len)
		to_chat(user, span_warning("你把[src]朝地上倒了倒，可惜里面什么也没有。"))
		return

	user.visible_message(span_notice("[user]把[src]中的东西倒在地上。"), \
		span_notice("你把[src]中的东西倒在地上。"))
	for(var/obj/item/cigbutt/butt in contents)
		ciggie_butts += 1
		qdel(butt)

	if(ciggie_butts > 8)
		new /obj/effect/decal/cleanable/ash/large(get_turf(user))
	else if(ciggie_butts)
		new /obj/effect/decal/cleanable/ash(get_turf(user))

	emptyStorage()
	playsound(user, 'sound/items/lighter/cig_snuff.ogg', rand(10,50), TRUE)


/datum/storage/ashtray
	max_slots = 16
	max_specific_storage = WEIGHT_CLASS_TINY

/datum/storage/ashtray/New(atom/parent, max_slots, max_specific_storage, max_total_storage, rustle_sound, remove_rustle_sound)
	. = ..()
	set_holdable(
		list(
			/obj/item/match,
			/obj/item/cigbutt,
			/obj/item/cigarette,
			/obj/item/rollingpaper
		),
		list(/obj/item/cigarette/pipe) // Blacklist
	)


/datum/loadout_item/pocket_items/ashtray
	name = "Ashtray"
	item_path = /obj/item/storage/ashtray

/datum/loadout_item/pocket_items/ashtray/get_item_information()
	. = ..()
	.[FA_ICON_PALETTE] = "可重新着色"
