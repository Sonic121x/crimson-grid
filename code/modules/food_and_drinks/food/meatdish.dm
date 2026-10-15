//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu


////////////////////////////////////////////FISH////////////////////////////////////////////

/obj/item/food/cubancarp
	name = "\improper 古巴风味鲤鱼"
	desc = "一份坑人绝佳的三明治，先灼烧你的舌头，再让它彻底麻木！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cubancarp"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 4, "batter" = 1, "hot peppers" = 1)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD|FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishmeat
	name = "鱼肉片"
	desc = "一片鱼肉。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 6
	tastes = list("fish" = 1)
	foodtypes = SEAFOOD
	eatverbs = list("咬下", "咀嚼", "啃食", "吞下", "大口嚼下")
	w_class = WEIGHT_CLASS_SMALL
	starting_reagent_purity = 1.0
	var/fillet_name = "%NAME肉片"

/obj/item/food/fishmeat/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_FOOD_DONT_INHERIT_NAME_FROM_PROCESSED, INNATE_TRAIT)

/obj/item/food/fishmeat/OnCreatedFromProcessing(mob/living/user, obj/item/work_tool, list/chosen_option, atom/original_atom)
	. = ..()
	name = replacetext(fillet_name, "%NAME", original_atom.name)
	material_flags &= ~MATERIAL_ADD_PREFIX //don't double down on material prefixes

/obj/item/food/fishmeat/quality
	name = "优质鱼肉片"
	desc = "一片珍贵的鱼肉。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 7
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/fishmeat/quality/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/quality_food_ingredient, FOOD_COMPLEXITY_1)

/obj/item/food/fishmeat/salmon
	name = "鲑鱼肉片"
	desc = "一片厚实肥美的鲑鱼肉。"
	icon_state = "salmon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	bite_consumption = 4.5
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/fishmeat/salmon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/quality_food_ingredient, FOOD_COMPLEXITY_1)

/obj/item/food/fishmeat/carp
	name = "鲤鱼肉片"
	desc = "一片太空鲤鱼肉。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/carpotoxin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	/// Cytology category you can swab the meat for.
	var/cell_line = CELL_LINE_TABLE_CARP

/obj/item/food/fishmeat/carp/Initialize(mapload)
	. = ..()
	if(cell_line)
		AddElement(/datum/element/swabable, cell_line, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/fishmeat/carp/imitation
	name = "仿鲤鱼肉片"
	desc = "差不多能以假乱真……大概吧。"
	cell_line = null
	starting_reagent_purity = 0.3

///carp fillet, but without the toxin. Used by baby carps (fish item), which have a trait that handles the toxin already.
/obj/item/food/fishmeat/carp/no_tox

/obj/item/food/fishmeat/carp/no_tox/Initialize(mapload)
	food_reagents -= /datum/reagent/toxin/carpotoxin
	return ..()

/obj/item/food/fishmeat/moonfish
	name = "月鱼肉片"
	desc = "一片月鱼肉。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_fillet"

/obj/item/food/fishmeat/moonfish/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_moonfish, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/fishmeat/gunner_jellyfish
	name = "炮手水母肉片"
	desc = "去除了刺细胞的炮手水母。生吃会有轻微致幻效果。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "jellyfish_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4, //The halluginogen comes from the fish trait.
	)

///Premade gunner jellyfish fillets from supply orders. Contains the halluginogen that'd be normally from the fish trait.
/obj/item/food/fishmeat/gunner_jellyfish/supply
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/toxin/mindbreaker/fish = 2)

/obj/item/food/fishmeat/armorfish
	name = "处理好的披甲鱼"
	desc = "去除了内脏和甲壳的披甲鱼，可以拿来烹饪了。"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "armorfish_fillet"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)
	fillet_name = "处理好的%NAME"

///donkfish fillets. The yuck reagent is now added by the fish trait of the same name.
/obj/item/food/fishmeat/donkfish
	name = "当克鱼肉片"
	desc = "令人闻风丧胆的当克鱼肉片。神志正常的人都不会吃，煮熟也好不到哪里去。" // DARKPACK EDIT CHANGE
	icon_state = "donkfillet"
	starting_reagent_purity = 0.3

/obj/item/food/fishmeat/octopus
	name = "章鱼触手"
	desc = "一根粗大的章鱼触手。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "octopus_fillet"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)
	fillet_name = "%NAME触手"

