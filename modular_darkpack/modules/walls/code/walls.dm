/obj/structure/window/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'modular_darkpack/modules/deprecated/icons/obj/smooth_structures/reinforced_window.dmi'

/obj/effect/wall_frill
	name = "wall frill"
	desc = "Hey how are you reading this."
	icon = 'modular_darkpack/modules/walls/icons/wallfrills.dmi'
	base_icon_state = "wall"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/effect/wall_frill/Initialize(mapload)
	. = ..()
	if(isnull(loc))
		. = INITIALIZE_HINT_QDEL
		CRASH("[type] created in nullspace, this should not happen!")
	// Turfs don't really move, so we set the reset timer to an abstractly high number so we can enable and disable seethrough at will
	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_WALLS, perimeter_reset_timer = 24 HOURS)
	update_seethrough()

/* If we want to have transpanecy for ALL mobs instead of just you.
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(update_alpha),
		COMSIG_ATOM_EXITED = PROC_REF(update_alpha),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/wall_frill/proc/update_alpha()
	if(locate(/mob/living) in get_turf(src))
		alpha = 128
	else
		alpha = 255
*/

/obj/effect/wall_frill/proc/update_seethrough()
	var/turf/our_turf = get_turf(src)
	var/datum/component/seethrough/comp = GetComponent(/datum/component/seethrough)
	if(our_turf.density)
		comp.dismantle_perimeter()
		return

	// This is done on init by default, we dont need to override it a ton of times
	if(!length(comp.watched_turfs))
		comp.setup_perimeter(src)

/turf/closed/wall/vampwall
	name = "旧砖墙"
	desc = "一面用旧砖砌成的厚实墙壁，用于分隔房间。"
	icon = 'modular_darkpack/modules/walls/icons/walls.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	abstract_type = /turf/closed/wall/vampwall
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CITY_WALL
	canSmoothWith = SMOOTH_GROUP_CITY_WALL

	baseturfs = /turf/open/floor/plating/concrete

	var/obj/effect/wall_frill/wall_frill
	var/frill_icon = /obj/effect/wall_frill::icon

/turf/closed/wall/vampwall/attackby(obj/item/W, mob/user, params)
	return

/turf/closed/wall/vampwall/attack_hand(mob/user)
	return

// CRIMSON EDIT ADD START - Welders no longer deconstruct city walls
/turf/closed/wall/vampwall/try_decon(obj/item/I, mob/user)
	if(I.tool_behaviour == TOOL_WELDER)
		to_chat(user, span_warning("墙壁太坚固，无法切开。"))
	return FALSE
// CRIMSON EDIT ADD END - Welders no longer deconstruct city walls

/turf/closed/wall/vampwall/mouse_drop_receive(atom/dropped, mob/user, params)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!living_user.combat_mode)
		//Adds the component only once. We do it here & not in Initialize() because there are tons of walls & we don't want to add to their init times
		LoadComponent(/datum/component/leanable, dropped)
	else
		if(get_dist(user, src) < 2)
			var/turf/user_turf = get_turf(user)
			var/turf/above_turf = GET_TURF_ABOVE(user_turf)
			if(living_user.can_z_move(UP, user_turf, above_turf, ZMOVE_STAIRS_FLAGS, user))
				climb_wall(user, above_turf)
			else
				to_chat(user, span_warning("你无法爬到那里！"))

/turf/closed/wall/vampwall/proc/climb_wall(mob/living/user, turf/above_turf)
	if(user.body_position != STANDING_UP)
		return
	if(above_turf && istype(above_turf, /turf/open/openspace))
		to_chat(user, span_notice("你开始向上攀爬……"))
		add_fingerprint(user)

		var/result = do_after(user, 1 TURNS, src)
		if(!result || HAS_TRAIT(user, LEANING_TRAIT))
			to_chat(user, span_notice("你的攀爬被打断了，没能爬上去。"))
			return

		//(Botch, slip and take damage), (Fail, fail to climb), (Success, climb up successfully)

		var/datum/storyteller_roll/climbing/climb_roll = new()
		var/roll = climb_roll.st_roll(user, src)
		switch(roll)
			if(ROLL_BOTCH)
				user.ZImpactDamage(loc, 1)
				to_chat(user, span_warning("你在攀爬时滑落了！"))
				return
			if(ROLL_FAILURE)
				to_chat(user, span_warning("你没能爬上去。"))
				return
			else
				user.zMove(UP, above_turf)
				var/turf/forward_turf = get_step(user.loc, user.dir)
				if(forward_turf && !forward_turf.density)
					user.forceMove(forward_turf)
					to_chat(user, span_notice("你成功爬了上去。"))

/turf/closed/wall/vampwall/ex_act(severity, target)
	return

