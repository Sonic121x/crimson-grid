//Moth Foods, the three C's: cheese, coleslaw, and cotton
//A large emphasis has been put on sharing and multiple portion dishes
//Additionally, where a mothic name is given, a short breakdown of what exactly it means is provided, for the curious on the internal workings of mothic: it's very onomatopoeic, and makes heavy use of combined words and accents

//Base ingredients and miscellany, generally not served on their own
/obj/item/food/herby_cheese
	name = "香草奶酪"
	desc = "奶酪是蛾人饮食的主食，常加入各种调味，让餐桌保持变化。\
		香草就是其中一种，而且格外受欢迎。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "herby_cheese"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6)
	tastes = list("cheese" = 1, "herbs" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_cheese
	name = "烤奶酪"
	desc = "正如奥尔顿大人所言——愿其名受赞颂——世上99.997%的烤奶酪食谱都在公然撒谎：\
		奶酪根本没上烤架，只是夹在铁板煎三明治里融化了。而这个才是真正的烤奶酪，连烤痕都有。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "grilled_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("cheese" = 1, "char" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mothic_salad
	name = "蛾式沙拉"
	desc = "用卷心菜、红洋葱和番茄做成的基础沙拉，可作为无数种沙拉的完美底料。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_salad"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("salad" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/toasted_seeds
	name = "烤籽仁"
	desc = "烤籽仁虽说远不够顶饱，却是蛾人喜爱的零食。\
		撒上盐、糖，甚至更奇特的调味，就能增添风味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "toasted_seeds"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("seeds" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/engine_fodder
	name = "引擎口粮"
	desc = "蛾人船队工程师常吃的零食，由籽仁、坚果、巧克力、爆米花和薯片混合而成——\
		热量密集，随手就能吃，专为需要加把劲的时候准备。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "engine_fodder"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("seeds" = 1, "nuts" = 1, "chocolate" = 1, "salt" = 1, "popcorn" = 1, "potato" = 1)
	foodtypes = JUNKFOOD|GRAIN|FRIED|NUTS|VEGETABLES|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mothic_pizza_dough
	name = "蛾式披萨面团"
	desc = "用玉米粉和面粉做成的高筋面团，足够有韧性，能承托奶酪和酱汁。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_pizza_dough"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("raw flour" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

//Entrees: categorising food that is 90% cheese and salad is not easy
/obj/item/food/squeaking_stir_fry
	name = "吱吱小炒" //skeklit = squeaking, mischt = stir, poppl = fry
	desc = "用奶酪凝块、豆腐等食材做成的蛾人经典菜。\
		名字直译为“吱吱小炒”，源于这些蛋白质食材咀嚼时独特的吱吱声。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "squeaking_stir_fry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("cheese" = 1, "tofu" = 1, "veggies" = 1)
	foodtypes = DAIRY|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sweet_chili_cabbage_wrap
	name = "甜辣卷心菜卷"
	desc = "卷心菜叶包着烤奶酪和沙拉，淋上美味甜辣酱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sweet_chili_cabbage_wrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "salad" = 1, "sweet chili" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/loaded_curds
	name = "满溢奶酪凝块薯条" //ozlsettit = overflowing (ozl = over, sett = flow, it = ing), ælo = cheese, skekllön = curds (skeklit = squeaking, llön = pieces/bits), ede = and, pommes = fries (hey, France!)
	desc = "什么比奶酪凝块更好？炸奶酪凝块！什么比炸奶酪凝块更好？\
		上面浇辣椒酱，再加更多奶酪！还能更好吗？把它铺在薯条上！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "loaded_curds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "oil" = 1, "chili" = 1, "fries" = 1)
	foodtypes = VEGETABLES|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/baked_cheese
	name = "焗奶酪轮"
	desc = "烤得融化的奶酪轮，十分美味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("cheese" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/baked_cheese_platter
	name = "炉烤奶酪拼盘" //stannt = oven, krakt = baked, ælo = cheese
	desc = "烤奶酪轮是蛾人最爱分享的食品之一，通常搭配酥脆面包片蘸着吃，\
		因为唯一胜过好奶酪的，就是面包上的好奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese_platter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("cheese" = 1, "bread" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Baked Green Lasagna at the Whistlestop Cafe
/obj/item/food/raw_green_lasagne
	name = "生青酱千层面"
	desc = "用罗勒青酱与香草白酱制作的精美千层面，只待入炉，可供多人分享。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS|RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_green_lasagne/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/green_lasagne, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/green_lasagne
	name = "青酱千层面"
	desc = "用罗勒青酱与香草白酱制作的精美千层面，可供多人分享。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 24,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/green_lasagne/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/green_lasagne_slice, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/green_lasagne_slice
	name = "青酱千层面片"
	desc = "一片香草与罗勒青酱风味的千层面。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice
	name = "大盘生焗饭"
	desc = "一大盘土豆层上铺着米饭、浇着蔬菜高汤，烤熟后就是可供分享的美味大餐。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN | RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/big_baked_rice, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/big_baked_rice
	name = "大盘焗饭"
	desc = "焗饭是备受喜爱的招牌料理，加入各式蔬菜，就能做成适合分享的美味大餐。\
		锅底也常铺一层土豆，烤出香脆底壳，让食客争抢不休。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "big_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 18,
		/datum/reagent/consumable/nutriment/vitamin = 42,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/big_baked_rice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/lil_baked_rice, 6, 3 SECONDS, table_required = TRUE, screentip_verb = "切开")

/obj/item/food/lil_baked_rice
	name = "小份焗饭"
	desc = "一人份焗饭，既适合作为配菜，也能当作一顿正餐。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "lil_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/oven_baked_corn
	name = "炉烤玉米"
	desc = "一根在烤箱高温中烤至表皮起泡焦黑的玉米。\
		制作快捷、味美又顶饱，深受船队食客喜爱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "oven_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/buttered_baked_corn
	name = "黄油烤玉米"
	desc = "什么比烤玉米更好？抹了黄油的烤玉米！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "buttered_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fiesta_corn_skillet
	name = "嘉年华铁锅玉米"
	desc = "又甜又辣，酱汁浓郁，满满玉米，满满趣味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fiesta_corn_skillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "chili" = 1, "char" = 1)
	foodtypes = VEGETABLES|JUNKFOOD|DAIRY|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_ratatouille
	name = "生普罗旺斯炖菜" //rawtatouille?
	desc = "蔬菜切片配烤甜椒酱。作为乡间饭菜，味道很不错。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_ratatouille/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ratatouille, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ratatouille
	name = "普罗旺斯炖菜"
	desc = "拯救餐厅、征服刻薄美食评论家的完美菜肴。帽子里有老鼠还能加分。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1, "char" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mozzarella_sticks
	name = "马苏里拉奶酪条"
	desc = "裹上面包糠油炸的小条马苏里拉奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mozzarella_sticks"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("creamy cheese" = 1, "breading" = 1, "oil" = 1)
	foodtypes = GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_stuffed_peppers
	name = "生酿甜椒" //voltöl = stuffed (vol = full, töl = push), paprik (from German paprika) = bell pepper
	desc = "去顶的甜椒里塞满香草奶酪与洋葱混合馅，最好别生吃。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_stuffed_peppers/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/stuffed_peppers, rand(10 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/stuffed_peppers
	name = "酿甜椒"
	desc = "柔软却仍带脆感的甜椒，内馅是美味融化的奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fueljacks_lunch
	name = "\improper 采燃工午餐"
	desc = "一份炒蔬菜，是采燃工喜爱的饭菜。这些勇敢的蛾人驾驶燃料采集艇，维持船队运转。\
		燃料需求从不停歇，而恒星位置适合采集的时机又十分有限，\
		所以他们常带盒饭，省去往返食堂的时间，并用刚灌满的燃料罐加热。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fueljacks_lunch"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mac_balls
	name = "通心粉奶酪球"
	desc = "奶酪通心粉捏成球，裹玉米糊油炸，配番茄酱食用。\
		风靡银河的零食，在蛾人船队尤其流行；那里常用即食当克作底料。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mac_balls"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("pasta" = 1, "cornbread" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES | FRIED | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sustenance_bar
	name = "船队剩余预包装维生棒"
	desc = "预包装维生棒是一种压制紧实、营养丰富的食品，旨在帮助民众度过\
		粮食短缺时期。它以大豆和豌豆蛋白制成，合理配给时每根可供三天食用。虽然保质期很长，\
		终究还是会变质，因此船队会将多余存货出售。这根和大多数人工调味的蛾人食品一样，是混合香草味。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sustenance_bar"
	trash_type = /obj/item/trash/fleet_ration
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("herbs" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sustenance_bar/neapolitan
	name = "船队剩余预包装维生棒——那不勒斯三色味"
	desc = "预包装维生棒是一种压制紧实、营养丰富的食品，旨在帮助民众度过\
		粮食短缺时期。它以大豆和豌豆蛋白制成，合理配给时每根可供三天食用。虽然保质期很长，\
		终究还是会变质，因此船队会将多余存货出售。这根是那不勒斯三色味：草莓、香草和巧克力。"
	tastes = list("strawberry" = 1, "vanilla" = 1, "chocolate" = 1)

/obj/item/food/sustenance_bar/cheese
	name = "船队剩余预包装维生棒——三重奶酪味"
	desc = "预包装维生棒是一种压制紧实、营养丰富的食品，旨在帮助民众度过\
		粮食短缺时期。它以大豆和豌豆蛋白制成，合理配给时每根可供三天食用。虽然保质期很长，\
		终究还是会变质，因此船队会将多余存货出售。这根是三重奶酪味：帕尔马、马苏里拉和切达奶酪。"
	tastes = list("parmesan" = 1, "mozzarella" = 1, "cheddar" = 1)

/obj/item/food/sustenance_bar/mint
	name = "船队剩余预包装维生棒——薄荷巧克力脆片味"
	desc = "预包装维生棒是一种压制紧实、营养丰富的食品，旨在帮助民众度过\
		粮食短缺时期。它以大豆和豌豆蛋白制成，合理配给时每根可供三天食用。虽然保质期很长，\
		终究还是会变质，因此船队会将多余存货出售。这根是薄荷巧克力脆片味：薄荷、\
		黑巧克力和薯片。看来蛾人根本不知道薄荷巧克力脆片是什么。"
	tastes = list("peppermint" = 1, "potato chips(?)" = 1, "dark chocolate" = 1)

/obj/item/food/sustenance_bar/wonka
	name = "船队剩余预包装维生棒——三道式晚餐"
	desc = "预包装维生棒是一种压制紧实、营养丰富的食品，旨在帮助民众度过\
		粮食短缺时期。它以大豆和豌豆蛋白制成，合理配给时每根可供三天食用。虽然保质期很长，\
		终究还是会变质，因此船队会将多余存货出售。这根分成三种口味，\
		凑成一顿典型餐食：番茄汤、烤南瓜和蓝莓派。" //Thankfully not made by Willy Wonka
	tastes = list("tomato soup" = 1, "roast pumpkin" = 1, "blueberry pie" = 1)

/obj/item/food/bowled/fried_eggplant_polenta
	name = "炸茄子配玉米糊"
	desc = "拌满奶酪的玉米糊，配上几片炸茄子和番茄酱。美味！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fried_eggplant_polenta"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("cornmeal" = 1, "cheese" = 1, "eggplant" = 1, "tomato sauce" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

//Salads: the bread and butter of mothic cuisine
/obj/item/food/caprese_salad
	name = "卡普雷塞沙拉"
	desc = "卡普雷塞沙拉虽非蛾人原创，却凭借做法简单、味道出众，\
		成为船队最受欢迎的菜式之一。蛾人给它起了个名字，\
		用银河通用语说，就是双色沙拉。" //zail = two, esken = colour/tone, knuskolt = salad
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "caprese_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("mozzarella" = 1, "tomato" = 1, "balsamic" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/fleet_salad
	name = "船队沙拉" //lörton = fleet, knusksolt = salad (knusk = crisp, solt = bowl)
	desc = "这道菜的蛾语名字译成银河通用语就是船队沙拉，常见于船队的小吃吧和食堂。\
		烤奶酪让它格外顶饱，面包丁则增添了酥脆口感。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fleet_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("cheese" = 1, "salad" = 1, "bread" = 1)
	foodtypes = DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/salad/cotton_salad
	name = "棉花沙拉"
	desc = "加了棉花和简单调味汁的沙拉。大概附近有蛾人，或者南方又崛起了。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cotton_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 14,
	)
	tastes = list("cheese" = 1, "salad" = 1, "bread" = 1)
	foodtypes = VEGETABLES | CLOTH
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/moth_kachumbari
	name = "\improper 肯尼亚沙拉" //Kæniat = Kenyan, knusksolt = salad
	desc = "原本来自肯尼亚的番茄洋葱沙拉，是又一道被蛾人接纳的人类跨文化美食——\
		不过为适应饮食，部分原料做了必要调整。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_kachumbari"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("onion" = 1, "tomato" = 1, "corn" = 1, "chili" = 1, "cilantro" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Pizza
/obj/item/food/raw_mothic_margherita
	name = "生蛾式玛格丽特披萨"
	desc = "又一道被蛾人接纳的人类经典料理。蛾式披萨以新鲜食材为特色，\
		尤其讲究新鲜马苏里拉奶酪，并用高筋面粉做出筋道的饼底。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_margherita/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_margherita, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_margherita
	name = "蛾式玛格丽特披萨"
	desc = "蛾式披萨的重要特点是按重量出售：零用信用点可以买单片，一张餐券则能换一整张。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_margherita
	boxtag = "蛾式玛格丽特"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_margherita
	name = "蛾式玛格丽特披萨片"
	desc = "一片蛾式玛格丽特披萨，最朴素的披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker
	name = "生蛾式爆竹披萨"
	desc = "喜欢冒险的蛾人的最爱。爆竹披萨，辣！辣！辣！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("dough" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_firecracker, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_firecracker
	name = "蛾式爆竹披萨"
	desc = "叫它火辣披萨，真不是开玩笑。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_firecracker
	boxtag = "维苏威爆竹"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_firecracker
	name = "蛾式爆竹披萨片"
	desc = "一片香辣又可口的好东西。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_slice"
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese
	name = "生蛾式五重奶酪披萨"
	desc = "几个世纪以来，学者们一直在问：到底放多少奶酪才算太多？"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_five_cheese, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_five_cheese
	name = "蛾式五重奶酪披萨"
	desc = "小鼠、大鼠和英国发明家的最爱。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_five_cheese
	boxtag = "奶酪大爆炸"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_five_cheese
	name = "蛾式五重奶酪披萨片"
	desc = "银河里奶酪最浓的一片！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie
	name = "生蛾式白披萨"
	desc = "专为讨厌番茄的人准备的披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_white_pie, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_white_pie
	name = "蛾式白披萨"
	desc = "你叫它西红柿，我叫它番茄，反正这披萨两样都不放。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_white_pie
	boxtag = "白面包"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_white_pie
	name = "蛾式白披萨片"
	desc = "奶酪香、蒜香、香草香，美味！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto
	name = "生蛾式青酱披萨"
	desc = "罗勒青酱是蛾人喜爱的披萨配料，很可能因为它汇集了他们最爱的味道：奶酪、香草和蔬菜。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_pesto, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_pesto
	name = "蛾式青酱披萨"
	desc = "绿得像花园里的草。虽然蛾人的船上也没多少花园。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	slice_type = /obj/item/food/pizzaslice/mothic_pesto
	boxtag = "快手青酱"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_pesto
	name = "蛾式青酱披萨片"
	desc = "一片快手青酱披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_slice"
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_garlic
	name = "生蛾式蒜香披萨面包"
	desc = "啊，大蒜。人人喜爱的食材，或许吸血鬼除外。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|RAW|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_mothic_garlic/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_garlic, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_garlic
	name = "蛾式蒜香披萨面包"
	desc = "银河系最棒的食物，毫无争议。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_garlic
	boxtag = "蛾式蒜香面包"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizzaslice/mothic_garlic
	name = "蛾式蒜香披萨面包片"
	desc = "蛾人所知的油香、蒜香与酥脆口感的最佳组合。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_slice"
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

//Bread
/obj/item/food/bread/corn
	name = "玉米面包"
	desc = "地道乡村风味，吆喝着、放着左轮枪，嚯呀一声的牛仔玉米面包。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 18)
	tastes = list("cornbread" = 10)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slice_type = /obj/item/food/breadslice/corn
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/corn
	name = "玉米面包片"
	desc = "一块酥脆的牛仔风味玉米面包。心满意足地吃吧。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread_slice"
	foodtypes = GRAIN
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	crafting_complexity = FOOD_COMPLEXITY_2

//Sweets
/obj/item/food/moth_cheese_cakes
	name = "\improper 奶酪球" //ælo = cheese, rölen = balls
	desc = "奶酪球是蛾人的传统甜点，用软奶酪、糖粉和面粉揉成球，裹糊后油炸。常配巧克力酱或蜂蜜，有时两样都加！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_cheese_cakes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("cheesecake" = 1, "chocolate" = 1, "honey" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/mothmallow
	name = "蛾式棉花糖盘"
	desc = "轻盈蓬松的纯素棉花糖，带香草与朗姆酒风味，顶上覆盖柔软的巧克力。蛾人称它为云朵方糖。" //höllflöf = cloud (höll = wind, flöf = cotton), starkken = squares
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_tray"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 20,
	)
	tastes = list("vanilla" = 1, "clouds" = 1, "chocolate" = 1)
	foodtypes = VEGETABLES | SUGAR
	slice_type = /obj/item/food/cakeslice/mothmallow
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/mothmallow
	name = "蛾式棉花糖"
	desc = "蓬松的快乐小云朵——颜色莫名很像蛾人。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("vanilla" = 1, "clouds" = 1, "chocolate" = 1)
	foodtypes = VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

//misc food
/obj/item/food/bubblegum/wake_up
	name = "提神口香糖"
	desc = "一条弹韧的口香糖，上面印着蛾人游牧船队的徽记。"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("herbs" = 1)
	color = "#567D46"

/obj/item/food/spacers_sidekick
	name = "\improper 太空旅伴薄荷糖"
	desc = "太空旅伴：好友相伴，呼吸畅快！"
	icon_state = "spacers_sidekick"
	trash_type = /obj/item/trash/spacers_sidekick
	food_reagents = list(
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/medicine/salbutamol = 1,
	)
	tastes = list("strong mint" = 1)
	junkiness = 15
	foodtypes = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