/obj/item/food/fishmeat/octopus/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_octopus, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/fishmeat/fish_tail
	name = "鱼尾肉片"
	desc = "直接从一条巨大的……鱼？的尾部切下的珍贵肥美肉片。由于十分罕见，在某些地方被视为珍馐。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	bite_consumption = 5
	tastes = list("fatty fish" = 1)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/fishmeat/fish_tail/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/quality_food_ingredient, FOOD_COMPLEXITY_1)

/obj/item/food/fishfingers
	name = "炸鱼条"
	desc = "一根手指粗细的鱼肉条。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfingers"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 1
	tastes = list("fish" = 1, "breadcrumbs" = 1)
	foodtypes = GRAIN|SEAFOOD|FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishandchips
	name = "炸鱼薯条"
	desc = "老兄，恕我自夸，这可真不错。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishandchips"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("fish" = 1, "chips" = 1)
	foodtypes = SEAFOOD | VEGETABLES | FRIED
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishfry
	name = "炸鱼"
	desc = "都有这么多了，竟然连袋薯条都没有……"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfry"
	food_reagents = list (
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("fish" = 1, "pan-seared vegetables" = 1)
	foodtypes = SEAFOOD | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/vegetariansushiroll
	name = "素食寿司卷"
	desc = "用米饭、胡萝卜和土豆做成的简单素食寿司卷。可以切成小块！"
	icon_state = "vegetariansushiroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/vegetariansushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/vegetariansushislice, 4, screentip_verb = "切块")

/obj/item/food/vegetariansushislice
	name = "素食寿司块"
	desc = "一块用米饭、胡萝卜和土豆做成的简单素食寿司。"
	icon_state = "vegetariansushislice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 4, "carrots" = 2, "potato" = 2)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spicyfiletsushiroll
	name = "香辣鱼片寿司卷"
	desc = "用鱼肉和蔬菜做成的美味香辣寿司卷。可以切成小块！"
	icon_state = "spicyfiletroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spicyfiletsushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spicyfiletsushislice, 4, screentip_verb = "切块")

/obj/item/food/spicyfiletsushislice
	name = "香辣鱼片寿司块"
	desc = "一块用鱼肉和蔬菜做成的美味香辣寿司。别吃得太快！"
	icon_state = "spicyfiletslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 4, "fish" = 2, "spicyness" = 2)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// empty sushi for custom sushi
/obj/item/food/sushi/empty
	name = "寿司"
	foodtypes = VEGETABLES
	tastes = list()
	icon_state = "vegetariansushiroll"
	desc = "一卷自制寿司。"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sushi/empty/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sushislice/empty, 4, screentip_verb = "切块")

/obj/item/food/sushislice/empty
	name = "寿司块"
	foodtypes = VEGETABLES
	tastes = list()
	icon_state = "vegetariansushislice"
	desc = "一块自制寿司。"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/nigiri_sushi
	name = "握寿司"
	desc = "简单的握寿司：紧实的饭团上铺着鱼肉，外面裹上海苔，旁边佐以酱油。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "nigiri_sushi"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("boiled rice" = 4, "fish filet" = 2, "soy sauce" = 2)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_poke
	name = "肉丁夏威夷拌饭"
	desc = "简单的夏威夷拌饭，底下是米饭，上面放着蔬菜和肉。食用前应拌匀。"
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "pokemeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = MEAT|VEGETABLES|GRAIN
	tastes = list("rice and meat" = 4, "lettuce" = 2, "soy sauce" = 2)
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/fish_poke
	name = "鱼肉夏威夷拌饭"
	desc = "简单的夏威夷拌饭，底下是米饭，上面放着蔬菜和鱼肉。食用前应拌匀。"
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "pokefish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD
	tastes = list("rice and fish" = 4, "lettuce" = 2, "soy sauce" = 2)
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/food/tempeh
	name = "生天贝块"
	desc = "经真菌发酵的大豆饼，摸起来暖暖的。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempeh"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 8)
	tastes = list("earthy" = 3, "nutty" = 2, "bland" = 1 )
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

// sliceable into 4xtempehslices
/obj/item/food/tempeh/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/tempehslice, 4, 5 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

