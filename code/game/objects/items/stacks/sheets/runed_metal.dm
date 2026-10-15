// Note, the order these in are deliberate, as it affects
// the order they are shown via radial.
GLOBAL_LIST_INIT(runed_metal_recipes, list( \
	new /datum/stack_recipe/radial( \
		title = "血祭尖塔", \
		result_type = /obj/structure/destructible/cult/pylon, \
		req_amount = 4, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("血祭尖塔：治疗附近的血之教徒与构装体，并补充血液，同时 \
			将附近地砖转化为刻纹地板，使血之教徒能更快地绘制符文。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "祭坛", \
		result_type = /obj/structure/destructible/cult/item_dispenser/altar, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("祭坛：可制作邪异磨刀石、构装体外壳及亵渎之水瓶。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "秘典库", \
		result_type = /obj/structure/destructible/cult/item_dispenser/archives, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("秘典库：可制作狂信徒眼罩、穿梭机诅咒法球 \
			和帷幕行者装备。能够发光。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "恶魔熔炉", \
		result_type = /obj/structure/destructible/cult/item_dispenser/forge, \
		req_amount = 3, \
		time = 4 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("恶魔熔炉：可制作纳尔西强化护甲与邪异长剑。能够发光。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "符文门", \
		result_type = /obj/machinery/door/airlock/cult, \
		time = 5 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("符文门：一扇脆弱的门，会击晕触碰它的非血之教徒。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \
	new /datum/stack_recipe/radial( \
		title = "符文支架", \
		result_type = /obj/structure/girder/cult, \
		time = 5 SECONDS, \
		crafting_flags = CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_MUST_BE_LEARNED, \
		desc = span_cult_bold("符文支架：一种脆弱的支架，用仪式匕首即可瞬间摧毁。 \
			不建议将符文金属用于这种用途。"), \
		required_noun = "符文金属板", \
		category = CAT_CULT, \
	), \

	new /datum/stack_recipe("符文石平台", /obj/structure/platform/cult, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("单面符文窗", /obj/structure/window/cult/unanchored, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_WINDOWS), \
	new/datum/stack_recipe("整格符文窗", /obj/structure/window/cult/fulltile/unanchored, 2, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_IS_FULLTILE, category = CAT_WINDOWS), \
))

/obj/item/stack/sheet/runed_metal
	name = "符文金属"
	desc = "冰冷的金属板，上面的铭文不断变幻。"
	singular_name = "符文金属板"
	icon_state = "sheet-runed"
	worn_icon_state = "sheet-runed"
	inhand_icon_state = "sheet-runed"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/runedmetal = SHEET_MATERIAL_AMOUNT)
	construction_path_type = "runed"
	merge_type = /obj/item/stack/sheet/runed_metal
	material_type = /datum/material/runedmetal
	has_unique_girder = TRUE
	use_radial = TRUE

/obj/item/stack/sheet/runed_metal/grind_results()
	return list(/datum/reagent/iron = 5, /datum/reagent/blood = 15)

/obj/item/stack/sheet/runed_metal/interact(mob/user)
	if(!IS_CULTIST(user))
		to_chat(user, span_warning("只有掌握禁忌知识的人，才有可能加工这种金属……"))
		return FALSE

	var/turf/user_turf = get_turf(user)
	var/area/user_area = get_area(user)

	var/is_valid_turf = user_turf && (is_station_level(user_turf.z) || is_mining_level(user_turf.z))
	var/is_valid_area = user_area && (user_area.area_flags & CULT_PERMITTED)

	if(!is_valid_turf || !is_valid_area)
		to_chat(user, span_warning("这里的帷幕还不够薄弱。"))
		return FALSE

	return ..()

/obj/item/stack/sheet/runed_metal/radial_check(mob/builder)
	return ..() && IS_CULTIST(builder)

/obj/item/stack/sheet/runed_metal/get_main_recipes()
	. = ..()
	. += GLOB.runed_metal_recipes

/obj/item/stack/sheet/runed_metal/fifty
	amount = 50

/obj/item/stack/sheet/runed_metal/ten
	amount = 10

/obj/item/stack/sheet/runed_metal/five
	amount = 5
