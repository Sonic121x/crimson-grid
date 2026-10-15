// Pizza (Whole)
/obj/item/food/pizza
	name = "bugged pizza"
	desc = "This pizza should not be."
	icon = 'icons/obj/food/pizza.dmi'
	abstract_type = /obj/item/food/pizza
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 6 at a time and replaces this pizza when processed by cutting tool
	var/obj/item/food/pizzaslice/slice_type = /obj/item/food/pizzaslice
	///What label pizza boxes use if this pizza spawns in them.
	var/boxtag = ""
	/// how many slices left
	var/slices_left = 6
	/// have we been sliced? like sliced and you can take it apart by hand
	var/sliced = FALSE
	/// cutting tools
	var/list/cutting_tools = list(TOOL_KNIFE, TOOL_SAW, TOOL_SCALPEL)

/obj/item/food/pizza/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/drag_pickup)
	register_context()

/obj/item/food/pizza/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(istype(held_item) && (held_item.tool_behaviour in cutting_tools))
		context[SCREENTIP_CONTEXT_LMB] = "切片"
		context[SCREENTIP_CONTEXT_RMB] = "切开分离"
		return TRUE

	if(sliced)
		context[SCREENTIP_CONTEXT_LMB] = "取一片"
		return TRUE

/obj/item/food/pizza/examine(mob/user)
	. = ..()
	if(isnull(slice_type) || !sliced)
		return
	. += span_notice("将它切片后，就能空手取出披萨片！")

/obj/item/food/pizza/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(isnull(slice_type) || !(tool.tool_behaviour in cutting_tools))
		return
	if(!sliced)
		slice(user, tool)
		return ITEM_INTERACT_SUCCESS
	user.visible_message(span_notice("[user]用[tool]将[src]分成了独立的披萨片。"))
	cut_apart()
	return ITEM_INTERACT_SUCCESS

/obj/item/food/pizza/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	. = NONE
	if(isnull(slice_type) || !(tool.tool_behaviour in cutting_tools))
		return
	visible_message(span_notice("[user]用[tool]将[src]分成了独立的披萨片。"))
	cut_apart()
	return ITEM_INTERACT_SUCCESS

/obj/item/food/pizza/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!sliced)
		return
	user.visible_message(span_notice("[user]从[src]上取了一片。"), span_notice("你从[src]上取了一片。"))
	produce_slice(user)

/obj/item/food/pizza/proc/get_slices_filter() //to not repeat code
	return alpha_mask_filter(icon = icon('icons/obj/food/pizza.dmi', "[slices_left]slices"))

/// slices this pizza. all arguments optional.
/obj/item/food/pizza/proc/slice(mob/user, obj/item/tool)
	if(sliced)
		return
	tool?.play_tool_sound(src)
	sliced = TRUE
	user?.visible_message(span_notice("[user]用[tool]将[src]切成了6片。"))
	interaction_flags_item &= ~INTERACT_ITEM_ATTACK_HAND_PICKUP

/obj/item/food/pizza/proc/cut_apart()
	for(var/_ in 1 to slices_left)
		produce_slice(no_update = TRUE)

/// make a slice and give it to user. no_update means no filter work is done. user is optional
/obj/item/food/pizza/proc/produce_slice(mob/user, no_update = FALSE)
	var/turf/our_turf = get_turf(src)
	var/obj/item/food/pizzaslice/slice = new slice_type(our_turf)
	if(HAS_TRAIT(src, TRAIT_FOOD_SILVER))
		ADD_TRAIT(slice, TRAIT_FOOD_SILVER, INNATE_TRAIT)
	if(HAS_TRAIT(src, TRAIT_HANDMADE))
		ADD_TRAIT(slice, TRAIT_HANDMADE, GET_TRAIT_SOURCES(src, TRAIT_HANDMADE)[1]) // wack thing to inherit first source
	slice.pixel_x += rand(-6, 6)
	slice.pixel_y += rand(-6, 6)
	user?.put_in_active_hand(slice)

	slice.reagents.remove_all()
	reagents.trans_to(slice, amount = reagents.total_volume / slices_left, no_react = TRUE)
	SEND_SIGNAL(src, COMSIG_PIZZA_SLICE_TAKEN, user, slice)

	slices_left--
	if(slices_left <= 0)
		qdel(src)
		return
	if(no_update)
		return
	remove_filter("pizzaslices")
	add_filter("pizzaslices", 1, get_slices_filter())

