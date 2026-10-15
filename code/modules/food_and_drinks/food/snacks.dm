////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/food/candy
	name = "糖果"
	desc = "牛轧糖，爱不爱吃随你。"
	icon_state = "candy"
	inhand_icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("candy" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/bronx
	name = "\improper 南布朗克斯天堂糖棒"
	desc = "保证减重！焦糖摩卡口味。后面还写着什么产品食用说明……"
	icon_state = "bronx"
	inhand_icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/yuck = 1,
	)
	junkiness = 10
	bite_consumption = 10
	tastes = list("candy" = 5, "weight loss" = 4, "insect larva" = 1)
	foodtypes = JUNKFOOD | RAW | BUGS
	custom_price = 80
	w_class = WEIGHT_CLASS_TINY
	var/revelation = FALSE

/obj/item/food/candy/bronx/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, on_consume = CALLBACK(src, PROC_REF(on_consume)))

/obj/item/food/candy/bronx/proc/on_consume(mob/living/eater)
	if(ishuman(eater))
		var/mob/living/carbon/human/carl = eater
		var/datum/disease/disease = new /datum/disease/parasite()
		carl.ForceContractDisease(disease, make_copy = FALSE, del_on_fail = TRUE)

/obj/item/food/candy/bronx/examine(mob/user)
	. = ..()
	if(!revelation && !isobserver(user))
		. += span_notice("天啊，你该去检查一下眼睛。再仔细看看……")

		name = "\improper 南布朗克斯寄生虫糖棒"
		desc = "保证减重！焦糖摩卡口味！警告：本产品不适合人类食用。含活体毒叶甲。"
		revelation = TRUE

/obj/item/food/sosjerky
	name = "\improper 胆小鬼私藏牛肉干"
	icon_state = "sosjerky"
	desc = "用最优质的太空牛肉制成的牛肉干。"
	trash_type = /obj/item/trash/sosjerky
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/salt = 2,
	)
	junkiness = 25
	tastes = list("dried meat" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = JUNKFOOD | MEAT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sosjerky/healthy
	name = "自制牛肉干"
	desc = "用最优质的太空牛肉自制的牛肉干。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	junkiness = 0

/obj/item/food/chips
	name = "薯片"
	desc = "赖克指挥官的什么鬼薯片。"
	icon_state = "chips"
	inhand_icon_state = "chips"
	trash_type = /obj/item/trash/chips
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/salt = 1,
	)
	junkiness = 20
	tastes = list("salt" = 1, "crisps" = 1)
	foodtypes = VEGETABLES|JUNKFOOD|FRIED
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chips/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/chips/shrimp
	name = "虾片"
	desc = "油炸虾味脆片。海鲜行家最爱的垃圾食品！"
	icon_state = "shrimp_chips"
	trash_type = /obj/item/trash/shrimp_chips
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("salt" = 1, "shrimp" = 1)
	foodtypes = JUNKFOOD | FRIED | SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/no_raisin
	name = "\improper 没道理葡萄干"
	icon_state = "4no_raisins"
	desc = "宇宙最棒的葡萄干。谁也说不清为什么。"
	trash_type = /obj/item/trash/raisins
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	junkiness = 25
	tastes = list("dried raisins" = 1)
	foodtypes = JUNKFOOD | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_CREW * 0.7
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/no_raisin/healthy
	name = "自制葡萄干"
	desc = "自制葡萄干，整个太空里最棒的。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	junkiness = 0
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spacetwinkie
	name = "\improper 太空夹心蛋糕"
	icon_state = "space_twinkie"
	desc = "保证比你活得久。"
	food_reagents = list(/datum/reagent/consumable/sugar = 4)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_LOWER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/candy_trash
	name = "糖果香烟烟蒂"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "candybum"
	desc = "抽完糖果香烟剩下的烟蒂。可以吃！"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
	)
	junkiness = 10 //powergame trash food by buying candy cigs in bulk and eating them when they extinguish
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/candy_trash/nicotine
	desc = "抽完糖果香烟剩下的烟蒂。闻起来像尼古丁……？"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
		/datum/reagent/drug/nicotine = 1,
	)

