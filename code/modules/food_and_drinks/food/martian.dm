//Ingredients and Simple Dishes
/obj/item/food/kimchi
	name = "韩式泡菜"
	desc = "经典韩国菜的火星风味版本：切碎的卷心菜配上辣椒、昆布、鲣鱼和混合香料。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("spicy cabbage" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/inferno_kimchi
	name = "地狱火泡菜"
	desc = "普通泡菜无法满足你对疯狂辣味的渴望时，就让地狱火泡菜来接棒。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "inferno_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("very spicy cabbage" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/garlic_kimchi
	name = "蒜香泡菜"
	desc = "经典配方的新花样——泡菜和大蒜终于完美融合。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "garlic_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("spicy cabbage" = 1, "garlic" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi
	name = "鱼糜"
	desc = "一份尚未加工成形的鱼糜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "surimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/surimi/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/kamaboko)

/obj/item/food/kamaboko
	name = "蒲鉾鱼糕"
	desc = "日式加工鱼糕，常用于小吃和拉面。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kamaboko/Initialize(mapload)
	. = ..()
	var/design = pick("smiling", "spiral", "star", "sunrise")
	name = "[list("smiling" = "笑脸", "spiral" = "螺旋", "star" = "星星", "sunrise" = "日出")[design]]蒲鉾鱼糕"
	icon_state = "kamaboko_[design]"

/obj/item/food/kamaboko/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/kamaboko_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "切开")

/obj/item/food/kamaboko_slice
	name = "蒲鉾鱼糕切片"
	desc = "一片鱼糕。放进拉面里很不错。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sambal
	name = "参巴辣酱"
	desc = "源自印度尼西亚的香辣酱，广泛用于东南亚各地的料理。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sambal"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("chilli heat" = 1, "umami" = 1)
	foodtypes = VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/katsu_fillet
	name = "日式炸肉排"
	desc = "裹上面包糠油炸的肉排，可用于多种菜式。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2
	)
	tastes = list("meat" = 1, "breadcrumbs" = 1)
	foodtypes = MEAT|FRIED|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/rice_dough
	name = "米粉面团"
	desc = "用等量米粉和小麦粉制成的面团，风味独特。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "rice_dough"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rice_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/reispan, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/rice_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/rawnoodles, 6, 3 SECONDS, table_required = TRUE)

