/datum/loadout_category/uniform
	category_name = "内搭"
	category_ui_icon = FA_ICON_SHIRT
	type_to_generate = /datum/loadout_item/uniform
	tab_order = /datum/loadout_category/head::tab_order + 9

/datum/loadout_item/uniform
	abstract_type = /datum/loadout_item/uniform

/datum/loadout_item/uniform/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.uniform)
		LAZYADD(outfit.backpack_contents, outfit.uniform)
	outfit.uniform = item_path

// Suit and Suitskirts
/datum/loadout_item/uniform/suit
	abstract_type = /datum/loadout_item/uniform/suit

/datum/loadout_item/uniform/suit/fancy_gray
	name = "西装（奢华，红色）"
	item_path = /obj/item/clothing/under/vampire/fancy_gray

/datum/loadout_item/uniform/suit/fancy_red
	name = "西装（奢华，灰色）"
	item_path = /obj/item/clothing/under/vampire/fancy_red

/datum/loadout_item/uniform/suit/fancy_black
	name = "西装（奢华，黑色）"
	item_path = /obj/item/clothing/under/vampire/ventrue

/datum/loadout_item/uniform/suit/fancy_black_skirt
	name = "连衣裙（奢华，黑色）"
	item_path = /obj/item/clothing/under/vampire/ventrue/female

/datum/loadout_item/uniform/suit/formal_white
	name = "西装（白色）"
	item_path = /obj/item/clothing/under/vampire/office

/datum/loadout_item/uniform/suit/plain_black
	name = "西装（朴素，黑色）"
	item_path = /obj/item/clothing/under/vampire/suit

/datum/loadout_item/uniform/suit/plain_black_skirt
	name = "西装（朴素，裙装，黑色）"
	item_path = /obj/item/clothing/under/vampire/suit/female

/datum/loadout_item/uniform/suit/plain_red
	name = "西装（朴素，红色）"
	item_path = /obj/item/clothing/under/vampire/sheriff

/datum/loadout_item/uniform/suit/plain_red_skirt
	name = "西装（朴素，裙装，红色）"
	item_path = /obj/item/clothing/under/vampire/sheriff/female

/datum/loadout_item/uniform/suit/plain_blue
	name = "西装（蓝色）"
	item_path = /obj/item/clothing/under/vampire/clerk

/datum/loadout_item/uniform/suit/plain_blue_skirt
	name = "西装（裙装，蓝色）"
	item_path = /obj/item/clothing/under/vampire/clerk/female

/datum/loadout_item/uniform/suit/plain_brown
	name = "西装（棕色）"
	item_path = /obj/item/clothing/under/vampire/archivist

/datum/loadout_item/uniform/suit/plain_brown_skirt
	name = "西装（裙装，棕色）"
	item_path = /obj/item/clothing/under/vampire/archivist/female

/datum/loadout_item/uniform/suit/prince
	name = "西装（亲王款）"
	item_path = /obj/item/clothing/under/vampire/prince

/datum/loadout_item/uniform/suit/prince_skirt
	name = "西装（亲王款，裙装）"
	item_path = /obj/item/clothing/under/vampire/prince/female

// Skirts
/datum/loadout_item/uniform/skirt
	abstract_type = /datum/loadout_item/uniform/skirt

/datum/loadout_item/uniform/skirt/pentagram
	name = "五芒星衬衫（配裙）"
	item_path = /obj/item/clothing/under/vampire/baali/female

// Turtleneck
/datum/loadout_item/uniform/turtleneck
	abstract_type = /datum/loadout_item/uniform/turtleneck

/datum/loadout_item/uniform/turtleneck/black
	name = "高领衫（黑色）"
	item_path = /obj/item/clothing/under/vampire/turtleneck_black

/datum/loadout_item/uniform/turtleneck/navy
	name = "高领衫（藏蓝色）"
	item_path = /obj/item/clothing/under/vampire/turtleneck_navy

/datum/loadout_item/uniform/turtleneck/red
	name = "高领衫（红色）"
	item_path = /obj/item/clothing/under/vampire/turtleneck_red

/datum/loadout_item/uniform/turtleneck/white
	name = "高领衫（白色）"
	item_path = /obj/item/clothing/under/vampire/turtleneck_white

// Pants
/datum/loadout_item/uniform/pants
	abstract_type = /datum/loadout_item/uniform/pants

/datum/loadout_item/uniform/pants/leather
	name = "皮裤"
	item_path = /obj/item/clothing/under/vampire/leatherpants

// Bloodlines clan outfits
/datum/loadout_item/uniform/flamboyant
	name = "正装衬衫（红色）"
	item_path = /obj/item/clothing/under/vampire/toreador

/datum/loadout_item/uniform/flamboyant_female
	name = "露脐上衣（紫色）"
	item_path = /obj/item/clothing/under/vampire/toreador/female

/datum/loadout_item/uniform/punk
	name = "正装衬衫（灰色）"
	item_path = /obj/item/clothing/under/vampire/brujah

