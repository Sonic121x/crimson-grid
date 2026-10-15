/obj/item/stack/sheet/animalhide
	name = "兽皮"
	desc = "Something went wrong."
	icon_state = "sheet-hide"
	inhand_icon_state = null
	worn_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/animalhide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'
	abstract_type = /obj/item/stack/sheet/animalhide

/// Subtype of skin to be dropped by carbon mobs as a result of being butchered, potentially inheriting their body color
/obj/item/stack/sheet/animalhide/carbon
	abstract_type = /obj/item/stack/sheet/animalhide/carbon
	/// Color of our skin, if we were created from a mob being butchered
	var/skin_color = null
	/// Should we recolor our sprite and prevent merging of stacks of different skin colors?
	var/uses_skin_color = FALSE

/obj/item/stack/sheet/animalhide/carbon/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt, new_skin_color)
	. = ..()
	if (!skin_color)
		set_skin_color(new_skin_color || get_random_skin_color())

/obj/item/stack/sheet/animalhide/carbon/can_merge(obj/item/stack/sheet/animalhide/carbon/check, inhand)
	. = ..()
	if (!. || !uses_skin_color)
		return
	return check.skin_color == skin_color // segregation, in my human butcher shop? how queer!

/obj/item/stack/sheet/animalhide/carbon/proc/set_skin_color(new_skin_color)
	skin_color = new_skin_color
	if (skin_color && uses_skin_color)
		add_atom_colour(skin_color, FIXED_COLOUR_PRIORITY)
	else
		remove_atom_colour(FIXED_COLOUR_PRIORITY)

/obj/item/stack/sheet/animalhide/carbon/split_stack(amount)
	var/obj/item/stack/sheet/animalhide/carbon/new_stack = ..()
	if (!new_stack)
		return
	new_stack.set_skin_color(skin_color)
	return new_stack

/// Select a random skin color to spawn
/obj/item/stack/sheet/animalhide/carbon/proc/get_random_skin_color()
	return null

/obj/item/stack/sheet/animalhide/carbon/human
	name = "人皮"
	desc = "人类养殖业的副产品。"
	singular_name = "人皮"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/carbon/human