/obj/item/food/cheesiehonkers
	name = "\improper HONK奶酪脆"
	desc = "一口大小的奶酪零食，让你的嘴里到处都是HONK声。"
	icon_state = "cheesie_honkers"
	trash_type = /obj/item/trash/cheesie
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("cheese" = 5, "crisps" = 2)
	foodtypes = JUNKFOOD | DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/syndicake
	name = "\improper 辛迪蛋糕"
	icon_state = "syndi_cakes"
	desc = "极其湿润的小蛋糕，即使被核过，味道也一样好。"
	trash_type = /obj/item/trash/syndi_cakes
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/doctor_delight = 5,
	)
	tastes = list("sweetness" = 3, "cake" = 1)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/energybar
	name = "\improper 高功率能量棒"
	icon_state = "energybar"
	desc = "劲头十足的能量棒。如果你不是以太人，最好别吃。"
	trash_type = /obj/item/trash/energybar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/liquidelectricity = 3,
	)
	tastes = list("pure electricity" = 3, "fitness" = 2)
	foodtypes = TOXIC
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/nutrient_bar
	name = "\improper 营养棒"
	icon_state = "nutrientbar"
	desc = "用油蔓灌木浆制成的高营养棒，加的糖刚够让它不至于难吃透顶。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/sugar = 3,
	)
	tastes = list("cardboard" = 3, "sugar" = 2)
	foodtypes = VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/peanuts
	name = "\improper 看台牌花生"
	desc = "怒气无药可救之人的最爱。"
	icon_state = "peanuts"
	trash_type = /obj/item/trash/peanuts
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("peanuts" = 4, "anger" = 1)
	foodtypes = JUNKFOOD | NUTS
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_CREW * 0.8 //nuts are expensive in real life, and this is the best food in the vendor.
	junkiness = 10 //less junky than other options, since peanuts are a decently healthy snack option
	w_class = WEIGHT_CLASS_SMALL
	var/safe_for_consumption = TRUE

/obj/item/food/peanuts/grind_results()
	return list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)

/obj/item/food/peanuts/salted
	name = "\improper 看台牌盐库花生"
	desc = "味道很咸。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("peanuts" = 3, "salt" = 1, "high blood pressure" = 1)

/obj/item/food/peanuts/wasabi
	name = "\improper 看台牌狂怒芥末花生"
	desc = "所有花生口味中最暴躁的一款。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("peanuts" = 3, "wasabi" = 1, "rage" = 1)

/obj/item/food/peanuts/honey_roasted
	name = "\improper 看台牌删甜花生"
	desc = "明明是甜食，却苦得出奇。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("peanuts" = 3, "honey" = 1, "bitterness" = 1)

/obj/item/food/peanuts/barbecue
	name = "\improper 看台牌死定烧烤花生"
	desc = "有烟未必有火，有时只是烧烤酱。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list("peanuts" = 3, "bbq sauce" = 1, "arguments" = 1)

/obj/item/food/peanuts/ban_appeal
	name = "\improper 看台牌禁果申诉混合花生"
	desc = "一款命运多舛的混合果仁，已被六个星区禁售。每年申请解禁都遭拒，并非因为苹果有毒，而是因为它们总在逃避封禁。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/toxin/cyanide = 1,
	) //uses dried poison apples
	tastes = list("peanuts" = 3, "apples" = 1, "regret" = 1)
	safe_for_consumption = FALSE

/obj/item/food/peanuts/random
	name = "\improper 看台牌百味花生"
	desc = "你会抽到什么口味？"
	icon_state = "peanuts"
	safe_for_consumption = FALSE

GLOBAL_LIST_INIT(safe_peanut_types, populate_safe_peanut_types())

/proc/populate_safe_peanut_types()
	. = list()
	for(var/obj/item/food/peanuts/peanut_type as anything in subtypesof(/obj/item/food/peanuts))
		if(!initial(peanut_type.safe_for_consumption))
			continue
		. += peanut_type

