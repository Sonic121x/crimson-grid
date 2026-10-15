/obj/item/food/bowled
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/food/soupsalad.dmi'
	abstract_type = /obj/item/food/bowled
	bite_consumption = 5
	max_volume = 80
	foodtypes = NONE
	eatverbs = list("吸溜", "小口喝下", "猛吸", "喝下")
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/bowled/make_germ_sensitive(mapload)
	return // It's in a bowl

/obj/item/food/bowled/wish
	name = "许愿汤"
	desc = "真希望这能算是汤。"
	icon_state = "wishsoup"
	food_reagents = list(/datum/reagent/water = 10)
	tastes = list("wishes" = 1)
	trash_type = /obj/item/reagent_containers/cup/bowl

/obj/item/food/bowled/wish/Initialize(mapload)
	. = ..()
	if(prob(25))
		desc = "愿望成真了！"
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)

/obj/item/food/bowled/mammi
	name = "芬兰黑麦布丁"
	desc = "一碗糊状的面包和牛奶。这模样让你不太愉快地想起排泄物。"
	icon_state = "mammi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	foodtypes = SUGAR | DAIRY | JUNKFOOD | GRAIN | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bowled/spacylibertyduff
	name = "太空自由布丁"
	desc = "照着阿尔弗雷德·哈伯德的食谱做出的果冻。"
	icon_state = "spacylibertyduff"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/drug/mushroomhallucinogen = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	trash_type = /obj/item/reagent_containers/cup/bowl

	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bowled/amanitajelly
	name = "毒蝇伞果冻"
	desc = "怎么看都像有毒。"
	icon_state = "amanitajelly"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/drug/mushroomhallucinogen = 3,
		/datum/reagent/toxin/amatoxin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	trash_type = /obj/item/reagent_containers/cup/bowl


	tastes = list("jelly" = 1, "mushroom" = 1)
	foodtypes = VEGETABLES | TOXIC
	crafting_complexity = FOOD_COMPLEXITY_2
