/obj/structure/food_cart
	name = "餐车"
	desc = "叮铃叮咚，来领你的胆固醇！"
	icon = 'modular_darkpack/modules/food/icons/food_cart.dmi'
	icon_state = "vat1"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER

/obj/structure/food_cart/Initialize(mapload)
	. = ..()
	icon_state = "vat[rand(1, 3)]"

/obj/machinery/reagentgrinder/kitchen
	name = "厨房搅拌机"
	//beaker_type = /obj/item/reagent_containers/glass/mixing_bowl
