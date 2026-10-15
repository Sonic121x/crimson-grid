// Corn
/obj/item/seeds/corn
	name = "玉米种子包"
	desc = "我可不是在说玉米烂梗……"
	icon_state = "seed-corn"
	species = "corn"
	plantname = "玉米秆"
	product = /obj/item/food/grown/corn
	maturation = 8
	potency = 20
	instability = 50 //Corn used to be wheatgrass, before being cultivated for generations.
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	icon_grow = "corn-grow" // Uses one growth icons set for all the subtypes
	icon_dead = "corn-dead" // Same for the dead icon
	mutatelist = list(/obj/item/seeds/corn/snapcorn, /obj/item/seeds/corn/pepper)
	reagents_add = list(/datum/reagent/consumable/nutriment/fat/oil/corn = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/corn
	seed = /obj/item/seeds/corn
	name = "玉米棒"
	desc = "得抹点黄油！"
	icon_state = "corn"
	trash_type = /obj/item/grown/corncob
	bite_consumption_mod = 2
	foodtypes = VEGETABLES
	tastes = list("corn" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/whiskey

/obj/item/food/grown/corn/grind_results()
	return list(/datum/reagent/consumable/cornmeal = 0, /datum/reagent/consumable/nutriment/fat/oil/corn = 0)

/obj/item/food/grown/corn/juice_typepath()
	return /datum/reagent/consumable/corn_starch

/obj/item/food/grown/corn/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/oven_baked_corn, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/grown/corn/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/popcorn)

/obj/item/grown/corncob
	seed = /obj/item/seeds/corn
	name = "玉米芯"
	desc = "一顿饭留下的纪念。"
	icon_state = "corncob"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/grown/corncob/grind_results()
	return list(/datum/reagent/cellulose = 10)

/obj/item/grown/corncob/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness())
		return NONE

	to_chat(user, span_notice("你用[tool]把玉米芯削成了一支烟斗！"))
	new /obj/item/cigarette/pipe/cobpipe (user.loc)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

// Snapcorn
/obj/item/seeds/corn/snapcorn
	name = "摔炮玉米种子包"
	desc = "啪！吓一跳！"
	icon_state = "seed-snapcorn"
	species = "snapcorn"
	plantname = "摔炮玉米秆"
	product = /obj/item/grown/snapcorn
	mutatelist = null
	rarity = 10

/obj/item/grown/snapcorn
	seed = /obj/item/seeds/corn/snapcorn
	name = "摔炮玉米"
	desc = "长满摔炮的玉米棒。"
	icon_state = "snapcorn"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	var/snap_pops = 1

/obj/item/grown/snapcorn/add_juice()
	..()
	snap_pops = max(round(seed.potency/8), 1)

/obj/item/grown/snapcorn/attack_self(mob/user)
	..()
	to_chat(user, span_notice("你从玉米棒上摘下一颗摔炮。"))
	var/obj/item/toy/snappop/S = new /obj/item/toy/snappop(user.loc)
	if(ishuman(user))
		user.put_in_hands(S)
	snap_pops -= 1
	if(!snap_pops)
		new /obj/item/grown/corncob/snap(user.loc)
		qdel(src)

/obj/item/grown/corncob/snap
	seed = /obj/item/seeds/corn/snapcorn
	name = "摔炮玉米芯"
	desc = "一场恶作剧留下的纪念。"

//Pepper-corn - Heh funny.
/obj/item/seeds/corn/pepper
	name = "胡椒玉米种子包"
	desc = "假如彼得捧着一包胡椒玉米……"
	icon_state = "seed-peppercorn"
	species = "peppercorn"
	plantname = "胡椒玉米秆"
	product = /obj/item/food/grown/peppercorn
	mutatelist = null
	reagents_add = list(/datum/reagent/consumable/blackpepper = 0.2, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/peppercorn
	seed = /obj/item/seeds/corn/pepper
	name = "胡椒玉米棒"
	desc = "这满身粉末的怪物需要上帝拯救……"
	icon_state = "peppercorn"
	trash_type = /obj/item/grown/corncob/pepper
	foodtypes = VEGETABLES
	tastes = list("pepper" = 1, "sneezing" = 1)

/obj/item/food/grown/peppercorn/grind_results()
	return list(/datum/reagent/consumable/blackpepper = 0)

/obj/item/grown/corncob/pepper
	seed = /obj/item/seeds/corn/pepper
	name = "胡椒玉米芯"
	desc = "基因怪胎留下的纪念。"
