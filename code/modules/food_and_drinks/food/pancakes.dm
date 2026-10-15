#define PANCAKE_MAX_STACK 10

/obj/item/food/pancakes
	name = "松饼"
	desc = "松软的煎松饼。比华夫饼这位亲戚更柔软，也更胜一筹。"
	icon_state = "pancakes_1"
	inhand_icon_state = null
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("pancakes" = 1)
	foodtypes = GRAIN | SUGAR | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	///Used as a base name while generating the icon states when stacked
	var/stack_name = "pancakes"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pancakes/raw
	name = "黏糊糊的松饼"
	desc = "一团几乎没熟的面糊，有人或许会误认成松饼。它渴望回到煎台上。"
	icon_state = "rawpancakes_1"
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("milky batter" = 1)
	stack_name = "rawpancakes"
	crafting_complexity = FOOD_COMPLEXITY_1
	foodtypes = GRAIN | SUGAR
	foodtypes_added_when_cooked = BREAKFAST

/obj/item/food/pancakes/raw/make_grillable()
	AddComponent(/datum/component/grillable,\
				cook_result = /obj/item/food/pancakes,\
				required_cook_time = rand(30 SECONDS, 40 SECONDS),\
				positive_result = TRUE,\
				use_large_steam_sprite = TRUE)

/obj/item/food/pancakes/raw/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(name != initial(name))// we already have additives
		return ..()

	var/newresult
	if(istype(tool, /obj/item/food/grown/berries))
		newresult = /obj/item/food/pancakes/blueberry
		name = "生蓝莓松饼"
		icon_state = "rawbbpancakes_1"
		stack_name = "rawbbpancakes"
	else if(istype(tool, /obj/item/food/chocolatebar))
		newresult = /obj/item/food/pancakes/chocolatechip
		name = "生巧克力豆松饼"
		icon_state = "rawccpancakes_1"
		stack_name = "rawccpancakes"
	if(!newresult)
		return ..()

	qdel(tool)
	to_chat(user, span_notice("你将[tool]加入[src]。"))
	AddComponent(/datum/component/grillable, cook_result = newresult)
	return ITEM_INTERACT_SUCCESS

/obj/item/food/pancakes/raw/examine(mob/user)
	. = ..()
	if(name == initial(name))
		. += span_notice("在煎熟之前，你可以加入<b>蓝莓</b>或<b>巧克力</b>来改变松饼的口味。")

/obj/item/food/pancakes/blueberry
	name = "蓝莓松饼"
	desc = "松软美味的蓝莓松饼。"
	icon_state = "bbpancakes_1"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pancakes" = 1, "blueberries" = 1)
	stack_name = "bbpancakes"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pancakes/chocolatechip
	name = "巧克力豆松饼"
	desc = "松软美味的巧克力豆松饼。"
	icon_state = "ccpancakes_1"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("pancakes" = 1, "chocolate" = 1)
	stack_name = "ccpancakes"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pancakes/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/food/pancakes/update_name()
	name = contents.len ? "一叠松饼" : initial(name)
	return ..()

/obj/item/food/pancakes/update_icon(updates = ALL)
	if(!(updates & UPDATE_OVERLAYS))
		return ..()

	updates &= ~UPDATE_OVERLAYS
	. = ..() // Don't update overlays. We're doing that here

	if(contents.len < LAZYLEN(overlays))
		overlays -= overlays[overlays.len]
	. |= UPDATE_OVERLAYS

/obj/item/food/pancakes/examine(mob/user)
	var/ingredients_listed = ""
	var/pancakeCount = contents.len
	switch(pancakeCount)
		if(0)
			desc = initial(desc)
		if(1 to 2)
			desc = "一叠松软的松饼。"
		if(3 to 6)
			desc = "厚厚一叠松软的松饼！"
		if(7 to 9)
			desc = "松软美味的松饼堆成了一座壮观的高塔！"
		if(PANCAKE_MAX_STACK to INFINITY)
			desc = "松软美味的松饼堆成一座高耸的巨塔，看起来随时都会倒塌！"
	. = ..()
	if (pancakeCount)
		for(var/obj/item/food/pancakes/ING in contents)
			ingredients_listed += "[ING.name]、"
		. += "[initial(name)]上堆着：[contents.len?"[ingredients_listed]":"没有配料。"]"

/obj/item/food/pancakes/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/food/pancakes))
		var/obj/item/food/pancakes/pancake = tool
		if((contents.len >= PANCAKE_MAX_STACK) || ((pancake.contents.len + contents.len) > PANCAKE_MAX_STACK))
			to_chat(user, span_warning("你不能在[src]上堆这么多松饼！"))
			return ITEM_INTERACT_BLOCKING

		if(!user.transferItemToLoc(pancake, src))
			return ITEM_INTERACT_BLOCKING

		to_chat(user, span_notice("你将[pancake]叠到[src]上。"))
		pancake.name = initial(pancake.name)
		contents += pancake
		update_snack_overlays(pancake)
		if (pancake.contents.len)
			for(var/pancake_content in pancake.contents)
				pancake = pancake_content
				pancake.name = initial(pancake.name)
				contents += pancake
				update_snack_overlays(pancake)
		pancake = tool
		pancake.contents.Cut()
		return ITEM_INTERACT_SUCCESS

	if(contents.len)
		var/obj/pancake = contents[contents.len]
		return pancake.item_interaction(user, tool, modifiers)

	return NONE

/obj/item/food/pancakes/proc/update_snack_overlays(obj/item/food/pancakes/pancake)
	var/mutable_appearance/pancake_visual = mutable_appearance(icon, "[pancake.stack_name]_[rand(1, 3)]")
	pancake_visual.pixel_w = rand(-1, 1)
	pancake_visual.pixel_z = 3 * contents.len - 1
	pancake_visual.layer = layer + (contents.len * 0.01)
	add_overlay(pancake_visual)
	update_appearance()

/obj/item/food/pancakes/attack(mob/target, mob/living/user, params, stacked = TRUE)
	if(user.combat_mode || !contents.len || !stacked)
		return ..()
	var/obj/item/item = contents[contents.len]
	. = item.attack(target, user, params, FALSE)
	update_appearance()

#undef PANCAKE_MAX_STACK
