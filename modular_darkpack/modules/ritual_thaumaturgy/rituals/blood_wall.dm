/obj/ritual_rune/thaumaturgy/blood_wall
	name = "鲜血之墙"
	desc = "创造一道鲜血之墙，保护睿魔尔或其领地。"
	icon_state = "rune3"
	word = "SOT'PY-O"
	level = 2

/obj/ritual_rune/thaumaturgy/blood_wall/complete()
	. = ..()
	new /obj/structure/bloodwall(loc)
	qdel(src)

/obj/structure/bloodwall
	name = "鲜血之墙"
	desc = "由鲜血构成的墙。"
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "bloodwall"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	max_integrity = 100
