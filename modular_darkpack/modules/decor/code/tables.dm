
/obj/structure/table/modern
	name = "现代风格桌子"
	desc = "浮夸的玻璃纤维桌。"
	icon = 'icons/obj/smooth_structures/alien_table.dmi'
	icon_state = "alien_table-0"
	base_icon_state = "alien_table"
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/sheet/iron
	buildstack = /obj/item/stack/sheet/plastic
	framestackamount = 1
	buildstackamount = 1
	smoothing_groups = SMOOTH_GROUP_ABDUCTOR_TABLES
	canSmoothWith = SMOOTH_GROUP_ABDUCTOR_TABLES

/obj/structure/table/countertop
	name = "柜台"
	desc = "底座结实的柜台。"
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	abstract_type = /obj/structure/table/countertop
	max_integrity = 200
	can_flip = FALSE

/obj/structure/table/countertop/bubway
	desc = "连锁餐饮店用来供应食物的柜台。"
	icon = 'icons/obj/smooth_structures/darkpack/bubway_table.dmi'
	icon_state = "bubway_table-0"
	base_icon_state = "bubway_table"
	smoothing_groups = SMOOTH_GROUP_BUB_TABLES
	canSmoothWith = SMOOTH_GROUP_BUB_TABLES


/obj/structure/table/countertop/bacotell
	desc = "连锁餐饮店用来供应食物的柜台。"
	icon = 'icons/obj/smooth_structures/darkpack/bacotell_table.dmi'
	icon_state = "bacotell_table-0"
	base_icon_state = "bacotell_table"
	smoothing_groups = SMOOTH_GROUP_BACO_TABLES
	canSmoothWith = SMOOTH_GROUP_BACO_TABLES

/obj/structure/table/countertop/beige
	icon = 'icons/obj/smooth_structures/beigetop_table.dmi'
	icon_state = "beigetop_table-0"
	base_icon_state = "beigetop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/black
	icon = 'icons/obj/smooth_structures/blacktop_table.dmi'
	icon_state = "blacktop_table-0"
	base_icon_state = "blacktop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/green
	icon = 'icons/obj/smooth_structures/greentop_table.dmi'
	icon_state = "greentop_table-0"
	base_icon_state = "greentop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/purple
	icon = 'icons/obj/smooth_structures/purpletop_table.dmi'
	icon_state = "purpletop_table-0"
	base_icon_state = "purpletop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/red
	icon = 'icons/obj/smooth_structures/redtop_table.dmi'
	icon_state = "redtop_table-0"
	base_icon_state = "redtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/teal
	icon = 'icons/obj/smooth_structures/tealtop_table.dmi'
	icon_state = "tealtop_table-0"
	base_icon_state = "tealtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/yellow
	icon = 'icons/obj/smooth_structures/yellowtop_table.dmi'
	icon_state = "yellowtop_table-0"
	base_icon_state = "yellowtop_table"
	smoothing_groups = SMOOTH_GROUP_COLOR_COUNTERTOP
	canSmoothWith = SMOOTH_GROUP_COLOR_COUNTERTOP

/obj/structure/table/countertop/fastfood
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table.dmi'
	icon_state = "fastfood_table-0"
	base_icon_state = "fastfood_table"
	smoothing_groups = SMOOTH_GROUP_FF_TABLES
	canSmoothWith = SMOOTH_GROUP_FF_TABLES

/obj/structure/table/countertop/fastfood/addon1
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi'
	icon_state = "fastfood_table_addon1-0"
	base_icon_state = "fastfood_table_addon1"

/obj/structure/table/countertop/fastfood/addon2
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi'
	icon_state = "fastfood_table_addon2-0"
	base_icon_state = "fastfood_table_addon2"

/obj/structure/table/countertop/fastfood/addon3
	icon = 'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi'
	icon_state = "fastfood_table_addon3-0"
	base_icon_state = "fastfood_table_addon3"

/obj/structure/table/countertop/fastfood/rand // Should probably use sparingly...
	var/list/possible_icons = list('icons/obj/smooth_structures/darkpack/fastfood_table.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon1.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon2.dmi',
		'icons/obj/smooth_structures/darkpack/fastfood_table_addon3.dmi')
	var/list/possible_icon_states = list("fastfood_table-0", "fastfood_table_addon1-0",
		"fastfood_table_addon2-0", "fastfood_table_addon3-0")
	var/list/possible_base_icon_states = list("fastfood_table", "fastfood_table_addon1",
		"fastfood_table_addon2", "fastfood_table_addon3")

/obj/structure/table/countertop/fastfood/rand/Initialize(mapload)
	. = ..()
	icon = pick(possible_icons)
	icon_state = possible_icon_states[possible_icons.Find(icon)]
	base_icon_state = possible_base_icon_states[possible_icons.Find(icon)]

/obj/structure/table/wood/bar
	desc = "餐厅里用的桌子，还有点讲究。采用简约的固定桌腿设计，哇！"
	icon_state = "table-0"
	base_icon_state = "table"
	icon = 'modular_darkpack/modules/decor/icons/table_wood_bar.dmi'
	can_flip = FALSE

/obj/structure/table/no_smooth
	abstract_type = /obj/structure/table/no_smooth
	icon = 'modular_darkpack/modules/decor/icons/standalone_tables.dmi'
	base_icon_state = "table_wood_stand"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	can_flip = FALSE

/obj/structure/table/no_smooth/modular_desk
	name = "wood desk"
	desc = "A compact wood desk, used by a wide variety of business-inclined individuals."
	icon = 'modular_darkpack/modules/decor/icons/modular_tables.dmi'
	icon_state = "desk_wood_mid"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/modular_desk/left
	icon_state = "desk_wood_left"

