/datum/loadout_category/mask
	category_name = "面部"
	category_ui_icon = FA_ICON_MASK
	type_to_generate = /datum/loadout_item/mask
	tab_order = /datum/loadout_category/head::tab_order + 4

/datum/loadout_item/mask
	abstract_type = /datum/loadout_item/mask

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.mask)
		LAZYADD(outfit.backpack_contents, outfit.mask)
	outfit.mask = item_path

/datum/loadout_item/mask/work
	group = "职业面罩"
	abstract_type = /datum/loadout_item/mask/work

/datum/loadout_item/mask/work/balaclava
	name = "巴拉克拉瓦头套"
	item_path = /obj/item/clothing/mask/vampire/balaclava

/datum/loadout_item/mask/work/respirator
	name = "呼吸防护面罩"
	item_path = /obj/item/clothing/mask/gas/vampire

/datum/loadout_item/mask/work/lucha
	name = "金色墨西哥摔角面具"
	item_path = /obj/item/clothing/mask/luchador

/datum/loadout_item/mask/work/lucha/green
	name = "绿色墨西哥摔角面具"
	item_path = /obj/item/clothing/mask/luchador/tecnicos

/datum/loadout_item/mask/work/lucha/Red
	name = "红色墨西哥摔角面具"
	item_path = /obj/item/clothing/mask/luchador/rudos

/datum/loadout_item/mask/work/shemagh
	name = "阿拉伯方巾"
	item_path = /obj/item/clothing/mask/vampire/shemagh

/datum/loadout_item/mask/work/surgical
	name = "无菌口罩"
	item_path = /obj/item/clothing/mask/surgical

//Animal Masks
/datum/loadout_item/mask/animal
	group = "动物面具"
	abstract_type = /datum/loadout_item/mask/animal

/datum/loadout_item/mask/animal/policeofficer
	name = "猪面具"
	item_path = /obj/item/clothing/mask/animal/pig

/datum/loadout_item/mask/animal/frog
	name = "青蛙面具"
	item_path = /obj/item/clothing/mask/animal/frog

/datum/loadout_item/mask/animal/cow
	name = "牛面具"
	item_path = /obj/item/clothing/mask/animal/cowmask

/datum/loadout_item/mask/animal/honse
	name = "马头面具"
	item_path = /obj/item/clothing/mask/animal/horsehead

/datum/loadout_item/mask/animal/rat
	name = "老鼠面具"
	item_path = /obj/item/clothing/mask/animal/small/rat

/datum/loadout_item/mask/animal/fox
	name = "狐狸面具"
	item_path = /obj/item/clothing/mask/animal/small/fox

/datum/loadout_item/mask/animal/kitsune
	name = "狐妖面具"
	item_path = /obj/item/clothing/mask/kitsune

/datum/loadout_item/mask/animal/bee
	name = "蜜蜂面具"
	item_path = /obj/item/clothing/mask/animal/small/bee

/datum/loadout_item/mask/animal/bear
	name = "熊面具"
	item_path = /obj/item/clothing/mask/animal/small/bear

/datum/loadout_item/mask/animal/man //Is he stupid?
	name = "蝙蝠面具"
	item_path = /obj/item/clothing/mask/animal/small/bat

/datum/loadout_item/mask/animal/raven
	name = "渡鸦面具"
	item_path = /obj/item/clothing/mask/animal/small/raven

/datum/loadout_item/mask/animal/jackal
	name = "胡狼面具"
	item_path = /obj/item/clothing/mask/animal/small/jackal

//Fancy dress masks that aren't costumes.

/datum/loadout_item/mask/fancy
	group = "舞会面具"
	abstract_type = /datum/loadout_item/mask/fancy

/datum/loadout_item/mask/fancy/tragedy
	name = "悲剧面具"
	item_path = /obj/item/clothing/mask/vampire/tragedy

/datum/loadout_item/mask/fancy/comedy
	name = "喜剧面具"
	item_path = /obj/item/clothing/mask/vampire/comedy

/datum/loadout_item/mask/fancy/venetian
	name = "威尼斯面具"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask

/datum/loadout_item/mask/fancy/venetian/fancy
	name = "华丽威尼斯面具"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/fancy

/datum/loadout_item/mask/fancy/venetian/jester
	name = "弄臣面具"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/jester

/datum/loadout_item/mask/fancy/venetian/bloody
	name = "染血威尼斯面具"
	item_path = /obj/item/clothing/mask/vampire/venetian_mask/scary

//Fancy dress masks that ARE costumes!

/datum/loadout_item/mask/costume
	group = "装扮面具"
	abstract_type = /datum/loadout_item/mask/costume

/datum/loadout_item/mask/costume/scarecrow
	name = "稻草人面具"
	item_path = /obj/item/clothing/mask/scarecrow

/datum/loadout_item/mask/costume/mummy
	name = "木乃伊面具"
	item_path = /obj/item/clothing/mask/mummy

// Bandanas
/datum/loadout_item/mask/bandana
	group = "面巾"
	abstract_type = /datum/loadout_item/mask/bandana

/datum/loadout_item/mask/bandana/normal_greyscale
	name = "面巾（可染色）"
	item_path = /obj/item/clothing/mask/bandana/vampire

/datum/loadout_item/mask/bandana/striped_greyscale
	name = "面巾（可染色，条纹）"
	item_path = /obj/item/clothing/mask/bandana/striped/vampire

/datum/loadout_item/mask/bandana/skull_greyscale
	name = "面巾（可染色，骷髅）"
	item_path = /obj/item/clothing/mask/bandana/skull/vampire

//Making this a bandana to group them together.
/datum/loadout_item/mask/bandana/facescarf_greyscale
	name = "蒙面围巾（可染色）"
	item_path = /obj/item/clothing/mask/facescarf/vampire
