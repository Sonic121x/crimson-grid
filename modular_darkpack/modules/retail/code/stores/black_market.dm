// DARKPACK TODO: you should not be able to use credit here. -Fallcon
/obj/structure/retail/black_market
	products_list = list(
		new /datum/data/vending_product("打火机", /obj/item/lighter/greyscale, 10),
		new /datum/data/vending_product("卷烟纸", /obj/item/rollingpaper, 10), // CRIMSON EDIT ADD - Shop Inventories Additions
		new /datum/data/vending_product("芝宝打火机", /obj/item/lighter, 20),
		new /datum/data/vending_product("金属浇水壶", /obj/item/reagent_containers/cup/watering_can/metal, 20),
		new /datum/data/vending_product("大麻种子", /obj/item/seeds/cannabis, 20),
		new /datum/data/vending_product("大麻烟卷", /obj/item/cigarette/rollie/cannabis, 40), // CRIMSON EDIT - Shop Inventories Additions - Original: "cannabis puff"
		new /datum/data/vending_product("水烟壶", /obj/item/bong, 50),
		new /datum/data/vending_product("开锁器", /obj/item/vamp/keys/hack, 50),
		new /datum/data/vending_product("LSD药片瓶", /obj/item/storage/pill_bottle/lsd, 50),
		new /datum/data/vending_product("小刀", /obj/item/knife/vamp, 85),
		new /datum/data/vending_product("弹簧刀", /obj/item/switchblade/vamp, 85),
		new /datum/data/vending_product("黄铜指虎", /obj/item/clothing/gloves/vampire/brassknuckles, 100),
		new /datum/data/vending_product("木桩", /obj/item/vampire_stake, 100),
		new /datum/data/vending_product("旅行袋", /obj/item/storage/backpack/duffelbag,	100), // CRIMSON EDIT ADD - Adds Duffelbags to Black Market
		new /datum/data/vending_product("手术器械旅行袋", /obj/item/storage/backpack/duffelbag/sec/surgery, 100),
		new /datum/data/vending_product("手铐", /obj/item/restraints/handcuffs, 50),
		new /datum/data/vending_product("黑色头袋", /obj/item/clothing/head/vampire/blackbag, 50),
		new /datum/data/vending_product("短管左轮手枪", /obj/item/gun/ballistic/revolver/darkpack/snub, 100),
		new /datum/data/vending_product("布拉多克.45冲锋枪", /obj/item/gun/ballistic/automatic/darkpack/mac10, 1200),
		new /datum/data/vending_product("布拉多克.45弹匣", /obj/item/ammo_box/magazine/darkpack45smg, 300), // CRIMSON EDIT ADD - Braddock Mags Buyable
		new /datum/data/vending_product("锯短雷明顿11-87霰弹枪", /obj/item/gun/ballistic/shotgun/vamp_remington/sawnoff, 1600),
		new /datum/data/vending_product("11-87机油滤芯消音器", /obj/item/suppressor/darkpack_oil, 400),
		new /datum/data/vending_product("大麻包", /obj/item/food/grown/cannabis, 700),
		new /datum/data/vending_product("吗啡注射器", /obj/item/reagent_containers/syringe/contraband/morphine, 800),
		new /datum/data/vending_product("冰毒包", /obj/item/reagent_containers/cup/glass/baggie/meth, 800),
		new /datum/data/vending_product("可卡因包", /obj/item/reagent_containers/cup/glass/baggie/meth/cocaine, 800),
// CRIMSON EDIT ADD START - Medkit to Pharmacy
		new /datum/data/vending_product("便携医疗包", /obj/item/storage/medkit/tactical_lite, 1125),
		new /datum/data/vending_product("验尸官手术包", /obj/item/storage/medkit/coroner, 750),
// CRIMSON EDIT ADD END - Medkit to Pharmacy
		new /datum/data/vending_product("9毫米银弹", /obj/item/ammo_box/darkpack/c9mm/silver, 5000),
		new /datum/data/vending_product(".45 ACP银弹", /obj/item/ammo_box/darkpack/c45acp/silver, 6000),
		new /datum/data/vending_product(".44银弹", /obj/item/ammo_box/darkpack/c44/silver, 7000),
		new /datum/data/vending_product("5.56银弹", /obj/item/ammo_box/darkpack/c556/silver, 8000),
		new /datum/data/vending_product("5.56燃烧弹", /obj/item/ammo_box/darkpack/c556/incendiary, 9000)
	)
