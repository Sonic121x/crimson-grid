
////////////////////////////////////////////OTHER////////////////////////////////////////////
/obj/item/food/watermelonslice
	name = "西瓜片"
	desc = "一片水润的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonslice/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/watermelonmush
	name = "西瓜泥"
	desc = "一团水润的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonpulp"
	food_reagents = list(
		/datum/reagent/water = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("watermelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/watermelonmush/juice_typepath()
	return /datum/reagent/consumable/watermelonjuice

/obj/item/food/holymelonslice
	name = "圣瓜片"
	desc = "一片神圣的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonslice"
	food_reagents = list(
		/datum/reagent/water/holywater = 0.5,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("holymelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonslice/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/holymelonmush
	name = "圣瓜泥"
	desc = "一团神圣的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "holymelonpulp"
	food_reagents = list(
		/datum/reagent/water/holywater = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("holymelon" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/holymelonmush/juice_typepath()
	return /datum/reagent/water/holywater

/obj/item/food/barrelmelonslice
	name = "桶瓜片"
	desc = "一片啤酒味的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonslice"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("beer" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonslice/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/barrelmelonmush
	name = "桶瓜泥"
	desc = "一团啤酒味的美味。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "barrelmelonpulp"
	food_reagents = list(
		/datum/reagent/consumable/ethanol/beer = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.1,
		/datum/reagent/consumable/nutriment = 0.5,
	)
	tastes = list("beer" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/barrelmelonmush/juice_typepath()
	return /datum/reagent/consumable/ethanol/beer

/obj/item/food/appleslice
	name = "苹果片"
	desc = "放学后的完美零食。"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "appleslice"
	food_reagents = list(
		/datum/reagent/consumable/applejuice = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("apple" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/appleslice/juice_typepath()
	return /datum/reagent/consumable/applejuice

/obj/item/food/hugemushroomslice
	name = "巨型蘑菇片"
	desc = "从巨型蘑菇上切下来的一片。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hugemushroomslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("mushroom" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_WALKING_MUSHROOM, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/food/popcorn
	name = "爆米花"
	desc = "现在找部电影来看吧。"
	icon_state = "popcorn"
	trash_type = /obj/item/trash/popcorn
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bite_consumption = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtypes = JUNKFOOD
	eatverbs = list("咬下", "小口吃下", "啃食", "狼吞虎咽地吃下", "大口嚼下")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popcorn/salty
	name = "咸味爆米花"
	icon_state = "salty_popcorn"
	desc = "咸味爆米花，永恒的经典。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("salt" = 2, "popcorn" = 1)
	trash_type = /obj/item/trash/popcorn/salty
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/popcorn/caramel
	name = "焦糖爆米花"
	icon_state = "caramel_popcorn"
	desc = "裹着焦糖的爆米花。真甜！"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("caramel" = 2, "popcorn" = 1)
	foodtypes = JUNKFOOD | SUGAR
	trash_type = /obj/item/trash/popcorn
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/soydope
	name = "豆泥"
	desc = "大豆制成的泥。"
	icon_state = "soydope"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("soy" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/badrecipe
	name = "烧焦的一团"
	desc = "有人该为这东西被撤掉厨师的职务。"
	icon_state = "badrecipe"
	food_reagents = list(/datum/reagent/toxin/bad_food = 30)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE //Can't decompose any more than this
	/// Variable that holds the reference to the stink lines we get when we're moldy, yucky yuck
	var/stink_particles

/obj/item/food/badrecipe/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_GRILL_PROCESS, PROC_REF(OnGrill))
	RegisterSignals(src, list(COMSIG_ITEM_GRILLED_RESULT, COMSIG_ITEM_BAKED_RESULT, COMSIG_ITEM_MICROWAVE_COOKED_RESULT, COMSIG_OBJ_DECOMPOSITION_RESULT), PROC_REF(convert_to_bad_food))
	if(stink_particles)
		add_shared_particles(stink_particles)

///Prevents grilling burnt shit from well, burning.
/obj/item/food/badrecipe/proc/OnGrill()
	SIGNAL_HANDLER
	return COMPONENT_HANDLED_GRILLING

/**
 * The bad food reagent is cleared when cooked rather than just spawned and the reagents of the item this is from are transferred to this instead,
 * So we want to convert most of the consumable reagents into bad food, which is what makes the burned mess a bad thing to eat, taste aside.
 */
/obj/item/food/badrecipe/proc/convert_to_bad_food(atom/source)
	SIGNAL_HANDLER
	var/bad_food_amount = 0
	for(var/datum/reagent/consumable/food_reagent in reagents.reagent_list)
		var/amount_to_remove = food_reagent.volume * rand(6, 8) * 0.1 //around 60% to 80% of the volume is to be converted.
		food_reagent.volume -= amount_to_remove
		bad_food_amount += amount_to_remove
	reagents.update_total()
	reagents.add_reagent(/datum/reagent/toxin/bad_food, bad_food_amount, reagtemp = reagents.chem_temp)

/obj/item/food/badrecipe/Destroy(force)
	if (stink_particles)
		remove_shared_particles(stink_particles)
	return ..()

// We override the parent procs here to prevent burned messes from cooking into burned messes.
/obj/item/food/badrecipe/make_grillable()
	return
/obj/item/food/badrecipe/make_bakeable()
	return

/obj/item/food/badrecipe/moldy
	name = "发霉的一团"
	desc = "一团腐臭恶心的霉菌和蚂蚁。在这下面的某个地方，<i>曾几何时</i>还是食物。"
	food_reagents = list(/datum/reagent/consumable/mold = 30)
	preserved_food = FALSE
	ant_attracting = TRUE
	decomp_type = null
	decomposition_time = 30 SECONDS
	stink_particles = /particles/stink

/obj/item/food/badrecipe/moldy/bacteria
	name = "细菌滋生的发霉团块"
	desc = "这团腐臭恶心的烂东西不仅爬满昆虫，\
		还滋生着各种微生物。<i>你不看它时，它会动。</i>"

/obj/item/food/badrecipe/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

/obj/item/food/spidereggs
	name = "蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵。当你不在乎健康时，它就是上好的配菜。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin = 2,
	)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | TOXIC | BUGS | EGG
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/spidereggs/processed
	name = "处理过的蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵。在嘴里爆开，却不会让你生病。"
	icon_state = "spidereggs"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("cobwebs" = 1)
	foodtypes = MEAT | EGG
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spiderling
	name = "幼蛛"
	desc = "它还在你手里微微抽动。呕……"
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "spiderling_dead"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 4,
	)
	tastes = list("cobwebs" = 1, "guts" = 2)
	foodtypes = MEAT | TOXIC | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonfruitbowl
	name = "蜜瓜水果碗"
	desc = "献给想体验味觉爆炸的人。"
	icon_state = "melonfruitbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("melon" = 1)
	foodtypes = VEGETABLES|FRUIT|ORANGES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/melonkeg
	name = "西瓜酒桶"
	desc = "谁知道伏特加原来是种水果？"
	icon_state = "melonkeg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/ethanol/vodka = 15,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	max_volume = 80
	bite_consumption = 5
	tastes = list("grain alcohol" = 1, "fruit" = 1)
	foodtypes = FRUIT | ALCOHOL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/honeybar
	name = "蜂蜜坚果棒"
	desc = "燕麦和坚果靠蜂蜜糖衣黏合，压成一条。"
	icon_state = "honeybar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/honey = 5,
	)
	tastes = list("oats" = 3, "nuts" = 2, "honey" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/powercrepe
	name = "强力可丽饼"
	desc = "能力越大，可丽饼越强。看着像夹果冻的薄饼，打起人来却毫不含糊。"
	icon_state = "powercrepe"
	inhand_icon_state = "powercrepe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	force = 30
	throwforce = 15
	block_chance = 55
	armour_penetration = 80
	block_sound = 'sound/items/weapons/parry.ogg'
	wound_bonus = -50
	attack_verb_continuous = list("拍打", "糊抹")
	attack_verb_simple = list("拍打", "糊抹")
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("cherry" = 1, "crepe" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.7)

/obj/item/food/branrequests
	name = "求麸麦片"
	desc = "满足你对麦麸渴求的干麦片，葡萄干与盐的独特风味。"
	icon_state = "bran_requests"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 8,
	)
	tastes = list("bran" = 4, "raisins" = 3, "salt" = 1)
	foodtypes = SUGAR|GRAIN|FRUIT|BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butter
	name = "黄油条"
	desc = "一条金黄、肥美又可口的黄油。"
	icon_state = "butter"
	food_reagents = list(/datum/reagent/consumable/nutriment/fat = 6)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	dog_fashion = /datum/dog_fashion/head/butter
	var/can_stick = TRUE

/obj/item/food/butter/examine(mob/user)
	. = ..()
	if (can_stick)
		. += span_notice("有根铁杆就能做成<b>黄油串</b>。")

/obj/item/food/butter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stack/rods) || !can_stick)
		return NONE

	var/obj/item/stack/rods/rods = tool
	if(!rods.use(1))//borgs can still fail this if they have no metal
		to_chat(user, span_warning("你没有足够的铁来把[src]串起来！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把铁杆插进黄油条里。"))
	user.temporarilyRemoveItemFromInventory(src)
	var/obj/item/food/butter/on_a_stick/new_item = new(drop_location())
	if (new_item.IsReachableBy(user))
		user.put_in_hands(new_item)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/food/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "黄油串"
	desc = "串在杆上的金黄肥美好滋味。"
	icon_state = "butteronastick"
	trash_type = /obj/item/stack/rods
	food_flags = FOOD_FINGER_FOOD
	venue_value = FOOD_PRICE_CHEAP
	can_stick = FALSE

/obj/item/food/butter/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/butterslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/butterslice
	name = "黄油片"
	desc = "一片黄油，满足你的涂抹需求。"
	icon_state = "butterslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/onionrings
	name = "洋葱圈"
	desc = "裹着面糊的洋葱片。"
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("batter" = 3, "onion" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pineappleslice
	name = "菠萝片"
	desc = "切下的一片多汁菠萝。"
	icon_state = "pineapple_slice"
	tastes = list("pineapple" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/pineappleslice/juice_typepath()
	return /datum/reagent/consumable/pineapplejuice

/obj/item/food/crab_rangoon
	name = "蟹肉奶酪炸馄饨"
	desc = "它有很多名字：蟹肉酥、奶酪馄饨、蟹肉饺？随便怎么叫，浓郁的奶油奶酪与蟹肉风味都会让你大呼过瘾。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "crabrangoon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cream cheese" = 4, "crab" = 3, "crispiness" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	custom_price = 2 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/pesto
	name = "罗勒青酱"
	desc = "由硬质奶酪、盐、香草、大蒜、油和松子混合制成，常用来拌意面、抹披萨或搭配面包。"
	icon_state = "pesto"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pesto" = 1)
	foodtypes = VEGETABLES | DAIRY | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/tomato_sauce
	name = "番茄酱汁"
	desc = "番茄酱汁，最适合搭配披萨或意面。妈妈咪呀！"
	icon_state = "tomato_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1, "herbs" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bechamel_sauce
	name = "白酱"
	desc = "欧洲多种饮食文化中常见的经典白酱。"
	icon_state = "bechamel_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("cream" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roasted_bell_pepper
	name = "烤甜椒"
	desc = "表皮烤得焦黑起泡的甜椒，很适合做酱。"
	icon_state = "roasted_bell_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("bell pepper" = 1, "char" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pierogi
	name = "波兰饺子"
	desc = "用未发酵面皮包住咸馅或甜馅，再下沸水煮熟的饺子。这只包着土豆洋葱馅。"
	icon_state = "pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("potato" = 1, "onions" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/stuffed_cabbage
	name = "酿卷心菜"
	desc = "熟卷心菜叶包着咸香的肉末米饭馅，再淋上番茄酱汁。美味得要命。"
	icon_state = "stuffed_cabbage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("juicy meat" = 1, "rice" = 1, "cabbage" = 1)
	foodtypes = MEAT|VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/seaweedsheet
	name = "海苔片"
	desc = "用来做寿司的干海苔片。把食材放上去，就能开始制作自选寿司！"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("seaweed" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/seaweedsheet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/sushi/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

/obj/item/food/seaweedsheet/saltcane
	name = "干盐蔗叶鞘"
	desc = "一片可用于做寿司的干盐蔗叶鞘。把食材放上去，就能开始制作自选寿司！"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("seaweed" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/granola_bar
	name = "燕麦坚果棒"
	desc = "燕麦、坚果、水果和巧克力的干混合物压成耐嚼的棒状，是太空徒步时的绝佳零食。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "granola_bar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("granola" = 1, "nuts" = 1, "chocolate" = 1, "raisin" = 1)
	foodtypes = GRAIN|NUTS|FRUIT|SUGAR|CHOCOLATE //DARKPACK EDIT CHANGE: Chocolate
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/onigiri
	name = "饭团"
	desc = "米饭包住馅料，捏成三角形，再裹上海苔。可以添加馅料！"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "onigiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("rice" = 1, "dried seaweed" = 1)
	foodtypes = VEGETABLES|GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = 1 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/onigiri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/onigiri/empty, CUSTOM_INGREDIENT_ICON_NOCHANGE, max_ingredients = 4)

// empty onigiri for custom onigiri
/obj/item/food/onigiri/empty
	name = "饭团"
	desc = "米饭包住馅料，捏成三角形，再裹上海苔。"
	icon_state = "onigiri"
	foodtypes = VEGETABLES|GRAIN
	tastes = list()

/obj/item/food/pacoca
	name = "巴西花生酥"
	desc = "巴西传统点心，将磨碎的花生、糖和盐压成圆柱形。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pacoca"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("peanuts" = 1, "sweetness" = 1)
	foodtypes = NUTS | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pickle
	name = "腌黄瓜"
	desc = "略微皱缩、颜色发暗的黄瓜，闻起来酸酸的，却格外诱人。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pickle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pickle = 1,
		/datum/reagent/medicine/antihol = 2,
	)
	tastes = list("pickle" = 1, "spices" = 1, "salt water" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pickle/juice_typepath()
	return /datum/reagent/consumable/pickle

/obj/item/food/pickle/make_edible()
	. = ..()
	AddComponentFrom(SOURCE_EDIBLE_INNATE, /datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/pickle/proc/check_liked(mob/living/carbon/human/consumer)
	var/obj/item/organ/liver/liver = consumer.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!HAS_TRAIT(consumer, TRAIT_AGEUSIA) && liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM))
		return FOOD_LIKED

/obj/item/food/springroll
	name = "春卷"
	desc = "一盘用半透明米皮裹着新鲜蔬菜的春卷，配上甜辣酱。喜欢的人很喜欢，不喜欢的人很讨厌。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "springroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("rice wrappers" = 1, "spice" = 1, "crunchy veggies" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_price = 1 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/cheese_pierogi
	name = "奶酪波兰饺子"
	desc = "用未发酵面皮包住咸馅或甜馅，再下沸水煮熟的饺子。这只包着土豆奶酪馅。"
	icon_state = "cheese_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("potato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_pierogi
	name = "肉馅波兰饺子"
	desc = "用未发酵面皮包住咸馅或甜馅，再下沸水煮熟的饺子。这只包着土豆肉馅。"
	icon_state = "meat_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("potato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/stuffed_eggplant
	name = "酿茄子"
	desc = "半个烤熟的茄子，茄肉挖出后混入肉、奶酪和蔬菜，再填回去。"
	icon_state = "stuffed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("cooked eggplant" = 5, "cheese" = 4, "ground meat" = 3, "veggies" = 2)
	foodtypes = VEGETABLES | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka
	name = "地中海茄子肉末千层焗"
	desc = "茄子、混合蔬菜和肉层层铺叠，覆上白酱焗制的地中海菜肴。可以切片。"
	icon_state = "moussaka"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("cooked eggplant" = 5, "potato" = 1, "baked veggies" = 2, "meat" = 4, "bechamel sauce" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/moussaka/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/moussaka_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "切开")

/obj/item/food/moussaka_slice
	name = "地中海茄子肉末千层焗片"
	desc = "茄子、混合蔬菜和肉层层铺叠，覆上白酱焗制的地中海菜肴。真美味！"
	icon_state = "moussaka_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("cooked eggplant" = 5, "potato" = 1, "baked veggies" = 2, "meat" = 4, "bechamel sauce" = 3)
	foodtypes = MEAT|VEGETABLES|GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT / 4)

/obj/item/food/candied_pineapple
	name = "糖渍菠萝"
	desc = "裹糖后风干的菠萝块，成了耐嚼的小点心。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	icon_state = "candied_pineapple_1"
	base_icon_state = "candied_pineapple"
	tastes = list("sugar" = 2, "chewy pineapple" = 4)
	foodtypes = SUGAR|FRUIT|PINEAPPLE
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/candied_pineapple/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/raw_pita_bread
	name = "生皮塔饼"
	desc = "一张黏黏的生皮塔饼。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "raw_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_pita_bread/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/raw_pita_bread/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/pita_bread
	name = "皮塔饼"
	desc = "源于地中海、用途广泛的香甜薄饼。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("pita bread" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_sauce
	name = "希腊蒜香酸奶酱"
	desc = "地中海和中东菜肴中广泛使用的蒜香酱汁，拿皮塔饼或蔬菜直接蘸着吃就很美味。"
	icon_state = "tzatziki_sauce"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("garlic" = 4, "cucumber" = 2, "olive oil" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_and_pita_bread
	name = "希腊蒜香酸奶酱配皮塔饼"
	desc = "希腊蒜香酸奶酱，现在配上皮塔饼蘸食。健康与美味兼备。"
	icon_state = "tzatziki_and_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("pita bread" = 4, "tzatziki sauce" = 2, "olive oil" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_beef_gyro
	name = "烤牛肉希腊卷饼"
	desc = "传统希腊料理，用皮塔饼包住肉、番茄、卷心菜、洋葱和希腊蒜香酸奶酱。"
	icon_state = "grilled_beef_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("pita bread" = 4, "tender meat" = 2, "tzatziki sauce" = 2, "mixed veggies" = 2)
	foodtypes = VEGETABLES | GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/vegetarian_gyro
	name = "素食希腊卷饼"
	desc = "用黄瓜代替肉的传统希腊卷饼，依旧风味浓郁、营养丰富。"
	icon_state = "vegetarian_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("pita bread" = 4, "cucumber" = 2, "tzatziki sauce" = 2, "mixed veggies" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4

///Extracted from squids, or any fish with the ink fish trait.
/obj/item/food/ink_sac
	name = "墨囊"
	desc = "取自某种鱼类或软体动物的墨囊，可以用加工机制成罐头。"
	icon_state = "ink_sac"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("seafood" = 3)
	foodtypes = SEAFOOD|RAW

/obj/item/food/ink_sac/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/splat, \
		memory_type = /datum/memory/witnessed_inking, \
		smudge_type = /obj/effect/decal/cleanable/food/squid_ink, \
		moodlet_type = /datum/mood_event/inked, \
		splat_color = COLOR_NEARLY_ALL_BLACK, \
		hit_callback = CALLBACK(src, PROC_REF(blind_em)), \
	)

/obj/item/food/ink_sac/proc/blind_em(mob/living/victim, can_splat_on)
	if(can_splat_on)
		victim.adjust_temp_blindness_up_to(2.5 SECONDS, 3 SECONDS)
		victim.adjust_confusion_up_to(2.5 SECONDS, 3 SECONDS)
	victim.visible_message(span_warning("[victim]被[src]泼了一身墨汁！"), span_userdanger("你被[src]泼了一身墨汁！"))
	playsound(victim, SFX_DESECRATION, 50, TRUE)
