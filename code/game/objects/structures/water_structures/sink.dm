/obj/structure/sink
	name = "水池"
	icon = 'modular_darkpack/master_files/icons/obj/watercloset.dmi' // DARKPACK EDIT CHANGE
	icon_state = "sink"
	desc = "用于洗手洗脸的水池，会随时间自动回收补充水。"
	anchored = TRUE
	layer = ABOVE_OBJ_LAYER
	pixel_z = 1
	///Something's being washed at the moment
	var/busy = FALSE
	///Capacity of this sink
	var/capacity = 100
	///What kind of reagent is produced by this sink by default? (We now have actual plumbing, Arcane, August 2020)
	var/dispensedreagent = /datum/reagent/water
	///Material to drop when broken or deconstructed.
	var/buildstacktype = /obj/item/stack/sheet/iron
	///Number of sheets of material to drop when broken or deconstructed.
	var/buildstackamount = 1
	///Does the sink have a water recycler to recollect its water supply?
	var/has_water_reclaimer = TRUE
	///Units of water to reclaim per second
	var/reclaim_rate = 50 // DARKPACK EDIT CHANGE - ORIGINAL: var/reclaim_rate = 0.5

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink, (-14))

/obj/structure/sink/Initialize(mapload)
	. = ..()

	create_reagents(capacity, NO_REACT)
	if(has_water_reclaimer)
		reagents.add_reagent(dispensedreagent, capacity)
	// AddComponent(/datum/component/plumbing/simple_demand/extended) // DARKPACK EDIT REMOVAL

	register_context()

	if(mapload && !find_and_mount_on_atom(mark_for_late_init = TRUE))
		return INITIALIZE_HINT_LATELOAD

/obj/structure/sink/LateInitialize()
	find_and_mount_on_atom(late_init = TRUE)

/obj/structure/sink/atom_deconstruct(dissambled = TRUE)
	if(buildstacktype)
		new buildstacktype(loc,buildstackamount)
	else
		for(var/i in custom_materials)
			var/datum/material/M = i
			new M.sheet_type(loc, FLOOR(custom_materials[M] / SHEET_MATERIAL_AMOUNT, 1))
	if(has_water_reclaimer)
		new /obj/item/stock_parts/water_recycler(drop_location())

/obj/structure/sink/is_mountable_turf(turf/target)
	return !isgroundlessturf(target)

/obj/structure/sink/get_turfs_to_mount_on()
	return list(get_turf(src))

/obj/structure/sink/get_mountable_objects()
	return list()

/obj/structure/sink/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = NONE
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "洗手"
		return CONTEXTUAL_SCREENTIP_SET

	if(is_reagent_container(held_item))
		if(held_item.is_refillable() && !held_item.reagents.holder_full())
			context[SCREENTIP_CONTEXT_LMB] = "灌装容器"
		if(held_item.reagents.total_volume > 0)
			context[SCREENTIP_CONTEXT_RMB] = "倒空容器"
		return CONTEXTUAL_SCREENTIP_SET

	if(istype(held_item, /obj/item/mop) || astype(held_item, /obj/item/rag)?.blood_level == 0)
		context[SCREENTIP_CONTEXT_LMB] = "浸湿拖把"
		context[SCREENTIP_CONTEXT_RMB] = "冲洗拖把"
		return CONTEXTUAL_SCREENTIP_SET

	if(istype(held_item, /obj/item/stock_parts/water_recycler) && !has_water_reclaimer)
		context[SCREENTIP_CONTEXT_LMB] = "安装水回收器"
		return CONTEXTUAL_SCREENTIP_SET

	if(istype(held_item, /obj/item/storage/fancy/pickles_jar))
		context[SCREENTIP_CONTEXT_LMB] = "清洗腌黄瓜罐"
		return CONTEXTUAL_SCREENTIP_SET

	if(!user.combat_mode || (held_item.item_flags & NOBLUDGEON))
		context[SCREENTIP_CONTEXT_LMB] = "清洗物品"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sink/examine(mob/user)
	. = ..()
	if(has_water_reclaimer)
		. += span_notice("装有水回收器，似乎可以将其撬出来。")
	. += span_notice("剩余液体：[reagents.total_volume]/[reagents.maximum_volume]。")
	. += span_notice("手持容器[EXAMINE_HINT("右键点击")]，可将其中的液体倒入下水道。")

