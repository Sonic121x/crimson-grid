/obj/item/toy/plush/argemia
	name = "奇怪的毛绒玩偶"
	desc = "遁入虚空……"
	icon_state = "argemia"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/toys/icons/toys_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/plush/argemia/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	. = ..()
	playsound(microwave_source.loc, 'modular_darkpack/modules/toys/sounds/aeaeae.ogg', 100, FALSE)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/toy/plush/argemia, microwave_explode), microwave_source), 5 SECONDS)

/obj/item/toy/plush/argemia/proc/microwave_explode(obj/machinery/microwave/microwave_source)
	explosion(microwave_source.loc, 0, 1, 2)

// Not made by us, but a readditon because TG removed it in https://github.com/tgstation/tgstation/pull/92311
/obj/item/toy/plush/goatplushie
	name = "奇怪的山羊毛绒玩偶"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "goat"
	desc = "虽然外表软萌，浑身毛绒绒，它照样会揍你。山羊本性难移。"
	squeak_override = list('sound/items/weapons/punch1.ogg' = 1)
	/// Whether or not this goat is currently taking in a monsterous doink
	var/going_hard = FALSE
	/// Whether or not this goat has been flattened like a funny pancake
	var/splat = FALSE

/obj/item/toy/plush/goatplushie/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_TURF_INDUSTRIAL_LIFT_ENTER = PROC_REF(splat),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/plush/goatplushie/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	var/obj/item/cigarette/rollie/fat_dart = tool
	if(!istype(fat_dart))
		return ..()
	if(splat)
		to_chat(user, span_notice("[src]现在似乎嗨不起来了。"))
		return ITEM_INTERACT_BLOCKING
	if(going_hard)
		to_chat(user, span_notice("[src]已经嗨过头了！"))
		return ITEM_INTERACT_BLOCKING
	if(!fat_dart.lit)
		to_chat(user, span_notice("你得先把它点燃！"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你把[fat_dart]塞进[src]嘴里。"))
	qdel(fat_dart)
	going_hard = TRUE
	update_icon(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/plush/goatplushie/proc/splat(datum/source)
	SIGNAL_HANDLER
	if(splat)
		return
	if(going_hard)
		going_hard = FALSE
		update_icon(UPDATE_OVERLAYS)
	icon_state = "goat_splat"
	playsound(src, SFX_DESECRATION, 50, TRUE)
	visible_message(span_danger("[src]被彻底压扁了！"))
	splat = TRUE

/obj/item/toy/plush/goatplushie/examine(mob/user)
	. = ..()
	if(splat)
		. += span_notice("[src]可能需要医疗救助。")
	if(going_hard)
		. += span_notice("[src]嗨得正起劲，尽管拍照留念吧。")

/obj/item/toy/plush/goatplushie/update_overlays()
	. = ..()
	if(going_hard)
		. += "goat_dart"


/obj/item/toy/plush/tzi
	name = "悲惨造物"
	desc = "一团骇人的血肉造物，大脑仍能运作。用来操纵复杂的血肉机关再合适不过！"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "plushtzi"
	attack_verb_continuous = list("折磨", "鞭打")
	attack_verb_simple = list("折磨", "鞭打")
	squeak_override = list('modular_darkpack/modules/toys/sounds/femurbreaker.ogg'=1)
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10)
