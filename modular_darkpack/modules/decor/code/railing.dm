/obj/structure/railing/darkpack
	icon_state = null
	icon = 'modular_darkpack/modules/decor/icons/railings.dmi'
	abstract_type = /obj/structure/railing/darkpack

/obj/structure/railing/darkpack/metal
	name = "护栏"
	desc = "用途广泛的坚固护栏，包括但不限于：确保你不会从四层楼高的屋顶上飞出去。"
	icon_state = "civ_full"

/obj/structure/railing/darkpack/metal/solo
	icon_state = "civ_solo"

/obj/structure/railing/darkpack/metal/industrial
	desc = "用途广泛的坚固护栏，包括但不限于：确保你不会从四层楼高的屋顶上飞出去。涂着亮眼的橙色，一看就符合工作场所的规章。"
	icon_state = "indus_full"

/obj/structure/railing/darkpack/metal/industrial/solo
	icon_state = "indus_solo"

/obj/structure/railing/darkpack/sewer
	name = "guard rail"
	desc = "A rusty guard rail used to prevent you from falling into the region's sewage. Thank the lord it's there."
	icon_state = "railings_sewer"

/obj/structure/railing/darkpack/wood
	name = "木栅栏"
	desc = "经典的木栅栏。没有比这更有家的感觉了。"
	icon_state = "wood_full"
	base_icon_state = "wood_full"
	item_deconstruct = /obj/item/stack/sheet/mineral/wood
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/railing/darkpack/wood/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[base_icon_state]_snow"

/obj/structure/railing/darkpack/wood/ending
	icon_state = "wood_end"
	base_icon_state = "wood_end"

/obj/structure/railing/darkpack/wood/single
	icon_state = "wood_solo"
	base_icon_state = "wood_solo"

/obj/structure/railing/darkpack/wood/snow
	icon_state = "wood_snow_full"

/obj/structure/railing/darkpack/wood/snow/ending
	icon_state = "wood_snow_end"

/obj/structure/railing/darkpack/wood/snow/single
	icon_state = "wood_snow_solo"
