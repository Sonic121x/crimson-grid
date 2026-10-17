
///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
// leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
// to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/reagent_containers/condiment
	name = "调味料瓶"
	desc = "就是一个普通的调味料瓶。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "bottle"
	inhand_icon_state = "beer" //Generic held-item sprite until unique ones are made.
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	initial_reagent_flags = OPENCONTAINER
	obj_flags = UNIQUE_RENAME
	possible_transfer_amounts = list(1, 5, 10, 15, 20, 25, 30, 50)
	volume = 50
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 100)
	/// Icon (icon_state) to be used when container becomes empty (no change if falsy)
	var/icon_empty
	/// Holder for original icon_state value if it was overwritten by icon_emty to change back to
	var/icon_preempty

/obj/item/reagent_containers/condiment/update_icon_state()
	. = ..()
	if(reagents?.reagent_list.len) // DARKPACK EDIT CHANGE - world icon can call update_icon_state before reagents exist
		if(icon_preempty)
			icon_state = icon_preempty
			icon_preempty = null
		return ..()

	if(icon_empty && !icon_preempty)
		icon_preempty = icon_state
		icon_state = icon_empty
	return ..()

/obj/item/reagent_containers/condiment/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正试图把整个[src]吃下去！看起来忘了食物该怎么吃！"))
	return OXYLOSS

/obj/item/reagent_containers/condiment/proc/try_eat(atom/target, mob/living/user)
	if(!canconsume(target, user))
		return ITEM_INTERACT_BLOCKING

	user.changeNext_move(CLICK_CD_MELEE)
	if(target == user)
		user.visible_message(
			span_notice("[user]喝下了[src]里的部分内容物。"),
			span_notice("你喝下了[src]里的部分内容物。"),
		)
	else
		target.visible_message(
			span_warning("[user]试图将[src]里的东西喂给[target]。"),
			span_warning("[user]试图将[src]里的东西喂给你。"),
		)
		if(!do_after(user, 3 SECONDS, target))
			return ITEM_INTERACT_BLOCKING
		if(!reagents || !reagents.total_volume)
			return ITEM_INTERACT_BLOCKING // The condiment might be empty after the delay.
		target.visible_message(
			span_warning("[user]将[src]里的东西喂给了[target]。"),
			span_warning("[user]将[src]里的东西喂给了你。"),
		)
		log_combat(user, target, "fed", reagents.get_reagent_log_string())
	reagents.trans_to(target, 10, transferred_by = user, methods = INGEST)
	playsound(target, 'sound/items/drink.ogg', rand(10, 50), TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/condiment/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!is_open_container())
		return NONE

	//Something like a glass or a food item. Player probably wants to transfer TO it.
	if(target.is_refillable() || IS_EDIBLE(target))
		return try_refill(target, user)
	//A dispenser. Transfer FROM it TO us.
	if(target.is_drainable())
		return try_drain(target, user)
	//Eating directly from the ketchup packet
	if(isliving(target))
		return try_eat(target, user)

	return NONE


/obj/item/reagent_containers/condiment/interact_with_atom_secondary(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(!is_open_container())
		return NONE
	//A dispenser. Transfer FROM it TO us.
	if(target.is_drainable())
		return try_drain(target, user)

	return NONE

/obj/item/reagent_containers/condiment/enzyme
	name = "通用酶"
	desc = "用于烹饪各种菜肴。"
	icon_state = "enzyme"
	list_reagents = list(/datum/reagent/consumable/enzyme = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/enzyme/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("[milk_required]单位牛奶加[enzyme_required]单位酶，就能得到奶酪。")
	. += span_warning("记住，酶不会被消耗，别忘了把它倒回瓶里，笨蛋！")

/obj/item/reagent_containers/condiment/sugar
	name = "糖袋"
	desc = "美味的太空糖！"
	icon_state = "sugar"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/sugar = 50)
	fill_icon_thresholds = null
	custom_price = 3 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/sugar/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/standard_recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/datum/chemical_reaction/alt_recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter/vegan]
	var/flour_required = standard_recipe.required_reagents[/datum/reagent/consumable/flour]
	var/eggyolk_required = standard_recipe.required_reagents[/datum/reagent/consumable/eggyolk]
	var/eggwhite_required = standard_recipe.required_reagents[/datum/reagent/consumable/eggwhite]
	var/sugar_required = standard_recipe.required_reagents[/datum/reagent/consumable/sugar]
	var/soymilk_required = alt_recipe.required_reagents[/datum/reagent/consumable/soymilk]
	. += span_notice("[flour_required]单位面粉、[sugar_required]单位糖，再加[eggyolk_required]单位蛋黄和[eggwhite_required]单位蛋白，或[soymilk_required]单位豆奶，就能得到蛋糕面团。它也可以制成派面团。")

