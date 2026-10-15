/obj/item/stack/cannonball
	name = "炮弹"
	desc = "一堆沉重的等离子钢炮弹。太空时代的火炮技术！"
	icon_state = "cannonballs"
	base_icon_state = "cannonballs"
	max_amount = 14
	singular_name = "炮弹"
	merge_type = /obj/item/stack/cannonball
	throwforce = 10
	obj_flags = CONDUCTS_ELECTRICITY
	custom_materials = list(/datum/material/alloy/plasteel=SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	throw_speed = 5
	throw_range = 3
	///the type of projectile this type of cannonball item turns into.
	var/obj/projectile/projectile_type = /obj/projectile/bullet/cannonball

/obj/item/stack/cannonball/update_icon_state()
	. = ..()
	icon_state = (amount == 1) ? "[base_icon_state]" : "[base_icon_state]_[min(amount, 14)]"

/obj/item/stack/cannonball/fourteen
	amount = 14

/obj/item/stack/cannonball/four
	amount = 4

/obj/item/stack/cannonball/shellball
	name = "爆炸炮弹"
	singular_name = "爆炸炮弹"
	desc = "用于反器材作战和压制敌方火炮的爆炸炮弹。能轻松炸开任何墙壁，方便进出。"
	color = COLOR_RED
	merge_type = /obj/item/stack/cannonball/shellball
	projectile_type = /obj/projectile/bullet/cannonball/explosive

/obj/item/stack/cannonball/shellball/seven
	amount = 7

/obj/item/stack/cannonball/shellball/fourteen
	amount = 14

/obj/item/stack/cannonball/emp
	name = "故障弹"
	singular_name = "故障弹"
	icon_state = "emp_cannonballs"
	base_icon_state = "emp_cannonballs"
	desc = "这种炮弹内有两个腔室，碰撞时其中的物质混合，通过化学反应产生电磁脉冲。这到底是什么意思？谁知道呢。有了这些新奇玩意儿，现代海盗真是失去了灵魂。"
	max_amount = 4
	merge_type = /obj/item/stack/cannonball/emp
	projectile_type = /obj/projectile/bullet/cannonball/emp

/obj/item/stack/cannonball/the_big_one
	name = "“最大号”炮弹"
	singular_name = "“最大号”炮弹"
	desc = "一颗塞满海量炸药的巨型炮弹。这会是你在战斗中打出的最后一炮，主要是因为之后就没什么可打的了。"
	max_amount = 5
	icon_state = "biggest_cannonballs"
	base_icon_state = "biggest_cannonballs"
	merge_type = /obj/item/stack/cannonball/the_big_one
	projectile_type = /obj/projectile/bullet/cannonball/biggest_one

/obj/item/stack/cannonball/the_big_one/five
	amount = 5

/obj/item/stack/cannonball/trashball
	name = "垃圾炮弹"
	singular_name = "垃圾炮弹"
	desc = "一团压得紧紧的垃圾。可以拿来当炮弹，但真把它塞进正经火炮里，恐怕对炮没什么好处。"
	max_amount = 4
	icon_state = "trashballs"
	base_icon_state = "trashballs"
	merge_type = /obj/item/stack/cannonball/trashball
	projectile_type = /obj/projectile/bullet/cannonball/trashball
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/stack/cannonball/trashball/four
	amount = 4
