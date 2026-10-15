/datum/loadout_category/suits
	category_name = "外套"
	category_ui_icon = FA_ICON_USER_SECRET
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/head::tab_order + 10

/*
/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.suit)
		LAZYADD(outfit.backpack_contents, outfit.suit)
	outfit.suit = item_path
*/

// Coats
/datum/loadout_item/suit/coat
	abstract_type = /datum/loadout_item/suit/coat

/datum/loadout_item/suit/coat/slickbackcoat
	name = "大衣（紫色皮草）"
	item_path = /obj/item/clothing/suit/vampire/slickbackcoat

/datum/loadout_item/suit/coat/labcoat
	name = "实验服"
	item_path = /obj/item/clothing/suit/vampire/labcoat

/datum/loadout_item/suit/coat/brown
	name = "大衣（棕色）"
	item_path = /obj/item/clothing/suit/vampire/coat

/datum/loadout_item/suit/coat/green
	name = "大衣（绿色）"
	item_path = /obj/item/clothing/suit/vampire/coat/alt

/datum/loadout_item/suit/coat/black
	name = "大衣（黑色）"
	item_path = /obj/item/clothing/suit/vampire/coat/winter

/datum/loadout_item/suit/coat/red
	name = "大衣（红色）"
	item_path = /obj/item/clothing/suit/vampire/coat/winter/alt

/datum/loadout_item/suit/coat/leopardcoat
	item_path = /obj/item/clothing/suit/vampire/coat/leopard

//CRIMSON GRID ADDITION START: MILPARKA TO LOADOUT
/datum/loadout_item/suit/jacket/military_parka
	name = "军用派克大衣"
	item_path = /obj/item/clothing/suit/vampire/coat/milparka
//CRIMSON GRID ADDITION END

/datum/loadout_item/suit/jacket/oversizedjacket
	name = "宽大夹克"
	item_path = /obj/item/clothing/suit/jacket/oversized

/datum/loadout_item/suit/jacket/fancyfurcoat
	name = "华丽皮草大衣"
	item_path = /obj/item/clothing/suit/jacket/fancy

/datum/loadout_item/suit/jacket/trenchcoatalt
	name = "风衣（另一款式）"
	item_path = /obj/item/clothing/suit/toggle/jacket/trenchcoat

// Jackets
/datum/loadout_item/suit/jacket
	abstract_type = /datum/loadout_item/suit/jacket

/datum/loadout_item/suit/jacket/majima_jacket
	name = "华丽夹克（真岛款）"
	item_path = /obj/item/clothing/suit/vampire/majima_jacket

/datum/loadout_item/suit/jacket/fancy_gray
	name = "华丽夹克（灰色）"
	item_path = /obj/item/clothing/suit/vampire/fancy_gray

/datum/loadout_item/suit/jacket/fancy_red
	name = "华丽夹克（红色）"
	item_path = /obj/item/clothing/suit/vampire/fancy_red

/datum/loadout_item/suit/jacket/black_leather
	name = "皮夹克（黑色）"
	item_path = /obj/item/clothing/suit/vampire/jacket

/datum/loadout_item/suit/jacket/black_leather_cut
	name = "短款皮夹克（黑色）"
	item_path = /obj/item/clothing/suit/vampire/jacket/cropped

/datum/loadout_item/suit/jacket/red_leather
	name = "皮夹克（红色）"
	item_path = /obj/item/clothing/suit/vampire/jacket/red

/datum/loadout_item/suit/jacket/red_leather_cut
	name = "短款皮夹克（红色）"
	item_path = /obj/item/clothing/suit/vampire/jacket/cropped/red

/datum/loadout_item/suit/jacket/military
	name = "夹克（军用）"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket/black_suit
	name = "夹克（黑色西装）"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/jacket/bomber_classic
	name = "经典飞行夹克"
	item_path = /obj/item/clothing/suit/vampire/bomber_jacket_classic