//add an icon for slices
/obj/item/food/tempehslice
	name = "天贝片"
	desc = "一片天贝，一片哈哈哈。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempehslice"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("earthy" = 3, "nutty" = 2, "bland" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

//add an icon for blends
/obj/item/food/tempehstarter
	name = "天贝发酵料"
	desc = "大豆与快乐的混合物。暖乎乎的……还在动？"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempehstarter"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("nutty" = 2, "bland" = 2)
	foodtypes = VEGETABLES | GROSS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tofu
	name = "豆腐"
	desc = "我们都爱豆腐。"
	icon_state = "tofu"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("tofu" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tofu/prison
	name = "湿漉漉的豆腐"
	desc = "你拒绝吃下这块奇怪的豆腐。"
	tastes = list("sour, rotten water" = 1)
	foodtypes = GROSS

/obj/item/food/spiderleg
	name = "蜘蛛腿"
	desc = "一条还在抽动的巨型蜘蛛腿……你不会真想吃这个吧？"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderleg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/toxin = 2,
	)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | TOXIC
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spiderleg/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/boiledspiderleg, rand(50 SECONDS, 60 SECONDS), TRUE, TRUE)

/obj/item/food/cornedbeef
	name = "腌牛肉配卷心菜"
	desc = "现在你可以体验一把游客在爱尔兰度假的感觉了。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cornedbeef"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("meat" = 1, "cabbage" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/bearsteak
	name = "熊吼菲力"
	desc = "因为光吃熊肉还不够有男子气概。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "bearsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
	)
	tastes = list("meat" = 1, "salmon" = 1)
	foodtypes = MEAT | ALCOHOL
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/polar_bear_steak
	name = "北极熊吼菲力"
	desc = "因为吃着火的熊肉还不够有斯拉夫风范。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "bearsteakfrost"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/consumable/ethanol/frosty_dorf = 3,
		/datum/reagent/consumable/ethanol/blue_blazer = 3,
		/datum/reagent/toxin/berserker = 3
	)
	tastes = list("meat" = 1, "cold" = 1)
	foodtypes = MEAT | ALCOHOL
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_meatball
	name = "生肉丸"
	desc = "圆滚滚的美餐，不是什么木头疙瘩。就是还有点生。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_meatball"
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	var/meatball_type = /obj/item/food/meatball
	var/patty_type = /obj/item/food/raw_patty

/obj/item/food/raw_meatball/make_grillable()
	AddComponent(/datum/component/grillable, meatball_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_meatball/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, patty_type, 1, table_required = TRUE, screentip_verb = "压扁", sound_to_play = SFX_ROLLING_PIN_ROLLING)

/obj/item/food/raw_meatball/human
	name = "奇怪的生肉丸"
	meatball_type = /obj/item/food/meatball/human
	patty_type = /obj/item/food/raw_patty/human

/obj/item/food/raw_meatball/corgi
	name = "生柯基肉丸"
	meatball_type = /obj/item/food/meatball/corgi
	patty_type = /obj/item/food/raw_patty/corgi

/obj/item/food/raw_meatball/xeno
	name = "生异形肉丸"
	meatball_type = /obj/item/food/meatball/xeno
	patty_type = /obj/item/food/raw_patty/xeno

/obj/item/food/raw_meatball/bear
	name = "生熊肉丸"
	meatball_type = /obj/item/food/meatball/bear
	patty_type = /obj/item/food/raw_patty/bear

/obj/item/food/raw_meatball/chicken
	name = "生鸡肉丸"
	meatball_type = /obj/item/food/meatball/chicken
	patty_type = /obj/item/food/raw_patty/chicken

/obj/item/food/meatball
	name = "肉丸"
	desc = "圆滚滚的美餐，不是什么木头疙瘩。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatball"
	inhand_icon_state = "meatball"
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/meatball/human
	name = "奇怪的肉丸"

/obj/item/food/meatball/corgi
	name = "柯基肉丸"

/obj/item/food/meatball/bear
	name = "熊肉丸"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/meatball/xeno
	name = "异形肉丸"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/meatball/chicken
	name = "鸡肉丸"
	tastes = list("chicken" = 1)
	icon_state = "chicken_meatball"

/obj/item/food/raw_patty
	name = "生肉饼"
	desc = "我……还没好——呢！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_patty"
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	var/patty_type = /obj/item/food/patty/plain