/obj/item/food/peanuts/random/Initialize(mapload)
	// Generate a sample p
	var/peanut_type = pick(GLOB.safe_peanut_types)
	var/obj/item/food/sample = new peanut_type(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/cnds
	name = "\improper C&D糖豆"
	desc = "出于法律原因，我们不能保证它不会融化在你手里。"
	icon_state = "cnds"
	trash_type = /obj/item/trash/cnds
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("chocolate candy" = 3)
	junkiness = 25
	foodtypes = JUNKFOOD|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cnds/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正让[src]在自己手里融化！看起来是想自杀！"))
	return TOXLOSS

/obj/item/food/cnds/caramel
	name = "焦糖C&D糖豆"
	desc = "塞满甜腻的焦糖，是糖尿病患者最可怕的噩梦。"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("chocolate candy" = 2, "caramel" = 1)

/obj/item/food/cnds/pretzel
	name = "椒盐卷饼C&D糖豆"
	desc = "搭配你最爱的啤酒，别有一番美味。"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("chocolate candy" = 2, "pretzel" = 1)
	foodtypes = JUNKFOOD | GRAIN | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate

/obj/item/food/cnds/peanut_butter
	name = "花生酱C&D糖豆"
	desc = "深受小孩子和外星人的喜爱。"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("chocolate candy" = 2, "peanut butter" = 1)

/obj/item/food/cnds/banana_honk
	name = "香蕉HONK C&D糖豆"
	desc = "各地小丑的官方指定糖果。HONK HONK！"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("chocolate candy" = 2, "banana" = 1)

/obj/item/food/cnds/random
	name = "神秘夹心C&D糖豆"
	desc = "内含四种美味口味之一！"

/obj/item/food/cnds/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cnds) - /obj/item/food/cnds/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/pistachios
	name = "\improper 甜心牌开心果"
	desc = "一包甜心牌优质开心果。"
	icon_state = "pistachio"
	trash_type = /obj/item/trash/pistachios
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //a healthy but expensive snack
	tastes = list("pistachios" = 4, "subtle sweetness" = 1)
	foodtypes = JUNKFOOD | NUTS
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_CREW//pistachios are even more expensive.
	junkiness = 10 //on par with peanuts
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pistachios/grind_results()
	return list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)

/obj/item/food/semki
	name = "\improper 嗑瓜籽牌葵花籽"
	desc = "一包烤葵花籽，深受太空俄罗斯人和老奶奶们喜爱。"
	icon_state = "semki"
	trash_type = /obj/item/trash/semki
	food_reagents = list(
		/datum/reagent/consumable/nutriment/fat/oil = 1,
		/datum/reagent/consumable/salt = 6,
	) //1 cornoil is equal to 1.33 nutriment
	tastes = list("sunflowers" = 5)
	foodtypes = JUNKFOOD | NUTS
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_LOWER * 0.4 //sunflowers are cheap in real life.
	bite_consumption = 1
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/semki/healthy
	name = "烤葵花籽"
	desc = "纸杯装的自制烤葵花籽。健康又顶饱，适合边嗑边看人来人往。"
	icon_state = "sunseeds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/iron = 2,
	)
	junkiness = 5 //Homemade or not, sunflower seets are always kinda junky
	foodtypes = JUNKFOOD | NUTS
	trash_type = /obj/item/trash/semki/healthy
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cornchips
	name = "\improper 波力脆玉米片"
	desc = "三角形玉米片。味道似乎有点淡，但配上蘸酱应该不错。"
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
	)
	junkiness = 20
	custom_price = PAYCHECK_LOWER * 0.8  //we are filled to the brim with flavor
	tastes = list("fried corn" = 1)
	foodtypes = JUNKFOOD | FRIED | GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cornchips/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/cornchips/blue
	name = "\improper 波力脆极酷牧场玉米片"
	desc = "先有牧场味，还是先有酷爽牧场味？"
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/yoghurt = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("fried corn" = 1, "coolest ranch" = 3)

/obj/item/food/cornchips/green
	name = "\improper 波力脆太空莎莎玉米片"
	desc = "莎莎酱已经烤进去了，无需另配蘸酱。"
	icon_state = "boritosgreen"
	trash_type = /obj/item/trash/boritos/green
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/blackpepper = 1,
	)
	tastes = list("fried corn" = 1, "spess salsa" = 3)

/obj/item/food/cornchips/red
	name = "\improper 波力脆墨西哥奶酪玉米片"
	desc = "出了名地能让你碰过的一切都沾上橙色奶酪粉。"
	icon_state = "boritosred"
	trash_type = /obj/item/trash/boritos/red
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/cornmeal = 1,
	)
	tastes = list("fried corn" = 1, "nacho cheese" = 3)

/obj/item/food/cornchips/purple
	name = "\improper 波力脆香辣甜椒玉米片"
	desc = "唯一像正经墨西哥玉米片那样真有辣味的口味。"
	icon_state = "boritospurple"
	trash_type = /obj/item/trash/boritos/purple
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("fried corn" = 1, "spicy & sweet chili" = 3)

/obj/item/food/cornchips/random
	name = "\improper 波力脆玉米片"
	desc = "内含四种美味口味之一！"

