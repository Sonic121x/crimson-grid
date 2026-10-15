///how much projectile damage is lost when using a bad fuel
#define BAD_FUEL_DAMAGE_TAX 20
///extra chance it explodes upon firing
#define BAD_FUEL_EXPLODE_PROBABILTY 10

/obj/structure/cannon
	name = "火炮"
	desc = "豪华开洞者：一款威力不俗的运动型火炮。每位火炮爱好者都该从它入门。"
	density = TRUE
	anchored = TRUE
	icon = 'icons/obj/weapons/cannons.dmi'
	icon_state = "falconet_patina"
	max_integrity = 300
	///whether the cannon can be unwrenched from the ground.
	var/anchorable_cannon = TRUE
	var/obj/item/stack/cannonball/loaded_cannonball = null
	var/charge_ignited = FALSE
	var/fire_delay = 1.5 SECONDS
	var/charge_size = 15
	var/fire_sound = 'sound/items/weapons/gun/general/cannon.ogg'

/obj/structure/cannon/Initialize(mapload)
	. = ..()
	create_reagents(charge_size)
	AddElement(/datum/element/simple_rotation)

/obj/structure/cannon/examine(mob/user)
	. = ..()
	. += span_notice("[src]可使用火药或焊接燃料。")
	. += span_warning("使用焊接燃料会降低炮弹的威力。")

/obj/structure/cannon/proc/fire()
	for(var/mob/shaken_mob in urange(10, src))
		if(!IS_UNCONSCIOUS_OR_CRIT(shaken_mob))
			shake_camera(shaken_mob, 3, 1)

		playsound(src, fire_sound, 50, TRUE)
		flick(icon_state+"_fire", src)
	if(loaded_cannonball)
		var/obj/projectile/fired_projectile = new loaded_cannonball.projectile_type(get_turf(src))
		if(reagents.has_reagent(/datum/reagent/fuel, charge_size))
			fired_projectile.damage = max(2, fired_projectile.damage - BAD_FUEL_DAMAGE_TAX)
		QDEL_NULL(loaded_cannonball)
		fired_projectile.firer = src
		fired_projectile.fired_from = src
		fired_projectile.fire(dir2angle(dir))
	reagents.remove_all()
	charge_ignited = FALSE

/obj/structure/cannon/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!anchorable_cannon)
		return FALSE
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/structure/cannon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(charge_ignited)
		balloon_alert(user, "马上要开炮了！")
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, /obj/item/stack/cannonball))
		if(loaded_cannonball)
			balloon_alert(user, "已经装填了！")
			return ITEM_INTERACT_BLOCKING

		var/obj/item/stack/cannonball/cannoneers_balls = tool
		loaded_cannonball = new cannoneers_balls.type(src, 1)
		loaded_cannonball.copy_evidences(cannoneers_balls)
		balloon_alert(user, "已装入一枚[cannoneers_balls.singular_name]")
		cannoneers_balls.use(1, transfer = TRUE)
		return ITEM_INTERACT_SUCCESS

	var/ignition_message = tool.ignition_effect(src, user)

	if(ignition_message)
		if(!reagents.has_reagent(/datum/reagent/gunpowder,charge_size) && !reagents.has_reagent(/datum/reagent/fuel,charge_size))
			balloon_alert(user, "需要[reagents.maximum_volume]单位的发射装药！")
			return ITEM_INTERACT_BLOCKING

		visible_message(ignition_message)
		user.log_message("fired a cannon", LOG_ATTACK)
		log_game("[key_name(user)] fired a cannon in [AREACOORD(src)]")
		addtimer(CALLBACK(src, PROC_REF(fire)), fire_delay)
		charge_ignited = TRUE
		return ITEM_INTERACT_SUCCESS

	if(is_reagent_container(tool))
		var/obj/item/reagent_containers/powder_keg = tool
		if(!powder_keg.is_open_container())
			return NONE // reagent containers transfer elsewhere in the chain, be free

		if(istype(powder_keg, /obj/item/rag))
			return NONE

		if(!powder_keg.reagents.total_volume)
			balloon_alert(user, "[powder_keg]是空的！")
			return ITEM_INTERACT_BLOCKING

		if(reagents.total_volume == reagents.maximum_volume)
			balloon_alert(user, "[src]已装满！")
			return ITEM_INTERACT_BLOCKING

		var/has_enough_gunpowder = powder_keg.reagents.has_reagent(/datum/reagent/gunpowder, charge_size)
		var/has_enough_alt_fuel = powder_keg.reagents.has_reagent(/datum/reagent/fuel, charge_size)
		if(!has_enough_gunpowder && !has_enough_alt_fuel)
			balloon_alert(user, "[powder_keg]需要15单位的发射装药才能装填！")
			to_chat(user, span_warning("[powder_keg]中的火药不足15单位，无法装填[src]！"))
			return ITEM_INTERACT_BLOCKING

		if(has_enough_gunpowder)
			powder_keg.reagents.trans_to(src, charge_size, target_id = /datum/reagent/gunpowder)
			balloon_alert(user, "[src]已装入火药")
			return ITEM_INTERACT_SUCCESS

		//if(has_enough_alt_fuel) but we already know it does if we're here
		powder_keg.reagents.trans_to(src, charge_size, target_id = /datum/reagent/fuel)
		balloon_alert(user, "[src]已装入焊接燃料")
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/structure/cannon/trash
	name = "垃圾炮"
	desc = "好吧，你可以说这不过是个焊在开口氧气罐上、再用电线绑到滑板上的工具箱，但在我们眼里，它就是垃圾炮！"
	icon_state = "garbagegun"
	anchored = FALSE
	anchorable_cannon = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11.65, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.5)
	var/fires_before_deconstruction = 5

/obj/structure/cannon/trash/fire()
	var/explode_chance = 10
	var/used_alt_fuel = reagents.has_reagent(/datum/reagent/fuel, charge_size)
	if(used_alt_fuel)
		explode_chance += BAD_FUEL_EXPLODE_PROBABILTY
	. = ..()
	fires_before_deconstruction--
	if(used_alt_fuel)
		fires_before_deconstruction--
	if(prob(explode_chance))
		visible_message(span_userdanger("[src]爆炸了！"))
		explosion(src, heavy_impact_range = 1, light_impact_range = 5, flame_range = 5)
		return
	if(fires_before_deconstruction <= 0)
		visible_message(span_warning("[src]因开火而散架了！"))
		qdel(src)

/obj/structure/cannon/trash/Destroy()
	new /obj/item/stack/sheet/iron/five(src.loc)
	new /obj/item/stack/rods(src.loc)
	. = ..()

///A cannon found from the fishing mystery box.
/obj/structure/cannon/mystery_box
	icon_state = "mystery_box_cannon" //east facing sprite for the presented item, it'll be changed back to normal on init
	dir = EAST
	anchored = FALSE

/obj/structure/cannon/mystery_box/Initialize(mapload)
	. = ..()
	icon_state = "falconet_patina"
	reagents.add_reagent(/datum/reagent/gunpowder, charge_size)
	loaded_cannonball = new(src)

#undef BAD_FUEL_DAMAGE_TAX
#undef BAD_FUEL_EXPLODE_PROBABILTY