/obj/structure/table/no_smooth/modular_desk/right
	icon_state = "desk_wood_right"

/obj/structure/table/no_smooth/modular_desk/corner
	icon_state = "desk_wood_corner"

// Metal Non-Smoothing tables //

/obj/structure/table/no_smooth/metal
	name = "metal table"
	desc = "A table, masterfully designed with high-tech to become... round."
	icon_state = "table_metal_round"
	base_icon_state = "table_metal_round"
	max_integrity = 225
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/sheet/iron

/obj/structure/table/no_smooth/metal/Initialize(mapload)
	. = ..()
	if(prob(35))
		icon_state = "[base_icon_state]-[rand(1,2)]"

// Rolling table

/obj/structure/table/rolling/darkpack
	desc = BRAND_DEPARTMENT_STORE_COMPANY_2 + "brand \"Rolly poly\" rolling table. It can and will move."
	icon = 'modular_darkpack/modules/decor/icons/standalone_tables.dmi'
	icon_state = "table_rolling"

// Large tables //

/obj/structure/table/no_smooth/large
	name = "base class large ms13 table"
	desc = "CALL A CODER, CALL A CODER. For ME!"
	icon = 'modular_darkpack/modules/decor/icons/64x64_large_tables.dmi'
	icon_state = "table_wood_wide_square"

/obj/structure/table/no_smooth/large/Initialize(mapload)
	. = ..()
	if(dir == NORTH)
		bound_width = 64

	if(dir == EAST)
		bound_height = 64

	if(dir == SOUTH)
		bound_width = 64

	if(dir == WEST)
		bound_height = 64

// Metal Large tables /

/obj/structure/table/no_smooth/large/metal
	name = "金属桌"
	desc = "宽大结实的金属桌，没有什么特别之处。"
	icon_state = "table_metal_wide"
	max_integrity = 300
	frame = /obj/structure/table_frame
	framestack = /obj/item/stack/rods
	buildstack = /obj/item/stack/sheet/iron

/obj/structure/table/no_smooth/large/metal/desk
	name = "metal desk"
	desc = "A solid, wide metal table. Nothing about it stands out in particular."
	icon_state = "desk_metal"

/obj/structure/table/no_smooth/large/metal/desk/alt
	name = "metal desk"
	desc = "A compact metal desk, used by people whose work would be far easier if you weren't there."
	icon_state = "desk_metal_small"

// Wood Non-Smoothing tables //

/obj/structure/table/no_smooth/wood
	name = "木桌"
	desc = "简洁的圆形木桌。真希望自己也能做出这么漂亮的东西。"
	icon_state = "table_wood_round"
	max_integrity = 150
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/wood/square
	name = "木桌"
	desc = "简洁的方形木桌。真希望自己也能做出这么漂亮的东西。"
	icon_state = "table_wood_square"

/obj/structure/table/no_smooth/wood/low
	name = "茶几"
	desc = "矮桌，方便你坐在沙发上时随手放些东西。"
	icon_state = "table_wood_low"

/obj/structure/table/no_smooth/wood/stand
	name = "床头桌"
	desc = "高脚桌，常见于床边或垃圾填埋场。"
	icon_state = "table_wood_stand"

/obj/structure/table/no_smooth/wood/end
	name = "console end"
	desc = "A separate optional add-on for your console. More storage for books you never read!"
	icon_state = "table_wood_end"

/obj/structure/table/no_smooth/wood/cablereel
	name = "电缆卷盘"
	desc = "曾经绕着铜缆，如今放着各种杂物。"
	icon_state = "cable_reel"

// Wood Large tables //

/obj/structure/table/no_smooth/large/wood
	name = "wood table"
	desc = "A large oval shaped wood table. Perfect for displaying the family photos you don't have."
	icon_state = "table_wood_wide_oval"
	max_integrity = 200
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/sheet/mineral/wood

/obj/structure/table/no_smooth/large/wood/square
	desc = "A large rectangular wood table. Very sturdy."
	icon_state = "table_wood_wide_square"

/obj/structure/table/no_smooth/large/wood/desk
	name = "wood desk"
	desc = "A full size wood desk, used by people whose work would be far easier if you weren't there."
	icon_state = "desk_wood"

/obj/structure/table/no_smooth/large/wood/desk/alt
	name = "wood desk"
	desc = "A compact wood desk, used by a wide variety of business-inclined individuals."
	icon_state = "desk_wood_small"

/obj/structure/table/no_smooth/large/wood/stand
	name = "木制边柜"
	desc = "光滑的宜迪牌边柜。主要作用就是摆在房间里好看。"
	icon_state = "stand_wood"

/obj/structure/table/no_smooth/large/wood/stand/alt
	icon_state = "stand_wood_small"

//Misc tables //

/obj/structure/table/no_smooth/dice
	name = "dice table"
	desc = "Shoot the dice with your friends. Preferably not literally."
	icon_state = "dice_dirty"
	max_integrity = 150
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/tile/carpet/red

/obj/structure/table/no_smooth/dice/pristine
	icon_state = "dice_clean"
	max_integrity = 200


// Misc Large tables //

/obj/structure/table/no_smooth/large/cards
	name = "cards table"
	desc = "Very classy. Reminds you of that time in Las Vegas..."
	icon_state = "table_cards"
	frame = /obj/structure/table_frame/wood
	framestack = /obj/item/stack/sheet/mineral/wood
	buildstack = /obj/item/stack/tile/carpet/purple
