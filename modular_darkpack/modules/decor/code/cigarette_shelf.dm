/obj/machinery/vending/cigarette/shelf
	name = "香烟货架"
	desc = "各种款式应有尽有，唯独没有你真正喜欢的那种。"
	icon = 'modular_darkpack/modules/decor/icons/cigarette_shelf.dmi' // TODO: add behavior for swapping to the empty icon
	icon_state = "ciggies1"
	base_icon_state = "ciggies"
	tiltable = FALSE
	panel_type = "panel22"
	light_mask = "ciggies-light-mask"
	light_color = COLOR_WHITE

/obj/machinery/vending/cigarette/shelf/Initialize(mapload)
	. = ..()
	if(icon_state == src::icon_state)
		icon_state = "[base_icon_state][rand(1,3)]"