/obj/item/food/raw_patty/make_grillable()
	AddComponent(/datum/component/grillable, patty_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_patty/human
	name = "奇怪的生肉饼"
	patty_type = /obj/item/food/patty/human

/obj/item/food/raw_patty/corgi
	name = "生柯基肉饼"
	patty_type = /obj/item/food/patty/corgi

/obj/item/food/raw_patty/bear
	name = "生熊肉饼"
	tastes = list("meat" = 1, "salmon" = 1)
	patty_type = /obj/item/food/patty/bear

/obj/item/food/raw_patty/xeno
	name = "生异形肉饼"
	tastes = list("meat" = 1, "acid" = 1)
	patty_type = /obj/item/food/patty/xeno

/obj/item/food/raw_patty/chicken
	name = "生鸡肉饼"
	tastes = list("chicken" = 1)
	patty_type = /obj/item/food/patty/chicken

/obj/item/food/patty
	name = "肉饼"
	desc = "你我共享的肉饼！" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "patty"
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("meat" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

///Exists purely for the crafting recipe (because it'll take subtypes)
/obj/item/food/patty/plain

/obj/item/food/patty/human
	name = "奇怪的肉饼"

/obj/item/food/patty/corgi
	name = "柯基肉饼"

/obj/item/food/patty/bear
	name = "熊肉饼"
	tastes = list("meat" = 1, "salmon" = 1)

/obj/item/food/patty/xeno
	name = "异形肉饼"
	tastes = list("meat" = 1, "acid" = 1)

/obj/item/food/patty/chicken
	name = "鸡肉饼"
	tastes = list("chicken" = 1)
	icon_state = "chicken_patty"

/obj/item/food/raw_sausage
	name = "生香肠"
	desc = "一根用混合肉馅做成的长条肉食，不过还是生的。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | RAW
	foodtypes_added_when_cooked = BREAKFAST
	eatverbs = list("咬下", "咀嚼", "小口吃下", "深吞", "狼吞虎咽地吃下", "大口嚼下")
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_sausage/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage, rand(60 SECONDS, 75 SECONDS), TRUE)

/obj/item/food/sausage
	name = "香肠"
	desc = "一根用混合肉馅做成的长条肉食。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	eatverbs = list("咬下", "咀嚼", "小口吃下", "深吞", "狼吞虎咽地吃下", "大口嚼下")
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = PAYCHECK_CREW * 0.6
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/sausage/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/salami, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sausage/american, 1, 3 SECONDS, table_required = TRUE,  screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/sausage/american
	name = "美式香肠"
	desc = "咔嚓剪一截。"
	icon_state = "american_sausage"

/obj/item/food/sausage/american/make_processable()
	return

/obj/item/food/salami
	name = "萨拉米香肠"
	desc = "一片腌制的萨拉米香肠。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "salami"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("meat" = 1, "smoke" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 6)

/obj/item/food/rawkhinkali
	name = "生格鲁吉亚灌汤包"
	desc = "一百个灌汤包？你看我像猪吗？"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT|GRAIN|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/rawkhinkali/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/khinkali, rand(50 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/khinkali
	name = "格鲁吉亚灌汤包"
	desc = "一百个灌汤包？你看我像猪吗？"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/garlic = 2,
	)
	bite_consumption = 3
	tastes = list("meat" = 1, "onions" = 1, "garlic" = 1)
	foodtypes = MEAT|GRAIN|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/meatbun
	name = "肉包"
	desc = "里面有可能不是人肉。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatbun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 3, "meat" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/stewedsoymeat
	name = "炖大豆素肉"
	desc = "连不吃素的人也会爱上它！"
	icon_state = "stewedsoymeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("soy" = 1, "vegetables" = 1)
	eatverbs = list("吸溜着喝下", "小口啜饮", "猛吸", "喝下")
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/boiledspiderleg
	name = "水煮蜘蛛腿"
	desc = "一条煮熟后还在抽动的巨型蜘蛛腿。真恶心！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderlegcooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("hot peppers" = 1, "cobwebs" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spidereggsham
	name = "绿鸡蛋火腿"
	desc = "你会在火车上吃吗？你会在飞机上吃吗？" // DARKPACK EDIT CHANGE
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggsham"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 4
	tastes = list("meat" = 1, "the colour green" = 1)
	foodtypes = MEAT|BUGS|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/sashimi
	name = "蜘蛛刺身"
	desc = "好不容易从敌对外星生物的袭击中活下来，就靠把自己吃进医院来庆祝吧。你真希望做这道菜的人手艺过硬。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sashimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/capsaicin = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("fish" = 1, "hot peppers" = 1)
	foodtypes = MEAT|SEAFOOD|BUGS|EGG
	w_class = WEIGHT_CLASS_TINY
	//total price of this dish is 20 and a small amount more for soy sauce, all of which are available at the orders console
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sashimi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CARP, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/nugget
	name = "鸡块"
	desc = "一块隐约捏出了某种形状的“鸡肉”块。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	icon = 'icons/obj/food/meat.dmi'
	/// Default nugget icon for recipes that need any nugget
	icon_state = "nugget_lump"
	tastes = list("\"chicken\"" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	var/meat_source = "“鸡肉”"

/obj/item/food/nugget/Initialize(mapload)
	. = ..()
	var/shape = pick("lump", "star", "lizard", "corgi")
	desc = "一块隐约呈[list("lump" = "团块", "star" = "星星", "lizard" = "蜥蜴", "corgi" = "柯基")[shape]]形状的[meat_source]块。"
	icon_state = "nugget_[shape]"

///subtype harvested from fish caught from, you guess it, the deepfryer
/obj/item/food/nugget/fish
	name = "鱼肉块"
	tastes = list("fried fish" = 1)
	foodtypes = MEAT|SEAFOOD|FRIED
	venue_value = FOOD_PRICE_NORMAL
	meat_source = "鱼肉"

/obj/item/food/pigblanket
	name = "酥皮香肠卷"
	desc = "小香肠裹在酥脆的黄油面包卷里。把它吃掉，让这只小猪摆脱被窝牢笼吧。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "pigblanket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1, "butter" = 1)
	foodtypes = MEAT | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_price = PAYCHECK_CREW
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/bbqribs
	name = "烧烤肋排"
	desc = "涂满厚厚一层烧烤酱的烤肋排。世上最不沾纯素边的东西。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "ribs"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/bbqsauce = 10,
	)
	tastes = list("meat" = 3, "smokey sauce" = 1)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/drake_ribs
	name = "飞龙肋排"
	desc = "用熊肉和飞龙皮碎料做成的肋排，涂满烧烤酱和冰凉酱。肉味再重一点，就能让纯素食者精神受创。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "drake_ribs"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/guidoferrun = 10,
		/datum/reagent/consumable/frostoil = 5,
		/datum/reagent/consumable/bbqsauce = 5,
	)
	tastes = list("meat" = 3, "cold sauce" = 1)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/meatclown
	name = "肉小丑"
	desc = "一块美味圆润的肉小丑。真可怕。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatclown"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/banana = 2,
	)
	tastes = list("meat" = 5, "clowns" = 3, "sixteen teslas" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = MEAT | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/meatclown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 3 SECONDS)

