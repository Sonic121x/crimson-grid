//Gun crafting parts til they can be moved elsewhere

// PARTS //
/obj/item/weaponcrafting
	abstract_type = /obj/item/weaponcrafting

/obj/item/weaponcrafting/Initialize(mapload)
	. = ..()
	create_slapcraft_component()

/obj/item/weaponcrafting/proc/create_slapcraft_component()
	return

/obj/item/weaponcrafting/receiver
	name = "模块化机匣"
	desc = "枪械用的原型模块化机匣与扳机组件。"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "receiver"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.55, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)

/* // DARKPACK EDIT REMOVAL
/obj/item/weaponcrafting/receiver/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/pipegun)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
 */
/obj/item/weaponcrafting/stock
	name = "步枪枪托"
	desc = "一具用木头粗略雕成的传统步枪枪托，也可充当握把。"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "riflestock"
/* // DARKPACK EDIT REMOVAL
/obj/item/weaponcrafting/stock/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/smoothbore_disabler, /datum/crafting_recipe/laser_musket)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
 */
/obj/item/weaponcrafting/giant_wrench
	name = "大巴掌零件套件"
	desc = "用于制造俗称“大巴掌”的巨型扳手的非法零件。"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "weaponkit_gw"
/*  // DARKPACK EDIT REMOVAL
/obj/item/weaponcrafting/giant_wrench/create_slapcraft_component() // slappycraft
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/giant_wrench)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)
 */
///These gun kits are printed from the security protolathe to then be used in making new weapons

// GUN PART KIT //

/obj/item/weaponcrafting/gunkit // These don't get a slapcraft component, it's added to the gun - more intuitive player-facing to slap the kit onto the gun.
	name = "通用枪械零件套件"
	desc = "一个空的枪械零件箱！你拿着它干什么？"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/weaponcrafting/gunkit/nuclear
	name = "高级能量枪零件套件（致命／非致命）"
	desc = "一个手提箱，装着将标准能量枪改装成高级能量枪所需的枪械零件。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/tesla
	name = "特斯拉炮零件套件（致命）"
	desc = "一个手提箱，装着以稳定化电磁异常为核心制造特斯拉炮所需的枪械零件。请小心操作。"
	icon_state = "weaponskit_tesla"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/weaponcrafting/gunkit/xray
	name = "X射线激光枪零件套件（致命）"
	desc = "一个手提箱，装着将激光枪改装成X射线激光枪所需的枪械零件。其中大多数零件都不应直接对准面部。"
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/ion
	name = "离子卡宾枪零件套件（非致命／高破坏力／对硅基生命高度致命）"
	desc = "一个手提箱，装着将标准激光枪改装成离子卡宾枪所需的枪械零件。特别适合对付你无权打开的储物柜。"
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)

/obj/item/weaponcrafting/gunkit/temperature
	name = "温度枪零件套件（低致命性／对蜥蜴人高度致命）"
	desc = "一个手提箱，装着将标准能量枪改装成温度枪所需的枪械零件。在生日派对和屠杀蜥蜴人原住民时都非常好用。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/weaponcrafting/gunkit/beam_rifle
	name = "\improper 事件视界反存在光束步枪零件套件（末日装置，禁止组装）"
	desc = "究竟是怎样疯狂的头脑设计了这套可怕的组装套件？竟要造出一副框架，利用流经旋臂星区的奇异能量，实施如此骇人的暴行？"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.25,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)

/obj/item/weaponcrafting/gunkit/ebow
	name = "能量弩零件套件（低致命性）"
	desc = "严令禁止的武器改装套件，可将标准原型动能加速器改装成近乎以假乱真的能量弩。几乎跟真品一样！"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/weaponcrafting/gunkit/hellgun
	name = "地狱火激光枪劣化套件（战争罪级致命）"
	desc = "拿来一把运转正常的激光枪。把内部结构改得面目全非，让它烧得更热、更凶。现在你有一把地狱火激光枪了。你这个怪物。"

/obj/item/weaponcrafting/gunkit/photon
	name = "光子炮零件套件（非致命）"
	desc = "一个手提箱，装着以稳定化电磁异常为核心制造光子炮所需的枪械零件。将太阳的力量掌握在双手之中。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/weaponcrafting/gunkit/sks
	name = "\improper 萨赫诺SKS半自动步枪零件套件（致命）"
	desc = "一个手提箱，装着制造萨赫诺SKS半自动步枪所需的枪械零件。这种枪在边疆星球上随处可见。"
