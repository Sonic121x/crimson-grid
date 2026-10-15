////////////////////////////////////////////DONK POCKETS////////////////////////////////////////////

/obj/item/food/donkpocket
	name = "\improper 当克口袋饼"
	desc = "老练叛徒的首选食品。"
	icon_state = "donkpocket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("umami" = 2, "dough" = 2, "laziness" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

	/// What type of donk pocket we're warmed into via baking or microwaving.
	var/warm_type = /obj/item/food/donkpocket/warm
	/// Whether baking/microwaving it yields a positive result
	var/positive_result = TRUE
	/// The lower end for how long it takes to bake
	var/baking_time_short = 25 SECONDS
	/// The upper end for how long it takes to bake
	var/baking_time_long = 30 SECONDS
	/// The amount of omnizine added when it's cooked.
	var/omnizine_to_add = 6

/obj/item/food/donkpocket/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, list(/datum/reagent/medicine/omnizine = omnizine_to_add))

/obj/item/food/donkpocket/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, string_assoc_list(list(/datum/reagent/medicine/omnizine = omnizine_to_add)), bad_recipe = !positive_result)

/obj/item/food/donkpocket/warm
	name = "热当克口袋饼"
	desc = "老练叛徒首选的热食。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 6,
	)
	tastes = list("umami" = 2, "dough" = 2, "laziness" = 1)
	foodtypes = GRAIN

	// Warmed donk pockets will burn if you leave them in the oven or microwave.
	warm_type = /obj/item/food/badrecipe
	positive_result = FALSE
	baking_time_short = 10 SECONDS
	baking_time_long = 15 SECONDS
	omnizine_to_add = 0

/obj/item/food/donkpocket/homemade
	foodtypes = MEAT|GRAIN
	tastes = list("meat" = 2, "dough" = 2, "comfiness" = 1)
	warm_type = /obj/item/food/donkpocket/warm/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/homemade
	foodtypes = MEAT|GRAIN
	tastes = list("meat" = 2, "dough" = 2, "comfiness" = 1)
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/dank
	name = "\improper 大麻口袋饼"
	desc = "老练植物学家的首选食品。"
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("weed" = 2, "dough" = 2)
	foodtypes = GRAIN|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2
	warm_type = /obj/item/food/donkpocket/warm/dank
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/dank
	name = "热大麻口袋饼"
	desc = "老练植物学家的首选食品。"
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("weed" = 2, "dough" = 2)
	foodtypes = GRAIN|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donkpocket/spicy
	name = "\improper 香辣口袋饼"
	desc = "经典零食，加热后便能激发香辣风味。"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("umami" = 2, "dough" = 2, "spice" = 1)
	foodtypes = VEGETABLES|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/spicy
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/spicy
	name = "热香辣口袋饼"
	desc = "经典零食，现在可能有点辣过头了。"
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/capsaicin = 5,
	)
	tastes = list("umami" = 2, "dough" = 2, "weird spices" = 2)
	foodtypes = VEGETABLES|GRAIN

/obj/item/food/donkpocket/spicy/homemade
	tastes = list("meat" = 2, "dough" = 2, "spice" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/spicy/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/spicy/homemade
	tastes = list("meat" = 2, "dough" = 2, "weird spices" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/teriyaki
	name = "\improper 照烧口袋饼"
	desc = "空间站经典零食的东亚风味版本。"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("umami" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/teriyaki
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/teriyaki
	name = "热照烧口袋饼"
	desc = "空间站经典零食的东亚风味版本，如今热气腾腾。"
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("umami" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/teriyaki/homemade
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = MEAT|GRAIN
	warm_type = /obj/item/food/donkpocket/warm/teriyaki/homemade
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/warm/teriyaki/homemade
	tastes = list("meat" = 2, "dough" = 2, "soy sauce" = 2)
	foodtypes = MEAT|GRAIN
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/pizza
	name = "\improper 披萨口袋饼"
	desc = "美味、奶酪味浓郁，还出奇地顶饱。"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("tomato" = 2, "dough" = 2, "cheese"= 2)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	warm_type = /obj/item/food/donkpocket/warm/pizza
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/pizza
	name = "热披萨口袋饼"
	desc = "美味、奶酪味浓郁，热着吃更棒。"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("tomato" = 2, "dough" = 2, "melty cheese"= 2)
	foodtypes = VEGETABLES|GRAIN|DAIRY

/obj/item/food/donkpocket/honk
	name = "\improper HONK口袋饼"
	desc = "获奖的当克口袋饼，同时赢得了小丑和人类的喜爱。"
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/banana = 4,
	)
	tastes = list("banana" = 2, "dough" = 2, "children's antibiotics" = 1)
	foodtypes = GRAIN|FRUIT|SUGAR
	warm_type = /obj/item/food/donkpocket/warm/honk
	crafting_complexity = FOOD_COMPLEXITY_3
	var/static/list/honk_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/laughter = 6,
	)
	custom_materials = null

/obj/item/food/donkpocket/honk/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, honk_added_reagents)

/obj/item/food/donkpocket/honk/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, honk_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/honk
	name = "热HONK口袋饼"
	desc = "获奖的当克口袋饼，如今烤得香热可口。"
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/banana = 4,
		/datum/reagent/consumable/laughter = 6,
	)
	tastes = list("banana" = 2, "dough" = 2, "children's antibiotics" = 1)
	foodtypes = GRAIN|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/donkpocket/berry
	name = "\improper 莓果口袋饼"
	desc = "甜得毫不留情的当克口袋饼，最初为甜点风暴行动研制。"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("dough" = 2, "jam" = 2)
	foodtypes = GRAIN|FRUIT|SUGAR
	warm_type = /obj/item/food/donkpocket/warm/berry
	custom_materials = null
	omnizine_to_add = 2

