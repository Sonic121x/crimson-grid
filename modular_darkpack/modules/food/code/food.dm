/obj/item/food/vampire
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	//eatsound = 'code/modules/wod13/sounds/eat.ogg'
	custom_price = 3
	food_flags = FOOD_BITE_SPRITE

//----------FAST FOOD--------///
/obj/item/food/burger/plain
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 3
	food_flags = FOOD_BITE_SPRITE

/obj/item/food/donut/plain // DARKPACK TODO: unique onfloors for variants
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 1
	food_flags = FOOD_BITE_SPRITE

/obj/item/food/donut/choco // DARKPACK TODO: unique onfloors for variants
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 1
	food_flags = FOOD_BITE_SPRITE
	foodtypes = JUNKFOOD|GRAIN|DAIRY|FRIED|SUGAR|BREAKFAST|CHOCOLATE

/obj/item/food/pizzaslice/square
	name = "方形披萨片"
	icon_state = "pizza"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 2
	food_flags = FOOD_BITE_SPRITE

/obj/item/food/taco
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 2
	food_flags = FOOD_BITE_SPRITE

/obj/item/food/taco/plain
	icon_state = "taco"

/obj/item/food/taco/fish
	icon_state = "taco"

/obj/item/trash/vampirenugget
	name = "鸡翅骨"
	icon_state = "nugget0"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/food/vampire/nugget
	name = "鸡翅"
	desc = "大块头就该吃大鸡翅。"
	icon_state = "nugget1"
	trash_type = /obj/item/trash/vampirenugget
	bite_consumption = 1
	tastes = list("chicken" = 1)
	foodtypes = MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/protein = 3)
	eat_time = 15

/obj/item/food/hotdog
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/food/butterdog
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/food/submarine_sandwich
	name = "潜艇三明治"
	desc = "像三明治，不过是在水下。等等，不对……"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	icon_state = "sub"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
	custom_price = 5
	food_flags = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("italy" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

#ifndef UNIT_TESTS
/obj/item/food/submarine_sandwich/Initialize(mapload)
	. = ..()
	if(istype(src, /obj/item/food/submarine_sandwich/wish))
		return
	if(!prob(0.1))
		return
	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
	visible_message(span_warning("他们把订单弄错了！"))
	new /obj/item/food/submarine_sandwich/wish(loc)
	qdel(src)
#endif

/obj/item/food/submarine_sandwich/meatball
	name = "肉丸潜艇三明治"
	desc = "总比“潜艇丸子肉”强。"
	icon_state = "meatball"
	tastes = list("italy" = 4, "meat" = 2) // demon
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5)
	foodtypes = MEAT | GRAIN

/obj/item/food/submarine_sandwich/italiano
	name = "意式潜艇三明治"
	desc = "别让你的水管工看见这个。"
	icon_state = "italian"
	tastes = list("extra italy" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)

/obj/item/food/submarine_sandwich/wish
	name = "许愿三明治"
	desc = "许个愿吧！"
	icon_state = "wish"
	tastes = list("a wish that the sandwich had anything in it" = 4)
	food_reagents = list(/datum/reagent/consumable/nutriment = 0.5)
	foodtypes = GRAIN

//--------PACKAGED SNACKS-----------//

/obj/item/trash/vampirebar
	name = "巧克力棒包装纸"
	icon_state = "bar0"
	icon = 'modular_darkpack/modules/food/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/food/vampire/icecream
	name = "冰淇淋"
	desc = "尝尝童年的味道。"
	icon_state = "icecream2"
	food_reagents = list(/datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("vanilla" = 2, "ice cream" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR

/obj/item/food/vampire/icecream/chocolate
	icon_state = "icecream1"
	tastes = list("chocolate" = 2, "ice cream" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR | CHOCOLATE
	food_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)

/obj/item/food/vampire/icecream/berry
	icon_state = "icecream3"
	tastes = list("berry" = 2, "ice cream" = 2)
	food_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)

/* Sprites dont match new tg ones, but they look so good.. do something with this fact.
/obj/item/reagent_containers/condiment/flour
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/reagent_containers/condiment/sugar
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

/obj/item/reagent_containers/condiment/rice
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')
*/

/obj/item/food/meat/slab
	ONFLOOR_ICONSTATE_HELPER("meat")
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/food/icons/food_onfloor.dmi')

// CRIMSON EDIT ADD START - Shop Inventories Additions
/obj/item/food/bowled/chicken_noodle
	name = "鸡肉汤面"
	desc = "一碗丰盛的鸡肉汤面，适合生病待在家时享用。"
	icon_state = "chicken_noodle_soup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/soup/chicken_noodle_soup = 30,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("broth" = 1, "chicken" = 1, "noodles" = 1, "carrots" = 1)
	foodtypes = VEGETABLES | MEAT | GRAIN
	trash_type = /obj/item/reagent_containers/cup/bowl

/obj/item/food/khinkali/dumpling
	name = "蒸饺"
	desc = "顶部捏合封口的蒸制面点，包着猪肉和洋葱馅。"
	tastes = list("pork" = 2, "onions" = 1, "dough" = 1)
	custom_price = 2

/obj/item/food/khinkali/dumpling/Initialize(mapload)
	. = ..()
	transform = transform.Scale(0.4)

/obj/item/food/fries
	custom_price = 2

/obj/item/food/cheesyfries
	custom_price = 3
// CRIMSON EDIT ADD END - Shop Inventories Additions
