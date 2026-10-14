/obj/ritual_rune/thaumaturgy/blood_to_water
	name = "化血为水"
	desc = "将范围内的所有鲜血净化为水。"
	icon_state = "rune8"
	word = "CL-ENE"

/obj/ritual_rune/thaumaturgy/blood_to_water/complete()
	. = ..()
	for(var/atom/A in range(7, src))
		A.wash(CLEAN_WASH)
	qdel(src)