// Pizza Slice
/obj/item/food/pizzaslice
	name = "bugged pizza slice"
	desc = "This slice of pizza should not be"
	icon = 'icons/obj/food/pizza.dmi'
	abstract_type = /obj/item/food/pizzaslice
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	decomp_type = /obj/item/food/pizzaslice/moldy
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizzaslice/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/stack/sheet/pizza, 1, 1 SECONDS, table_required = TRUE, screentip_verb = "擀平", sound_to_play = SFX_ROLLING_PIN_ROLLING)

/obj/item/food/pizza/custom
	name = "披萨"
	desc = "一份精致的自制披萨。"
	icon_state = "pizzamargherita" // Colored by the ingredient_holder component
	slice_type = /obj/item/food/pizzaslice/custom

/obj/item/food/pizzaslice/custom
	name = "披萨片"
	desc = "一片精致的自制披萨。"
	icon_state = "pizzamargheritaslice"

/obj/item/food/pizza/margherita
	name = "玛格丽特披萨"
	desc = "全银河奶酪味最浓郁的披萨。"
	icon_state = "pizzamargherita"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/margherita
	boxtag = "豪华玛格丽特"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/margherita/raw
	name = "生玛格丽特披萨"
	icon_state = "pizzamargherita_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/margherita/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/margherita, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/margherita/robo
	food_reagents = list(
		/datum/reagent/cyborg_mutation_nanomachines = 70,
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)

/obj/item/food/pizzaslice/margherita
	name = "玛格丽特披萨片"
	desc = "一片全银河奶酪味最浓郁的披萨。"
	icon_state = "pizzamargheritaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizzaslice/margherita/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 12)

/obj/item/food/pizza/meat
	name = "肉披萨"
	desc = "油滋滋的披萨，铺满了美味的肉。"
	icon_state = "meatpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	foodtypes = GRAIN | VEGETABLES| DAIRY | MEAT
	slice_type = /obj/item/food/pizzaslice/meat
	boxtag = "肉食至尊"
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 4)

/obj/item/food/pizza/meat/raw
	name = "生肉披萨"
	icon_state = "meatpizza_raw"
	foodtypes = GRAIN | VEGETABLES| DAIRY | MEAT | RAW
	slice_type = null

/obj/item/food/pizza/meat/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/meat, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/meat
	name = "肉披萨片"
	desc = "一片营养丰富的肉披萨。"
	icon_state = "meatpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizzaslice/meat/pizzeria //Reward for pizzeria bitrunning domain; not really meant to be eaten but functionality as food still exists for remote tasters and absurdly determined persons.
	name = "老披萨店肉披萨片"
	desc = "来自一家早已关门的披萨店，几乎没有营养的肉披萨片。它硬得像纸板，看着就难以下咽，大概不值得为了吃它把下巴弄坏。"
	tastes = list("crust" = 1, "ketchup" = 1, "'cheese'" = 1, "mystery meat" = 1, "glue" = 1)
	bite_consumption = 0.1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
	)
	foodtypes = parent_type::foodtypes | GROSS
	eat_time = 5 MINUTES

/obj/item/food/pizzaslice/meat/pizzeria/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_FOOD_CONSUMED, PROC_REF(on_consumed))

