/obj/machinery/vending/coffee
	name = "\improper 太阳系精选热饮"
	desc = "一台供应热饮的自动售货机。"
	product_ads = "来一杯吧！;喝吧！;有益健康！;想来杯热咖啡吗？;为了喝上咖啡，我什么都干得出来！;银河系最好的咖啡豆。;只为你献上最好的佳酿。;嗯，咖啡就是无可替代。;我喜欢咖啡，你呢？;咖啡助你工作！;尝尝茶吧。;愿您钟爱我们的上品！;尝尝我们的新款巧克力！;管理员的阴谋"
	// DARKPACK EDIT CHANGE START
	icon = 'modular_darkpack/modules/retail/icons/vendors_shops.dmi'
	icon_state = "coffee"
	icon_vend = null
	panel_type = null
	// DARKPACK EDIT CHANGE END
	products = list(
		/obj/item/reagent_containers/cup/glass/coffee/vampire = 10, // DARKPACK EDIT CHANGE
		/obj/item/reagent_containers/cup/glass/coffee/vampire/robust = 5, // DARKPACK EDIT CHANGE
		/obj/item/reagent_containers/cup/glass/mug/tea = 6,
		/obj/item/reagent_containers/cup/glass/mug/coco = 3,
	)
	contraband = list(
		/obj/item/reagent_containers/cup/glass/ice = 12,
	)
	refill_canister = /obj/item/vending_refill/coffee
	default_price = PAYCHECK_LOWER
	extra_price = PAYCHECK_CREW
	payment_department = ACCOUNT_SRV
	//light_mask = "coffee-light-mask" // DARKPACK EDIT REMOVAL
	//light_color = COLOR_DARK_MODERATE_ORANGE // DARKPACK EDIT REMOVAL

// DARKPACK EDIT ADD START
/obj/machinery/vending/coffee/private
	desc = "一台员工专用售货机。我就爱把咖啡灌进嘴里。"
	req_access = null
	onstation = FALSE
	all_products_free = TRUE
// DARKPACK EDIT ADD END

/obj/machinery/vending/coffee/Initialize(mapload)
	. = ..()
	if(!mapload || !is_station_level(z) || !HAS_TRAIT(SSstation, STATION_TRAIT_VENDING_SHORTAGE))
		return

	for(var/datum/data/vending_product/product_record as anything in product_records + coin_records + hidden_records)
		product_record.amount = 0
		credits_contained += rand(1, 5)

/obj/item/vending_refill/coffee
	machine_name = "太阳系精选热饮"
	icon_state = "refill_joe"
