/* Diffrent misc types of sheets
 * Contains:
 * Iron
 * Plasteel
 * Wood
 * Cloth
 * Plastic
 * Cardboard
 * Paper Frames
 * Runed Metal (cult)
 * Bronze (bake brass)
 */

/*
 * Iron
 */
GLOBAL_LIST_INIT(metal_recipes, list ( \
	new/datum/stack_recipe("凳子", /obj/structure/chair/stool, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("吧台凳", /obj/structure/chair/stool/bar, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("床", /obj/structure/bed, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("双人床", /obj/structure/bed/double, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	null, \
	new/datum/stack_recipe_list("办公椅", list( \
		new/datum/stack_recipe("深色办公椅", /obj/structure/chair/office, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("浅色办公椅", /obj/structure/chair/office/light, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new/datum/stack_recipe_list("软椅", list( \
		new/datum/stack_recipe("米色软椅", /obj/structure/chair/comfy/beige, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("黑色软椅", /obj/structure/chair/comfy/black, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("棕色软椅", /obj/structure/chair/comfy/brown, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("青柠色软椅", /obj/structure/chair/comfy/lime, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new/datum/stack_recipe("蓝绿色软椅", /obj/structure/chair/comfy/teal, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new/datum/stack_recipe_list("沙发", list( \
		new /datum/stack_recipe("商务沙发（中段）", /obj/structure/chair/sofa/corp, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("商务沙发（左端）", /obj/structure/chair/sofa/corp/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("商务沙发（右端）", /obj/structure/chair/sofa/corp/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("商务沙发（转角）", /obj/structure/chair/sofa/corp/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("沙发（中段）", /obj/structure/chair/sofa/middle, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("沙发（左端）", /obj/structure/chair/sofa/left, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("沙发（右端）", /obj/structure/chair/sofa/right, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("沙发（转角）", /obj/structure/chair/sofa/corner, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("复古沙发（中段）", /obj/structure/chair/sofa/middle/brown, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("复古沙发（左端）", /obj/structure/chair/sofa/left/brown, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("复古沙发（右端）", /obj/structure/chair/sofa/right/brown, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("复古沙发（转角）", /obj/structure/chair/sofa/corner/brown, 1, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE) \
	)), \
	new /datum/stack_recipe_list("长椅", list( \
		new /datum/stack_recipe("长椅（中段）", /obj/structure/chair/sofa/bench, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("长椅（左端）", /obj/structure/chair/sofa/bench/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("长椅（右端）", /obj/structure/chair/sofa/bench/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("长椅（转角）", /obj/structure/chair/sofa/bench/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("电车长椅（独座）", /obj/structure/chair/sofa/bench/tram/solo, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("电车长椅（中段）", /obj/structure/chair/sofa/bench/tram, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("电车长椅（左端）", /obj/structure/chair/sofa/bench/tram/left, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("电车长椅（右端）", /obj/structure/chair/sofa/bench/tram/right, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		new /datum/stack_recipe("电车长椅（转角）", /obj/structure/chair/sofa/bench/tram/corner, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
		)), \
	new /datum/stack_recipe_list("国际象棋棋子", list( \
		new /datum/stack_recipe("白兵", /obj/structure/chess/whitepawn, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白车", /obj/structure/chess/whiterook, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白马", /obj/structure/chess/whiteknight, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白象", /obj/structure/chess/whitebishop, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白后", /obj/structure/chess/whitequeen, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白王", /obj/structure/chess/whiteking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑兵", /obj/structure/chess/blackpawn, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑车", /obj/structure/chess/blackrook, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑马", /obj/structure/chess/blackknight, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑象", /obj/structure/chess/blackbishop, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑后", /obj/structure/chess/blackqueen, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑王", /obj/structure/chess/blackking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	)),
	new /datum/stack_recipe_list("西洋跳棋棋子", list( \
		new /datum/stack_recipe("白色跳棋兵", /obj/structure/chess/checker/whiteman, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("白色跳棋王", /obj/structure/chess/checker/whiteking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑色跳棋兵", /obj/structure/chess/checker/blackman, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
		new /datum/stack_recipe("黑色跳棋王", /obj/structure/chess/checker/blackking, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	)),
	// DARKPACK EDIT CHANGE START
	null, \
	new/datum/stack_recipe("置物架零件", /obj/item/rack_parts, category = CAT_FURNITURE), \
	new/datum/stack_recipe("储物柜", /obj/structure/closet, 2, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	null, \
	new/datum/stack_recipe("地砖", /obj/item/stack/tile/iron/base, 1, 4, 20, category = CAT_TILES), \
	new/datum/stack_recipe("铁杆", /obj/item/stack/rods, 1, 2, 60, category = CAT_MISC), \
	null, \
	new/datum/stack_recipe("墙体支架（已固定）", /obj/structure/girder, 2, time = 4 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, placement_checks = STACK_CHECK_TRAM_FORBIDDEN, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new /datum/stack_recipe_list("平台（已固定）", list( \
		new /datum/stack_recipe("圆边平台", /obj/structure/platform, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("粗制平台", /obj/structure/platform/iron, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("平台台阶", /obj/structure/steps, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	)),
	null, \
	new/datum/stack_recipe("电脑框架", /obj/structure/frame/computer, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("模块化控制台", /obj/machinery/modular_computer, 10, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("机器框架", /obj/structure/frame/machine, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("防火门框架", /obj/structure/firelock_frame, 3, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS), \
	new/datum/stack_recipe("单面防火门框架", /obj/structure/firelock_frame/border_only, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ON_SOLID_GROUND | CRAFT_CHECK_DIRECTION, category = CAT_DOORS), \
	new/datum/stack_recipe("挂肉架框架", /obj/structure/kitchenspike_frame, 5, time = 2.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("手榴弹外壳", /obj/item/grenade/chem_grenade, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("灯具框架", /obj/item/wallframe/light_fixture, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("小型灯具框架", /obj/item/wallframe/light_fixture/small, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("灭火器柜框架", /obj/item/wallframe/extinguisher_cabinet, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("按钮框架", /obj/item/wallframe/button, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("电灯开关框架", /obj/item/wallframe/light_switch, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("摄像头组件", /obj/item/wallframe/camera, 1, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("内部通话器框架", /obj/item/wallframe/intercom, 2, crafting_flags = NONE, category = CAT_STRUCTURE), \
	null, \
	new/datum/stack_recipe("文件柜", /obj/structure/filingcabinet, 2, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("桌铃", /obj/structure/desk_bell, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("泛光灯框架", /obj/structure/floodlight_frame, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("投票箱", /obj/structure/votebox, 15, time = 5 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("研杵", /obj/item/pestle, 1, time = 5 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("淋浴器框架", /obj/structure/showerframe, 2, time = 2 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("小便池", /obj/item/wallframe/urinal, 2, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE)
))
// DARKPACK EDIT CHANGE END
/obj/item/stack/sheet/iron
	name = "铁"
	desc = "铁制的板材。"
	singular_name = "铁板"
	icon_state = "sheet-metal"
	worn_icon_state = "sheet-metal"
	inhand_icon_state = "sheet-metal"
	mats_per_unit = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/iron
	gulag_value = 5
	table_type = /obj/structure/table
	material_type = /datum/material/iron
	matter_amount = 4
	cost = SHEET_MATERIAL_AMOUNT
	source = /datum/robot_energy_storage/material/iron
	stairs_type = /obj/structure/stairs
	sniffable = TRUE

/obj/item/stack/sheet/iron/Initialize(mapload)
	. = ..()
	var/static/list/tool_behaviors = list(
		TOOL_WELDER = list(
			SCREENTIP_CONTEXT_LMB = "制作铁杆",
			SCREENTIP_CONTEXT_RMB = "制作地砖",
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/obj/item/stack/sheet/iron/examine(mob/user)
	. = ..()
	. += span_notice("右键点击地板可建造：")
	. += span_notice("- 未固定的墙体支架")
	. += span_notice("- 电脑或机器框架（需持有电路板）")

/obj/item/stack/sheet/iron/fifty
	amount = 50

/obj/item/stack/sheet/iron/twenty
	amount = 20

/obj/item/stack/sheet/iron/ten
	amount = 10

/obj/item/stack/sheet/iron/five
	amount = 5

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.metal_recipes

/obj/item/stack/sheet/iron/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用[src]猛砸自己的脑袋！看起来是想自杀！"))
	return BRUTELOSS

/obj/item/stack/sheet/iron/welder_act(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/rods/two/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name]用[tool]将[src]加工成了铁杆。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(1)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/iron/welder_act_secondary(mob/living/user, obj/item/tool)
	if(tool.use_tool(src, user, delay = 0, volume = 40))
		var/obj/item/stack/tile/iron/four/new_item = new(user.loc)
		user.visible_message(
			span_notice("[user.name]用[tool]将[src]加工成了地砖。"),
			blind_message = span_hear("你听到了焊接声。"),
			vision_distance = COMBAT_MESSAGE_RANGE,
			ignored_mobs = user
		)
		use(1)
		user.put_in_inactive_hand(new_item)
		return ITEM_INTERACT_SUCCESS

/obj/item/stack/sheet/iron/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/open/build_on = interacting_with
	if(!user.Adjacent(build_on))
		return ITEM_INTERACT_BLOCKING
	if(isgroundlessturf(build_on))
		user.balloon_alert(user, "不能放在这里！")
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "这里有东西挡着！")
		return ITEM_INTERACT_BLOCKING

	var/frame_path = null
	var/cost = 2 // Default girder cost
	var/time = 4 SECONDS //Default girder build time
	var/obj/item/circuitboard/held_board = locate() in user.held_items
	if(!isnull(held_board))
		if(istype(held_board, /obj/item/circuitboard/machine))
			frame_path = /obj/structure/frame/machine
		else
			frame_path = /obj/structure/frame/computer
		for(var/datum/stack_recipe/recipe in GLOB.metal_recipes)
			if(recipe.result_type == frame_path)
				time = recipe.time
				cost = recipe.req_amount
				break
	if(get_amount() < cost)
		user.balloon_alert(user, "需要[cost]块金属板！")
		return ITEM_INTERACT_BLOCKING
	if(!do_after(user, time, build_on))
		return ITEM_INTERACT_BLOCKING
	if(build_on.is_blocked_turf())
		user.balloon_alert(user, "这里有东西挡着！")
		return ITEM_INTERACT_BLOCKING
	if(!use(cost))
		user.balloon_alert(user, "材料不足！")
		return ITEM_INTERACT_BLOCKING
	if(frame_path)
		var/obj/structure/frame/constructed_frame = new frame_path(build_on)
		constructed_frame.setDir(REVERSE_DIR(user.dir)) //to align computer frame with player direction
		user.balloon_alert(user, "框架已建好")
	else
		new/obj/structure/girder/displaced(build_on)
		user.balloon_alert(user, "支架已建好")
	return ITEM_INTERACT_SUCCESS

/*
 * Plasteel
 */
// DARKPACK EDIT CHANGE START
GLOBAL_LIST_INIT(plasteel_recipes, list ( \
	new/datum/stack_recipe("卷帘门组件", /obj/machinery/door/poddoor/shutters/preopen/deconstructed, 5, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_DOORS),
	new/datum/stack_recipe("大型金属箱", /obj/structure/closet/cardboard/metal, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS),
	null,
	new /datum/stack_recipe_list("气闸门组件", list( \
		new/datum/stack_recipe("高安全气闸门组件", /obj/structure/door_assembly/door_assembly_highsecurity, 4, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
		new/datum/stack_recipe("金库门组件", /obj/structure/door_assembly/door_assembly_vault, 6, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_DOORS),
	)), \
	new /datum/stack_recipe("雷达塔", /obj/machinery/power/weather_tower/constructed, 12, time = 10 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
))
// DARKPACK EDIT CHANGE END
/obj/item/stack/sheet/plasteel
	name = "等离子钢"
	singular_name = "等离子钢板"
	desc = "这种板材由铁与等离子体的合金制成。"
	icon_state = "sheet-plasteel"
	worn_icon_state = "sheet-plasteel"
	inhand_icon_state = "sheet-plasteel"
	mats_per_unit = list(/datum/material/alloy/plasteel=SHEET_MATERIAL_AMOUNT)
	material_type = /datum/material/alloy/plasteel
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	armor_type = /datum/armor/sheet_plasteel
	resistance_flags = FIRE_PROOF
	merge_type = /obj/item/stack/sheet/plasteel
	gulag_value = 10
	table_type = /obj/structure/table/reinforced
	material_flags = NONE
	matter_amount = 12

/datum/armor/sheet_plasteel
	fire = 100
	acid = 80

/obj/item/stack/sheet/plasteel/get_main_recipes()
	. = ..()
	. += GLOB.plasteel_recipes

/obj/item/stack/sheet/plasteel/twenty
	amount = 20

/obj/item/stack/sheet/plasteel/fifty
	amount = 50

/*
 * Wood
 */
// DARKPACK EDIT CHANGE START
GLOBAL_LIST_INIT(wood_recipes, list ( \
	new/datum/stack_recipe("木凉鞋", /obj/item/clothing/shoes/sandal, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("木地板", /obj/item/stack/tile/wood, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("木桌架", /obj/structure/table_frame/wood, 2, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe_list("平台（已固定）", list( \
		new /datum/stack_recipe("木平台", /obj/structure/platform/wood, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
		new /datum/stack_recipe("木舞台", /obj/structure/platform/wood/stage, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	)),
	new/datum/stack_recipe("擀面杖", /obj/item/kitchen/rollingpin, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("木椅", /obj/structure/chair/wood/, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("翼背木椅", /obj/structure/chair/wood/wings, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("木路障", /obj/structure/barricade/wooden, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("木楼梯框架", /obj/structure/stairs_frame/wood, 10, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("木栅栏", /obj/structure/railing/darkpack/wood, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("猫屋", /obj/structure/cat_house, 5, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_STRUCTURE), \
	new/datum/stack_recipe("棺材", /obj/structure/closet/crate/coffin, 5, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("书柜", /obj/structure/bookcase, 4, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("晾晒架", /obj/machinery/smartfridge/drying/rack, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("木桶", /obj/structure/fermenting_barrel, 8, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("狗窝", /obj/structure/bed/dogbed, 10, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("法槌", /obj/item/gavelhammer, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("法槌垫座", /obj/item/gavelblock, 1, time = 2 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("衣橱", /obj/structure/dresser, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("橱柜", /obj/structure/closet/cabinet, 2, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("相框", /obj/item/wallframe/picture, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT),\
	new/datum/stack_recipe("画框", /obj/item/wallframe/painting, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_ENTERTAINMENT),\
	new/datum/stack_recipe("展示柜底座", /obj/structure/displaycase_chassis, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("木圆盾", /obj/item/shield/buckler, 20, time = 4 SECONDS, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new/datum/stack_recipe("蜂箱", /obj/structure/beebox, 40, time = 5 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("服装人台", /obj/structure/mannequin/wood, 25, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("提基面具", /obj/item/clothing/mask/gas/tiki_mask, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("烟斗", /obj/item/cigarette/pipe, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("蜂巢框", /obj/item/honey_frame, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("木水桶", /obj/item/reagent_containers/cup/bucket/wooden, 3, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CONTAINERS),\
	new/datum/stack_recipe("耙子", /obj/item/cultivator/rake, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_TOOLS),\
	new/datum/stack_recipe("木箱", /obj/structure/closet/crate/wooden, 6, time = 5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),\
	new/datum/stack_recipe("棒球棍", /obj/item/melee/baseball_bat, 5, time = 1.5 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE, removed_mats = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 1.5)),\
	new/datum/stack_recipe("木拐杖", /obj/item/cane/crutch/wood, 5, time = 1.5 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE),\
	new/datum/stack_recipe("织布机", /obj/structure/loom, 10, time = 1.5 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("研钵", /obj/item/reagent_containers/cup/mortar, 3, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("火种棒", /obj/item/match/firebrand, 2, time = 10 SECONDS, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("篝火", /obj/structure/bonfire, 10, time = 6 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_TOOLS), \
	new/datum/stack_recipe("画架", /obj/structure/easel, 5, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("公告板", /obj/item/wallframe/noticeboard, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("鱼类标本挂架", /obj/item/wallframe/fish, 2, time = 3 SECONDS, crafting_flags = NONE, category = CAT_FURNITURE),\
	new/datum/stack_recipe("试管架", /obj/item/storage/test_tube_rack, 1, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	null, \
	new/datum/stack_recipe_list("教堂长椅", list(
		new /datum/stack_recipe("教堂长椅（中段）", /obj/structure/chair/pew, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("教堂长椅（左端）", /obj/structure/chair/pew/left, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("教堂长椅（右端）", /obj/structure/chair/pew/right, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
		)),
	new/datum/stack_recipe_list("木假肢", list(
		new /datum/stack_recipe("木假臂（左）", /obj/item/bodypart/arm/left/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("木假臂（右）", /obj/item/bodypart/arm/right/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("木假腿（左）", /obj/item/bodypart/leg/left/ghetto, 2, crafting_flags = NONE, category = CAT_MISC),
		new /datum/stack_recipe("木假腿（右）", /obj/item/bodypart/leg/right/ghetto, 2, crafting_flags = NONE, category = CAT_MISC)
	)),
	null, \
	))
// DARKPACK EDIT CHANGE END
/obj/item/stack/sheet/mineral/wood
	name = "木板"
	desc = "只能猜测这是一堆木头。"
	singular_name = "木板"
	icon_state = "sheet-wood"
	worn_icon_state = "sheet-wood"
	inhand_icon_state = "sheet-wood"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/wood=SHEET_MATERIAL_AMOUNT)
	construction_path_type = "wood"
	armor_type = /datum/armor/mineral_wood
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/wood
	material_type = /datum/material/wood
	walltype = /turf/closed/wall/mineral/wood
	stairs_type = /obj/structure/stairs/wood
	pickup_sound = 'sound/items/handling/materials/wood_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/wood_drop.ogg'

/datum/armor/mineral_wood
	fire = 50

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.wood_recipes

/obj/item/stack/sheet/mineral/wood/fifty
	amount = 50

/obj/item/stack/sheet/mineral/wood/interact_with_atom(mob/living/carbon/human/target, mob/user)
	if(!istype(target))
		return NONE

	var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
	if(affecting && IS_PEG_LIMB(affecting))
		if(user == target)
			user.visible_message(span_notice("[user]开始修补自己的[affecting.name]。"), span_notice("你开始修补[target == user ? "自己" : "[target]"]的[affecting.name]。"))
			if(!do_after(user, 5 SECONDS, target))
				return ITEM_INTERACT_FAILURE
		if(target.item_heal(user, brute_heal = 15, burn_heal = 15, heal_message_brute = "碎裂", heal_message_burn = "焦痕", required_bodytype = BODYTYPE_PEG))
			use(1)
		return ITEM_INTERACT_SUCCESS
	else
		return NONE

/*
 * Bamboo
 */
GLOBAL_LIST_INIT(bamboo_recipes, list ( \
	new/datum/stack_recipe("竹签陷阱", /obj/structure/punji_sticks, 5, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_EQUIPMENT), \
	new/datum/stack_recipe("竹矛", /obj/item/spear/bamboospear, 25, time = 9 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_MELEE), \
	new/datum/stack_recipe("吹箭筒", /obj/item/gun/syringe/blowgun, 10, time = 7 SECONDS, crafting_flags = NONE, category = CAT_WEAPON_RANGED), \
	new/datum/stack_recipe("粗制注射器", /obj/item/reagent_containers/syringe/crude, 5, time = 1 SECONDS, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("斗笠", /obj/item/clothing/head/costume/rice_hat, 10, time = 7 SECONDS, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("竹凳", /obj/structure/chair/stool/bamboo, 2, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
	new/datum/stack_recipe("竹席块", /obj/item/stack/tile/bamboo, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	null, \
	new /datum/stack_recipe("竹平台", /obj/structure/platform/bamboo, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	new/datum/stack_recipe_list("竹长椅", list(
		new /datum/stack_recipe("竹长椅（中段）", /obj/structure/chair/sofa/bamboo, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("竹长椅（左端）", /obj/structure/chair/sofa/bamboo/left, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE),
		new /datum/stack_recipe("竹长椅（右端）", /obj/structure/chair/sofa/bamboo/right, 3, time = 1 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE)
		)),	\
	))

/obj/item/stack/sheet/mineral/bamboo
	name = "竹段"
	desc = "切割整齐的竹段。"
	singular_name = "竹段"
	icon_state = "sheet-bamboo"
	inhand_icon_state = "sheet-bamboo"
	icon = 'icons/obj/stack_objects.dmi'
	construction_path_type = "bamboo"
	mats_per_unit = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT)
	throwforce = 15
	armor_type = /datum/armor/mineral_bamboo
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/sheet/mineral/bamboo
	material_type = /datum/material/bamboo
	walltype = /turf/closed/wall/mineral/bamboo
	drop_sound = null
	pickup_sound = null

/datum/armor/mineral_bamboo
	fire = 50

/obj/item/stack/sheet/mineral/bamboo/get_main_recipes()
	. = ..()
	. += GLOB.bamboo_recipes

/obj/item/stack/sheet/mineral/bamboo/fifty
	amount = 50

/*
 * Cloth
 */
GLOBAL_LIST_INIT(cloth_recipes, list ( \
	new/datum/stack_recipe("白色连身裙", /obj/item/clothing/under/color/jumpskirt/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), /*Ladies first*/ \
	new/datum/stack_recipe("白色连身服", /obj/item/clothing/under/color/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白鞋", /obj/item/clothing/shoes/sneakers/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白色围巾", /obj/item/clothing/neck/scarf, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白色方巾", /obj/item/clothing/mask/bandana/white, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("背包", /obj/item/storage/backpack, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("挎包", /obj/item/storage/backpack/satchel, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("邮差包", /obj/item/storage/backpack/messenger, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("行李袋", /obj/item/storage/backpack/duffelbag, 6, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("植物袋", /obj/item/storage/bag/plants, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("书袋", /obj/item/storage/bag/books, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("矿石袋", /obj/item/storage/bag/ore, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("化学袋", /obj/item/storage/bag/chemistry, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("生物样本袋", /obj/item/storage/bag/bio, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("科研袋", /obj/item/storage/bag/xeno, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("施工袋", /obj/item/storage/bag/construction, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("简易纱布", /obj/item/stack/medical/wrap/gauze/improvised, 1, 2, 6, crafting_flags = NONE, category = CAT_TOOLS), \
	new/datum/stack_recipe("抹布", /obj/item/rag, 1, crafting_flags = NONE, category = CAT_CHEMISTRY), \
	new/datum/stack_recipe("床单", /obj/item/bedsheet, 3, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("双人床单", /obj/item/bedsheet/double, 6, crafting_flags = NONE, category = CAT_FURNITURE), \
	new/datum/stack_recipe("空沙袋", /obj/item/emptysandbag, 4, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	new/datum/stack_recipe("露指手套", /obj/item/clothing/gloves/fingerless, 1, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白手套", /obj/item/clothing/gloves/color/white, 3, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白色软帽", /obj/item/clothing/head/soft/mime, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("白色针织帽", /obj/item/clothing/head/beanie, 2, crafting_flags = NONE, category = CAT_CLOTHING), \
	null, \
	new/datum/stack_recipe("眼罩", /obj/item/clothing/glasses/blindfold, 2, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	null, \
	new/datum/stack_recipe("19x19画布", /obj/item/canvas/nineteen_nineteen, 3, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("23x19画布", /obj/item/canvas/twentythree_nineteen, 4, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("23x23画布", /obj/item/canvas/twentythree_twentythree, 5, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	new/datum/stack_recipe("枕头", /obj/item/pillow, 3, category = CAT_FURNITURE), \
	))

/obj/item/stack/sheet/cloth
	name = "布料"
	desc = "这是棉布？亚麻布？牛仔布？粗麻布？帆布？你分辨不出来。"
	singular_name = "布卷"
	icon_state = "sheet-cloth"
	inhand_icon_state = null
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cloth
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'
	pickup_sound = SFX_CLOTH_PICKUP
	drop_sound = SFX_CLOTH_DROP

/obj/item/stack/sheet/cloth/grind_results()
	return list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cloth/get_main_recipes()
	. = ..()
	. += GLOB.cloth_recipes

/obj/item/stack/sheet/cloth/ten
	amount = 10

/obj/item/stack/sheet/cloth/five
	amount = 5
// DARKPACK EDIT REMOVAL
/obj/item/stack/sheet/durathread
	name = "耐久纤维布"
	desc = "用极其坚韧的纤维织成的布料，以适合制作护甲而闻名。"
	singular_name = "耐久纤维布卷"
	icon_state = "sheet-durathread"
	inhand_icon_state = null
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/durathread
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'
/* // DARKPACK EDIT REMOVAL
/obj/item/stack/sheet/durathread/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/durathread_helmet, /datum/crafting_recipe/durathread_vest)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/stack/sheet/durathread/get_main_recipes()
	. = ..()
	. += GLOB.durathread_recipes
*/
/obj/item/stack/sheet/durathread/used_in_craft(atom/created, datum/crafting_recipe/recipe)
	. = ..()
	created.set_armor_rating(CONSUME, max(50, created.get_armor_rating(CONSUME)))

/obj/item/stack/sheet/cotton
	name = "原棉束"
	desc = "一束可以放到织布机上织成布的原棉。"
	singular_name = "原棉团"
	icon_state = "sheet-cotton"
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cotton
	drop_sound = 'sound/items/handling/cloth/cloth_drop1.ogg'
	pickup_sound = 'sound/items/handling/cloth/cloth_pickup1.ogg'

	var/loom_result = /obj/item/stack/sheet/cloth
	var/loom_time = 1 SECONDS

/obj/item/stack/sheet/cotton/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/loomable, resulting_atom = loom_result, loom_time = loom_time)

/obj/item/stack/sheet/cotton/grind_results()
	return list(/datum/reagent/cellulose = 20)

/obj/item/stack/sheet/cotton/durathread
	name = "耐久纤维原料束"
	desc = "一束可以放到织布机上织成布的耐久纤维原料。"
	singular_name = "耐久纤维原料团"
	icon_state = "sheet-durathreadraw"
	merge_type = /obj/item/stack/sheet/cotton/durathread
	loom_result = /obj/item/stack/sheet/durathread

/obj/item/stack/sheet/cotton/wool
	name = "原羊毛束"
	desc = "一束可以放到织布机上织成布的原羊毛。"
	singular_name = "原羊毛团"
	icon_state = "sheet-wool"
	merge_type = /obj/item/stack/sheet/cotton/wool
	loom_result = /obj/item/stack/sheet/cloth

/*
 * Cardboard
 */
// DARKPACK EDIT CHANGE START
GLOBAL_LIST_INIT(cardboard_recipes, list ( \
	new/datum/stack_recipe("盒子", /obj/item/storage/box, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("大纸箱", /obj/structure/closet/cardboard, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("中型纸箱", /obj/structure/closet/crate/cardboard, 4, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("人形纸板", /obj/item/cardboard_cutout, 5, crafting_flags = NONE, category = CAT_ENTERTAINMENT), \
	null, \

	new/datum/stack_recipe("披萨盒", /obj/item/pizzabox, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new/datum/stack_recipe("文件夹", /obj/item/folder, crafting_flags = NONE, category = CAT_CONTAINERS), \
	null, \
	//TO-DO: Find a proper way to just change the illustration on the box. Code isn't the issue, input is.
	new/datum/stack_recipe_list("花式盒子", list(
		new /datum/stack_recipe("甜甜圈盒", /obj/item/storage/fancy/donut_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("鸡蛋盒", /obj/item/storage/fancy/egg_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("当克口袋饼盒", /obj/item/storage/box/donkpockets, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("香辣当克口袋饼盒", /obj/item/storage/box/donkpockets/donkpocketspicy, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("照烧当克口袋饼盒", /obj/item/storage/box/donkpockets/donkpocketteriyaki, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("披萨当克口袋饼盒", /obj/item/storage/box/donkpockets/donkpocketpizza, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("莓果当克口袋饼盒", /obj/item/storage/box/donkpockets/donkpocketberry, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("滑稽当克口袋饼盒", /obj/item/storage/box/donkpockets/donkpockethonk, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("鸡块盒", /obj/item/storage/fancy/nugget_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("红色鸡块盒", /obj/item/storage/fancy/nugget_box/red, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("红色鸡翅盒", /obj/item/storage/fancy/wing_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("红色薯条盒", /obj/item/storage/fancy/fry_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("玻璃杯盒", /obj/item/storage/box/drinkingglasses, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("纸杯盒", /obj/item/storage/box/cups, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("雪茄盒", /obj/item/storage/fancy/cigarettes/cigars, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \

		new /datum/stack_recipe("致命弹药盒", /obj/item/storage/box/lethalshot, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("橡胶霰弹盒", /obj/item/storage/box/rubbershot, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("豆袋弹盒", /obj/item/storage/box/beanbag, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("闪光震撼弹盒", /obj/item/storage/box/flashbangs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("闪光器盒", /obj/item/storage/box/flashes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("手铐盒", /obj/item/storage/box/handcuffs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("身份卡盒", /obj/item/storage/box/ids, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("PDA盒", /obj/item/storage/box/pdas, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \
		new /datum/stack_recipe("药瓶盒", /obj/item/storage/box/pillbottles, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("医用凝胶盒", /obj/item/storage/box/medigels, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("烧杯盒", /obj/item/storage/box/beakers, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("注射器盒", /obj/item/storage/box/syringes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("乳胶手套盒", /obj/item/storage/box/gloves, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("无菌口罩盒", /obj/item/storage/box/masks, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("裹尸袋盒", /obj/item/storage/box/bodybags, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("矫正眼镜盒", /obj/item/storage/box/rxglasses, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("医用注射笔盒", /obj/item/storage/box/medipens, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("DNA注射器盒", /obj/item/storage/box/injectors, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("氧气瓶盒", /obj/item/storage/box/emergencytank, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("扩容氧气瓶盒", /obj/item/storage/box/engitank, crafting_flags = NONE, category = CAT_CONTAINERS), \
		null, \
		new /datum/stack_recipe("磁盘盒", /obj/item/storage/box/disks, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("灯管盒", /obj/item/storage/box/lights/tubes, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("灯泡盒", /obj/item/storage/box/lights/bulbs, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("混装灯具盒", /obj/item/storage/box/lights/mixed, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("捕鼠夹盒", /obj/item/storage/box/mousetraps, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("蜡烛盒", /obj/item/storage/fancy/candle_box, crafting_flags = NONE, category = CAT_CONTAINERS), \
		new /datum/stack_recipe("绷带盒", /obj/item/storage/box/bandages, crafting_flags = NONE, category = CAT_CONTAINERS)
		)),

	null, \
))
// DARKPACK EDIT CHANGE END

/obj/item/stack/sheet/cardboard
	name = "纸板"
	desc = "大张的硬纸板，像是压扁的纸箱。"
	singular_name = "纸板"
	icon_state = "sheet-card"
	worn_icon_state = "sheet-card"
	inhand_icon_state = "sheet-card"
	mats_per_unit = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	force = 0
	throwforce = 0
	merge_type = /obj/item/stack/sheet/cardboard
	material_type = /datum/material/cardboard
	pickup_sound = 'sound/items/handling/materials/cardboard_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/cardboard_drop.ogg'
/* // DARKPACK EDIT REMOVAL
/obj/item/stack/sheet/cardboard/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/cardboard_id)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
 */

/obj/item/stack/sheet/cardboard/get_main_recipes()
	. = ..()
	. += GLOB.cardboard_recipes

/obj/item/stack/sheet/cardboard/fifty
	amount = 50

/obj/item/stack/sheet/cardboard/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stamp/clown) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(!use(1))
			return ITEM_INTERACT_BLOCKING
		playsound(tool, 'sound/items/bikehorn.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("你在纸板上盖了个章！它变成小丑盒了！HONK！"))
		new /obj/item/storage/box/clown(droploc) //bugfix
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stamp/chameleon) && !istype(loc, /obj/item/storage))
		var/atom/droploc = drop_location()
		if(!use(1))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你阴森森地在纸板上盖了个章。"))
		new /obj/item/storage/box/syndie_kit(droploc)
		return ITEM_INTERACT_SUCCESS

	return ..()

/*
 * Bronze
 */
// DARKPACK EDIT CHANGE START
GLOBAL_LIST_INIT(bronze_recipes, list ( \
	new /datum/stack_recipe("发条平台", /obj/structure/platform/bronze, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
	null,
	new/datum/stack_recipe("青铜地砖", /obj/item/stack/tile/bronze, 1, 4, 20, crafting_flags = NONE, category = CAT_TILES), \
	new/datum/stack_recipe("青铜帽", /obj/item/clothing/head/costume/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("青铜服", /obj/item/clothing/suit/costume/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	new/datum/stack_recipe("青铜靴", /obj/item/clothing/shoes/bronze, crafting_flags = NONE, category = CAT_CLOTHING), \
	null,
	new/datum/stack_recipe("青铜椅", /obj/structure/chair/bronze, 1, time = 0, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, category = CAT_FURNITURE), \
))
// DARKPACK EDIT CHANGE END
/obj/item/stack/sheet/bronze
	name = "青铜"
	desc = "仔细看，原以为是完全不适合建筑的黄铜，实际上是结构更稳定的青铜。"
	singular_name = "青铜板"
	icon_state = "sheet-brass"
	worn_icon_state = "sheet-brass"
	inhand_icon_state = "sheet-brass"
	icon = 'icons/obj/stack_objects.dmi'
	mats_per_unit = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT)
	lefthand_file = 'icons/mob/inhands/items/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/sheets_righthand.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	construction_path_type = "bronze"
	force = 5
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	novariants = FALSE
	merge_type = /obj/item/stack/sheet/bronze
	table_type = /obj/structure/table/bronze
	material_type = /datum/material/bronze
	walltype = /turf/closed/wall/mineral/bronze
	has_unique_girder = TRUE

/obj/item/stack/sheet/bronze/get_main_recipes()
	. = ..()
	. += GLOB.bronze_recipes

/obj/item/stack/sheet/bronze/thirty
	amount = 30

/*
 * Lesser and Greater gems - unused
 */
/obj/item/stack/sheet/lessergem
	name = "次级宝石"
	desc = "只有向次等神祇献上血祭才能获得的稀有宝石，是制作强力物品的必需材料。"
	singular_name = "次级宝石"
	icon_state = "sheet-lessergem"
	inhand_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/lessergem

/obj/item/stack/sheet/greatergem
	name = "高级宝石"
	desc = "只有向次等神祇献上血祭才能获得的稀有宝石，是制作强力物品的必需材料。"
	singular_name = "高级宝石"
	icon_state = "sheet-greatergem"
	inhand_icon_state = null
	novariants = TRUE
	merge_type = /obj/item/stack/sheet/greatergem

/*
 * Bones
 */
/obj/item/stack/sheet/bone
	name = "骨头"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "bone"
	inhand_icon_state = null
	mats_per_unit = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
	singular_name = "骨头"
	desc = "看来主人平时没少喝牛奶。"
	force = 7
	throwforce = 5
	max_amount = 12
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 3
	merge_type = /obj/item/stack/sheet/bone
	material_type = /datum/material/bone
	drop_sound = null
	pickup_sound = null
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/stack/sheet/bone/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()

	// As bone and sinew have just a little too many recipes for this, we'll just split them up.
	// Sinew slapcrafting will mostly-sinew recipes, and bones will have mostly-bones recipes.
	var/static/list/slapcraft_recipe_list = list(
		/datum/crafting_recipe/bonearmor,
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonedagger,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bracers,
		/datum/crafting_recipe/skullhelm,
	)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/*
 * Plastic
 */
GLOBAL_LIST_INIT(plastic_recipes, list(
	new /datum/stack_recipe("塑料地砖", /obj/item/stack/tile/plastic, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES), \
	new /datum/stack_recipe("塑料折叠椅", /obj/structure/chair/plastic, 2, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe("塑料门帘", /obj/structure/plasticflaps, 5, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, time = 4 SECONDS, category = CAT_FURNITURE), \
	new /datum/stack_recipe("水瓶", /obj/item/reagent_containers/cup/glass/waterbottle/empty, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("大水瓶", /obj/item/reagent_containers/cup/glass/waterbottle/large/empty, 3, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("彩色派对杯", /obj/item/reagent_containers/cup/glass/colocup, 1, crafting_flags = NONE, category = CAT_CONTAINERS, removed_mats = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)), \
	new /datum/stack_recipe("服装人台", /obj/structure/mannequin/plastic, 25, time = 5 SECONDS, crafting_flags = CRAFT_ONE_PER_TURF, category = CAT_ENTERTAINMENT), \
	new /datum/stack_recipe("小心地滑警示牌", /obj/item/clothing/suit/caution, 2, crafting_flags = CRAFT_SKIP_MATERIALS_PARITY, category = CAT_EQUIPMENT), \
	new /datum/stack_recipe("警示锥", /obj/item/clothing/head/cone, 2, crafting_flags = NONE, category = CAT_EQUIPMENT), \
	new /datum/stack_recipe("空白墙牌", /obj/item/sign, 1, crafting_flags = NONE, category = CAT_FURNITURE), \
	new /datum/stack_recipe("饮水机水桶", /obj/item/reagent_containers/cooler_jug, 4, time = 5 SECONDS, crafting_flags = NONE, category = CAT_CONTAINERS), \
	new /datum/stack_recipe("饮水机", /obj/structure/reagent_dispensers/water_cooler/jugless, 25, time = 10 SECONDS, crafting_flags = NONE, category = CAT_STRUCTURE), \
	new /datum/stack_recipe("反抗面具", /obj/item/clothing/mask/rebellion, 1, crafting_flags = NONE, category = CAT_CLOTHING)))
// DARKPACK EDIT CHANGE END
/obj/item/stack/sheet/plastic
	name = "塑料"
	desc = "把恐龙压上几百万年，再精炼、裂解、塑形，瞧！塑料就做好了。"
	singular_name = "塑料板"
	icon_state = "sheet-plastic"
	worn_icon_state = "sheet-plastic"
	inhand_icon_state = "sheet-plastic"
	mats_per_unit = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	throwforce = 7
	material_type = /datum/material/plastic
	merge_type = /obj/item/stack/sheet/plastic
	pickup_sound = 'sound/items/handling/materials/plastic_pick_up.ogg'
	drop_sound = 'sound/items/handling/materials/plastic_drop.ogg'

/obj/item/stack/sheet/plastic/fifty
	amount = 50

/obj/item/stack/sheet/plastic/five
	amount = 5

/obj/item/stack/sheet/plastic/get_main_recipes()
	. = ..()
	. += GLOB.plastic_recipes

/*
 * Paper Frames
 */
GLOBAL_LIST_INIT(paperframe_recipes, list(
	new /datum/stack_recipe("纸框隔断", /obj/structure/window/paperframe, 2, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND | CRAFT_IS_FULLTILE, time = 1 SECONDS), \
	new /datum/stack_recipe("纸框门", /obj/structure/mineral_door/paperframe, 3, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, time = 1 SECONDS ), \
	new /datum/stack_recipe("纸框平台", /obj/structure/platform/paper, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
))

/obj/item/stack/sheet/paperframes
	name = "纸框"
	desc = "贴着纸的薄木框。"
	singular_name = "纸框"
	icon_state = "sheet-paper"
	worn_icon_state = "sheet-paper"
	inhand_icon_state = "sheet-paper"
	mats_per_unit = list(/datum/material/paper = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/paperframes
	resistance_flags = FLAMMABLE
	material_type = /datum/material/paper
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/paperframes/get_main_recipes()
	. = ..()
	. += GLOB.paperframe_recipes
/obj/item/stack/sheet/paperframes/five
	amount = 5
/obj/item/stack/sheet/paperframes/twenty
	amount = 20
/obj/item/stack/sheet/paperframes/fifty
	amount = 50

/*
 * Meat
 */
/obj/item/stack/sheet/meat
	name = "肉板"
	desc = "某种生物的血肉压成的结实板材。"
	singular_name = "肉板"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR | MATERIAL_NO_DESCRIPTORS
	mats_per_unit = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/meat
	material_type = /datum/material/meat
	material_modifier = 1 //None of that wussy stuff
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/meat/fifty
	amount = 50
/obj/item/stack/sheet/meat/twenty
	amount = 20
/obj/item/stack/sheet/meat/five
	amount = 5

GLOBAL_LIST_INIT(pizza_sheet_recipes, list(
	new/datum/stack_recipe("巨型披萨", /obj/structure/platform/pizza, 2, time = 3 SECONDS, crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_ONE_PER_TURF | CRAFT_ON_SOLID_GROUND, trait_booster = TRAIT_QUICK_BUILD, trait_modifier = 0.75, category = CAT_STRUCTURE), \
))

/*
 * Pizza
 */
/obj/item/stack/sheet/pizza
	name = "披萨板"
	desc = "一整块美味的长方形披萨！"
	singular_name = "披萨板"
	icon_state = "sheet-pizza"
	mats_per_unit = list(/datum/material/pizza = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/pizza
	material_type = /datum/material/pizza
	material_modifier = 1
	drop_sound = null
	pickup_sound = null

/obj/item/stack/sheet/pizza/get_main_recipes()
	. = ..()
	. += GLOB.pizza_sheet_recipes

/obj/item/stack/sheet/pizza/fifty
	amount = 50
/obj/item/stack/sheet/pizza/twenty
	amount = 20
/obj/item/stack/sheet/pizza/five
	amount = 5

/*
 * Hauntium
 */
GLOBAL_LIST_INIT(hauntium_recipes, list(
	new /datum/stack_recipe("幽魂金属地砖", /obj/item/stack/tile/hauntium, 1, 4, 20, time = 2 SECONDS, crafting_flags = NONE, category = CAT_TILES), \
))

/obj/item/stack/sheet/hauntium/get_main_recipes()
	. = ..()
	. += GLOB.hauntium_recipes

/obj/item/stack/sheet/hauntium
	name = "幽魂金属板"
	desc = "这些板材似乎受到了诅咒。"
	singular_name = "幽魂金属板"
	icon_state = "sheet-meat"
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR | MATERIAL_NO_DESCRIPTORS
	mats_per_unit = list(/datum/material/hauntium = SHEET_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/hauntium
	material_type = /datum/material/hauntium
	material_modifier = 1 //None of that wussy stuff

/obj/item/stack/sheet/hauntium/fifty
	amount = 50
/obj/item/stack/sheet/hauntium/twenty
	amount = 20
/obj/item/stack/sheet/hauntium/five
	amount = 5
