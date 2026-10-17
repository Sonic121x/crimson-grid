
/obj/item/melee/skateboard
	name = "滑板"
	desc = "一块滑板。可以轮子朝下放好滑行，也能当作酷炫的武器。"
	icon = 'modular_darkpack/master_files/icons/mob/rideables/vehicles.dmi' // DARKPACK EDIT CHANGE - Darkpack skateboard icon
	icon_state = "skateboard_held"
	inhand_icon_state = "skateboard"
	force = 12
	throwforce = 4
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("拍打", "猛击", "重击", "砸击")
	attack_verb_simple = list("拍打", "猛击", "重击", "砸击")
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)
	custom_price = 50 // DARKPACK EDIT ADD - ECONOMY
	///The vehicle counterpart for the board
	var/board_item_type = /obj/vehicle/ridden/scooter/skateboard

/obj/item/melee/skateboard/attack_self(mob/user)
	var/obj/vehicle/ridden/scooter/skateboard/board = new board_item_type(get_turf(user), src)//this probably has fucky interactions with telekinesis but for the record it wasn't my fault
	board.buckle_mob(user)
	forceMove(board)

/obj/item/melee/skateboard/improvised
	name = "简易滑板"
	desc = "一块临时拼凑的滑板。可以轮子朝下放好滑行，也能当作酷炫的武器。"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/improvised
	custom_price = 25 // DARKPACK EDIT ADD - ECONOMY

/obj/item/melee/skateboard/pro
	name = "滑板"
	desc = "一块八零牌专业滑板，看起来结实耐用，做工精良。"
	icon_state = "skateboard2_held"
	inhand_icon_state = "skateboard2"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/pro
	custom_price = 150 // DARKPACK EDIT ADD - ECONOMY
	custom_premium_price = PAYCHECK_COMMAND * 5

/obj/item/melee/skateboard/hoverboard
	name = "悬浮滑板"
	desc = "来自往日的潮流，真复古！"
	icon_state = "hoverboard_red_held"
	inhand_icon_state = "hoverboard_red"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard
	custom_premium_price = PAYCHECK_COMMAND * 5.4 //If I can't make it a meme I'll make it RAD

/obj/item/melee/skateboard/hoverboard/admin
	name = "董事滑板"
	desc = "将一艘太空船的复杂工程浓缩在一块滑板里，价格也一样昂贵。"
	icon_state = "hoverboard_nt_held"
	inhand_icon_state = "hoverboard_nt"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard/admin

/obj/item/melee/skateboard/holyboard
	name = "神圣滑板"
	desc = "一块受诸神祝福的滑板，能用滑磨为我们赎罪。底面刻着首字母缩写“J.C.”。"
	icon_state = "hoverboard_holy_held"
	inhand_icon_state = "hoverboard_holy"
	force = 18
	throwforce = 6
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = parent_type::obj_flags | UNIQUE_RENAME
	attack_verb_continuous = list("猛砸", "撞击", "碾磨", "滑撞")
	attack_verb_simple = list("猛砸", "撞击", "碾磨", "滑撞")
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard/holyboarded

/obj/item/melee/skateboard/holyboard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/nullrod_core)