/obj/item/reagent_containers/condiment/saltshaker //Separate from above since it's a small shaker rather then
	name = "盐罐" // a large one.
	desc = "盐，大概来自太空海洋。"
	icon_state = "saltshakersmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/salt = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/saltshaker/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始和盐罐交换形态！看起来是想自杀！"))
	var/newname = "[name]"
	name = "[user.name]"
	user.name = newname
	user.real_name = newname
	desc = "盐，大概来自死去的船员。"
	return TOXLOSS

/obj/item/reagent_containers/condiment/saltshaker/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(isturf(target))
		if(!reagents.has_reagent(/datum/reagent/consumable/salt, 2))
			to_chat(user, span_warning("盐不够，撒不成一堆！"))
			return
		user.visible_message(span_notice("[user]往[target]上撒了点盐。"), span_notice("你往[target]上撒了点盐。"))
		reagents.remove_reagent(/datum/reagent/consumable/salt, 2)
		new/obj/effect/decal/cleanable/food/salt(target)
		return ITEM_INTERACT_SUCCESS
	return .

/obj/item/reagent_containers/condiment/peppermill
	name = "胡椒研磨器"
	desc = "常用于给食物调味，或让人打喷嚏。"
	icon_state = "peppermillsmall"
	icon_empty = "emptyshaker"
	inhand_icon_state = ""
	possible_transfer_amounts = list(1,20) //for clown turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/blackpepper = 20)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk
	name = "太空牛奶"
	desc = "这就是牛奶。洁白又营养丰富的好东西！"
	icon_state = "milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/milk/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += span_notice("[milk_required]单位牛奶加[enzyme_required]单位酶，就能得到奶酪。")
	. += span_warning("记住，酶不会被消耗，别忘了把它倒回瓶里，笨蛋！")

/obj/item/reagent_containers/condiment/flour
	name = "面粉袋"
	desc = "一大袋面粉。烘焙好帮手！"
	icon_state = "flour"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/flour = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/flour/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe_dough = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/dough]
	var/datum/chemical_reaction/recipe_cakebatter = GLOB.chemical_reactions_list[/datum/chemical_reaction/food/cakebatter]
	var/dough_flour_required = recipe_dough.required_reagents[/datum/reagent/consumable/flour]
	var/dough_water_required = recipe_dough.required_reagents[/datum/reagent/water]
	var/cakebatter_flour_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/flour]
	var/cakebatter_eggyolk_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/eggyolk]
	var/cakebatter_sugar_required = recipe_cakebatter.required_reagents[/datum/reagent/consumable/sugar]
	. += "<b><i>你沉入内心，回想起关于……和面的教诲……</i></b>"
	. += span_notice("[dough_flour_required]单位面粉与[dough_water_required]单位水可制成普通面团，之后还能擀成面皮。")
	. += span_notice("[cakebatter_flour_required]单位面粉、[cakebatter_eggyolk_required]单位蛋黄（或豆奶）与[cakebatter_sugar_required]单位糖可制成蛋糕面团，之后还能制成派面团。")