/obj/item/food/donkpocket/warm/berry
	name = "热莓果口袋饼"
	desc = "甜得毫不留情的当克口袋饼，如今热乎美味。"
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("dough" = 2, "warm jam" = 2)
	foodtypes = GRAIN|FRUIT|SUGAR
	custom_materials = null

/obj/item/food/donkpocket/gondola
	name = "\improper 冈多拉口袋饼"
	desc = "使用真正的冈多拉肉做馅，至少可以说，这个决定颇具争议。" //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)
	foodtypes = GRAIN|MEAT

	warm_type = /obj/item/food/donkpocket/warm/gondola
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	var/static/list/gondola_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)

/obj/item/food/donkpocket/gondola/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, gondola_added_reagents)

/obj/item/food/donkpocket/gondola/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, gondola_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/gondola
	name = "热冈多拉口袋饼"
	desc = "使用真正的冈多拉肉做馅，至少可以说，这个决定颇具争议。"
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 10,
	)
	tastes = list("meat" = 2, "dough" = 2, "inner peace" = 1)
	foodtypes = GRAIN|MEAT
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/donkpocket/deluxe
	name = "\improper 豪华当克口袋饼"
	desc = "当克公司的最新产品，配方是严加保密的秘密。"
	icon_state = "donkpocketdeluxe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("quality meat" = 2, "dough" = 2, "raw fanciness" = 1)
	foodtypes = GRAIN|MEAT|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

	warm_type = /obj/item/food/donkpocket/warm/deluxe
	var/static/list/deluxe_added_reagents = list(
		/datum/reagent/medicine/omnizine = 8,
	)
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/donkpocket/deluxe/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), positive_result, TRUE, deluxe_added_reagents)

/obj/item/food/donkpocket/deluxe/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, deluxe_added_reagents, positive_result)

/obj/item/food/donkpocket/warm/deluxe
	name = "热豪华当克口袋饼"
	desc = "当克公司的最新产品。香脆热乎，火候完美。该死，这当克口袋饼看着真诱人。"
	icon_state = "donkpocketdeluxe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("quality meat" = 2, "dough" = 2, "fanciness" = 1)
	foodtypes = GRAIN|MEAT|VEGETABLES|FRIED
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/donkpocket/deluxe/nocarb
	name = "\improper 纯肉口袋饼"
	desc = "肉食叛徒的首选食品。"
	icon_state = "donkpocketdeluxenocarb"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("raw meat" = 2, "more meat" = 2, "no carbs" = 1)
	foodtypes = MEAT|RAW
	crafting_complexity = FOOD_COMPLEXITY_4
	warm_type = /obj/item/food/donkpocket/warm/deluxe/nocarb
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/donkpocket/warm/deluxe/nocarb
	name = "热纯肉口袋饼"
	desc = "肉食叛徒首选的热食。"
	icon_state = "donkpocketdeluxenocarb"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("meat" = 2, "more meat" = 2, "no carbs" = 1)
	foodtypes = MEAT
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/donkpocket/deluxe/vegan
	name = "\improper 当克米饭卷"
	desc = "空间站经典零食，如今加入米饭！获动物解放阵线认证：纯素、无动物虐待。"
	icon_state = "donkpocketdeluxevegan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("rice patty" = 2, "dough" = 2, "peppery kick" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	warm_type = /obj/item/food/donkpocket/warm/deluxe/vegan
	custom_materials = null

/obj/item/food/donkpocket/warm/deluxe/vegan
	name = "热当克米饭卷"
	desc = "空间站经典零食，如今加入米饭！煎炸火候恰到好处。"
	icon_state = "donkpocketdeluxevegan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/medicine/omnizine = 10,
	)
	tastes = list("rice patty" = 2, "fried dough" = 2, "peppery kick" = 1)
	foodtypes = GRAIN | VEGETABLES | FRIED
	custom_materials = null
