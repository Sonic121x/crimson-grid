// Use /obj/structure/retail/gas_station unless you really only want smokes
/obj/structure/retail/smoke_menu
	products_list = list(
		new /datum/data/vending_product("马尔博罗", /obj/item/storage/fancy/cigarettes/cigpack_robust, 50),
		new /datum/data/vending_product("金装马尔博罗", /obj/item/storage/fancy/cigarettes/cigpack_robustgold),
		new /datum/data/vending_product("新港", /obj/item/storage/fancy/cigarettes/cigpack_xeno, 30),
		new /datum/data/vending_product("骆驼", /obj/item/storage/fancy/cigarettes/dromedaryco, 30),
		new /datum/data/vending_product("高级雪茄盒", /obj/item/storage/fancy/cigarettes/cigars),
		new /datum/data/vending_product("高希霸罗布图高级雪茄盒", /obj/item/storage/fancy/cigarettes/cigars/cohiba),
		new /datum/data/vending_product("高级哈瓦那雪茄盒", /obj/item/storage/fancy/cigarettes/cigars/havana),
		new /datum/data/vending_product("卷烟纸", /obj/item/rollingpaper, 10),
		// CRIMSON EDIT ADD START - vapes!! why cant i buy vapes from the smoke store?!!
		new /datum/data/vending_product("电子烟", /obj/item/vape, 150),
		new /datum/data/vending_product("红色电子烟", /obj/item/vape/red, 170), // special colors are gonna cost ya more
		new /datum/data/vending_product("蓝色电子烟", /obj/item/vape/blue, 170),
		new /datum/data/vending_product("紫色电子烟", /obj/item/vape/purple, 170),
		new /datum/data/vending_product("绿色电子烟", /obj/item/vape/green, 170),
		new /datum/data/vending_product("黄色电子烟", /obj/item/vape/yellow, 170),
		new /datum/data/vending_product("橙色电子烟", /obj/item/vape/orange, 170), // Ja- ORANGE!
		new /datum/data/vending_product("黑色电子烟", /obj/item/vape/black, 170),
		new /datum/data/vending_product("白色电子烟", /obj/item/vape/white, 170),
		// CRIMSON EDIT ADD END
		new /datum/data/vending_product("\"花瓶\"", /obj/item/bong, 50),
		new /datum/data/vending_product("芝宝打火机", /obj/item/lighter, 20),
		new /datum/data/vending_product("打火机", /obj/item/lighter/greyscale, 10),
		new /datum/data/vending_product("火柴盒",/obj/item/storage/box/matches),
		new /datum/data/vending_product("烟灰缸",/obj/item/storage/ashtray),
	)
