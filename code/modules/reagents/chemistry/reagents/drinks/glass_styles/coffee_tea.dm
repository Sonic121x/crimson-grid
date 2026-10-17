// Coffees and Teas

/datum/glass_style/drinking_glass/coffee
	required_drink_type = /datum/reagent/consumable/coffee
	name = "杯装咖啡"
	desc = "别摔了，否则滚烫的咖啡和玻璃碎片会溅得到处都是。"

/datum/glass_style/drinking_glass/tea
	required_drink_type = /datum/reagent/consumable/tea
	name = "杯装茶"
	desc = "用这种杯子喝茶总觉得不太对。"
	icon_state = "teaglass"

/datum/glass_style/drinking_glass/icecoffee
	required_drink_type = /datum/reagent/consumable/icecoffee
	name = "冰咖啡"
	desc = "让你精神振奋、清爽提神的饮品！"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "icedcoffeeglass"

/datum/glass_style/drinking_glass/hot_ice_coffee
	required_drink_type = /datum/reagent/consumable/hot_ice_coffee
	name = "热冰咖啡"
	desc = "口感尖锐的饮品，价格肯定不便宜。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "hoticecoffee"

/datum/glass_style/drinking_glass/icetea
	required_drink_type = /datum/reagent/consumable/icetea
	name = "冰茶"
	desc = "纯天然、富含抗氧化物的味觉享受。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "icedteaglass"

/datum/glass_style/drinking_glass/soy_latte
	required_drink_type = /datum/reagent/consumable/soy_latte
	name = "豆奶拿铁"
	desc = "阅读时享用的清爽美味饮品。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "soy_latte"

/datum/glass_style/drinking_glass/cafe_latte
	required_drink_type = /datum/reagent/consumable/cafe_latte
	name = "拿铁咖啡"
	desc = "阅读时享用的浓郁清爽饮品。"
	icon = 'icons/obj/drinks/coffee.dmi'
	icon_state = "cafe_latte"

/datum/glass_style/drinking_glass/pumpkin_latte
	required_drink_type = /datum/reagent/consumable/pumpkin_latte
	name = "南瓜拿铁"
	desc = "咖啡与南瓜汁的混合饮品。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "pumpkin_latte"

/datum/glass_style/has_foodtype/drinking_glass/hot_coco
	required_drink_type = /datum/reagent/consumable/hot_coco
	name = "杯装热可可"
	desc = "深受喜爱的冬日暖身饮品。"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/italian_coco
	required_drink_type = /datum/reagent/consumable/italian_coco
	name = "杯装意式热可可"
	desc = "冬日经典饮品的讨喜变体。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "italiancoco"

/datum/glass_style/drinking_glass/mushroom_tea
	required_drink_type = /datum/reagent/consumable/mushroom_tea
	name = "杯装蘑菇茶"
	desc = "作为饮品，咸鲜得有些古怪。"
	icon_state = "mushroom_tea_glass"

/datum/glass_style/drinking_glass/t_letter
	required_drink_type = /datum/reagent/consumable/t_letter
	name = "杯装字母T"
	desc = "第二十个字母。"
	icon = 'icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "tletter"
