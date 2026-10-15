//Pastry is a food that is made from dough which is made from wheat or rye flour.
//This file contains pastries that don't fit any existing categories.
////////////////////////////////////////////MUFFINS////////////////////////////////////////////

/obj/item/food/muffin
	name = "玛芬"
	desc = "美味松软的小蛋糕。"
	icon_state = "muffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = 1 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/muffin/berry
	name = "浆果玛芬"
	icon_state = "berrymuffin"
	desc = "加了浆果的美味松软小蛋糕。"
	tastes = list("muffin" = 3, "berry" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/muffin/booberry
	name = "幽灵莓玛芬"
	icon_state = "berrymuffin"
	alpha = 125
	desc = "我的胃就是墓地！任何活物都无法满足我的嗜血欲望！"
	tastes = list("muffin" = 3, "spookiness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|BREAKFAST|FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/muffin/booberry/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/muffin/moffin
	name = "蛾芬"
	icon_state = "moffin_1"
	base_icon_state = "moffin"
	desc = "美味松软的小蛋糕。"
	tastes = list("muffin" = 3, "dust" = 1, "lint" = 1)
	foodtypes = CLOTH|DAIRY|GRAIN|SUGAR|BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/moffin/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/muffin/moffin/examine(mob/user)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/moffin_observer = user
	if(moffin_observer.get_liked_foodtypes() & CLOTH)
		. += span_nicegreen("哦！上面居然还有碎布！真好吃！")
	else
		. += span_warning("不过，你不太确定上面放的是什么……")

////////////////////////////////////////////WAFFLES////////////////////////////////////////////

/obj/item/food/waffles
	name = "华夫饼"
	desc = "嗯，华夫饼。"
	icon_state = "waffles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("waffles" = 1)
	foodtypes = GRAIN|DAIRY|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/waffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

/obj/item/food/soylentgreen
	name = "\improper 索伊伦绿饼"
	desc = "不是人肉做的，真的。" //Totally people.
	icon_state = "soylent_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("waffles" = 7, "people" = 1)
	foodtypes = MEAT|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/soylenviridians
	name = "\improper 索伊伦翠绿饼"
	desc = "不是人肉做的，真的。" //Actually honest for once.
	icon_state = "soylent_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("waffles" = 7, "the colour green" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles
	name = "乐福华夫饼"
	desc = "乐福公司出品的华夫饼。"
	icon_state = "rofflewaffles"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/drug/mushroomhallucinogen = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("waffles" = 1, "mushrooms" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, max_scoops = 1, x_offset = -2)

////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/food/cookie
	name = "曲奇"
	desc = "曲奇！！！"
	icon_state = "COOKIE!!!"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = 1 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/cookie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cookie/sleepy
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/chloralhydrate = 10)

/obj/item/food/fortunecookie
	name = "幸运饼干"
	desc = "每块饼干里都有一句真正的预言！"
	icon_state = "fortune_cookie"
	trash_type = /obj/item/paper/paperslip/fortune
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cookie" = 1)
	foodtypes = GRAIN|SUGAR|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = 0.25 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/fortunecookie/proc/get_fortune()
	var/atom/drop_location = drop_location()

	var/obj/item/paper/fortune = locate(/obj/item/paper) in src
	// If a fortune exists, use that.
	if (fortune)
		fortune.forceMove(drop_location)
		return fortune

	// Otherwise, use a generic one
	var/obj/item/paper/paperslip/fortune/fortune_slip = new trash_type(drop_location)
	// if someone adds lottery tickets in the future, be sure to add random numbers to this
	return fortune_slip

/obj/item/food/fortunecookie/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, food_flags, TYPE_PROC_REF(/obj/item/food/fortunecookie, get_fortune))