/obj/structure/sink/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user || !istype(user))
		return
	if(!iscarbon(user))
		return
	if(!Adjacent(user))
		return
	if(reagents.total_volume < 5)
		to_chat(user, span_warning("水池没水了！"))
		return
	if(busy)
		to_chat(user, span_warning("已经有人在这里清洗了！"))
		return

	var/selected_area = user.parse_zone_with_bodypart(user.zone_selected)
	var/washing_face = FALSE
	if(selected_area in list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES))
		washing_face = TRUE

	playsound(src, 'sound/machines/sink-faucet.ogg', 50)
	user.visible_message(span_notice("[user]开始洗[washing_face ? "脸" : "手"]……"), \
						span_notice("你开始洗[washing_face ? "脸" : "手"]……"))
	busy = TRUE

	if(!do_after(user, 4 SECONDS, target = src))
		busy = FALSE
		return

	busy = FALSE
	reagents.expose(user, TOUCH, 5 / max(reagents.total_volume, 5))
	reagents.remove_all(5)
	START_PROCESSING(SSobj, src)
	if(washing_face)
		SEND_SIGNAL(user, COMSIG_COMPONENT_CLEAN_FACE_ACT, CLEAN_WASH)
	else if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(!human_user.wash_hands(CLEAN_WASH))
			to_chat(user, span_warning("你的双手被东西遮住了！"))
			return
	else
		user.wash(CLEAN_WASH)

	user.visible_message(span_notice("[user]用[src]洗了[washing_face ? "脸" : "手"]。"), \
						span_notice("你用[src]洗了[washing_face ? "脸" : "手"]。"))

/obj/structure/sink/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(busy)
		to_chat(user, span_warning("已经有人在这里清洗了！"))
		return ITEM_INTERACT_FAILURE

	if(is_reagent_container(tool))
		var/obj/item/reagent_containers/RG = tool
		if(!reagents.total_volume)
			to_chat(user, span_notice("[src]没水了。"))
			return ITEM_INTERACT_FAILURE
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				reagents.trans_to(RG, RG.amount_per_transfer_from_this, transferred_by = user)
				START_PROCESSING(SSobj, src)
				to_chat(user, span_notice("你从[src]向[RG]中灌入了液体。"))
				return ITEM_INTERACT_SUCCESS
			to_chat(user, span_notice("[RG]已经装满了。"))
		return ITEM_INTERACT_FAILURE

	if(istype(tool, /obj/item/mop) || astype(tool, /obj/item/rag)?.blood_level == 0)
		if(!reagents.total_volume)
			to_chat(user, span_notice("[src]没水了。"))
			return ITEM_INTERACT_FAILURE
		reagents.trans_to(tool, 5, transferred_by = user)
		START_PROCESSING(SSobj, src)
		to_chat(user, span_notice("你在[src]里浸湿了[tool]。"))
		playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stock_parts/water_recycler))
		if(has_water_reclaimer)
			to_chat(user, span_warning("已经装有水回收器了。"))
			return ITEM_INTERACT_FAILURE

		playsound(src, 'sound/machines/click.ogg', 20, TRUE)
		qdel(tool)
		has_water_reclaimer = TRUE
		START_PROCESSING(SSobj, src)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/storage/fancy/pickles_jar))
		if(tool.contents.len)
			to_chat(user, span_notice("罐子里似乎还留着东西。"))
			return ITEM_INTERACT_FAILURE
		qdel(tool)
		to_chat(user, span_notice("你洗净了罐子，冲掉了盐水。"))
		user.put_in_active_hand(new /obj/item/reagent_containers/cup/beaker/large(loc))
		return ITEM_INTERACT_SUCCESS

	if(!user.combat_mode || (tool.item_flags & NOBLUDGEON))
		if(reagents.total_volume < 5)
			to_chat(user, span_warning("水池没水了！"))
			return ITEM_INTERACT_FAILURE

		to_chat(user, span_notice("你开始清洗[tool]……"))
		playsound(src, 'sound/machines/sink-faucet.ogg', 50)

		var/obj/item/melee/baton/security/baton = tool
		if(istype(baton) && baton.active && baton.cell?.use(baton.cell_hit_cost, force = TRUE))
			flick("baton_active", src)
			user.Paralyze(baton.knockdown_time)
			user.set_stutter(baton.knockdown_time)
			user.visible_message(span_warning("[user]试图清洗还开着的[baton.name]，结果电到了自己！"), \
								span_userdanger("你竟然试图清洗还开着的[baton]，真不明智。"))
			playsound(src, baton.on_stun_sound, 50, TRUE)
			return ITEM_INTERACT_FAILURE

		busy = TRUE
		if(!do_after(user, 4 SECONDS, target = src))
			busy = FALSE
			return ITEM_INTERACT_FAILURE
		busy = FALSE
		tool.wash(CLEAN_WASH)
		reagents.expose(tool, TOUCH, 5 / max(reagents.total_volume, 5))
		reagents.remove_all(5)
		START_PROCESSING(SSobj, src)
		user.visible_message(span_notice("[user]用[src]清洗了[tool]。"), \
							span_notice("你用[src]清洗了[tool]。"))
		return ITEM_INTERACT_SUCCESS

