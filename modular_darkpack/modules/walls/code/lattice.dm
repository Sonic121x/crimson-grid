/obj/structure/lattice/grate
	icon = 'modular_darkpack/modules/walls/icons/floors.dmi'
	icon_state = "lattice_grate"
	base_icon_state = "lattice_grate"

	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/lattice/pentex
	desc = "采用先进材料制成，看起来相当结实。"
	icon = 'icons/obj/smooth_structures/darkpack/catwalk_pentex_opaque.dmi'

/obj/structure/lattice/catwalk/borderless
	icon = 'icons/obj/smooth_structures/darkpack/catwalk_borderless.dmi'

/obj/structure/lattice/catwalk/borderless/smooth_walls
	canSmoothWith = SMOOTH_GROUP_CATWALK + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CITY_WALL