/obj/item/food/spaghetti/rawnoodles
	name = "鲜米面条"
	desc = "新鲜制作的米面条。记住，没有什么秘方。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_noodles"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/boilednoodles
	name = "熟米面条"
	desc = "现点现煮。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("rice" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/ramen_dry
	name = "干太空拉面"
	desc = "压缩脱水面条。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ramen"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("ramen" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/ramen_beef
	name = "牛肉太空拉面"
	desc = "热气腾腾的弹牙面条，滴着浓郁的人造牛肉汤。吃着让人安心，却又隐约带着化工味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_ramen"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("ramen" = 1, "beef" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan
	name = "米粉面包"
	desc = "米粉面包在亚洲已有数百年历史，不过如今这种面包更多让人想到火星——那里有限的耕地逼出了人们的巧思。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15
	)
	tastes = list("bread" = 10)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_TRASH
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/reispan/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/reispan, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/breadslice/reispan
	name = "米粉面包片"
	desc = "一片米粉面包，可用于制作火星风味三明治。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

// Fried Rice

/obj/item/food/salad/hurricane_rice
	name = "飓风炒饭"
	desc = "这道香辣饭食以印尼炒饭为灵感，出自火星远景城的夜市。名字源于独特的烹饪手法：翻炒时把米饭高高抛起，主要是因为顾客看着觉得特别酷。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hurricane_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "meat" = 1, "pineapple" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | PINEAPPLE | FRUIT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/bowled/hua_mulan_congee
	name = "\improper 花木兰粥"
	desc = "没人说得清，这碗用鸡蛋和培根摆出笑脸的米粥，为什么会以中国传说中的人物命名——\
		反正一直都这么叫。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hua_mulan_congee"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("bacon" = 1, "eggs" = 1)
	foodtypes = MEAT|GRAIN|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/ikareis
	name = "鱿墨辣饭"
	desc = "用鱿鱼墨汁、甜椒、洋葱、香肠和香辣可口的辣椒做成的辣味饭。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ikareis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 4
	)
	tastes = list("rice" = 1, "squid ink" = 1, "veggies" = 1, "sausage" = 1, "chilli heat" = 1)
	foodtypes = MEAT | GRAIN | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/hawaiian_fried_rice
	name = "\improper 夏威夷炒饭"
	desc = "这并非夏威夷传统菜，而是把夏威夷常见食材拼在一起的炒饭，包括火腿猪肉午餐肉丁，以及颇有争议的菠萝。传统派对菠萝该不该入饭争论不休。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hawaiian_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("rice" = 1, "pork" = 1, "pineapple" = 1, "soy sauce" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/ketchup_fried_rice
	name = "番茄酱炒饭"
	desc = "经典的日式暖心家常菜，由香肠、蔬菜、伍斯特酱和米饭做成——哦，当然还有番茄酱。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ketchup_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ketchup = 2,
	)
	tastes = list("rice" = 1, "sausage" = 1, "ketchup" = 1, "veggies" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/mediterranean_fried_rice
	name = "地中海炒饭"
	desc = "炒饭配方的奇特变奏：香草、奶酪、橄榄，当然还有肉丸。有点像意式烩饭和炒饭的结合体。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "mediterranean_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "cheese" = 1, "meatball" = 1, "olives" = 1, "herbs" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/egg_fried_rice
	name = "蛋炒饭"
	desc = "最简单的炒饭：米饭、鸡蛋、酱油。简单精妙，还能随心搭配。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "egg_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("rice" = 1, "egg" = 1, "soy sauce" = 1)
	foodtypes = MEAT | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/egg_fried_rice/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/salad/bibimbap
	name = "韩式拌饭"
	desc = "米饭配上各种浇头，盛在滚烫石碗里的韩国料理。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bibimbap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice" = 1, "spicy cabbage" = 1, "chilli heat" = 1, "egg" = 1, "meat" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/bibimbap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Noodles
/obj/item/food/salad/bulgogi_noodles
	name = "韩式烤肉面"
	desc = "韩式烤肉配面条！加入韩式辣椒酱，让辣味更上一层。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bulgogi_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("barbecue meat" = 1, "noodles" = 1, "chilli heat" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/yakisoba_katsu
	name = "炸肉排炒面"
	desc = "炒面上铺着裹面包糠油炸的肉排。虽然不太传统，但确实美味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "yakisoba_katsu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("fried noodles" = 1, "meat" = 1, "breadcrumbs" = 1, "veggies" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/martian_fried_noodles
	name = "\improper 火星炒面"
	desc = "来自红色星球的炒面。火星料理兼收各地文化，这道面也不例外——融合了马来、泰国、中国、韩国和日本菜的元素。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "martian_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("noodles" = 1, "meat" = 1, "nuts" = 1, "onion" = 1, "egg" = 1)
	foodtypes = GRAIN | NUTS | MEAT | VEGETABLES | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/simple_fried_noodles
	name = "简易炒面"
	desc = "简单又美味的炒面，最适合有创意的厨师发挥，做出自己想要的炒面。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "simple_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 6,
	)
	tastes = list("noodles" = 1, "soy sauce" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/salad/simple_fried_noodles/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Curry
/obj/item/food/salad/setagaya_curry //let me explain...
	name = "\improper 世田谷咖喱"
	desc = "这道咖喱因世田谷的一家咖啡馆而闻名，其繁复配方如今成了人类星域各地咖啡馆主严守的秘密。据说它的味道能滋养食客的灵魂，随你怎么理解。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "setagaya_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/medicine/omnizine = 5,
	)
	tastes = list("masterful curry" = 1, "rice" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|SUGAR|CHOCOLATE  //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5 //Extensive and secretly guarded. Was previously 2 and I thought it was pathetic.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

// Burgers and Sandwiches
/obj/item/food/burger/big_blue
	name = "\improper 大蓝汉堡"
	desc = "来自夏威夷最受欢迎汉堡店的原版大蓝汉堡，也是最棒的一款。兄弟，乘风破浪吧！" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "big_blue_burger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bun" = 1, "burger" = 2, "teriyaki onions" = 1, "cheese" = 1, "bacon" = 1, "pineapple" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //It's THE big blue, Baby!
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/chappy
	name = "\improper 午餐肉饼堡"
	desc = "午餐肉饼堡诞生于大蓝汉堡店厨房里的一夜畅饮，如今已成为大蓝菜单和全球夏威夷风味菜——至少是仿夏威夷风味菜——的常客。考虑到大酋长的大部分门店都在夏威夷，这道菜在那里走红也不足为奇。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chappy_patty"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("bun" = 1, "fried pork" = 2, "egg" = 1, "cheese" = 1, "ketchup" = 1)
	foodtypes =  MEAT|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/king_katsu_sandwich
	name = "\improper 炸肉排之王三明治"
	desc = "米粉面包里夹着酥脆炸肉排、培根、泡菜丝和沙拉的大三明治。堪称面包夹肉之王。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "king_katsu_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("meat" = 1, "bacon" = 1, "kimchi" = 1, "salad" = 1, "rice bread" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/marte_cubano_sandwich
	name = "\improper 火星古巴三明治"
	desc = "来自火星的融合料理，以经典古巴三明治为基础，根据当地能获取的食材和口味变化加以改良。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bacon" = 1, "pickles" = 1, "cheese" = 1, "rice bread" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_shiro_sandwich
	name = "\improper 小白三明治"
	desc = "经典火星三明治，以首位来自火星的地球政府总统命名。夹着煎蛋、韩式烤牛肉、泡菜沙拉，顶上再铺满马苏里拉奶酪。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("egg" = 1, "meat" = 1, "kimchi" = 1, "mozzarella" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/croque_martienne
	name = "火星热烤三明治"
	desc = "经典早餐三明治加上一抹果香。鸡蛋、五花肉、菠萝、奶酪。简单。经典。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "croque_martienne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("egg" = 1, "toast" = 1, "pork" = 1, "pineapple" = 1, "cheese" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|DAIRY|FRIED|PINEAPPLE|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/prospect_sunrise
	name = "\improper 远景日出三明治"
	desc = "火星第二经典的早餐三明治。煎蛋饼、培根、腌黄瓜与奶酪的绝妙组合。远景城的每家咖啡馆都有供应。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "prospect_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("egg" = 1, "toast" = 1, "bacon" = 1, "pickles" = 1, "cheese" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Snacks
/obj/item/food/takoyaki
	name = "章鱼烧"
	desc = "经典日本街头小吃，又称章鱼小丸子。用面糊裹住章鱼和洋葱煎制，再淋上咸鲜酱汁。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("octopus" = 1, "batter" = 1, "onion" = 1, "worcestershire sauce" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/russian
	name = "俄式章鱼烧"
	desc = "经典菜式的危险变种，是躲避警察时的完美掩护。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "russian_takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("octopus" = 1, "batter" = 1, "onion" = 1, "chilli heat" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/takoyaki/taco
	name = "塔可烧"
	desc = "来自火星最有创意的街头摊位：用塔可肉馅和玉米替代章鱼，用奶酪酱替代伍斯特酱的塔可烧。太好吃啦！"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tacoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("taco meat" = 1, "batter" = 1, "corn" = 1, "cheese" = 1)
	foodtypes = MEAT|GRAIN|FRIED|VEGETABLES|DAIRY|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Batter AND Cargo ingredients.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/okonomiyaki
	name = "御好烧"
	desc = "关西经典料理，是一种咸味煎饼，里面可以放……嗯，任何你想吃的东西。不过卷心菜、长山药、日式高汤基本不可少，同名的御好烧酱也是如此。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "okonomiyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("batter" = 1, "cabbage" = 1, "onion" = 1, "worcestershire sauce" = 1)
	foodtypes = GRAIN|FRIED|VEGETABLES|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo stuff and batter.

//hey, the name literally means "grilled how you like it", it'd be crazy to not make it customisable
/obj/item/food/okonomiyaki/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/brat_kimchi
	name = "烤肠泡菜"
	desc = "炒泡菜拌糖，再放上德式烤肠。在不拘传统的居酒屋很受欢迎。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "brat_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("spicy cabbage" = 1, "sausage" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/tonkatsuwurst
	name = "炸猪排酱烤肠"
	desc = "德国与日本烹饪文化的融合，将咖喱香肠与炸猪排酱搭在一起，熟悉又新鲜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tonkatsuwurst"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/worcestershire = 2,
	)
	tastes = list("sausage" = 1, "spicy sauce" = 1, "fries" = 1)
	foodtypes = MEAT|VEGETABLES|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Cargo ingredients and a few steps.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/kebab/ti_hoeh_koe
	name = "猪血糕串"
	desc = "猪血混合米饭煎炸，再撒上花生和香菜。这个味道……确实需要适应，不过台湾移民带来的这道小吃在远景城夜市很受欢迎。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ti_hoeh_koe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("blood" = 1, "nuts" = 1, "herbs" = 1)
	foodtypes = MEAT|FRIED|NUTS|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kitzushi
	name = "狐喜寿司"
	desc = "在火星狐人乃至更广泛的兽人社群中流行的稻荷寿司变种，在豆皮口袋里加入辣奶酪和辣椒混合馅，增添风味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kitzushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice" = 1, "tofu" = 1, "chilli cheese" = 1)
	foodtypes = GRAIN | FRIED | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/epok_epok
	name = "咖喱酥角"
	desc = "源自马来西亚的油炸酥皮小吃，内馅是咖喱鸡肉、土豆和一片水煮蛋，在旧金山是热门街头小吃。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "epok_epok"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("curry" = 1, "egg" = 1, "pastry" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | FRIED | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/roti_john
	name = "约翰煎面包"
	desc = "经典马来西亚小吃，把面包放在肉、鸡蛋和洋葱的混合物中煎制，成品介于法式吐司和煎蛋饼之间。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "roti_john"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("bread" = 1, "egg" = 1, "meat" = 1, "onion" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/izakaya_fries
	name = "居酒屋薯条"
	desc = "连续两个世纪都是新大阪最受欢迎的薯条——全靠红湾调味料、拌饭料和蛋黄酱的巧妙搭配。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "izakaya_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "mars" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Extra complexity due to cargo ingredient.

/obj/item/food/kurry_ok_subsando
	name = "咖喱OK潜艇三明治"
	desc = "咖喱面包盅遇上火星人的巧思，变成了咖喱OK潜艇三明治，薯条与炸肉排咖喱在其中完美相融。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kurry_ok_subsando"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bread" = 1, "spicy fries" = 1, "mayonnaise" = 1, "curry" = 1, "meat" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/loco_moco
	name = "夏威夷肉饼盖饭"
	desc = "夏威夷的简单经典料理，管饱、美味又实惠。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "loco_moco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("rice" = 1, "burger" = 1, "gravy" = 1, "egg" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRIED|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/wild_duck_fries
	name = "野鸭薯条"
	desc = "配有鸭肉丝、番茄酱、蛋黄酱和红湾调味料的薯条。火星经典街头小吃，不过人们更常把它与快呱联系起来——那是火星最受欢迎、其实也是唯一的鸭子主题快餐连锁店。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "wild_duck_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "duck" = 1, "ketchup" = 1, "mayo" = 1, "spicy seasoning" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Requires a complex 3 as an ingredient.
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/little_hawaii_hotdog
	name = "\improper 小夏威夷热狗"
	desc = "檀香山大道的友好摊贩带来了小夏威夷热狗——既有热带风情，又让人长胖！"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "little_hawaii_hotdog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("sausage" = 1, "pineapple" = 1, "onion" = 1, "teriyaki" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_price = PAYCHECK_CREW * 1.2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salt_chilli_fries
	name = "椒盐薯条"
	desc = "简单的名字道不尽它的美味——盐和辣椒固然重要，洋葱、生姜和大蒜才是真正的风味功臣。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("fries" = 1, "garlic" = 1, "ginger" = 1, "numbing heat" = 1, "salt" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_octopus
	name = "烤章鱼触手"
	desc = "简单的海鲜料理，凡是吃章鱼的地方都很常见。火星人喜欢搭配红湾调味料。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "grilled_octopus"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/char = 2)
	tastes = list("octopus" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/steak_croquette
	name = "牛排可乐饼"
	desc = "好家伙，把牛排块塞进可乐饼里。准是乡下人的做法。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "steak_croquette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("steak" = 1, "potato" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/chapsilog
	name = "午餐肉煎蛋蒜香饭"
	desc = "传统菲律宾风味的煎蛋饭，由蒜香炒饭、煎蛋和火腿猪肉午餐肉片组成。简单却管饱的早餐。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapsilog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("ham" = 1, "garlic rice" = 1, "egg" = 1)
	foodtypes = MEAT|GRAIN|FRIED|BREAKFAST|VEGETABLES|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/chap_hash
	name = "午餐肉土豆杂烩"
	desc = "把火腿猪肉午餐肉、洋葱、甜椒和土豆混在一起会得到什么？当然是午餐肉土豆杂烩！再加点红湾调味料，就是一顿美味早餐。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chap_hash"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3,
	)
	tastes = list("ham" = 1, "onion" = 1, "pepper" = 1, "potato" = 1)
	foodtypes = MEAT | VEGETABLES | BREAKFAST | EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/agedashi_tofu
	name = "日式炸豆腐"
	desc = "酥脆炸豆腐浸在鲜美高汤中，是居酒屋的常见菜。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "agedashi_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("umami broth" = 1, "tofu" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

// Curries and Stews
/obj/item/food/salad/po_kok_gai
	name = "葡国鸡"
	desc = "名字意为“葡萄牙式鸡肉”，却并非葡萄牙本土菜，而是葡萄牙殖民历史中诞生的澳门经典料理。鸡肉浸在“葡汁”中，那是一种以椰奶为底的温和咖喱。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "po_kok_gai"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("chicken" = 1, "coconut" = 1, "curry" = 1)
	foodtypes = MEAT|GRAIN|FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/huoxing_tofu
	name = "\improper 火星豆腐"
	desc = "麻婆豆腐的改良版，在火星美食圣地远景城声名鹊起。如果眯起眼仔细看，它甚至有点像火星。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "huoxing_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("meat" = 1, "chilli heat" = 1, "tofu" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/feizhou_ji
	name = "非洲鸡"
	desc = "被视为非洲辣椒烤鸡的澳门变种。无论用中文、葡萄牙语，还是你兴致所至换成英语，名字说的都是“非洲鸡”。这道菜在澳门很受欢迎，也随着澳门移民的涌入在旧金山流行起来。" // DARKPACK EDIT CHANGE - not satisfied with this one
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "feizhou_ji"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("chicken" = 1, "chilli heat" = 1, "vinegar" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/galinha_de_cabidela
	name = "葡式鸡血饭"
	desc = "原是葡萄牙菜，传统上在葡萄牙用鸡肉、在澳门用鸭肉制作。受欧洲文化影响，最终是鸡肉版在火星占了上风。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "galinha_de_cabidela"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("chicken" = 1, "iron" = 1, "vinegar" = 1, "rice" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/salad/katsu_curry
	name = "炸肉排咖喱"
	desc = "裹面包糠油炸的肉排，淋上咖喱酱，铺在米饭上。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("curry" = 1, "meat" = 1, "breadcrumbs" = 1, "rice" = 1)
	foodtypes = MEAT|GRAIN|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/beef_bowl
	name = "牛肉盖饭"
	desc = "炖牛肉、洋葱与日式高汤的美味组合，浇在米饭上。常见配料有腌姜、辣椒粉和煎蛋。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "beef_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("beef" = 25, "onion" = 25, "chili heat" = 15, "rice" = 34, "soul" = 1) //I pour my soul into this bowl
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/salad/salt_chilli_bowl
	name = "椒盐章鱼饭"
	desc = "以日式盖饭传统为灵感，这道天妇罗盖饭的香辣变种掀起了席卷火星的美食热潮。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("seafood" = 1, "rice" = 1, "garlic" = 1, "ginger" = 1, "numbing heat" = 1, "salt" = 1)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //A few Cargo ingredients

/obj/item/food/salad/kansai_bowl
	name = "\improper 关西饭"
	desc = "又称木叶盖饭，是关西地区的典型盖饭，把蒲鉾鱼糕、鸡蛋和洋葱盖在米饭上。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kansai_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("seafood" = 1, "rice" = 1, "egg" = 1, "onion" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/eigamudo_curry //curry is meant to be really spicy or kinda mild, this just stinks!
	name = "\improper 怪味咖喱"
	desc = "用乱七八糟的食材做成的莫名其妙的咖喱。世上大概总有人觉得好吃——不过要找到这种人，祝你好运。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "eigamudo_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutraslop = 8,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/toxin/slimejelly = 4,
	)
	tastes = list("grit" = 1, "slime" = 1, "gristle" = 1, "rice" = 1, "Mystery Food X" = 1)
	foodtypes = VEGETABLES|GRAIN|FRUIT|SEAFOOD|GROSS|TOXIC
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Entrees
/obj/item/food/cilbir
	name = "土耳其酸奶蛋"
	desc = "鸡蛋放在咸味酸奶底上，再淋上辣油。这道土耳其菜随德国的土耳其裔移民来到火星，从此成了早餐常客。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cilbir"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("yoghurt" = 1, "garlic" = 1, "lemon" = 1, "egg" = 1, "chilli heat" = 1)
	foodtypes = MEAT|VEGETABLES|DAIRY|FRIED|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peking_duck_crepes
	name = "\improper 橙香北京烤鸭薄饼"
	desc = "汇聚北京与巴黎料理之长，做成酸香开胃、咸鲜可口的一餐。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "peking_duck_crepes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/orangejuice = 4,
	)
	tastes = list("meat" = 1, "crepes" = 1, "orange" = 1)
	foodtypes = MEAT|GRAIN|FRUIT|SUGAR|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Desserts
/obj/item/food/cake/spekkoek
	name = "神馔草千层蛋糕"
	desc = "由荷兰和印度尼西亚移民带到火星，是红色星球常见的节日蛋糕，常作为传统印尼米饭宴的一部分。远离地球的深空难觅斑斓叶，因此只能用普通神馔草调味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 15
	)
	tastes = list("winter spices" = 2, "ambrosia vulgaris" = 2, "cake" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/spekkoek/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/cakeslice/spekkoek, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/cakeslice/spekkoek
	name = "神馔草千层蛋糕切片"
	desc = "一片神馔草千层蛋糕。如果你来自火星，它也许会勾起你的思乡之情。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek_slice"
	tastes = list("winter spices" = 2, "ambrosia vulgaris" = 2, "cake" = 5)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/pineapple_foster
	name = "火焰菠萝"
	desc = "经典甜点的经典火星改版，香热甜美，火灾风险仅为轻度到中度。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_foster"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
		/datum/reagent/consumable/pineapplejuice = 2,
		/datum/reagent/consumable/milk = 4
	)
	tastes = list("pineapple" = 1, "vanilla" = 1, "caramel" = 1, "ice cream" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR|PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pastel_de_nata
	name = "葡式蛋挞"
	desc = "最初由葡萄牙修士创制，随葡萄牙殖民帝国传播到世界各地，包括澳门。后来又随港澳TID的移民，从澳门来到火星。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pastel_de_nata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("custard" = 1, "vanilla" = 1, "sweet pastry" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/boh_loh_yah
	name = "菠萝油"
	desc = "这种香港点心虽然叫“菠萝包”，却根本不含菠萝，令人困惑。它其实是夹着黄油、外皮类似糖曲奇的面包。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "boh_loh_yah"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("cookie" = 1, "butter" = 1)
	foodtypes = DAIRY | GRAIN | PINEAPPLE //it's funny
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/banana_fritter
	name = "炸香蕉"
	desc = "在东南亚海岛地区随处可见的甜点，名字五花八门，做法却大同小异——香蕉裹上面糊，再油炸。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "banana_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("banana" = 1, "batter" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //Fried goodness, oil scawy.

/obj/item/food/pineapple_fritter
	name = "炸菠萝"
	desc = "和近亲炸香蕉一样，这是种热门小吃，不过菠萝那种出了名的“爱者深爱、厌者深恶”的味道，多少拖了后腿。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("pineapple" = 1, "batter" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/kasei_dango
	name = "火星团子"
	desc = "用石榴糖浆和橙子调味的日式团子，看起来像火星，吃起来是甜点，三个串一签。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kasei_dango"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/orangejuice = 3,
		/datum/reagent/consumable/grenadine = 3
	)
	tastes = list("pomegranate" = 1, "orange" = 1)
	foodtypes = FRUIT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Frozen
/obj/item/food/pb_ice_cream_mochi
	name = "花生酱冰淇淋麻薯"
	desc = "远景城阿拉伯街夜市的经典甜点，以花生酱味冰淇淋为主要馅料，再按台湾传统裹上花生碎。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pb_ice_cream_mochi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 4,
		/datum/reagent/consumable/milk = 2,
	)
	tastes = list("peanut butter" = 1, "mochi" = 1)
	foodtypes = NUTS | GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/pineapple_pop
	name = "冰冻菠萝棒"
	desc = "插在棒子上的冰冻菠萝，稍微蘸了点黑巧克力。" // DARKPACK EDIT CHANGE
	overlay_state = "pineapple_pop"
	food_reagents = list(
		/datum/reagent/consumable/pineapplejuice = 4,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cold pineapple" = 1, "chocolate" = 1)
	foodtypes = SUGAR|FRUIT|PINEAPPLE|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/sea_salt
	name = "海盐雪糕"
	desc = "天蓝色的雪糕，只选用最上等的进口海盐调味。咸的……不，是甜的！"
	overlay_state = "sea_salt_pop"
	food_reagents = list(
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("salt" = 1, "sweet" = 1)
	foodtypes = SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

// topsicles, also known as tofu popsicles
/obj/item/food/popsicle/topsicle
	name = "浆果顶味冰棍"
	desc = "把豆腐和浆果汁搅打细腻后冷冻而成的冰点。据说是熊的最爱，可这完全说不通……"
	overlay_state = "topsicle_berry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/berryjuice = 4
	)
	tastes = list("berry" = 1, "tofu" = 1)
	foodtypes = FRUIT|SUGAR|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/popsicle/topsicle/banana
	name = "香蕉顶味冰棍"
	desc = "把豆腐和香蕉汁搅打细腻后冷冻而成的冰点，在日本乡村的夏天很受欢迎。"
	overlay_state = "topsicle_banana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/banana = 4
	)
	tastes = list("banana" = 1, "tofu" = 1)

/obj/item/food/popsicle/topsicle/pineapple
	name = "菠萝顶味冰棍"
	desc = "把豆腐和菠萝汁搅打细腻后冷冻而成的冰点。电视同款。"
	overlay_state = "topsicle_pineapple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/pineapplejuice = 4
	)
	foodtypes = FRUIT|SUGAR|VEGETABLES|PINEAPPLE
	tastes = list("pineapple" = 1, "tofu" = 1)

// Ballpark Food
/obj/item/food/plasma_dog_supreme
	name = "\improper 至尊等离子热狗"
	desc = "新大阪啄木鸟队主场赛博太阳球场的招牌小吃：球场热狗配参巴辣酱、日式高汤烤洋葱和菠萝青柠莎莎酱。你懂的，就是火星人喜欢的那种浓烈风味。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "plasma_dog_supreme"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("sausage" = 1, "relish" = 1, "onion" = 1, "fruity salsa" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|FRUIT|PINEAPPLE|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4 //Uses Sambal
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	custom_price = PAYCHECK_CREW * 2

/obj/item/food/frickles
	name = "炸腌黄瓜"
	desc = "香辣油炸腌黄瓜条？这么大胆的组合肯定只会来自一个地方——美国棒球场？其实不一定，不过在那里确实很受欢迎。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "frickles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("frickles" = 1)
	foodtypes = VEGETABLES|GRAIN|FRIED|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3 //batter and cargo stuff.

/obj/item/food/raw_ballpark_pretzel
	name = "生球场椒盐卷饼"
	desc = "扭成结状的面团，准备好拿去烘烤了，或者放铁板上煎？"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("bread" = 1, "salt" = 1)
	foodtypes = GRAIN | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_ballpark_pretzel/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/raw_ballpark_pretzel/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ballpark_pretzel
	name = "球场椒盐卷饼"
	desc = "经典德国面包，经美国帝国主义之手，变成了比赛日小吃。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("bread" = 1, "salt" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/raw_ballpark_tsukune
	name = "生球场日式鸡肉丸串"
	desc = "串在签子上的生鸡肉丸，准备上铁板煎成美味小吃。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("raw chicken" = 7, "salmonella" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/kebab/raw_ballpark_tsukune/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/kebab/ballpark_tsukune, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/kebab/ballpark_tsukune
	name = "球场日式鸡肉丸串"
	desc = "蘸着咸甜烧鸟酱的鸡肉丸串，日本棒球场的常见小吃。" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("chicken" = 1, "umami sauce" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

// Ethereal-suitable cross-culture food
/*	Ethereals are, as part of the uplifting process, considered as citizens of the Terran Federation.
	For this reason, a lot of ethereals have chosen to move throughout human space, settling on various planets to a mixed reception.
	Mars is no exception to this rule, where the ethereal population has been more welcomed than most, due to Mars' more cosmopolitan past.
	Here, the ethereals have developed a distinct culture, neither that of their homeland nor that of Mars, and with that a distinct cuisine.
*/

// Pickled Voltvine
/obj/item/food/pickled_voltvine
	name = "腌电藤"
	desc = "萌芽星的传统料理，当地称为希努沙舒鲁克。在火星腌菜大师手中焕发新生，与腌姜和韩式泡菜并列腌菜圣殿——至少得先充分放电才行。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pickled_voltvine"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("sour radish" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2 //If it comes straight from cargo, should be worth paying for.

// 24-Volt Energy
/obj/item/food/volt_fish
	name = "24伏鱼"
	desc = "有人可能会质疑24伏鱼。毕竟，用电光蓝色的超酸能量饮料煮鱼，看起来实在糟糕，吃起来也确实糟糕。那火星以太人为什么喜欢它呢？" //beats the hell out of me
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "volt_fish"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("fish" = 1, "sour pear" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// Sprout Bowl
/obj/item/food/salad/sprout_bowl
	name = "\improper 萌芽星盖饭"
	desc = "以以太人母星命名的米饭料理，借鉴日式盖饭传统，却舍弃了常见浇头，改用刺身级鱼肉和腌电藤。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sprout_bowl"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1, "sour radish" = 1, "rice" = 1)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