/obj/structure/sink/item_interaction_secondary(mob/living/user, obj/item/held_item, list/modifiers)
	if(!is_reagent_container(held_item) && !istype(held_item, /obj/item/mop))
		return ..()

	if(busy)
		to_chat(user, span_warning("已经有人在这里清洗了！"))
		return ITEM_INTERACT_BLOCKING

	if(held_item.reagents.total_volume <= 0)
		balloon_alert(user, "已经空了！")
		return ITEM_INTERACT_BLOCKING

	held_item.reagents.clear_reagents()
	playsound(src, 'sound/effects/slosh.ogg', 25, TRUE)

	user.visible_message(
		span_notice("[user]把[held_item]中的液体倒进了[src]。"),
		span_notice("你把[held_item]中的液体倒进[src]，冲入下水道。"),
	)
	return ITEM_INTERACT_SUCCESS

/obj/structure/sink/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/structure/sink/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()

	if(!has_water_reclaimer)
		to_chat(user, span_warning("没有可拆除的水回收器。"))
		return ITEM_INTERACT_FAILURE

	tool.play_tool_sound(src)
	has_water_reclaimer = FALSE
	new/obj/item/stock_parts/water_recycler(get_turf(loc))
	to_chat(user, span_notice("你从[src]上拆下了水回收器。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/sink/process(seconds_per_tick)
	// Water reclamation complete?
	if(!has_water_reclaimer || reagents.holder_full())
		return PROCESS_KILL

	reagents.add_reagent(dispensedreagent, reclaim_rate * seconds_per_tick)

/obj/structure/sink/kitchen
	name = "厨房水池"
	icon_state = "sink_alt"
	pixel_z = 4

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/kitchen, (-16))

/obj/structure/sink/gasstation
	name = "等离子燃料加注站"
	desc = "为车辆加注液态等离子燃料的地方，也能向容器中灌装。"
	icon_state = "sink_gasstation"
	dispensedreagent = /datum/reagent/toxin/plasma
	has_water_reclaimer = FALSE

/obj/structure/sink/greyscale
	icon_state = "sink_greyscale"
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	buildstacktype = null
	has_water_reclaimer = FALSE

/obj/structure/sink/greyscale/setDir(newdir)
	return ..(REVERSE_DIR(newdir))

/obj/structure/sink/greyscale/filled
	has_water_reclaimer = TRUE

// DARKPACK EDIT ADD START
// Please no more map varedits for this.
/obj/structure/sink/basin
	icon_state = "basin"
	pixel_z = 0
	// pixel_shift = 0

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sink/basin, (0))
// DARKPACK EDIT ADD END

/obj/item/wallframe/sinkframe
	name = "水池框架"
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "sink_frame"
	desc = "水池框架，还需安装水回收器才能完成组装。"
	wall_external = TRUE
	result_path = /obj/structure/sink/greyscale
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	pixel_shift = 16
	throw_range = 1

/obj/item/wallframe/sinkframe/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(istype(held_item, /obj/item/stock_parts/water_recycler) && result_path == /obj/structure/sink/greyscale)
		context[SCREENTIP_CONTEXT_LMB] = "安装水回收器"
		return CONTEXTUAL_SCREENTIP_SET

	return ..()

/obj/item/wallframe/sinkframe/examine(mob/user)
	. = ..()
	if(result_path == /obj/structure/sink/greyscale/filled)
		. += span_notice("已装有[EXAMINE_HINT("水回收器")]。")
	else
		. += span_notice("可以安装[EXAMINE_HINT("水回收器")]。")

/obj/item/wallframe/sinkframe/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(istype(tool, /obj/item/stock_parts/water_recycler) && result_path == /obj/structure/sink/greyscale)
		qdel(tool)
		result_path = /obj/structure/sink/greyscale/filled
		playsound(src, 'sound/machines/click.ogg', 20, TRUE)
		balloon_alert(user, "水回收器已安装！")
		return ITEM_INTERACT_SUCCESS

/obj/item/wallframe/sinkframe/after_attach(obj/structure/sink/greyscale/attached_to)
	attached_to.set_custom_materials(custom_materials)
	attached_to.update_appearance(UPDATE_OVERLAYS)
