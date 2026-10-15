/obj/item/food/sandwich
	name = "三明治"
	desc = "肉、奶酪、面包和几片生菜组成的伟大创作！亚瑟·登特会为此自豪。"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("meat" = 2, "cheese" = 1, "bread" = 2, "lettuce" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sandwich/cheese
	name = "奶酪三明治"
	desc = "适合暖日的清淡小食。……不过，要是拿去烤一烤呢？"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bread" = 1, "cheese" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/cheese/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sandwich/grilled_cheese, rand(30 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/sandwich/grilled_cheese
	name = "烤奶酪三明治"
	desc = "温热的三明治，奶酪融化流淌，与番茄汤堪称绝配。"
	icon_state = "toastedsandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/carbon = 4,
	)
	tastes = list("toast" = 2, "cheese" = 3, "butter" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/jelly
	name = "果酱三明治"
	desc = "真希望有些花生酱来搭配……"
	icon_state = "jellysandwich"
	bite_consumption = 3
	tastes = list("bread" = 1, "jelly" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/jelly/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/slimejelly = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC

/obj/item/food/sandwich/jelly/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/sandwich/notasandwich
	name = "这不是三明治"
	desc = "好像有哪里不对劲，可你说不上来。也许是它的小胡子。"
	icon_state = "notasandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("nothing suspicious" = 1)
	foodtypes = GRAIN | GROSS
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/griddle_toast
	name = "香煎吐司"
	desc = "煎得恰到好处的厚切面包。"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("toast" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_MASK
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butteredtoast
	name = "黄油吐司"
	desc = "薄薄抹了一层黄油的吐司。"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "butteredtoast"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("butter" = 1, "toast" = 1)
	foodtypes = GRAIN | BREAKFAST | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast
	name = "果酱吐司"
	desc = "一片涂满美味果酱的吐司。"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellytoast"
	bite_consumption = 3
	tastes = list("toast" = 1, "jelly" = 1)
	foodtypes = GRAIN | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR | BREAKFAST

/obj/item/food/jelliedtoast/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC | BREAKFAST

/obj/item/food/twobread
	name = "双片面包"
	desc = "这东西似乎苦得厉害。"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "twobread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bread" = 2)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/hotdog
	name = "热狗"
	desc = "新鲜出炉的一英尺长热狗，等着你张嘴享用。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hotdog"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 3, "meat" = 2)
	foodtypes = GRAIN | MEAT //Ketchup is not a vegetable
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_price = PAYCHECK_CREW * 0.7
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

// Used for unit tests, do not delete
/obj/item/food/hotdog/debug
	eat_time = 0

/obj/item/food/danish_hotdog
	name = "丹麦热狗"
	desc = "诱人的面包夹着香肠，上面浇着酱汁，撒着炸洋葱和腌黄瓜圈。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "danish_hotdog"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("bun" = 3, "meat" = 2, "fried onion" = 1, "pickles" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sandwich/blt
	name = "\improper 培根生菜番茄三明治"
	desc = "经典的培根、生菜和番茄三明治。"
	icon_state = "blt"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("bacon" = 3, "lettuce" = 2, "tomato" = 2, "bread" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/sandwich/peanut_butter_jelly
	name = "花生酱果酱三明治"
	desc = "经典的花生酱果酱三明治，就像妈妈以前做的一样。"
	icon_state = "peanut_butter_jelly_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "jelly" = 1, "bread" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/peanut_butter_banana
	name = "花生酱香蕉三明治"
	desc = "夹入香蕉片的花生酱三明治，是不错的高蛋白小食。"
	icon_state = "peanut_butter_banana_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("peanut butter" = 1, "banana" = 1, "bread" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = null

/obj/item/food/sandwich/philly_cheesesteak
	name = "费城奶酪牛肉三明治"
	desc = "广受欢迎的三明治，用长面包夹入肉片、洋葱和融化的奶酪。光说垂涎欲滴都不足以形容。"
	icon_state = "philly_cheesesteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("bread" = 1, "juicy meat" = 1, "melted cheese" = 1, "onions" = 1)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/sandwich/toast_sandwich
	name = "吐司三明治"
	desc = "两片面包中间夹着一片黄油吐司。你为什么要做这个？"
	icon_state = "toast_sandwich"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bread" = 2, "Britain" = 1, "butter" = 1, "toast" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = null

/obj/item/food/sandwich/death
	name = "死亡三明治"
	desc = "吃法不对，就得送命！"
	icon_state = "death_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bread" = 1, "meat" = 1, "tomato sauce" = 1, "death" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	eat_time = 4 SECONDS // Makes it harder to force-feed this to people as a weapon, as funny as that is.
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)
	var/static/list/correct_clothing = list(/obj/item/clothing/under/rank/civilian/cookjorts, /obj/item/clothing/under/shorts/jeanshorts)

/obj/item/food/sandwich/death/Initialize(mapload)
	. = ..()
	obj_flags &= ~UNIQUE_RENAME // You shouldn't be able to disguise this on account of how it kills you

// Makes you feel disgusted if you look at it wrong.
/obj/item/food/sandwich/death/examine(mob/user)
	. = ..()
	// Only human mobs, not animals or silicons, can like/dislike by this.
	if(!ishuman(user))
		return
	if(check_liked(user) == FOOD_LIKED)
		return
	to_chat(user, span_warning("你想象自己吃下[src]。嘴里突然泛起一股酸味，心中升起一阵做错了什么的可怕预感。"))
	user.adjust_disgust(33)

// Override for after_eat and check_liked callbacks.
/obj/item/food/sandwich/death/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, after_eat = CALLBACK(src, PROC_REF(after_eat)), check_liked = CALLBACK(src, PROC_REF(check_liked)))

/**
* Callback to be used with the edible component.
* If you have the right clothes and hairstyle, you like it.
* If you don't, you don't like it.
*/
/obj/item/food/sandwich/death/proc/check_liked(mob/living/carbon/human/consumer)
	// Closest thing to a mullet we have
	if(consumer.hairstyle == "Gelled Back" && is_type_in_list(consumer.get_item_by_slot(ITEM_SLOT_ICLOTHING), correct_clothing))
		return FOOD_LIKED
	return FOOD_ALLERGIC

/**
* Callback to be used with the edible component.
* If you take a bite of the sandwich with the right clothes and hairstyle, you like it.
* If you don't, you contract a deadly disease.
*/
/obj/item/food/sandwich/death/proc/after_eat(mob/living/carbon/human/consumer)
	// If you like it, you're eating it right.
	if(check_liked(consumer) == FOOD_LIKED)
		return
	// I thought it didn't make sense for it to instantly kill you, so instead enjoy shitloads of toxin damage per bite.
	balloon_alert(consumer, "吃法不对！")
	consumer.ForceContractDisease(new /datum/disease/death_sandwich_poisoning())

/obj/item/food/sandwich/death/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用错误的方式将[src]塞进喉咙。看起来是想自杀！"))
	qdel(src)
	user.gib()
	return MANUAL_SUICIDE
