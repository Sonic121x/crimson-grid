/obj/structure/retail/pharmacy
	product_types = list(
		/obj/item/stack/medical/bruise_pack,
		/obj/item/stack/medical/ointment,
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/stack/medical/suture,
		/obj/item/stack/medical/mesh,
	)
	products_list = list(
		new /datum/data/vending_product("碘化钾药片瓶", /obj/item/storage/pill_bottle/potassiodide),
		new /datum/data/vending_product("乳胶手套", /obj/item/clothing/gloves/vampire/latex, 150),
		new /datum/data/vending_product("补铁药片瓶", /obj/item/storage/pill_bottle/iron, 150),
		new /datum/data/vending_product("吸入器药罐", /obj/item/reagent_containers/inhaler_canister/albuterol/asthma, 150),
		new /datum/data/vending_product("麻黄碱药片瓶", /obj/item/storage/pill_bottle/ephedrine),
		new /datum/data/vending_product("注射器盒", /obj/item/storage/box/syringes, 300),
		new /datum/data/vending_product("吸入器", /obj/item/inhaler/albuterol/asthma, 400),
		new /datum/data/vending_product("手杖", /obj/item/cane),
		new /datum/data/vending_product("白色盲杖", /obj/item/cane/white),
		new /datum/data/vending_product("拐杖", /obj/item/cane/crutch),
		new /datum/data/vending_product("木制拐杖", /obj/item/cane/crutch/wood),
// CRIMSON EDIT ADD START - Medkit to Pharmacy
		new /datum/data/vending_product("空血袋", /obj/item/reagent_containers/blood/empty),
		new /datum/data/vending_product("空医疗包", /obj/item/storage/medkit/darkpack, 200),
		new /datum/data/vending_product("医疗包", /obj/item/storage/medkit/darkpack/standard, 500),
		new /datum/data/vending_product("个人急救包", /obj/item/storage/medkit/darkpack/ifak, 500),
		new /datum/data/vending_product("医生医疗包", /obj/item/storage/medkit/darkpack/doctor, 900),
		new /datum/data/vending_product("高级医疗包", /obj/item/storage/medkit/darkpack/advanced, 1200),
		new /datum/data/vending_product("烧伤救治包", /obj/item/storage/medkit/darkpack/burn, 600),
		new /datum/data/vending_product("中毒救治包", /obj/item/storage/medkit/darkpack/tox, 700),
		new /datum/data/vending_product("创伤救治包", /obj/item/storage/medkit/darkpack/brute, 700),
		new /datum/data/vending_product("缺氧救治包", /obj/item/storage/medkit/darkpack/oxy, 700),
// CRIMSON EDIT ADD END - Medkit to Pharmacy
// CRIMSON EDIT ADD START - Shop Inventories Additions
		new /datum/data/vending_product("安神定药片瓶", /obj/item/storage/pill_bottle/psicodine, 150),
		new /datum/data/vending_product("多效净药片瓶", /obj/item/storage/pill_bottle/multiver, 150),
		new /datum/data/vending_product("肾上腺素急救注射笔", /obj/item/reagent_containers/hypospray/medipen, 100),
		new /datum/data/vending_product("拔牙钳", /obj/item/wirecutters/pliers, 300),
// CRIMSON EDIT ADD END - Shop Inventories Additions
// CRIMSON EDIT ADD START - Magadon Drugs
		new /datum/data/vending_product("玛加醒药片瓶", /obj/item/storage/pill_bottle/magafinil, 500),
		new /datum/data/vending_product("玛加舒药片瓶", /obj/item/storage/pill_bottle/magaloft, 600),
// CRIMSON EDIT ADD END - Magadon Drugs
	)