/obj/item/food/cornchips/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cornchips) - /obj/item/food/cornchips/random)

	var/obj/item/food/sample = new random_flavour(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	icon_state = sample.icon_state
	trash_type = sample.trash_type
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/hot_shots
	name = "\improper 火热投手"
	desc = "看棒球的终极零食。一旦开吃，就很难停下！"
	icon_state = "hot_shots"
	trash_type = /obj/item/trash/hot_shots
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("popcorn" = 1, "caramel" = 1, "peanuts" = 1)
	foodtypes = JUNKFOOD | SUGAR | NUTS
	food_flags = FOOD_FINGER_FOOD
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hot_shots/grind_results()
	return list(/datum/reagent/consumable/nutriment/fat/oil = 3, /datum/reagent/consumable/caramel = 2)

/obj/item/food/sticko
	name = "\improper 棒棒脆经典味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款是经典原味，有人说也是最好吃的：饼干加牛奶巧克力。"
	icon_state = "sticko_classic"
	trash_type = /obj/item/trash/sticko
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("biscuit" = 1, "chocolate" = 1)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sticko/matcha
	name = "\improper 棒棒脆抹茶味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款裹着抹茶味白巧克力，唤起传统风味。"
	icon_state = "sticko_matcha"
	trash_type = /obj/item/trash/sticko/matcha
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("biscuit" = 1, "matcha" = 1)

/obj/item/food/sticko/nutty
	name = "\improper 棒棒脆坚果味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款裹着花生酱味巧克力，多了一份坚果香。"
	icon_state = "sticko_nutty"
	trash_type = /obj/item/trash/sticko/nutty
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("biscuit" = 1, "peanut butter" = 1)
	foodtypes = JUNKFOOD | GRAIN | NUTS | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate

/obj/item/food/sticko/pineapple
	name = "\improper 棒棒脆菠萝味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款裹着菠萝味白巧克力，专为菠萝迷准备。"
	icon_state = "sticko_pineapple"
	trash_type = /obj/item/trash/sticko/pineapple
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("biscuit" = 1, "pineapple" = 1)
	foodtypes = JUNKFOOD | GRAIN | PINEAPPLE | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate

/obj/item/food/sticko/yuyake
	name = "\improper 棒棒脆夕烧味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款裹着夕烧风味白巧克力，蜜瓜味清新可口。"
	icon_state = "sticko_yuyake"
	trash_type = /obj/item/trash/sticko/yuyake
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("biscuit" = 1, "melon" = 1)

/obj/item/food/sticko/random
	name = "\improper 棒棒脆神秘味"
	desc = "老少皆宜的经典零食——棒棒脆，原创巧克力涂层饼干棒！这款套着不透明纸包装，把真正的口味藏了起来……"

/obj/item/food/sticko/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/sticko) - /obj/item/food/sticko/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/shok_roks
	name = "\improper 电跳石——雷云棉糖味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味。这袋是雷云棉糖味——像棉花糖，不过带电！"
	icon_state = "shok_roks_candy"
	trash_type = /obj/item/trash/shok_roks
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity = 2,
		/datum/reagent/consumable/sugar = 3
	)
	food_flags = FOOD_FINGER_FOOD
	tastes = list("sugar" = 1, "lightning" = 1)

/obj/item/food/shok_roks/citrus
	name = "\improper 电跳石——卷云柑橘味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味。这袋是卷云柑橘味——满满柑橘香，半点柑橘提取物也没有。"
	icon_state = "shok_roks_citrus"
	trash_type = /obj/item/trash/shok_roks/citrus
	tastes = list("citrus" = 1, "lightning" = 1)

/obj/item/food/shok_roks/berry
	name = "\improper 电跳石——莓果风暴味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味。这袋是莓果风暴味——满满一袋说不清是什么莓的酸味！"
	icon_state = "shok_roks_berry"
	trash_type = /obj/item/trash/shok_roks/berry
	tastes = list("sour berry" = 1, "lightning" = 1)

/obj/item/food/shok_roks/tropical
	name = "\improper 电跳石——热带惊雷味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味。这袋是热带惊雷味——所有热带水果！全都有！"
	icon_state = "shok_roks_tropical"
	trash_type = /obj/item/trash/shok_roks/tropical
	tastes = list("tropical fruits" = 1, "lightning" = 1)

/obj/item/food/shok_roks/lanternfruit
	name = "\improper 电跳石——闪电灯笼果味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味。这袋是闪电灯笼果味——电跳石所有口味中唯一采用萌芽星原生水果的一款。"
	icon_state = "shok_roks_lanternfruit"
	trash_type = /obj/item/trash/shok_roks/lanternfruit
	tastes = list("sour pear" = 1, "lightning" = 1)

/obj/item/food/shok_roks/random
	name = "\improper 电跳石——神秘飓风味"
	desc = "听说过爆跳石？现在迎接电跳石吧，以太人专属跳跳糖！共有五种刺激口味，这袋里任意一种都有可能！"

/obj/item/food/shok_roks/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/shok_roks) - /obj/item/food/shok_roks/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()
