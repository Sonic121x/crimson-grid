//SHOES

//SHOES

//SHOES

/obj/item/clothing/shoes/vampire
	name = "鞋子"
	desc = "一双看起来很舒适的鞋。"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "shoes"
	gender = PLURAL
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

/obj/item/clothing/shoes/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 5, "shoes", FALSE)

/obj/item/clothing/shoes/vampire/brown
	icon_state = "shoes_brown"

/obj/item/clothing/shoes/vampire/white
	icon_state = "shoes_white"

/obj/item/clothing/shoes/vampire/jackboots
	name = "军靴"
	desc = "一双看起来结实耐用的靴子。"
	icon_state = "jackboots"

/obj/item/clothing/shoes/vampire/jackboots/Initialize(mapload)
	. = ..()

	create_storage(storage_type = /datum/storage/pockets/shoes)

/obj/item/clothing/shoes/vampire/jackboots/high
	name = "高筒靴"
	desc = "高筒靴。你还指望是什么？"
	icon_state = "tall_boots"

/obj/item/clothing/shoes/vampire/jackboots/punk
	icon_state = "daboots"

/obj/item/clothing/shoes/vampire/jackboots/work
	icon_state = "jackboots_work"

/obj/item/clothing/shoes/vampire/sneakers
	name = "运动鞋"
	desc = "一双颇有运动风格的鞋。"
	icon_state = "sneakers"

/obj/item/clothing/shoes/vampire/sneakers/red
	icon_state = "sneakers_red"

/obj/item/clothing/shoes/vampire/blackfur
	name = "黑色毛皮靴"
	desc = "一双毛茸茸的黑白双色靴子。"
	icon_state = "furboots_black"

/obj/item/clothing/shoes/vampire/brownfur
	name = "棕色毛皮靴"
	desc = "一双毛茸茸的棕色靴子。"
	icon_state = "furboots_brown"

/obj/item/clothing/shoes/vampire/pumped
	name = "及膝运动鞋"
	desc = "来自人气品牌‘康维兹’的运动鞋。"
	icon_state = "pumped_up_kicks"

/obj/item/clothing/shoes/vampire/heels
	name = "高跟鞋"
	desc = "一双看起来很昂贵的高跟鞋。"
	icon_state = "heels"

/obj/item/clothing/shoes/vampire/heels/red
	icon_state = "heels_red"

/obj/item/clothing/shoes/vampire/businessscaly
	name = "鳞纹鞋"
	desc = "带有鳞片纹理的鞋。"
	icon_state = "scales_shoes"

/obj/item/clothing/shoes/vampire/businessblack
	name = "黑色鞋子"
	desc = "经典的黑色鞋子。"
	icon_state = "business_shoes"

/obj/item/clothing/shoes/vampire/businesstip
	name = "金属包头鞋"
	desc = "鞋头包有金属的鞋。"
	icon_state = "metal_shoes"

