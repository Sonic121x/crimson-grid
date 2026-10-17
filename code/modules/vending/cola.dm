
/obj/machinery/vending/cola
	name = "\improper 坚实汽水"
	desc = "一台由坚实工业有限责任公司提供的汽水售货机。"
	icon_state = "Cola_Machine"
	panel_type = "panel2"
	product_slogans = "坚实汽水：比砸到头上的工具箱还带劲！"
	product_ads = "清爽！;希望你渴了！;销量突破一百万罐！;口渴？何不来罐可乐？;请喝一杯！;畅饮吧！;太空中最好的饮料。"
	products = list(
		/obj/item/reagent_containers/cup/soda_cans/cola = 10,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind = 10,
		/obj/item/reagent_containers/cup/soda_cans/dr_gibb = 10,
		/obj/item/reagent_containers/cup/soda_cans/starkist = 10,
		/obj/item/reagent_containers/cup/soda_cans/space_up = 10,
		/obj/item/reagent_containers/cup/soda_cans/pwr_game = 10,
		/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 10,
		/obj/item/reagent_containers/cup/soda_cans/sol_dry = 10,
		/obj/item/reagent_containers/cup/glass/waterbottle = 10,
		/obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha = 3,
		/obj/item/reagent_containers/cup/soda_cans/volt_energy = 3,
	)
	contraband = list(
		/obj/item/reagent_containers/cup/soda_cans/thirteenloko = 6,
		/obj/item/reagent_containers/cup/soda_cans/shamblers = 6,
		/obj/item/reagent_containers/cup/soda_cans/wellcheers = 6,
	)
	premium = list(
		/obj/item/reagent_containers/cup/glass/drinkingglass/filled/nuka_cola = 1,
		/obj/item/reagent_containers/cup/soda_cans/air = 1,
		/obj/item/reagent_containers/cup/soda_cans/monkey_energy = 1,
		/obj/item/reagent_containers/cup/soda_cans/grey_bull = 1,
		/obj/item/reagent_containers/cup/glass/bottle/rootbeer = 1,
	)
	refill_canister = /obj/item/vending_refill/cola
	default_price = PAYCHECK_CREW * 0.7
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV

	var/static/list/spiking_booze = list(
		// Your "common" spiking booze
		/datum/reagent/consumable/ethanol/vodka = 5,
		/datum/reagent/consumable/ethanol/beer = 5,
		/datum/reagent/consumable/ethanol/whiskey = 5,
		/datum/reagent/consumable/ethanol/gin = 5,
		/datum/reagent/consumable/ethanol/rum = 5,
		// A bit rarer, can be dangerous if you take too much
		/datum/reagent/consumable/ethanol/thirteenloko = 3,
		/datum/reagent/consumable/ethanol/absinthe = 3,
		/datum/reagent/consumable/ethanol/hooch = 3,
		/datum/reagent/consumable/ethanol/moonshine = 3,
		// Gets funky here
		/datum/reagent/consumable/ethanol/beepsky_smash = 1,
		/datum/reagent/consumable/ethanol/gargle_blaster = 1,
		/datum/reagent/consumable/ethanol/neurotoxin = 1,
		)

/obj/machinery/vending/cola/Initialize(mapload)
	. = ..()
	if(!mapload || !is_station_level(z) || !HAS_TRAIT(SSstation, STATION_TRAIT_VENDING_SHORTAGE))
		return

	for(var/datum/data/vending_product/product_record as anything in product_records + coin_records + hidden_records)
		product_record.amount = 0
		credits_contained += rand(1, 5)

/obj/machinery/vending/cola/on_dispense(obj/item/vended_item, dispense_returned = FALSE)
	// Only apply to newly dispensed items
	if(dispense_returned)
		return
	// 35% chance that your drink will be safe, as safe pure acid and sugar that these drinks probably are can be
	if(!onstation || !HAS_TRAIT(SSstation, STATION_TRAIT_SPIKED_DRINKS) || !prob(65))
		return
	// Don't fill booze with more booze
	if (isnull(vended_item.reagents) || vended_item.reagents.has_reagent(/datum/reagent/consumable/ethanol, check_subtypes = TRUE))
		return
	var/removed_volume = vended_item.reagents.remove_all(rand(5, vended_item.reagents.maximum_volume * 0.5))
	if (!removed_volume)
		return
	// Don't want bubbling sodas when we add some rum to cola
	ADD_TRAIT(vended_item, TRAIT_SILENT_REACTIONS, VENDING_MACHINE_TRAIT)
	vended_item.reagents.add_reagent(pick_weight(spiking_booze), removed_volume)
	vended_item.reagents.handle_reactions()
	REMOVE_TRAIT(vended_item, TRAIT_SILENT_REACTIONS, VENDING_MACHINE_TRAIT)