/obj/item/food/lasagna
	name = "千层面"
	desc = "一块千层面。最适合在周一下午享用。"
	icon_state = "lasagna"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/tomatojuice = 10,
	)
	tastes = list("meat" = 3, "pasta" = 3, "tomato" = 2, "cheese" = 2)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

//////////////////////////////////////////// KEBABS AND OTHER SKEWERS ////////////////////////////////////////////

/obj/item/food/kebab
	trash_type = /obj/item/stack/rods
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "kebab"
	abstract_type = /obj/item/food/kebab
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 14)
	tastes = list("meat" = 3, "metal" = 1)
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/kebab/human
	name = "人肉串"
	desc = "串在签子上的人肉。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("tender meat" = 3, "metal" = 1)
	foodtypes = MEAT | GORE
	venue_value = FOOD_PRICE_CHEAP
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/kebab/monkey
	name = "烤肉串"
	desc = "串在签子上的美味肉块。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 3, "metal" = 1)
	foodtypes = MEAT
	venue_value = FOOD_PRICE_CHEAP
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/kebab/tofu
	name = "豆腐串"
	desc = "串在签子上的纯素肉。"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 15)
	tastes = list("tofu" = 3, "metal" = 1)
	foodtypes = VEGETABLES
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/tail
	name = "蜥蜴尾串"
	desc = "串在签子上的断蜥蜴尾巴。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("meat" = 8, "metal" = 4, "scales" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/kebab/rat
	name = "鼠肉串"
	desc = "串在签子上的鼠肉，味道不怎么样。"
	icon_state = "ratkebab"
	w_class = WEIGHT_CLASS_NORMAL
	trash_type = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("rat meat" = 1, "metal" = 1)
	foodtypes = MEAT|RAW|GORE
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/rat/double
	name = "双份鼠肉串"
	icon_state = "doubleratkebab"
	tastes = list("rat meat" = 2, "metal" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/iron = 2,
	)

