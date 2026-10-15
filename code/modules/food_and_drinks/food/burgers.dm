/obj/item/food/burger
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "hburger"
	inhand_icon_state = "burger"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtypes = GRAIN | MEAT //lettuce doesn't make burger a vegetable.
	eat_time = 15 //Quick snack
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_price = 3 // DARKPACK EDIT ADD - ECONOMY

/obj/item/food/burger/plain
	name = "原味汉堡"
	desc = "每顿营养早餐的基石。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN | MEAT
	custom_price = PAYCHECK_CREW * 0.8
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/plain/Initialize(mapload)
	. = ..()
	if(!prob(1))
		return
	new/obj/effect/particle_effect/fluid/smoke(get_turf(src))
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE)
	visible_message(span_warning("老天爷啊！[src]毁了！不过，要是……？"))
	name = "蒸火腿"
	// DARKPACK EDIT CHANGE START
	desc = pick("啊，主管，欢迎。希望你准备好享用一顿难忘的午餐了！",
		"这些明明是微波炉加热的，你却叫它们蒸火腿？",
		"北极光？在这个时节、这个夜晚、这座城市，而且只出现在你的冰柜里？",
		"你知道吗，这些汉堡吃起来很像奥托利快餐店的汉堡。")
	// DARKPACK EDIT CHANGE END

/obj/item/food/burger/human
	name = "人肉汉堡"
	desc = "血淋淋的汉堡。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "long pig" = 4)
	foodtypes = MEAT | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/human/on_craft_completion(list/components, datum/crafting_recipe/current_recipe, atom/crafter)
	. = ..()
	for(var/datum/material/meat/mob_meat/mob_meat_material in custom_materials)
		if(mob_meat_material.subjectname)
			name = "[mob_meat_material.subjectname]汉堡"
		else if(mob_meat_material.subjectjob)
			name = "[JOB_DISPLAY_NAME(mob_meat_material.subjectjob)]汉堡"

/obj/item/food/burger/corgi
	name = "柯基汉堡"
	desc = "你这个恶魔。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "corgi meat" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/appendix
	name = "阑尾汉堡"
	desc = "尝起来像阑尾炎。"
	icon_state = "appendixburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "grass" = 2)
	foodtypes = GRAIN | MEAT | GORE
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/fish
	name = "鲤鱼柳三明治"
	desc = "仿佛有条鲤鱼在什么地方叫喊……把那鲤鱼柳还给我，把那条鲤鱼给我。"
	icon_state = "fishburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 4, "fish" = 4)
	foodtypes = GRAIN | SEAFOOD | DAIRY
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/burger/tofu
	name = "豆腐汉堡"
	desc = "什么……那是肉吗？"
	icon_state = "tofuburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("bun" = 4, "tofu" = 4)
	foodtypes = GRAIN | VEGETABLES
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/roburger
	name = "机械汉堡"
	desc = "生菜是唯一的有机成分。哔。"
	icon_state = "roburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/cyborg_mutation_nanomachines = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 4, "lettuce" = 2, "sludge" = 1)
	foodtypes = GRAIN | TOXIC
	venue_value = FOOD_PRICE_EXOTIC

/obj/item/food/burger/roburger/big
	desc = "这块巨大的肉饼看起来像毒药。哔。"
	max_volume = 120
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/cyborg_mutation_nanomachines = 80,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)

/obj/item/food/burger/xeno
	name = "异形汉堡"
	desc = "闻起来刺鼻，尝起来满是异端滋味。"
	icon_state = "xburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 4, "acid" = 4)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/bearger
	name = "熊肉汉堡"
	desc = "生吃最佳——嗷！"
	icon_state = "bearger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "meat" = 2, "salmon" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/clown
	name = "小丑汉堡"
	desc = "这味道有点逗……"
	icon_state = "clownburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 2, "a bad joke" = 4)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/mime
	name = "默剧汉堡"
	desc = "它的滋味难以言表。"
	icon_state = "mimeburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nothing = 6,
	)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/brain
	name = "脑花汉堡"
	desc = "模样古怪的汉堡，看起来几乎有了意识。"
	icon_state = "brainburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/medicine/mannitol = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("bun" = 4, "brains" = 2)
	foodtypes = GRAIN | MEAT | GORE
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/ghost
	name = "幽灵汉堡"
	desc = "太吓人了！"
	icon_state = "ghostburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("bun" = 2, "ectoplasm" = 4)
	foodtypes = GRAIN
	alpha = 170
	verb_say = "呻吟"
	verb_yell = "哀嚎"
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3
	preserved_food = TRUE // It's made of ghosts

/obj/item/food/burger/ghost/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	START_PROCESSING(SSobj, src)
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/burger/ghost/make_germ_sensitive()
	return // This burger moves itself so it shouldn't pick up germs from walking onto the floor