/datum/loadout_item/suit/jacket/bomber_gray
	name = "灰色飞行夹克"
	item_path = /obj/item/clothing/suit/vampire/bomber_jacket_gray

// Trenchcoats
/datum/loadout_item/suit/trenchcoat
	abstract_type = /datum/loadout_item/suit/trenchcoat

/datum/loadout_item/suit/trenchcoat/black
	name = "风衣（黑色）"
	item_path = /obj/item/clothing/suit/vampire/trench

/datum/loadout_item/suit/trenchcoat/brown
	name = "风衣（棕色）"
	item_path = /obj/item/clothing/suit/vampire/trench/alt

/datum/loadout_item/suit/trenchcoat/burgundy
	name = "风衣（酒红色）"
	item_path = /obj/item/clothing/suit/vampire/trench/archive

// Hoodies
/datum/loadout_item/suit/hoodie
	item_path = /obj/item/clothing/suit/hooded/hoodie

/datum/loadout_item/suit/hoodiezim
	item_path = /obj/item/clothing/suit/hooded/hoodie/hoodie_pim

// Misc
/datum/loadout_item/suit/kasaya
	name = "袈裟"
	item_path = /obj/item/clothing/suit/vampire/kasaya

// CRIMSON GRID ADDITION START: HAZARD VEST TO LOADOUT
/datum/loadout_item/suit/hazard_vest
	name = "反光安全背心"
	item_path = /obj/item/clothing/suit/hazardvest
//CRIMSON GRID ADDITION END

/datum/loadout_item/suit/imam
	name = "伊玛目长袍"
	item_path = /obj/item/clothing/suit/vampire/imam

/datum/loadout_item/suit/orthodox
	name = "东正教教士袍"
	item_path = /obj/item/clothing/suit/vampire/orthodox

/datum/loadout_item/suit/letterman_red
	name = "校队夹克（红色）"
	item_path = /obj/item/clothing/suit/jacket/letterman_syndie

// Robes
/datum/loadout_item/suit/robes
	abstract_type = /datum/loadout_item/suit/robes

/datum/loadout_item/suit/robes/white
	name = "长袍（白色）"
	item_path = /obj/item/clothing/suit/hooded/robes

/datum/loadout_item/suit/robes/black
	name = "长袍（黑色）"
	item_path = /obj/item/clothing/suit/hooded/robes/black

/datum/loadout_item/suit/robes/grey
	name = "长袍（灰色）"
	item_path = /obj/item/clothing/suit/hooded/robes/grey

/datum/loadout_item/suit/robes/darkred
	name = "长袍（暗红色）"
	item_path = /obj/item/clothing/suit/hooded/robes/darkred

/datum/loadout_item/suit/robes/yellow
	name = "长袍（黄色）"
	item_path = /obj/item/clothing/suit/hooded/robes/yellow

/datum/loadout_item/suit/robes/green
	name = "长袍（绿色）"
	item_path = /obj/item/clothing/suit/hooded/robes/green

/datum/loadout_item/suit/robes/Red
	name = "长袍（红色）"
	item_path = /obj/item/clothing/suit/hooded/robes/red

/datum/loadout_item/suit/robes/purple
	name = "长袍（紫色）"
	item_path = /obj/item/clothing/suit/hooded/robes/purple

/datum/loadout_item/suit/robes/blue
	name = "长袍（蓝色）"
	item_path = /obj/item/clothing/suit/hooded/robes/blue


/// Shawls
/datum/loadout_item/suit/shawl
	abstract_type = /datum/loadout_item/suit/shawl

/datum/loadout_item/suit/shawl/black
	name = "黑色披肩"
	item_path = /obj/item/clothing/suit/vampire/shawl_black

/datum/loadout_item/suit/shawl/white
	name = "白色披肩"
	item_path = /obj/item/clothing/suit/vampire/shawl_white