/obj/item/vending_refill/cola
	machine_name = "坚实汽水"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/blue
	icon_state = "Cola_Machine"
	light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE
	allow_custom = FALSE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_mask = "cola-light-mask"
	allow_custom = FALSE

/obj/machinery/vending/cola/red
	icon_state = "red_cola"
	name = "\improper Space Cola Vendor"
	desc = "It vends cola, in space."
	product_slogans = "Cola in space!"
	light_mask = "red_cola-light-mask"
	light_color = COLOR_DARK_RED
	allow_custom = FALSE

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	name = "\improper Space-up! Vendor"
	desc = "Indulge in an explosion of flavor."
	product_slogans = "Space-up! Like a hull breach in your mouth."
	light_mask = "space_up-light-mask"
	light_color = COLOR_DARK_MODERATE_LIME_GREEN
	allow_custom = FALSE

/obj/machinery/vending/cola/starkist
	icon_state = "starkist"
	name = "\improper 星吻售货机"
	desc = "液态星辰的滋味。"
	product_slogans = "畅饮星辰！星吻！"
	panel_type = "panel7"
	light_mask = "starkist-light-mask"
	light_color = COLOR_LIGHT_ORANGE
	allow_custom = FALSE

/obj/machinery/vending/cola/sodie
	icon_state = "soda"
	panel_type = "panel7"
	light_mask = "soda-light-mask"
	light_color = COLOR_WHITE
	allow_custom = FALSE

/obj/machinery/vending/cola/pwr_game
	icon_state = "pwr_game"
	name = "\improper 劲玩售货机"
	desc = "你想要的，我们都有。与弗拉德沙拉联合呈献。"
	product_slogans = "玩家渴望的力量！劲玩！"
	light_mask = "pwr_game-light-mask"
	light_color = COLOR_STRONG_VIOLET
	allow_custom = FALSE

/obj/machinery/vending/cola/shamblers
	name = "\improper 蹒跚者售货机"
	desc = "～给我摇一杯蹒跚者果汁！～"
	icon_state = "shamblers_juice"
	products = list(
		/obj/item/reagent_containers/cup/soda_cans/cola = 10,
		/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind = 10,
		/obj/item/reagent_containers/cup/soda_cans/dr_gibb = 10,
		/obj/item/reagent_containers/cup/soda_cans/starkist = 10,
		/obj/item/reagent_containers/cup/soda_cans/space_up = 10,
		/obj/item/reagent_containers/cup/soda_cans/pwr_game = 10,
		/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 10,
		/obj/item/reagent_containers/cup/soda_cans/sol_dry = 10,
		/obj/item/reagent_containers/cup/soda_cans/shamblers = 10,
		/obj/item/reagent_containers/cup/soda_cans/wellcheers = 5,
		)
	product_slogans = "～给我摇一杯蹒跚者果汁！～"
	product_ads = "清爽！;渴求DNA？满足你的欲望！;畅饮灵魂已逾一万亿！;含有真正的DNA！;蜂巢意识需要你的渴望！;畅饮吧！;吸收你的口渴。"
	light_mask = "shamblers-light-mask"
	refill_canister = /obj/item/vending_refill/cola/shamblers
	light_color = COLOR_MOSTLY_PURE_PINK


/obj/item/vending_refill/cola/shamblers
	machine_name = "蹒跚者售货机"
	icon_state = "refill_shamblers"

/obj/machinery/vending/cola/shamblers/Initialize(mapload)
	. = ..()
	set_active_language(get_random_spoken_language())

/obj/machinery/vending/cola/shamblers/speak(message)
	. = ..()
	set_active_language(get_random_spoken_language())