/obj/item/food/kebab/fiesta
	name = "嘉年华烤串"
	desc = "把各种肉类和蔬菜串在一起的烤串。"
	icon_state = "fiestaskewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("tex-mex" = 3, "cumin" = 2)
	foodtypes = MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/fried_chicken
	name = "炸鸡"
	desc = "一大块多汁鸡肉，炸得恰到好处。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fried_chicken1"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("chicken" = 3, "fried batter" = 1)
	foodtypes = MEAT | FRIED
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	custom_price = 2 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/fried_chicken/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "fried_chicken2"

/obj/item/food/beef_stroganoff
	name = "俄式酸奶油炖牛肉"
	desc = "由牛肉和酱汁做成的俄罗斯菜。在日本很受欢迎，至少我看的动画片是这么说的。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beefstroganoff"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("beef" = 3, "sour cream" = 1, "salt" = 1, "pepper" = 1)
	foodtypes = MEAT | VEGETABLES | DAIRY

	w_class = WEIGHT_CLASS_SMALL
	//basic ingredients, but a lot of them. just covering costs here
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/beef_wellington
	name = "惠灵顿牛排"
	desc = "豪华的大块牛肉，裹上细腻的蘑菇泥和意式腌五花肉，再包进酥皮里。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beef_wellington"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("beef" = 3, "mushrooms" = 1, "pancetta" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/beef_wellington/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/beef_wellington_slice, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/beef_wellington_slice
	name = "惠灵顿牛排切片"
	desc = "一片浇上浓郁肉汁的惠灵顿牛排。美味至极。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beef_wellington_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("beef" = 3, "mushrooms" = 1, "pancetta" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * (4/3))

/obj/item/food/korta_wellington
	name = "科塔惠灵顿牛排"
	desc = "豪华的大块牛肉，裹上细腻的蘑菇泥和意式腌五花肉，再包进科塔酥皮里。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "korta_wellington"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("beef" = 3, "mushrooms" = 1, "pancetta" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/korta_wellington/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/korta_wellington_slice, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/korta_wellington_slice
	name = "科塔惠灵顿牛排切片"
	desc = "一片浇上浓郁肉汁的科塔惠灵顿牛排。美味至极。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "korta_wellington_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("beef" = 3, "mushrooms" = 1, "pancetta" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * (4/3))

/obj/item/food/roast_dinner
	name = "烤鸡大餐"
	desc = "豪华的烤鸡，配有卷心菜、欧防风、土豆、豌豆、填馅和一小壶肉汁。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "full_roast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("chicken" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/roast_dinner/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/roast_slice, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/roast_slice
	name = "一盘烤鸡大餐"
	desc = "一小盘烤鸡、豌豆、卷心菜、欧防风、土豆、填馅，还有……等等，就给我这点肉汁？！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "roast_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("chicken" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/roast_dinner_lizzy
	name = "无谷烤鸡大餐"
	desc = "豪华的烤鸡，配有卷心菜、欧防风、土豆、豌豆、科塔填馅和一小壶科塔血肉汁。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "full_roast_lizzy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("chicken" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/roast_dinner_lizzy/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/roast_slice_lizzy, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/roast_slice_lizzy
	name = "一盘无谷烤鸡大餐"
	desc = "一小盘烤鸡、豌豆、卷心菜、欧防风、土豆、科塔填馅，还有……等等，就给我这点科塔血肉汁？！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "roast_slice_lizzy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("chicken" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/roast_dinner_tofu
	name = "素食烤制大餐"
	desc = "豪华的烤豆腐“鸡”，配有卷心菜、欧防风、土豆、豌豆、填馅和一小壶大豆素肉汁。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "full_roast_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("tofu" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/roast_dinner_tofu/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/roast_slice_tofu, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/roast_slice_tofu
	name = "一盘素食烤制大餐"
	desc = "一小盘烤豆腐“鸡”、豌豆、卷心菜、欧防风、土豆、填馅，还有……等等，就给我这点大豆素肉汁？！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "roast_slice_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("tofu" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/full_english
	name = "全套英式早餐"
	desc = "丰盛的一盘早餐，配菜一应俱全，堪称早餐艺术的巅峰。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "full_english"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("sausage" = 1, "bacon" = 1, "egg" = 1, "tomato" = 1, "mushrooms" = 1, "bread" = 1, "beans" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY|FRIED|BREAKFAST|EGG
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/raw_meatloaf
	name = "生肉糜糕"
	desc = "用肉末、洋葱和大蒜做成的沉甸甸的“糕”。放进烤箱烤一烤吧！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_meatloaf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 32,
		/datum/reagent/consumable/nutriment = 32,
	)
	tastes = list("raw meat" = 3, "onions" = 1)
	foodtypes = MEAT | RAW | VEGETABLES
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/raw_meatloaf/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/meatloaf, rand(30 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/meatloaf
	name = "肉糜糕"
	desc = "把肉、洋葱和大蒜混合塑成糕状，再放入烤箱烘烤，表面涂满了番茄酱。用刀切片吧！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatloaf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 32,
		/datum/reagent/consumable/nutriment = 32,
	)
	tastes = list("juicy meat" = 3, "onions" = 1, "garlic" = 1, "ketchup" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/meatloaf/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meatloaf_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/meatloaf_slice
	name = "肉糜糕切片"
	desc = "一片美味多汁的肉糜糕，表面涂着番茄酱。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatloaf_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("juicy meat" = 3, "onions" = 1, "garlic" = 1, "ketchup" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 2)

/obj/item/food/wendigo_feast
	trash_type = /obj/item/wendigo_skull
	name = "温迪戈盛宴"
	desc = "堆满肉食、冰凉酱和烧烤酱的盛宴，顶上摆着一颗温迪戈头骨，里面塞满了弗蕾娅的原生植物。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "wendigofeast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 50,
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/guidoferrun = 10,
		/datum/reagent/consumable/frostoil = 10,
		/datum/reagent/consumable/bbqsauce = 5,
		/datum/reagent/toxin/berserker = 5,
	)
	tastes = list("chicken" = 3, "vegetables" = 1, "gravy" = 1)
	foodtypes = MEAT | VEGETABLES | FRUIT | SUGAR
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 3)

/obj/item/food/sweet_and_sour_meatballs
	name = "糖醋肉丸"
	desc = "金黄的肉丸裹着浓稠鲜美的酱汁，配以菠萝块和甜椒块。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sweet_and_sour_meatballs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("meat" = 5, "savory sauce" = 4, "tangy pineapple" = 3, "pepper" = 2)
	foodtypes = MEAT | VEGETABLES | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/kebab/pineapple_skewer
	name = "菠萝烤串"
	desc = "裹着酱汁的肉块和菠萝片串在一根签子上。意外地不错！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "pineapple_skewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("juicy meat" = 4, "pineapple" = 3)
	foodtypes = MEAT | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/futomaki_sushi_roll
	name = "太卷寿司"
	desc = "用水煮蛋、鱼肉和黄瓜做成的太卷寿司。可以切块。"
	icon_state = "futomaki_sushi_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("boiled rice" = 4, "fish" = 5, "egg" = 3, "dried seaweed" = 2, "cucumber" = 2)
	foodtypes = MEAT|VEGETABLES|GRAIN|SEAFOOD|EGG
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/futomaki_sushi_roll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/futomaki_sushi_slice, 4, screentip_verb = "切块")

/obj/item/food/futomaki_sushi_slice
	name = "太卷寿司块"
	desc = "一块用水煮蛋、鱼肉和黄瓜做成的太卷寿司。"
	icon_state = "futomaki_sushi_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("boiled rice" = 4, "fish" = 5, "egg" = 3, "dried seaweed" = 2, "cucumber" = 2)
	foodtypes = VEGETABLES|GRAIN|DAIRY|SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/philadelphia_sushi_roll
	name = "费城寿司卷"
	desc = "用奶酪、鱼肉和黄瓜做成的费城寿司卷。可以切块。"
	icon_state = "philadelphia_sushi_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("boiled rice" = 4, "fish" = 5, "creamy cheese" = 3, "dried seaweed" = 2, "cucumber" = 2)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/philadelphia_sushi_roll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/philadelphia_sushi_slice, 4, screentip_verb = "切块")

/obj/item/food/philadelphia_sushi_slice
	name = "费城寿司块"
	desc = "一块用奶酪、鱼肉和黄瓜做成的费城寿司。"
	icon_state = "philadelphia_sushi_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("boiled rice" = 4, "fish" = 5, "creamy cheese" = 3, "dried seaweed" = 2, "cucumber" = 2)
	foodtypes = VEGETABLES|GRAIN|SEAFOOD|DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