/// Little bit of flavor for the absurdly persistent pizza eater.
/obj/item/food/pizzaslice/meat/pizzeria/proc/on_consumed(datum/source, mob/living/eater, mob/feeder)
	SIGNAL_HANDLER

	to_chat(eater, span_notice("你终于吃完了那块垃圾，胃痛也随之而来。这片披萨肯定还有更好的用途……"))

	return NONE

/obj/item/food/pizza/mushroom
	name = "蘑菇披萨"
	desc = "一份非常特别的披萨。"
	icon_state = "mushroompizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mushroom
	boxtag = "蘑菇特选"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizza/mushroom/raw
	name = "生蘑菇披萨"
	icon_state = "mushroompizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/mushroom/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mushroom, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/mushroom
	name = "蘑菇披萨片"
	desc = "这可能是你这辈子吃的最后一片披萨。"
	icon_state = "mushroompizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2


/obj/item/food/pizza/vegetable
	name = "蔬菜披萨"
	desc = "制作这份披萨的过程中，没有任何番茄智人受到伤害。"
	icon_state = "vegetablepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/vegetable
	boxtag = "精选时蔬"
	venue_value = FOOD_PRICE_NORMAL

/obj/item/food/pizza/vegetable/raw
	name = "生蔬菜披萨"
	icon_state = "vegetablepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/vegetable/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/vegetable, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/vegetable
	name = "蔬菜披萨片"
	desc = "在所有不含绿色食材的披萨里，这一片最“绿色”。"
	icon_state = "vegetablepizzaslice"
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/donkpocket
	name = "当克口袋饼披萨"
	desc = "谁会觉得这是个好主意？"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "umami" = 1, "laziness" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY|JUNKFOOD
	slice_type = /obj/item/food/pizzaslice/donkpocket
	boxtag = "超赞当克"
	crafting_complexity = FOOD_COMPLEXITY_3
	intrinsic_food_materials = list(/datum/material/meat) //default donkpockets do not contain meat but homemade ones do.

/obj/item/food/pizza/donkpocket/raw
	name = "生当克口袋饼披萨"
	icon_state = "donkpocketpizza_raw"
	foodtypes = GRAIN|VEGETABLES|DAIRY|JUNKFOOD|RAW
	slice_type = null

/obj/item/food/pizza/donkpocket/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/donkpocket, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/donkpocket
	name = "当克口袋饼披萨片"
	desc = "闻起来像当克口袋饼。"
	icon_state = "donkpocketpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "umami" = 1, "laziness" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY|JUNKFOOD
	intrinsic_food_materials = list(/datum/material/meat) //default donkpockets do not contain meat but homemade ones do.

/obj/item/food/pizza/dank
	name = "大麻披萨"
	desc = "嬉皮士的披萨首选。"
	icon_state = "dankpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/doctor_delight = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "weed" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/dank
	boxtag = "新鲜香草"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/dank/raw
	name = "生大麻披萨"
	icon_state = "dankpizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/dank/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/dank, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/dank
	name = "大麻披萨片"
	desc = "兄弟，太爽了……"
	icon_state = "dankpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "weed" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/sassysage
	name = "骚气香肠披萨"
	desc = "你几乎能尝到那股骚气。"
	icon_state = "sassysagepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	slice_type = /obj/item/food/pizzaslice/sassysage
	boxtag = "香肠爱好者"
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pizza/sassysage/raw
	name = "生骚气香肠披萨"
	icon_state = "sassysagepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | RAW
	slice_type = null

/obj/item/food/pizza/sassysage/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/sassysage, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/sassysage
	name = "骚气香肠披萨片"
	desc = "骚气又美味。"
	icon_state = "sassysagepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/pineapple
	name = "\improper 夏威夷披萨"
	desc = "披萨界的爱因斯坦谜题。"
	icon_state = "pineapplepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/pineapplejuice = 8,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE
	slice_type = /obj/item/food/pizzaslice/pineapple
	boxtag = "檀香山嚼趣"
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT * 2)