/obj/item/food/cookie/sugar
	name = "糖饼干"
	desc = "就像你妹妹以前做的那样。"
	icon_state = "sugarcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
	)
	tastes = list("sweetness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/Initialize(mapload, seasonal_changes = TRUE)
	. = ..()
	if(seasonal_changes && check_holidays(FESTIVE_SEASON))
		var/shape = pick("tree", "bear", "santa", "stocking", "present", "cane")
		desc = "一块[list("tree" = "圣诞树", "bear" = "小熊", "santa" = "圣诞老人", "stocking" = "长袜", "present" = "礼物", "cane" = "拐杖")[shape]]形状的糖饼干。希望圣诞老人喜欢！"
		icon_state = "sugarcookie_[shape]"

/obj/item/food/chococornet
	name = "巧克力螺旋卷"
	desc = "哪边才是头，粗的那端还是细的那端？"
	icon_state = "chococornet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("biscuit" = 3, "chocolate" = 1)
	foodtypes = JUNKFOOD|GRAIN|DAIRY|SUGAR|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/oatmeal
	name = "燕麦曲奇"
	desc = "兼具曲奇与燕麦的美好。"
	icon_state = "oatmealcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 2, "oat" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/raisin
	name = "葡萄干曲奇"
	desc = "为什么要往曲奇里放葡萄干？"
	icon_state = "raisincookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cookie" = 1, "raisins" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poppypretzel
	name = "罂粟籽椒盐卷饼"
	desc = "全都拧到一起了！"
	icon_state = "poppypretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pretzel" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit
	name = "厚盔菇饼干"
	desc = "这是一块精心制作的厚盔菇饼干，原料是切得极细的厚盔菇和磨得细致的矮人小麦粉。"
	icon_state = "phelmbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1, "biscuit" = 1)
	foodtypes = VEGETABLES|GRAIN|DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "极品厚盔菇饼干"
		desc = "微波炉陷入了灵感狂热！它烹制出了一块极品厚盔菇饼干！"
		food_reagents = list(
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment = 1,
			/datum/reagent/consumable/nutriment/vitamin = 1,
		)
	. = ..()
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/food/cracker
	name = "咸脆饼干"
	desc = "一块加盐的脆饼干。"
	icon_state = "cracker"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("cracker" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/khachapuri
	name = "格鲁吉亚奶酪面包"
	desc = "加了鸡蛋和奶酪的面包？"
	icon_state = "khachapuri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bread" = 1, "egg" = 1, "cheese" = 1)
	foodtypes = GRAIN | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake
	name = "樱桃纸杯蛋糕"
	desc = "含有樱桃碎的香甜纸杯蛋糕。"
	icon_state = "cherrycupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("cake" = 3, "cherry" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake/blue
	name = "蓝樱桃纸杯蛋糕"
	desc = "美味的纸杯蛋糕里藏着蓝樱桃。"
	icon_state = "bluecherrycupcake"
	tastes = list("cake" = 3, "blue cherry" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/jupitercupcake
	name = "朱庇特纸杯蛋糕"
	desc = "一道带静电的甜点。"
	icon_state = "jupitercupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/liquidelectricity = 3,
	)
	tastes = list("cake" = 3, "caramel" = 2, "zap" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	crafted_food_buff = /datum/status_effect/food/trait/shockimmune

/obj/item/food/honeybun
	name = "蜂蜜面包"
	desc = "表面涂着蜂蜜的黏甜面包。"
	icon_state = "honeybun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/honey = 6,
	)
	tastes = list("pastry" = 1, "sweetness" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cannoli
	name = "西西里奶油卷"
	desc = "让你也像个黑帮老手的西西里点心。"
	icon_state = "cannoli"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("pastry" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP // Pastry base, 3u of sugar and a single. fucking. unit. of. milk. really?
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/icecream
	name = "华夫蛋筒"
	desc = "美味的华夫蛋筒，不过里面没有冰淇淋。"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "icecream_cone_waffle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("cream" = 2, "waffle" = 1)
	bite_consumption = 4
	foodtypes = DAIRY | SUGAR | GRAIN
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2
	max_volume = 10 //The max volumes scales up with the number of scoops of ice cream served.
	/// These two variables are used by the ice cream vat. Latter is the one that shows on the UI.
	var/list/ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
	)
	var/ingredients_text
	/*
	 * Assoc list var used to prefill the cone with ice cream.
	 * Key is the flavour's name (use text defines; see __DEFINES/food.dm or ice_cream_holder.dm),
	 * assoc is the list of args that is going to be used in [flavour/add_flavour()]. Can as well be null for simple flavours.
	 */
	var/list/prefill_flavours

/obj/item/food/icecream/Initialize(mapload, list/prefill_flavours)
	if(ingredients)
		ingredients_text = "需要：[reagent_paths_list_to_text(ingredients)]"
	src.prefill_flavours = prefill_flavours
	return ..()

/obj/item/food/icecream/make_edible()
	. = ..()
	var/max_scoops = check_holidays(ICE_CREAM_DAY) ? DEFAULT_MAX_ICE_CREAM_SCOOPS * 4 : DEFAULT_MAX_ICE_CREAM_SCOOPS
	AddComponent(/datum/component/ice_cream_holder, max_scoops, filled_name = "冰淇淋", change_desc = TRUE, prefill_flavours = prefill_flavours)

/obj/item/food/icecream/chocolate
	name = "巧克力蛋筒"
	desc = "美味的巧克力蛋筒，不过里面没有冰淇淋。"
	icon_state = "icecream_cone_chocolate"
	foodtypes = CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coco = 1,
	)
	ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/coco,
	)

