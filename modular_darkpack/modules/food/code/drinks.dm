//---------DRINKS---------//

/obj/item/reagent_containers/cup/glass/coffee/vampire
	name = "咖啡"
	desc = "小心，你即将享用的饮料非常烫。"
	icon_state = "coffee"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	//foodtype = BREAKFAST

/obj/item/reagent_containers/cup/glass/coffee/vampire/robust
	name = "浓香咖啡"
	icon_state = "coffee-alt"

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire
	name = "啤酒"
	desc = "啤酒。"
	icon_state = "beer"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/blue_stripe
	name = "蓝条啤酒"
	desc = "蓝条啤酒，由国王酿酒与蒸馏公司出品！"
	icon_state = "beer_blue"
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/light = 25, /datum/reagent/toxin/amatoxin = 5)

// DARKPACK TODO - (Typhon's Beer needs an audit of its handling. This looks ass.)
/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon
	name = "堤丰啤酒"
	desc = "一款满足嗜血口味的血色饮品。"
	icon_state = "typhon"
	//foodtype = SANGUINE
	list_reagents = list(/datum/reagent/consumable/ethanol/beer/typhon = 30)

/obj/item/reagent_containers/cup/glass/bottle/beer/vampire/typhon/attack(mob/living/M, mob/user, def_zone)
	. = ..()
	reagents.trans_to(M, gulp_size, transferred_by = user)

/datum/reagent/consumable/ethanol/beer/typhon
	name = "堤丰啤酒"
	description = "一款酿出血腥风味的酒饮，让人病态地上瘾。"
	color = "#660000"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 50
	taste_description = "blood sweet"
	//glass_name = "glass of sanquine beer"
	//glass_desc = "A freezing pint of vitae."

/datum/reagent/consumable/ethanol/beer/typhon/on_mob_life(mob/living/carbon/M)
	if(get_kindred_splat(M))
		M.adjust_blood_pool(0.25)
	if(get_ghoul_splat(M))
		M.adjust_blood_pool(1)
	return ..()

/obj/item/reagent_containers/cup/glass/vampirecola
	name = "两升瓶装可乐"
	desc = "可口可乐冒泡泡……"
	icon_state = "colared"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/space_cola = 100)
	volume = 100
	age_restricted = FALSE
	custom_price = 2 // ECONOMY

/obj/item/reagent_containers/cup/glass/vampirecola/blue
	desc = "活力可乐，让你的步伐充满活力。"
	list_reagents = list(/datum/reagent/consumable/space_up = 100)
	icon_state = "colablue"

/obj/item/reagent_containers/cup/glass/vampirewater
	name = "瓶装水"
	desc = "H2O."
	icon_state = "water1"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	isGlass = FALSE
	list_reagents = list(/datum/reagent/water = 50)
	age_restricted = FALSE
	custom_price = 2 // ECONOMY

/obj/item/reagent_containers/cup/soda_cans/vampirecola
	name = "可乐"
	desc = "可口可乐冒泡泡……"
	icon_state = "colared2"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 30)

/obj/item/reagent_containers/cup/soda_cans/vampirecola/blue
	desc = "活力可乐，让你的步伐充满活力。"
	icon_state = "colablue2"
	list_reagents = list(/datum/reagent/consumable/space_up = 30)

/obj/item/reagent_containers/cup/soda_cans/vampiresoda
	name = "汽水"
	desc = "又是水……"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/sodawater = 30)

/obj/item/reagent_containers/cup/soda_cans/summer_thaw
	name = "夏日融冰"
	desc = "清爽的饮料，由国王酿酒与蒸馏公司出品！"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/space_cola = 20, /datum/reagent/medicine/muscle_stimulant = 5, /datum/reagent/toxin/amatoxin = 5)

/obj/item/reagent_containers/cup/soda_cans/thaw_club
	name = "融冰苏打水"
	desc = "满足你的活力需求，由国王酿酒与蒸馏公司出品！"
	icon_state = "soda"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	list_reagents = list(/datum/reagent/consumable/monkey_energy = 30)

/obj/item/reagent_containers/condiment/milk
	name = "牛奶"
	desc = "又是牛奶……"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 4 // ECONOMY

/obj/item/reagent_containers/condiment/milk/malk
	desc = "一盒鱼牌牛奶，该品牌隶属于玛尔克公司。"

/obj/item/reagent_containers/cup/mixing_bowl
	name = "搅拌碗"
	desc = "一个最多能容纳50单位液体的搅拌碗，非常适合烹饪。"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	icon_state = "mixingbowl"
	spillable = TRUE
	custom_materials = list(/datum/material/glass=500)
	custom_price = 10 // ECONOMY

// CRIMSON EDIT ADD START - Shop Inventories Additions
/obj/item/reagent_containers/cup/glass/mug/tea/jasmine
	name = "茉莉花茶"
	desc = "散叶冲泡的热茉莉花茶，盛在朴素的陶瓷杯中。"
// CRIMSON EDIT ADD END - Shop Inventories Additions