/obj/item/food/pizza/pineapple/raw
	name = "生夏威夷披萨"
	icon_state = "pineapplepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE | RAW
	slice_type = null

/obj/item/food/pizza/pineapple/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/pineapple, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/pineapple
	name = "\improper 夏威夷披萨片"
	desc = "一片饱受争议的美味。"
	icon_state = "pineapplepizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE


// Moldly Pizza
// Used in cytobiology.
/obj/item/food/pizzaslice/moldy
	name = "发霉披萨片"
	desc = "它曾是一片完好的披萨，如今却腐臭地躺在这里，长满了孢子。 \
		真可惜！不过我们不该沉溺过去，而应展望未来。"
	icon_state = "moldy_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/peptides = 3,
		/datum/reagent/consumable/tomatojuice = 1,
		/datum/reagent/toxin/amatoxin = 2,
	)
	tastes = list("stale crust" = 1, "rancid cheese" = 2, "mushroom" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | GROSS
	preserved_food = TRUE

/obj/item/food/pizzaslice/moldy/bacteria
	name = "富菌发霉披萨片"
	desc = "这片曾经美味的披萨不仅裹满了喷吐孢子的霉菌，还似乎会在无人注意时自行蠕动，充满了新生命。"

/obj/item/food/pizzaslice/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

// Arnold Pizza
// Has meme code.
/obj/item/food/pizza/arnold
	name = "\improper 阿诺披萨"
	desc = "你好，这里是阿诺披萨店。我现在不在，出去宰意式辣香肠了。"
	icon_state = "arnoldpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/iron = 10,
		/datum/reagent/medicine/omnizine = 30,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pepperoni" = 2, "9 millimeter bullets" = 2)
	slice_type = /obj/item/food/pizzaslice/arnold
	boxtag = "9毫米意式辣香肠"
	foodtypes = MEAT|GRAIN|DAIRY|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 8, /datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pizza/arnold/raw
	name = "生阿诺披萨"
	icon_state = "arnoldpizza_raw"
	foodtypes = MEAT|GRAIN|DAIRY|VEGETABLES|RAW
	slice_type = null

/obj/item/food/pizza/arnold/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/arnold, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

//fuck it, i will leave this at the food level for now.
/obj/item/food/proc/try_break_off(mob/living/attacker, mob/living/user) //maybe i give you a pizza maybe i break off your arm
	if(prob(50) || (attacker != user) || !iscarbon(user) || HAS_TRAIT(user, TRAIT_NODISMEMBER))
		return
	var/obj/item/bodypart/arm/left = user.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/arm/right = user.get_bodypart(BODY_ZONE_R_ARM)
	var/did_the_thing = (left?.dismember() || right?.dismember()) //not all limbs can be removed, so important to check that we did. the. thing.
	if(!did_the_thing)
		return
	to_chat(user, span_userdanger("也许我会给你一份披萨，也许我会掰断你的胳膊。")) //makes the reference more obvious
	user.visible_message(span_warning("[src]扯断了[user]的胳膊！"), span_warning("[src]扯断了你的胳膊！"))
	playsound(user, SFX_DESECRATION, 50, TRUE, -1)

/obj/item/food/proc/i_kill_you(obj/item/item, mob/living/user)
	if(istype(item, /obj/item/food/pineappleslice))
		to_chat(user, "<font color='red' size='7'>你要是敢加菠萝这种离谱的东西，我就宰了你。</font>") //this is in bigger text because it's hard to spam something that gibs you, and so that you're perfectly aware of the reason why you died
		user.investigate_log("has been gibbed by putting pineapple on an arnold pizza.", INVESTIGATE_DEATHS)
		user.gib(DROP_ALL_REMAINS) //if you want something crazy like pineapple, i'll kill you
		return TRUE

	if(istype(item, /obj/item/food/grown/mushroom) && iscarbon(user))
		to_chat(user, span_userdanger("所以，你要是想加蘑菇，就闭嘴。")) //not as large as the pineapple text, because you could in theory spam it
		var/mob/living/carbon/shutup = user
		shutup.gain_trauma(/datum/brain_trauma/severe/mute)
		return TRUE

	return FALSE

/obj/item/food/pizza/arnold/attack(mob/living/target, mob/living/user)
	. = ..()
	try_break_off(target, user)

/obj/item/food/pizza/arnold/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!i_kill_you(tool, user))
		return ..()

	return ITEM_INTERACT_SUCCESS

