// Use /obj/structure/retail/gas_station unless you really only want junkfood
/obj/structure/retail/junkfood_menu
	desc = "购买垃圾食品和其他破烂玩意。"
	products_list = list(
		new /datum/data/vending_product("巧克力棒", /obj/item/food/chocolatebar),
		new /datum/data/vending_product("薯片", /obj/item/food/chips),
		new /datum/data/vending_product("瓶装水", /obj/item/reagent_containers/cup/glass/vampirewater),
		new /datum/data/vending_product("罐装汽水", /obj/item/reagent_containers/cup/soda_cans/vampiresoda),
		new /datum/data/vending_product("两升瓶装可乐", /obj/item/reagent_containers/cup/glass/vampirecola),
		new /datum/data/vending_product("罐装可乐", /obj/item/reagent_containers/cup/soda_cans/vampirecola),
		new /datum/data/vending_product("夏日融冰", /obj/item/reagent_containers/cup/soda_cans/summer_thaw),
		new /datum/data/vending_product("牛奶", /obj/item/reagent_containers/condiment/milk),
		new /datum/data/vending_product("瓶装啤酒", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire),
		new /datum/data/vending_product("蓝条啤酒", /obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe),
		new /datum/data/vending_product("盒装蜡烛", /obj/item/storage/fancy/candle_box),
		new /datum/data/vending_product("创伤敷料", /obj/item/stack/medical/bruise_pack),
		new /datum/data/vending_product("呼吸防护面罩", /obj/item/clothing/mask/gas/vampire)
	)