/obj/item/food/burger/ghost/process()
	if(!isturf(loc)) //no floating out of bags
		return
	var/paranormal_activity = rand(100)
	switch(paranormal_activity)
		if(97 to 100)
			audible_message("[src]摇得一截锁链哗哗作响。")
			playsound(loc, 'sound/misc/chain_rattling.ogg', 300, TRUE)
		if(91 to 96)
			say(pick("呜呜呜……", "呜——呜呜！！"))
		if(84 to 90)
			dir = pick(NORTH, SOUTH, EAST, WEST, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
			step(src, dir)
		if(71 to 83)
			step(src, dir)
		if(65 to 70)
			var/obj/machinery/light/light = locate(/obj/machinery/light) in view(4, src)
			light?.flicker()
		if(62 to 64)
			playsound(loc, SFX_HALLUCINATION_I_SEE_YOU, 50, TRUE, ignore_walls = FALSE)
		if(61)
			visible_message("[src]喷出了一团灵质！")
			new /obj/effect/decal/cleanable/greenglow/ecto(loc)
			playsound(loc, 'sound/effects/splat.ogg', 200, TRUE)

/obj/item/food/burger/ghost/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/food/burger/red
	name = "红色汉堡"
	desc = "完美掩盖了它已经烤成焦炭的事实。"
	icon_state = "cburger"
	color = COLOR_RED
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/red = 10,
	)
	tastes = list("bun" = 2, "red" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/orange
	name = "橙色汉堡"
	desc = "果汁含量为0%。"
	icon_state = "cburger"
	color = COLOR_ORANGE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/orange = 10,
	)
	tastes = list("bun" = 2, "orange" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/yellow
	name = "黄色汉堡"
	desc = "鲜亮到最后一口。"
	icon_state = "cburger"
	color = COLOR_YELLOW
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/yellow = 10,
	)
	tastes = list("bun" = 2, "yellow" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/green
	name = "绿色汉堡"
	desc = "不是变质肉，是上了色的肉！"
	icon_state = "cburger"
	color = COLOR_GREEN
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/green = 10,
	)
	tastes = list("bun" = 2, "green" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/blue
	name = "蓝色汉堡"
	desc = "这是极生的蓝色汉堡吗？"
	icon_state = "cburger"
	color = COLOR_BLUE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/blue = 10,
	)
	tastes = list("bun" = 2, "blue" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/purple
	name = "紫色汉堡"
	desc = "既高贵又低俗。"
	icon_state = "cburger"
	color = COLOR_PURPLE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/purple = 10,
	)
	tastes = list("bun" = 2, "purple" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/black
	name = "黑色汉堡"
	desc = "这个烤过头了。"
	icon_state = "cburger"
	color = COLOR_ALMOST_BLACK
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/black = 10,
	)
	tastes = list("bun" = 2, "black" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/white
	name = "白色汉堡"
	desc = "美味的钛！"
	icon_state = "cburger"
	color = COLOR_WHITE
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/colorful_reagent/powder/white = 10,
	)
	tastes = list("bun" = 2, "white" = 2)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/spell
	name = "咒术汉堡"
	desc = "这绝对是 Ei Nath。"
	icon_state = "spellburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("bun" = 4, "magic" = 2)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/bigbite
	name = "大口汉堡"
	desc = "忘了巨无霸吧，这才是未来！"
	icon_state = "bigbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("bun" = 2, "meat" = 10)
	w_class = WEIGHT_CLASS_NORMAL
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/jelly
	name = "果酱汉堡"
	desc = "美食享受……？"
	icon_state = "jellyburger"
	tastes = list("bun" = 4, "jelly" = 2)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/jelly/slime
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/slimejelly = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | TOXIC

/obj/item/food/burger/jelly/cherry
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cherryjelly = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	foodtypes = GRAIN | FRUIT

/obj/item/food/burger/superbite
	name = "超大口汉堡"
	desc = "堆得像山一样的汉堡。食物啊！"
	icon_state = "superbiteburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 26,
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 13,
	)
	w_class = WEIGHT_CLASS_NORMAL
	bite_consumption = 7
	max_volume = 100
	tastes = list("bun" = 4, "type two diabetes" = 10)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES | EGG
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/superbite/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始一口吞下[src]，看起来是在试图自杀！"))
	var/datum/component/edible/component = GetComponent(/datum/component/edible)
	component?.TakeBite(user, user)
	return OXYLOSS