/obj/item/food/pizzaslice/arnold
	name = "\improper 阿诺披萨片"
	desc = "我过来了，也许会给你一份披萨，也许会掰断你的胳膊。"
	icon_state = "arnoldpizzaslice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pepperoni" = 2, "9 millimeter bullets" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizzaslice/arnold/attack(mob/living/target, mob/living/user)
	. =..()
	try_break_off(target, user)

/obj/item/food/pizzaslice/arnold/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!i_kill_you(tool, user))
		return ..()

	return ITEM_INTERACT_SUCCESS

// Ant Pizza, now with more ants.
/obj/item/food/pizzaslice/ants
	name = "\improper 蚂蚁派对披萨片"
	desc = "做出完美披萨片的关键，在于蚂蚁不能放太多。"
	icon_state = "antpizzaslice"
	food_reagents = list(
		/datum/reagent/ants = 5,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "insects" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | BUGS

// Ethereal Pizza, for when they want a slice
/obj/item/food/pizza/energy
	name = "能量披萨"
	desc = "这东西大概能给一台里普利机甲供电。如果你不是以太人，最好别吃。"
	icon_state ="energypizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/liquidelectricity = 18,
	)
	tastes = list("pure electricity" = 4, "pizza" = 2)
	slice_type = /obj/item/food/pizzaslice/energy
	foodtypes = GRAIN|TOXIC
	boxtag = "24小时能量"
	crafting_complexity = FOOD_COMPLEXITY_2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.4, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/obj/item/food/pizza/energy/raw
	name = "生能量披萨"
	icon_state = "energypizza_raw"
	foodtypes = GRAIN|TOXIC|RAW
	slice_type = null

/obj/item/food/pizza/energy/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/energy, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/energy
	name = "能量披萨片"
	desc = "你正考虑用它给模块服供电。如果你不是以太人，最好别吃。"
	icon_state ="energypizzaslice"
	tastes = list("pure electricity" = 4, "pizza" = 2)
	foodtypes = GRAIN|TOXIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_meat_calzone
	name = "生肉馅意式馅饼"
	desc = "一个生的意式馅饼，已经可以放进烤箱了。"
	icon_state = "raw_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("raw dough" = 1, "raw meat" = 1, "cheese" = 1, "tomato sauce" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY|MEAT|RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_meat_calzone/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/meat_calzone, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/meat_calzone
	name = "肉馅意式馅饼"
	desc = "塞满奶酪、肉和番茄酱的意式馅饼。小心烫舌头！"
	icon_state = "meat_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("baked dough" = 1, "juicy meat" = 1, "melted cheese" = 1, "tomato sauce" = 1)
	foodtypes = GRAIN|VEGETABLES|DAIRY|MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/raw_vegetarian_calzone
	name = "生素食意式馅饼"
	desc = "一个生的意式馅饼，已经可以放进烤箱了。"
	icon_state = "raw_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("raw dough" = 1, "vegetables" = 1, "tomato sauce" = 1)
	foodtypes = GRAIN|VEGETABLES|RAW
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_vegetarian_calzone/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/vegetarian_calzone, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/vegetarian_calzone
	name = "素食意式馅饼"
	desc = "塞满什锦蔬菜和番茄酱的意式馅饼。更健康，但也没那么过瘾。"
	icon_state = "vegetarian_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("baked dough" = 1, "baked vegetables" = 1, "tomato sauce" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