#define CULL_JUNCTIONS (NORTH_JUNCTION|EAST_JUNCTION|WEST_JUNCTION|NORTHWEST_JUNCTION|NORTHEAST_JUNCTION)
/turf/closed/wall/vampwall/set_smoothed_icon_state(new_junction)
	. = ..()

	// Our wall is not generally visible.
	if((new_junction & CULL_JUNCTIONS) == CULL_JUNCTIONS)
		if(wall_frill)
			QDEL_NULL(wall_frill)
		return

	if(!wall_frill)
		var/turf/north = get_step(src, NORTH)
		if(isnull(north)) // edge of the map
			return
		wall_frill = new(north)
		wall_frill.icon = frill_icon
		wall_frill.name = name
		wall_frill.desc = desc

	wall_frill.icon_state = icon_state
	// This will cover most cases with updating seethrough, except for cases where all the northern walls don't smooth with this turf, and all change from dense to non-dense
	wall_frill.update_seethrough()

#undef CULL_JUNCTIONS

/turf/closed/wall/vampwall/Destroy()
	. = ..()
	if(wall_frill)
		QDEL_NULL(wall_frill)

/turf/closed/wall/vampwall/rich
	name = "华丽的墙壁"
	desc = "一面用昂贵砖块砌成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rich/frill.dmi'

/turf/closed/wall/vampwall/rich/old
	name = "陈旧的华丽墙壁"
	desc = "一面用旧砖砌成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/rich_old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rich_old/frill.dmi'

/turf/closed/wall/vampwall/brick_old
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick_old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/brick_old/frill.dmi'

/turf/closed/wall/vampwall/junk
	name = "破旧砖墙"
	desc = "一面用脏砖砌成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/junk/frill.dmi'

/turf/closed/wall/vampwall/junk/alt
	icon = 'icons/obj/smooth_structures/darkpack/wall/junk_alt/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/junk_alt/frill.dmi'

/turf/closed/wall/vampwall/market
	name = "混凝土墙"
	desc = "一面厚实的混凝土墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/market/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/market/frill.dmi'

/turf/closed/wall/vampwall/old
	name = "旧砖墙"
	desc = "一面用旧砖砌成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/old/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/old/frill.dmi'

/turf/closed/wall/vampwall/painted
	name = "涂漆砖墙"
	desc = "一面涂过漆的厚实砖墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/painted/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/painted/frill.dmi'

/turf/closed/wall/vampwall/brick
	name = "砖墙"
	desc = "一面厚实的砖墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/brick/frill.dmi'

/turf/closed/wall/vampwall/redbrick
	name = "红砖墙"
	desc = "一面用红砖砌成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/red_brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/red_brick/frill.dmi'

/turf/closed/wall/vampwall/city
	name = "墙壁"
	desc = "一面用混凝土和砖块筑成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/city/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/city/frill.dmi'

/turf/closed/wall/vampwall/metal
	name = "金属墙"
	desc = "一面厚实的金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal/frill.dmi'

/turf/closed/wall/vampwall/metal/reinforced
	name = "加固金属墙"
	desc = "一面厚实的加固金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_reinforced/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_reinforced/frill.dmi'

/turf/closed/wall/vampwall/metal/alt
	name = "金属墙"
	desc = "一面厚实的金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_alt/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_alt/frill.dmi'

/turf/closed/wall/vampwall/metal/glass
	name = "金属墙"
	desc = "一面厚实的金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/metal_glass/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/metal_glass/frill.dmi'
	opacity = FALSE

/turf/closed/wall/vampwall/bar
	name = "深色砖墙"
	desc = "一面厚实的砖墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/bar/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/bar/frill.dmi'

/turf/closed/wall/vampwall/wood
	name = "木墙"
	desc = "一面用脏木料筑成的厚实墙壁，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/wood/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/wood/frill.dmi'

/turf/closed/wall/vampwall/rust
	name = "锈蚀的墙壁"
	desc = "一面厚实的锈蚀金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/rust/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rust/frill.dmi'

/turf/closed/wall/vampwall/dirtywood
	name = "脏木墙"
	desc = "一面厚实的棕色金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/wood_dirty/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/wood_dirty/frill.dmi'

/turf/closed/wall/vampwall/green
	name = "绿色墙壁"
	desc = "一面厚实的绿色金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/green/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/green/frill.dmi'

/turf/closed/wall/vampwall/rustbad
	name = "锈蚀的墙壁"
	desc = "一面厚实的锈蚀金属墙，用于分隔房间。"
	icon = 'icons/obj/smooth_structures/darkpack/wall/rustbad/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rustbad/frill.dmi'

/turf/closed/wall/vampwall/rock
	name = "岩壁"
	desc = "一大片岩石构成的屏障，将整片区域隔开。"
	//icon = 'icons/obj/smooth_structures/darkpack/wall/rock/wall.dmi'
	icon = 'modular_darkpack/modules/walls/icons/rock_wall.dmi' // Unfortuante case where its autocutting is a bit lacking so I manually edit it.
	frill_icon = 'icons/obj/smooth_structures/darkpack/wall/rock/frill.dmi'

/*
/turf/closed/wall/vampwall/rock/brown
	icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown/frill.dmi'

/turf/closed/wall/vampwall/rock/brown/full
	icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown_full/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/rock_brown_full/frill.dmi'

/turf/closed/wall/vampwall/mojave/brick
	icon = 'icons/obj/smooth_structures/darkpack/mojave/brick/wall.dmi'
	frill_icon = 'icons/obj/smooth_structures/darkpack/mojave/brick/frill.dmi'
*/