GLOBAL_LIST_INIT(human_recipes, list( \
	new/datum/stack_recipe("人皮地毯", /obj/item/stack/tile/carpet/human, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("臃肿人皮服", /obj/item/clothing/suit/hooded/bloated_human, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("人皮帽", /obj/item/clothing/head/fedora/human_leather, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/carbon/human/get_main_recipes()
	. = ..()
	. += GLOB.human_recipes

/obj/item/stack/sheet/animalhide/carbon/human/five
	amount = 5

/obj/item/stack/sheet/animalhide/generic
	name = "皮肤"
	desc = "一块皮肤。"
	singular_name = "皮肤"
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/animalhide/generic

/obj/item/stack/sheet/animalhide/corgi
	name = "柯基皮"
	desc = "柯基养殖业的副产品。"
	singular_name = "柯基皮"
	icon_state = "sheet-corgi"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/corgi

/obj/item/stack/sheet/animalhide/corgi/five
	amount = 5

/obj/item/stack/sheet/animalhide/mothroach
	name = "蛾蟑皮"
	desc = "一层薄薄的蛾蟑皮。"
	singular_name = "蛾蟑皮"
	icon_state = "sheet-mothroach"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/mothroach

/obj/item/stack/sheet/animalhide/mothroach/five
	amount = 5

GLOBAL_LIST_INIT(mothroach_recipes, list( \
	new/datum/stack_recipe("蛾毛地毯", /obj/item/stack/tile/carpet/moth, 1, 4, 20, category = CAT_TILES), \
	))

/obj/item/stack/sheet/animalhide/mothroach/get_main_recipes()
	. = ..()
	. += GLOB.mothroach_recipes

/* // DARKPACK EDIT REMOVAL
GLOBAL_LIST_INIT(gondola_recipes, list ( \
	new/datum/stack_recipe("gondola mask", /obj/item/clothing/mask/gondola, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("gondola suit", /obj/item/clothing/under/costume/gondola, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("gondola bedsheet", /obj/item/bedsheet/gondola, 1, crafting_flags = NONE, category = CAT_FURNITURE), \
	))
 */
/obj/item/stack/sheet/animalhide/gondola
	name = "冈多拉皮"
	desc = "猎杀冈多拉获得的极其珍贵的产物。"
	singular_name = "冈多拉皮"
	icon_state = "sheet-gondola"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/gondola

/* // DARKPACK EDIT REMOVAL
/obj/item/stack/sheet/animalhide/gondola/get_main_recipes()
	. = ..()
	. += GLOB.gondola_recipes

GLOBAL_LIST_INIT(corgi_recipes, list ( \
	new/datum/stack_recipe("corgi costume", /obj/item/clothing/suit/hooded/ian_costume, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/corgi/get_main_recipes()
	. = ..()
	. += GLOB.corgi_recipes
 */
/obj/item/stack/sheet/animalhide/cat
	name = "猫皮"
	desc = "猫类养殖业的副产品。"
	singular_name = "猫皮"
	icon_state = "sheet-cat"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/cat

/obj/item/stack/sheet/animalhide/cat/five
	amount = 5

/obj/item/stack/sheet/animalhide/carbon/monkey
	name = "猴皮"
	desc = "猴类养殖业的副产品。"
	singular_name = "猴皮"
	icon_state = "sheet-monkey"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/carbon/monkey
/* // DARKPACK EDIT REMOVAL
GLOBAL_LIST_INIT(monkey_recipes, list ( \
	new/datum/stack_recipe("monkey mask", /obj/item/clothing/mask/gas/monkeymask, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("monkey suit", /obj/item/clothing/suit/costume/monkeysuit, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/carbon/monkey/get_main_recipes()
	. = ..()
	. += GLOB.monkey_recipes
 */
/obj/item/stack/sheet/animalhide/carbon/monkey/five
	amount = 5

/obj/item/stack/sheet/animalhide/carbon/lizard
	name = "蜥蜴皮"
	desc = "嘶嘶嘶……"
	singular_name = "蜥蜴皮"
	icon_state = "sheet-lizard"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/carbon/lizard
	uses_skin_color = TRUE

/obj/item/stack/sheet/animalhide/carbon/lizard/get_random_skin_color()
	return sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]")

/obj/item/stack/sheet/animalhide/carbon/lizard/five
	amount = 5

GLOBAL_LIST_INIT(lizard_recipes, list( \
	new/datum/stack_recipe("蜥蜴鳞地毯", /obj/item/stack/tile/carpet/lizard, 1, 4, 20, category = CAT_TILES), \
	))

/obj/item/stack/sheet/animalhide/carbon/lizard/get_main_recipes()
	. = ..()
	. += GLOB.lizard_recipes

/obj/item/stack/sheet/animalhide/xeno
	name = "异形甲壳"
	singular_name = "异形甲壳"
	desc = "一种可怕生物的外皮。"
	icon_state = "sheet-xeno"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/xeno
/* // DARKPACK EDIT REMOVAL
GLOBAL_LIST_INIT(xeno_recipes, list ( \
	new/datum/stack_recipe("alien helmet", /obj/item/clothing/head/costume/xenos, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("alien suit", /obj/item/clothing/suit/costume/xenos, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	))

/obj/item/stack/sheet/animalhide/xeno/get_main_recipes()
	. = ..()
	. += GLOB.xeno_recipes
*/
/obj/item/stack/sheet/animalhide/xeno/five
	amount = 5

/obj/item/stack/sheet/animalhide/carp
	name = "太空鲤鱼鳞"
	desc = "太空鲤鱼的鳞皮。从那只恶心的生物身上剥下来后，看着倒挺漂亮。"
	singular_name = "太空鲤鱼鳞"
	icon_state = "sheet-carp"
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/animalhide/carp
/* // DARKPACK EDIT REMOVAL
GLOBAL_LIST_INIT(carp_recipes, list ( \
	new/datum/stack_recipe("carp scale carpet", /obj/item/stack/tile/carpet/carp, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("carp costume", /obj/item/clothing/suit/hooded/carp_costume, 4, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("carp mask", /obj/item/clothing/mask/gas/carp, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("carpskin chair", /obj/structure/chair/comfy/carp, 2, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("carpskin suit", /obj/item/clothing/under/suit/carpskin, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("carpskin fedora", /obj/item/clothing/head/fedora/carpskin, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("carpskin fishing bag", /obj/item/storage/bag/fishing/carpskin, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
	))

/obj/item/stack/sheet/animalhide/carp/get_main_recipes()
	. = ..()
	. += GLOB.carp_recipes
 */
/obj/item/stack/sheet/animalhide/carp/five
	amount = 5

/obj/item/xenos_claw
	name = "异形利爪"
	desc = "一种可怕生物的爪子。"
	icon = 'icons/mob/nonhuman-player/alien.dmi'
	icon_state = "claw"

/*
 * Leather SHeet
 */
/obj/item/stack/sheet/leather
	name = "皮革"
	desc = "碾碎生物得到的副产品。"
	singular_name = "皮革"
	icon_state = "sheet-leather"
	worn_icon_state = null
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/leather
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

GLOBAL_LIST_INIT(leather_recipes, list ( \
	new/datum/stack_recipe("钱包", /obj/item/storage/wallet, 1, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("口套", /obj/item/clothing/mask/muzzle, 2, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("篮球", /obj/item/toy/basketball, 20, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("棒球", /obj/item/toy/beach_ball/baseball, 3, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("鞍具", /obj/item/goliath_saddle, 5, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new/datum/stack_recipe("皮鞋", /obj/item/clothing/shoes/laceup, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("牛仔靴", /obj/item/clothing/shoes/cowboy, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("园艺手套", /obj/item/clothing/gloves/botanic_leather, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("皮革挎包", /obj/item/storage/backpack/satchel/leather, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("警长马甲", /obj/item/clothing/accessory/vest_sheriff, 4, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("皮夹克", /obj/item/clothing/suit/jacket/leather, 7, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("机车夹克", /obj/item/clothing/suit/jacket/leather/biker, 7, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe_list("腰带", list( \
		new/datum/stack_recipe("工具腰带", /obj/item/storage/belt/utility, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("园艺腰带", /obj/item/storage/belt/plant, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("清洁腰带", /obj/item/storage/belt/janitor, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("医疗腰带", /obj/item/storage/belt/medical, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("安保腰带", /obj/item/storage/belt/security, 2, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("肩式枪套", /obj/item/storage/belt/holster, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new/datum/stack_recipe("弹药带", /obj/item/storage/belt/bandolier, 5, crafting_flags = NONE, category = CAT_CONTAINERS), \
	)),
	new/datum/stack_recipe_list("牛仔帽", list( \
		new/datum/stack_recipe("警长帽", /obj/item/clothing/head/cowboy/brown, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("亡命徒帽", /obj/item/clothing/head/cowboy/black, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("高顶牛仔帽", /obj/item/clothing/head/cowboy/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("副警长帽", /obj/item/clothing/head/cowboy/red, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("流浪客帽", /obj/item/clothing/head/cowboy/grey, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	)),
	new/datum/stack_recipe_list("刀鞘", list( \
		new/datum/stack_recipe("武士刀鞘", /obj/item/storage/belt/sheath/katana/empty, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("半藏武士刀鞘", /obj/item/storage/belt/sheath/hanzo_katana/empty, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
		new/datum/stack_recipe("玩具武士刀鞘", /obj/item/storage/belt/sheath/katana/toy/empty, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	)),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	. += GLOB.leather_recipes

/obj/item/stack/sheet/leather/five
	amount = 5

/*
 * Sinew
 */
/obj/item/stack/sheet/sinew
	name = "凝视者筋腱"
	icon = 'icons/obj/mining.dmi'
	desc = "细长的筋状纤维，大概取自凝视者的翅膀。"
	singular_name = "凝视者筋腱"
	icon_state = "sinew"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/sinew
	drop_sound = 'sound/effects/meatslap.ogg'
	pickup_sound = 'sound/effects/meatslap.ogg'
	resistance_flags = FIRE_PROOF | LAVA_PROOF
/* // DARKPACK EDIT REMOVAL
	/// Trophy crafting recipe for this type of sinew
	var/trophy_type = /datum/crafting_recipe/crusher_trophy/watcher_wing

/obj/item/stack/sheet/sinew/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	// As bone and sinew have just a little too many recipes for this, we'll just split them up.
	// Sinew slapcrafting will mostly-sinew recipes, and bones will have mostly-bones recipes.

	var/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/goliathcloak,
		/datum/crafting_recipe/skilt,
		/datum/crafting_recipe/drakecloak,
	)
	if (trophy_type)
		slapcraft_recipe_list += trophy_type
	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = string_list(slapcraft_recipe_list),\
	)
*/

/obj/item/stack/sheet/sinew/icewing
	name = "冰翼凝视者筋腱"
	desc = "冰冷的纤维，大概取自冰翼凝视者的翅膀。"
	singular_name = "冰翼凝视者筋腱"
	icon_state = "sinew_icewing"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/sinew/icewing
	// trophy_type = /datum/crafting_recipe/crusher_trophy/icewing_watcher_wing // DARKPACK EDIT REMOVAL

/obj/item/stack/sheet/sinew/magmawing
	name = "熔翼凝视者筋腱"
	desc = "炽热的纤维，大概取自熔翼凝视者的翅膀。"
	singular_name = "熔翼凝视者筋腱"
	icon_state = "sinew_magmawing"
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/sinew/magmawing
	// trophy_type = /datum/crafting_recipe/crusher_trophy/magmawing_watcher_wing // DARKPACK EDIT REMOVAL

/obj/item/stack/sheet/sinew/wolf
	name = "狼筋"
	desc = "取自狼体内的细长筋状纤维。"
	singular_name = "狼筋"
	merge_type = /obj/item/stack/sheet/sinew/wolf
	// trophy_type = null // DARKPACK EDIT REMOVAL

GLOBAL_LIST_INIT(sinew_recipes, list ( \
	new/datum/stack_recipe("筋腱绑绳", /obj/item/restraints/handcuffs/cable/sinew, 1, crafting_flags = NONE, category = CAT_EQUIPMENT), \
))

/obj/item/stack/sheet/sinew/get_main_recipes()
	. = ..()
	. += GLOB.sinew_recipes

/*Plates*/
/obj/item/stack/sheet/animalhide/goliath_hide
	name = "歌利亚巨兽皮甲片"
	desc = "歌利亚巨兽岩石般的皮甲碎片，或许能加固你的防护服，更好地抵御当地野兽的攻击。"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "goliath_hide"
	singular_name = "皮甲片"
	max_amount = 6
	novariants = FALSE
	item_flags = NOBLUDGEON
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide

/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide
	name = "北极熊皮"
	desc = "几块北极熊皮，或许能加固你的防护服，更好地抵御当地野兽的攻击。"
	icon_state = "polar_bear_hide"
	singular_name = "北极熊皮"
	merge_type = /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide

GLOBAL_LIST_INIT(polar_bear_recipes, list( \
	new/datum/stack_recipe("北极熊皮地毯", /obj/item/stack/tile/carpet/polar_bear, 1, 4, 20, category = CAT_TILES), \
	))

/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide/get_main_recipes()
	. = ..()
	. += GLOB.polar_bear_recipes

/obj/item/stack/sheet/animalhide/ashdrake
	name = "灰烬龙皮"
	desc = "灰烬龙坚韧的鳞皮。"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "dragon_hide"
	singular_name = "龙鳞甲片"
	max_amount = 10
	novariants = FALSE
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_NORMAL
	layer = MOB_LAYER
	merge_type = /obj/item/stack/sheet/animalhide/ashdrake
/* // DARKPACK EDIT REMOVAL
/obj/item/stack/sheet/animalhide/ashdrake/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()

	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/drakecloak)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
 */
/obj/item/stack/sheet/animalhide/bear
	name = "熊皮"
	desc = "毛茸茸的熊皮。想象一下，裹着这种皮料做的大衣该有多暖和。"
	icon_state = "bear_hide" //change
	singular_name = "熊皮"
	merge_type = /obj/item/stack/sheet/animalhide/bear
	novariants = FALSE

GLOBAL_LIST_INIT(bear_pelt_recipes, list ( \
	new/datum/stack_recipe("熊皮地毯", /obj/item/stack/tile/carpet/bear, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("熊装", /obj/item/clothing/suit/costume/bear_suit, 5, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("熊皮帽", /obj/item/clothing/head/costume/bearpelt, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
))

/obj/item/stack/sheet/animalhide/bear/get_main_recipes()
	. = ..()
	. += GLOB.bear_pelt_recipes

//Step one - dehairing.
/obj/item/stack/sheet/animalhide/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.get_sharpness())
		return ..()
	playsound(loc, 'sound/items/weapons/slice.ogg', 50, TRUE, -1)
	user.visible_message(span_notice("[user]开始刮去[src]上的毛。"), span_notice("你开始刮去[src]上的毛……"), span_hear("你听到了刀刃摩擦皮肉的声音。"))
	if(!do_after(user, 5 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你刮去了[src.name]上的毛。"))
	new /obj/item/stack/sheet/hairlesshide(user.drop_location(), amount)
	use(amount)
	return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/animalhide/examine(mob/user)
	. = ..()
	. += span_notice("你可以用任何锋利的物品刮去上面的毛。")

//Step two - washing..... it's actually in washing machine code.

/obj/item/stack/sheet/hairlesshide
	name = "去毛兽皮"
	desc = "这张兽皮已去毛，但仍需清洗和鞣制。"
	singular_name = "去毛兽皮"
	icon_state = "sheet-hairlesshide"
	worn_icon_state = null
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/hairlesshide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'

/obj/item/stack/sheet/hairlesshide/examine(mob/user)
	. = ..()
	. += span_notice("你可以把它放入水中洗净。")

//Step three - drying
/obj/item/stack/sheet/wethide
	name = "湿兽皮"
	desc = "这张兽皮已经洗净，但还需要烘干。"
	singular_name = "湿兽皮"
	icon_state = "sheet-wetleather"
	worn_icon_state = null
	inhand_icon_state = null
	merge_type = /obj/item/stack/sheet/wethide
	pickup_sound = 'sound/items/handling/materials/skin_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/skin_drop.ogg'
	/// Reduced when exposed to high temperatures
	var/wetness = 30
	/// Kelvin to start drying
	var/drying_threshold_temperature = 500

/obj/item/stack/sheet/wethide/examine(mob/user)
	. = ..()
	. += span_notice("你可以将它烘干，制成皮革。")

/obj/item/stack/sheet/wethide/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)
	AddElement(/datum/element/dryable, /obj/item/stack/sheet/leather)
	AddElement(/datum/element/microwavable, /obj/item/stack/sheet/leather)
	AddComponent(/datum/component/grillable, /obj/item/stack/sheet/leather, rand(1 SECONDS, 3 SECONDS), TRUE)
	AddComponent(/datum/component/bakeable, /obj/item/stack/sheet/leather, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/stack/sheet/wethide/burn()
	visible_message(span_notice("[src]烘干了！"))
	new /obj/item/stack/sheet/leather(loc, amount) // all the sheets to incentivize not losing your whole stack by accident
	qdel(src)

/obj/item/stack/sheet/wethide/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return (exposed_temperature > drying_threshold_temperature)

/obj/item/stack/sheet/wethide/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	wetness--
	if(wetness == 0)
		new /obj/item/stack/sheet/leather(drop_location(), amount)
		wetness = initial(wetness)
		use(1)