/obj/item/food/icecream/korta
	name = "科塔坚果蛋筒"
	desc = "适合蜥蜴人食用的美味蛋筒，不过里面没有冰淇淋。"
	foodtypes = NUTS | SUGAR
	ingredients = list(
		/datum/reagent/consumable/korta_flour,
		/datum/reagent/consumable/sugar,
	)

/obj/item/food/cookie/peanut_butter
	name = "花生酱曲奇"
	desc = "一块美味耐嚼的花生酱曲奇。"
	icon_state = "peanut_butter_cookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 2, "cookie" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_brownie_batter
	name = "生布朗尼面糊"
	desc = "黏稠的生布朗尼面糊，放进烤箱烤熟吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "raw_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	foodtypes_added_when_cooked = BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/brownie_sheet
	name = "整盘布朗尼"
	desc = "烤好但还没切开的整盘布朗尼，用刀切开吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/brownie
	name = "布朗尼"
	desc = "一块方形的美味耐嚼布朗尼，经常被大麻爱好者盯上。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/peanut_butter_brownie_batter
	name = "生花生酱布朗尼面糊"
	desc = "黏稠的生花生酱布朗尼面糊，放进烤箱烤熟吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/peanut_butter = 4,
	)
	tastes = list("raw brownie batter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|NUTS|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	foodtypes_added_when_cooked = BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/peanut_butter_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/peanut_butter_brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/peanut_butter_brownie_sheet
	name = "整盘花生酱布朗尼"
	desc = "烤好但还没切开的整盘花生酱布朗尼，用刀切开吧！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 24,
		/datum/reagent/consumable/sugar = 16,
		/datum/reagent/consumable/peanut_butter = 20,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1, "peanut butter" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peanut_butter_brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/peanut_butter_brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/peanut_butter_brownie
	name = "花生酱布朗尼"
	desc = "一块方形的美味耐嚼花生酱布朗尼，经常被大麻爱好者盯上。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("brownie" = 1, "chocolatey goodness" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|BREAKFAST|NUTS|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/crunchy_peanut_butter_tart
	name = "香脆花生酱挞"
	desc = "夹着花生酱的小馅饼，覆有奶油糖霜，再撒上碎坚果。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "crunchy_peanut_butter_tart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("peanut butter" = 1, "peanuts" = 1, "cream" = 1)
	foodtypes = GRAIN|DAIRY|JUNKFOOD|SUGAR|NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/chocolate_chip_cookie
	name = "巧克力豆曲奇"
	desc = "香气诱人的巧克力豆曲奇。牛奶呢？"
	icon_state = "COOKIE!!!"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "chocolate" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY | CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/snickerdoodle
	name = "肉桂糖曲奇"
	desc = "用香草和肉桂制成的软曲奇。"
	icon_state = "snickerdoodle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("soft cookie" = 2, "vanilla" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron
	name = "马卡龙"
	desc = "像三明治一样的甜点，柔软饼干外壳中夹着绵密蛋白霜。"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	icon_state = "macaron_1"
	base_icon_state = "macaron"
	tastes = list("wafer" = 2, "creamy meringue" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 4)]"

/obj/item/food/cookie/thumbprint_cookie
	name = "拇指饼干"
	desc = "中间留有拇指大小凹槽、用来放馅料的饼干。这块装着樱桃果酱。"
	icon_state = "thumbprint_cookie"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("cookie" = 2, "cherry jelly" = 3)
	foodtypes = GRAIN|DAIRY|SUGAR|FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/apple_fritter
	name = "苹果炸饼"
	desc = "看着像一堆裹了糖衣的泥土，尝起来却出奇地酸。那股甜香简直能把你熏晕。"
	icon_state = "apple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/applejuice = 1,
	)
	tastes = list("apple" = 1, "glaze" = 1)
	foodtypes = GRAIN|FRUIT|FRIED|DAIRY|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
