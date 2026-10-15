/obj/item/seeds/onion
	name = "洋葱种子包"
	desc = "这些种子能长成洋葱。"
	icon_state = "seed-onion"
	species = "onion"
	plantname = "洋葱苗"
	product = /obj/item/food/grown/onion
	lifespan = 20
	maturation = 3
	production = 4
	yield = 6
	endurance = 25
	instability = 10
	growthstages = 3
	weed_chance = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_vegetables.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/consumable/tearjuice = 0.25)
	mutatelist = list(/obj/item/seeds/onion/red)

/obj/item/food/grown/onion
	seed = /obj/item/seeds/onion
	name = "洋葱"
	desc = "没什么好哭的。"
	icon_state = "onion"
	tastes = list("onions" = 1)
	wine_power = 30
	foodtypes = VEGETABLES

/obj/item/food/grown/onion/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/onion_slice, 2, 15, screentip_verb = "切开")

/obj/item/seeds/onion/red
	name = "红洋葱种子包"
	desc = "用来种出格外辛辣的洋葱。"
	icon_state = "seed-onionred"
	species = "onion_red"
	plantname = "红洋葱苗"
	weed_chance = 1
	product = /obj/item/food/grown/onion/red
	mutatelist = null

/obj/item/food/grown/onion/red
	seed = /obj/item/seeds/onion/red
	name = "红洋葱"
	desc = "虽然叫红洋葱，却是紫色的。"
	icon_state = "onion_red"
	wine_power = 60

/obj/item/food/grown/onion/red/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/onion_slice/red, 2, 15, screentip_verb = "切开")

/obj/item/food/grown/onion/UsedforProcessing(mob/living/user, obj/item/I, list/chosen_option, list/created_atoms)
	var/splat_location = get_turf(src) //we need to set up the smoke beforehand
	do_chem_smoke(0, src, splat_location, carry = reagents, silent = FALSE)
	return ..()

/obj/item/food/onion_slice
	name = "洋葱片"
	desc = "这是葱圈，可不是拿来戴的。"
	icon_state = "onionslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	w_class = WEIGHT_CLASS_TINY
	foodtypes = VEGETABLES

/obj/item/food/onion_slice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/onionrings, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/onion_slice/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/onionrings)

/obj/item/food/onion_slice/red
	name = "红洋葱片"
	desc = "闪着光，像一块成色极差的紫水晶。"
	icon_state = "onionslice_red"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/tearjuice = 2.5)