/obj/item/reagent_containers/condiment/soymilk
	name = "豆奶"
	desc = "这就是豆奶。洁白又营养丰富的好东西！"
	icon_state = "soymilk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/rice
	name = "米袋"
	desc = "一大袋米。做饭好帮手！"
	icon_state = "rice"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/rice = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/cornmeal
	name = "玉米粉盒"
	desc = "一大盒玉米粉，适合制作南方风味料理。"
	icon_state = "cornmeal"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/cornmeal = 30)
	fill_icon_thresholds = null
	custom_price = 3 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/korta_flour
	name = "科塔坚果粉袋"
	desc = "一大袋蜥蜴人最爱的科塔坚果粉。提兹拉制造！"
	icon_state = "korta_flour"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/korta_flour = 30)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/bbqsauce
	name = "烧烤酱"
	desc = "不附带擦手湿巾。"
	icon_state = "bbqsauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 50)

/obj/item/reagent_containers/condiment/soysauce
	name = "酱油"
	desc = "一种以大豆为原料的咸味调料。"
	icon_state = "soysauce"
	list_reagents = list(/datum/reagent/consumable/soysauce = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/mayonnaise
	name = "蛋黄酱"
	desc = "一种用蛋黄制成的油润调料。"
	icon_state = "mayonnaise"
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/vinegar
	name = "醋"
	desc = "如果你想体验太空英国风情，配薯条再合适不过。"
	icon_state = "vinegar"
	list_reagents = list(/datum/reagent/consumable/vinegar = 50)
	fill_icon_thresholds = null
	custom_price = 10 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/vegetable_oil
	name = "食用油"
	desc = "满足你的一切油炸需求。"
	icon_state = "cooking_oil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil = 50)
	fill_icon_thresholds = null
	custom_price = 10 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/olive_oil
	name = "优质食用油"
	desc = "献给每个人心中的精致大厨。"
	icon_state = "oliveoil"
	list_reagents = list(/datum/reagent/consumable/nutriment/fat/oil/olive = 50)
	fill_icon_thresholds = null
	custom_price = 25 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/yoghurt
	name = "盒装酸奶"
	desc = "绵密顺滑。"
	icon_state = "yoghurt"
	list_reagents = list(/datum/reagent/consumable/yoghurt = 50)
	fill_icon_thresholds = null
	custom_price = 5 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/peanut_butter
	name = "花生酱"
	desc = "装在罐里的加工花生，美味又容易长胖。"
	icon_state = "peanutbutter"
	list_reagents = list(/datum/reagent/consumable/peanut_butter = 50)
	fill_icon_thresholds = null
	custom_price = 5 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/cherryjelly
	name = "樱桃果冻"
	desc = "一罐甜得不得了的樱桃果冻。"
	icon_state = "cherryjelly"
	list_reagents = list(/datum/reagent/consumable/cherryjelly = 50)
	fill_icon_thresholds = null
	custom_price = 5 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/honey
	name = "蜂蜜"
	desc = "一罐甜蜜黏稠的蜂蜜。"
	icon_state = "honey"
	list_reagents = list(/datum/reagent/consumable/honey = 50)
	fill_icon_thresholds = null
	custom_price = 5 // DARKPACK EDIT ADD - ECONOMY

/obj/item/reagent_containers/condiment/ketchup
	name = "番茄酱"
	ONFLOOR_ICON_HELPER('modular_darkpack/master_files/icons/obj/food/containers.dmi') // DARKPACK EDIT ADD
	// At time of writing, "ketchup" mechanically, is just ground tomatoes,
	// rather than // tomatoes plus vinegar plus sugar.
	desc = "装在高塑料瓶里的番茄糊。不知为何，还是透着一股美国味。"
	icon_state = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/mustard
	name = "芥末酱"
	ONFLOOR_ICON_HELPER('modular_darkpack/master_files/icons/obj/food/containers.dmi') // DARKPACK EDIT ADD
	desc = "用芥菜制成的辛辣酸香酱料，配热狗很棒！"
	icon_state = "mustard"
	list_reagents = list(/datum/reagent/consumable/mustard = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/worcestershire
	name = "伍斯特酱"
	desc = "来自古老英格兰的传奇发酵酱汁，几乎能让任何东西更好吃。"
	icon_state = "worcestershire"
	list_reagents = list(/datum/reagent/consumable/worcestershire = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/red_bay
	name = "\improper 红湾调味料"
	desc = "火星人最爱的调味料。"
	icon_state = "red_bay"
	list_reagents = list(/datum/reagent/consumable/red_bay = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/curry_powder
	name = "咖喱粉"
	desc = "正是这黄色魔法，让咖喱尝起来像咖喱。"
	icon_state = "curry_powder"
	list_reagents = list(/datum/reagent/consumable/curry_powder = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/dashi_concentrate
	name = "日式高汤浓缩液"
	desc = "一瓶天城牌日式高汤浓缩液。按1:8的比例加水慢炖，即可得到完美的日式高汤。"
	icon_state = "dashi_concentrate"
	list_reagents = list(/datum/reagent/consumable/dashi_concentrate = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/coconut_milk
	name = "椰奶"
	desc = "这就是椰奶。烤香浓郁！"
	icon_state = "coconut_milk"
	inhand_icon_state = "carton"
	lefthand_file = 'icons/mob/inhands/items/drinks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/drinks_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/coconut_milk = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/grounding_solution
	name = "接地溶液"
	desc = "食用级离子溶液，用于中和萌芽星食物中常见的神秘\"液态电\"，接触后会生成无害的盐。"
	icon_state = "grounding_solution"
	list_reagents = list(/datum/reagent/consumable/grounding_solution = 50)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/protein
	name = "蛋白粉"
	desc = "为你内心的绿巨人加油——想练成魁梧大块头，怎么能少了乳清！"
	icon_state = "protein"
	list_reagents = list(/datum/reagent/consumable/nutriment/protein = 40)
	fill_icon_thresholds = null

//technically condiment packs but they are non transparent

/obj/item/reagent_containers/condiment/creamer
	name = "咖啡奶精包"
	desc = "最好别想他们是用什么做出来的。"
	icon_state = "condi_creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/creamer = 5)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/chocolate
	name = "巧克力糖粒包"
	desc= "原来那些糖还不够你吃吗？"
	icon_state = "condi_chocolate"
	list_reagents = list(/datum/reagent/consumable/choccyshake = 10)


/obj/item/reagent_containers/condiment/hotsauce
	name = "辣酱瓶"
	desc= "你几乎能尝到胃溃疡的滋味！"
	icon_state = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 50)

/obj/item/reagent_containers/condiment/coldsauce
	name = "冰酱瓶"
	desc= "所过之处，舌头一片麻木。"
	icon_state = "coldsauce"
	list_reagents = list(/datum/reagent/consumable/frostoil = 50)

//Food packs. To easily apply deadly toxi... delicious sauces to your food!

/obj/item/reagent_containers/condiment/pack
	name = "调味包"
	desc = "装有食物调味料的小塑料包。"
	icon_state = "condi_empty"
	initial_reagent_flags = parent_type::initial_reagent_flags | NO_SPLASH
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(10)
	/**
	  * List of possible styles (list(<icon_state>, <name>, <desc>)) for condiment packs.
	  * Since all of them differs only in color should probably be replaced with usual reagentfillings instead
	  */
	var/list/possible_states = list(
		/datum/reagent/consumable/ketchup = list("condi_ketchup", "番茄酱", "你已经感觉自己更像美国人了。"),
		/datum/reagent/consumable/capsaicin = list("condi_hotsauce", "辣酱", "你现在几乎能尝到胃溃疡的滋味！"),
		/datum/reagent/consumable/soysauce = list("condi_soysauce", "酱油", "一种以大豆为原料的咸味调料"),
		/datum/reagent/consumable/frostoil = list("condi_frostoil", "冰酱", "所过之处，舌头一片麻木"),
		/datum/reagent/consumable/salt = list("condi_salt", "盐罐", "盐，大概来自太空海洋"),
		/datum/reagent/consumable/blackpepper = list("condi_pepper", "胡椒磨", "常用来给食物调味，或让人打喷嚏"),
		/datum/reagent/consumable/nutriment/fat/oil = list("condi_cornoil", "植物油", "用于烹饪的美味食用油。"),
		/datum/reagent/consumable/sugar = list("condi_sugar", "糖", "美味的太空糖！"),
		/datum/reagent/consumable/astrotame = list("condi_astrotame", "太空甜味剂", "千倍于糖的甜蜜，却没有热量。"),
		/datum/reagent/consumable/bbqsauce = list("condi_bbq", "烧烤酱", "不附带擦手湿巾。"),
		/datum/reagent/consumable/peanut_butter = list("condi_peanutbutter", "花生酱", "用研磨花生制成的绵滑糊酱。"),
		/datum/reagent/consumable/cherryjelly = list("condi_cherryjelly", "樱桃果冻", "一罐甜得不得了的樱桃果冻。"),
		/datum/reagent/consumable/mayonnaise = list("condi_mayo", "蛋黄酱", "这可不是乐器。"),
	)
	/// Can't use initial(name) for this. This stores the name set by condimasters.
	var/originalname = "调味料"

/obj/item/reagent_containers/condiment/pack/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignal(reagents, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_update), TRUE)

/obj/item/reagent_containers/condiment/pack/update_icon()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/item/reagent_containers/condiment/pack/try_eat(atom/target, mob/living/user)
	return NONE

/obj/item/reagent_containers/condiment/pack/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	//You can tear the bag open above food to put the condiments on it, obviously.
	if(IS_EDIBLE(target))
		if(!reagents.total_volume)
			to_chat(user, span_warning("你撕开了[src]，但里面什么也没有。"))
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("你撕开了[src]，但[target]堆得太高，调味料全滴下去了！") )
			qdel(src)
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你在[target]上方撕开了[src]，调味料滴了上去。"))
		reagents.trans_to(target, amount_per_transfer_from_this, transferred_by = user)
		qdel(src)
		return ITEM_INTERACT_SUCCESS
	return ..()

/// Handles reagents getting added to the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_update(datum/reagents/reagents)
	SIGNAL_HANDLER

	if(!reagents.total_volume)
		icon_state = "condi_empty"
		desc = "一个小调味包，已经空了。"
		return
	var/datum/reagent/main_reagent = reagents.get_master_reagent()

	var/list/temp_list = possible_states[main_reagent.type]
	if(length(temp_list))
		icon_state = temp_list[1]
		desc = temp_list[3]
	else
		icon_state = "condi_mixed"
		desc = "一个小调味包。标签上写着内含[originalname]。"

//Ketchup
/obj/item/reagent_containers/condiment/pack/ketchup
	name = "番茄酱包"
	originalname = "番茄酱"
	list_reagents = list(/datum/reagent/consumable/ketchup = 10)

//Hot sauce
/obj/item/reagent_containers/condiment/pack/hotsauce
	name = "辣酱包"
	originalname = "辣酱"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 10)

/obj/item/reagent_containers/condiment/pack/astrotame
	name = "太空甜味剂包"
	originalname = "太空甜味剂"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/astrotame = 5)

/obj/item/reagent_containers/condiment/pack/bbqsauce
	name = "烧烤酱包"
	originalname = "烧烤酱"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 10)

/obj/item/reagent_containers/condiment/pack/creamer
	name = "奶精包"
	originalname = "奶精"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/cream = 5)

/obj/item/reagent_containers/condiment/pack/sugar
	name = "糖包"
	originalname = "糖"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/sugar = 5)

/obj/item/reagent_containers/condiment/pack/soysauce
	name = "酱油包"
	originalname = "酱油"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/soysauce = 5)

/obj/item/reagent_containers/condiment/pack/mayonnaise
	name = "蛋黄酱包"
	originalname = "蛋黄酱"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 5)

/obj/item/reagent_containers/condiment/pack/beef_flavour
	name = "牛肉味太空拉面调味粉"
	originalname = "牛肉味"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/beef_flavour = 5)
