/obj/machinery/vending/cola
	icon_state = "cola_red"
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	light_mask = "cola-light-mask"
	products = list(
		/obj/item/reagent_containers/cup/soda_cans/vampirecola = 20,
		/obj/item/reagent_containers/cup/soda_cans/vampirecola/blue = 10,
		/obj/item/reagent_containers/cup/glass/waterbottle = 10, // TODO: Resprite
	)
	contraband = list()
	premium = list()

/obj/machinery/vending/cola/blue
	icon_state = "cola_blue"
	light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_mask = "cola-light-mask"

/obj/machinery/vending/cola/red
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

/obj/machinery/vending/cola/space_up
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

// Bloodlines Refrence
/obj/machinery/vending/cola/starkist
	name = "\improper 13维生素售货机"
	desc = "每瓶含有13种兴奋剂！！！"
	icon_state = "thirteen"
	light_mask = "front_cola-light-mask"
	light_color = COLOR_YELLOW
	products = list(
		/obj/item/reagent_containers/cup/soda_cans/thirteenloko = 30, // TODO: Resprite
	)
	premium = list(
		/obj/item/reagent_containers/cup/soda_cans/monkey_energy = 10, // TODO: Resprite
		/obj/item/reagent_containers/cup/soda_cans/grey_bull = 5, // TODO: Resprite
	)

/obj/machinery/vending/cola/sodie
	icon_state = "cola_red"
	light_mask = "cola-light-mask"
	light_color = COLOR_DARK_RED

// Bloodlines Refrence
/obj/machinery/vending/cola/pwr_game
	name = "\improper 液态魔种售货机"
	desc = "大口灌下去！！"
	icon_state = "demon_seed"
	light_mask = "front_cola-light-mask"

/obj/machinery/vending/cola/shamblers
	name = "\improper 美味公司售货机"
	icon_state = "yumco"
	light_mask = "yumco-light-mask"
	light_color = COLOR_YELLOW