/obj/item/food/burger/fivealarm
	name = "五级火警汉堡"
	desc = "辣！辣！"
	icon_state = "fivealarmburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/condensedcapsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("extreme heat" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/rat
	name = "老鼠汉堡"
	desc = "基本上就是你想的那样……"
	icon_state = "ratburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("dead rat" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT | GORE | RAW
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/baseball
	name = "本垒打棒球汉堡"
	desc = "它还热乎着，冒出的蒸汽看起来像棒球。"
	icon_state = "baseball"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 2, "a home run" = 4)
	foodtypes = GRAIN | GROSS
	custom_price = PAYCHECK_CREW * 0.8
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = /obj/item/melee/baseball_bat::custom_materials

/obj/item/food/burger/baconburger
	name = "培根汉堡"
	desc = "各种美式元素的完美结合。"
	icon_state = "baconburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bacon" = 4, "bun" = 2)
	foodtypes = GRAIN | MEAT
	custom_premium_price = PAYCHECK_CREW * 1.6
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/burger/empoweredburger
	name = "充能汉堡"
	desc = "好吃到触电，前提是你靠电力为生。"
	icon_state = "empoweredburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/liquidelectricity = 6,
	)
	tastes = list("bun" = 2, "pure electricity" = 4)
	foodtypes = GRAIN | TOXIC
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/burger/catburger
	name = "猫肉汉堡"
	desc = "那些猫和猫人终于有点用处了！"
	icon_state = "catburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 4, "meat" = 2, "cat" = 2)
	foodtypes = GRAIN | MEAT | GORE
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/crab
	name = "蟹肉汉堡"
	desc = "美味的蟹肉饼，往面包中间一夹就成。"
	icon_state = "crabburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "crab meat" = 4)
	foodtypes = GRAIN | SEAFOOD
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/soylent
	name = "索伊伦汉堡"
	desc = "用低价值索伊伦食品回收加工而成的环保汉堡。" // DARKPACK EDIT CHANGE
	icon_state = "soylentburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("bun" = 2, "assistant" = 4)
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/rib
	name = "撑破肚汉堡" // DARKPACK EDIT CHANGE
	desc = "全国限量供应、难得一见的肋排形汉堡。没有你记忆中那么好吃。" // DARKPACK EDIT CHANGE
	icon_state = "mcrib"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/bbqsauce = 1,
		)
	tastes = list("bun" = 2, "pork patty" = 4)
	foodtypes = GRAIN | MEAT | SUGAR | VEGETABLES
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/mcguffin
	name = "麦高芬汉堡"
	desc = "班尼迪克蛋的廉价油腻仿制品。"
	icon_state = "mcguffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/eggyolk = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("muffin" = 2, "bacon" = 3)
	foodtypes = GRAIN | MEAT | BREAKFAST | FRIED | EGG
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/burger/chicken
	name = "鸡肉三明治"
	//Apparently the proud people of Americlapstan object to this thing being called a burger.
	//Apparently McDonald's just calls it a burger in Europe as to not scare and confuse us.
	desc = "美味的鸡肉三明治。" // DARKPACK EDIT CHANGE
	icon_state = "chickenburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("bun" = 2, "chicken" = 4, "God's covenant" = 1)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/cheese
	name = "奶酪汉堡"
	desc = "这位高贵的汉堡披着金色奶酪，傲然挺立。"
	icon_state = "cheeseburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 3)
	foodtypes = GRAIN | MEAT | DAIRY
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/burger/cheese/Initialize(mapload)
	. = ..()
	if(prob(33))
		icon_state = "cheeseburgeralt"

/obj/item/food/burger/crazy
	name = "疯狂汉堡"
	desc = "这看起来像是一个穿着风衣的疯小丑会做出的食物。"
	icon_state = "crazyburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 3,
		/datum/reagent/consumable/condensedcapsaicin = 3,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("bun" = 2, "beef patty" = 4, "cheese" = 2, "beef soaked in chili" = 3, "a smoking flare" = 2)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(
		/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 0.5,
		/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 0.5,
	)

/obj/item/food/burger/crazy/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/food/burger/crazy/process(seconds_per_tick) // DIT EES HORRIBLE
	if(SPT_PROB(2.5, seconds_per_tick))
		do_smoke(0, src, loc, smoke_type = /datum/effect_system/fluid_spread/smoke/bad/green)

// empty burger you can customize
/obj/item/food/burger/empty
	name = "汉堡"
	desc = "一个疯厨师做出的疯狂自制汉堡。"
	icon_state = "custburg"
	tastes = list("bun")
	foodtypes = GRAIN

/obj/item/food/burger/sloppy_moe
	name = "邋遢莫汉堡"
	desc = "肉糜拌上洋葱和烧烤酱，随手往汉堡面包上一堆。美味，但保证会弄脏你的手。"
	icon_state = "sloppy_moe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("juicy meat" = 4, "BBQ sauce" = 3, "onions" = 2, "bun" = 2)
	foodtypes = MEAT|VEGETABLES|GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)