/datum/loadout_item/uniform/punk_female
	name = "露脐上衣（白色）"
	item_path = /obj/item/clothing/under/vampire/brujah/female

/datum/loadout_item/uniform/gimp
	name = "束缚服"
	item_path = /obj/item/clothing/under/vampire/nosferatu

/datum/loadout_item/uniform/gimp_female
	name = "束缚服（胸衣款）"
	item_path = /obj/item/clothing/under/vampire/nosferatu/female

/datum/loadout_item/uniform/gangrel
	name = "粗犷服装（红色）"
	item_path = /obj/item/clothing/under/vampire/gangrel

/datum/loadout_item/uniform/gangrel_female
	name = "粗犷服装（蓝色）"
	item_path = /obj/item/clothing/under/vampire/gangrel/female

/datum/loadout_item/uniform/pants/grimey
	name = "裤子（脏污）"
	item_path = /obj/item/clothing/under/vampire/malkavian

/datum/loadout_item/uniform/schoolgirl
	name = "哥特女学生制服"
	item_path = /obj/item/clothing/under/vampire/malkavian/female

/datum/loadout_item/uniform/suit/formal_burgundy
	name = "西装（酒红色）"
	item_path = /obj/item/clothing/under/vampire/tremere

/datum/loadout_item/uniform/suit/formal_burgundy_skirt
	name = "西装（裙装，酒红色）"
	item_path = /obj/item/clothing/under/vampire/tremere/female


//Dresses
/datum/loadout_item/uniform/dress
	name = "连衣裙（黑色）"
	item_path = /obj/item/clothing/under/vampire/business

/datum/loadout_item/uniform/dress_red
	name = "连衣裙（红色）"
	item_path = /obj/item/clothing/under/vampire/primogen_toreador/female

/datum/loadout_item/uniform/maid
	name = "女仆装"
	item_path = /obj/item/clothing/under/costume/maid

//Dress Shirts
/datum/loadout_item/uniform/emo
	name = "正装衬衫（黑色）"
	item_path = /obj/item/clothing/under/vampire/emo

/datum/loadout_item/uniform/messy
	name = "正装衬衫（白色）"
	item_path = /obj/item/clothing/under/vampire/bouncer

/datum/loadout_item/uniform/biker
	name = "正装衬衫（棕色）"
	item_path = /obj/item/clothing/under/vampire/biker

//Scene
/datum/loadout_item/uniform/scenepink
	item_path = /obj/item/clothing/under/vampire/scenepink

/datum/loadout_item/uniform/scenemoody
	item_path = /obj/item/clothing/under/vampire/scenemoody

/datum/loadout_item/uniform/sceneleopard
	item_path = /obj/item/clothing/under/vampire/sceneleopard

/datum/loadout_item/uniform/scenezim
	item_path = /obj/item/clothing/under/vampire/scenezim

//Other
/datum/loadout_item/uniform/baron
	name = "酒保服装"
	item_path = /obj/item/clothing/under/vampire/bar

/datum/loadout_item/uniform/baron_female
	name = "酒保服装（裙装）"
	item_path = /obj/item/clothing/under/vampire/bar/female

/datum/loadout_item/uniform/sleeveless_yellow
	name = "背心（黄色）"
	item_path = /obj/item/clothing/under/vampire/larry

/datum/loadout_item/uniform/sleeveless_white
	name = "背心（白色）"
	item_path = /obj/item/clothing/under/vampire/bandit

/datum/loadout_item/uniform/hipster
	name = "露脐上衣（红色）"
	item_path = /obj/item/clothing/under/vampire/red

/datum/loadout_item/uniform/black_grunge
	name = "露脐上衣（黑色）"
	item_path = /obj/item/clothing/under/vampire/black


/datum/loadout_item/uniform/burlesque
	name = "艳舞演出服"
	item_path = /obj/item/clothing/under/vampire/burlesque

/datum/loadout_item/uniform/daisyd
	name = "超短牛仔裤"
	item_path = /obj/item/clothing/under/vampire/burlesque/daisyd

/datum/loadout_item/uniform/overalls
	name = "工装背带裤"
	item_path = /obj/item/clothing/under/vampire/mechanic

//CRIMSON GRID ADDITION START: BLACK OVERALLS TO LOADOUT
/datum/loadout_item/uniform/black_overalls
	name = "黑色工装背带裤"
	item_path = /obj/item/clothing/under/vampire/graveyard
//CRIMSON GRID ADDITION END

/datum/loadout_item/uniform/black_overcoat
	name = "大衣（黑色）"
	item_path = /obj/item/clothing/under/vampire/rich

/datum/loadout_item/uniform/gown_black
	name = "黑色礼服长裙"
	item_path = /obj/item/clothing/under/vampire/gown_black

/datum/loadout_item/uniform/gown_white
	name = "白色礼服长裙"
	item_path = /obj/item/clothing/under/vampire/gown_white
