/obj/structure/retail/camping
	desc = "出售露营用品的商店，不含烤棉花糖夹心饼。"
	products_list = list(
		new /datum/data/vending_product("相机胶卷", /obj/item/camera_film),
		new /datum/data/vending_product("猎刀", /obj/item/knife/vamp),
		new /datum/data/vending_product("帐篷桩", /obj/item/vampire_stake),
		new /datum/data/vending_product("铲子", /obj/item/shovel/vamp),
		new /datum/data/vending_product("7.62x51猎枪弹匣",/obj/item/ammo_box/magazine/darkpack556/hunt), // Crimson Grid Edit - Magazine was originally 5.56
		new /datum/data/vending_product("手电筒", /obj/item/flashlight), // CRIMSON EDIT ADD - Shop Inventories Additions
		new /datum/data/vending_product("煤", /obj/item/stack/sheet/mineral/coal, 10), // CRIMSON EDIT ADD - Shop Inventories Additions
		new /datum/data/vending_product("辣椒喷雾", /obj/item/reagent_containers/spray/pepper),
		new /datum/data/vending_product("蛇科手持电击器", /obj/item/melee/baton/security/handtaser),
		new /datum/data/vending_product("伯莱塔弹匣", /obj/item/ammo_box/magazine/semi9mm),
		new /datum/data/vending_product("双筒望远镜", /obj/item/binoculars),
		new /datum/data/vending_product("相机", /obj/item/camera),
		new /datum/data/vending_product("9毫米弹药盒", /obj/item/ammo_box/darkpack/c9mm),
		new /datum/data/vending_product("12号鹿弹",/obj/item/ammo_box/darkpack/c12g/buck),
		new /datum/data/vending_product("砍刀", /obj/item/claymore/machete),
		new /datum/data/vending_product("狩猎霰弹枪", /obj/item/gun/ballistic/shotgun/vampire),
		new	/datum/data/vending_product("精英92G", /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta),
		new /datum/data/vending_product("救援消防斧", /obj/item/fireaxe/vamp),
		new /datum/data/vending_product("链锯", /obj/item/chainsaw/vamp),
		new /datum/data/vending_product("狩猎步枪", /obj/item/gun/ballistic/automatic/darkpack/huntrifle),
		new /datum/data/vending_product("7.52x51弹药", /obj/item/ammo_box/darkpack/c762x51mm, 1000), // Crimson Grid Replacement - Was 5.56 Ammo Box
		new /datum/data/vending_product("军用派克大衣", /obj/item/clothing/suit/vampire/coat/milparka,	90),
	)
	product_types = list(
		/obj/item/fishing_rod,
		/obj/item/bait_can/worm,
		/obj/item/bait_can/super_baits,
		/obj/item/storage/toolbox/fishing,
		/obj/item/storage/box/fishing_lures,
		/obj/item/fishing_line/auto_reel
	)
