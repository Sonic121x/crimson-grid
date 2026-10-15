//SUITS

//SUITS

//SUITS

/obj/item/clothing/suit/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')

	body_parts_covered = CHEST
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	max_integrity = 250
	resistance_flags = NONE
	armor_type = /datum/armor/vampire_suit

/datum/armor/vampire_suit
	melee = 10
	laser = 10
	energy = 10
	bomb = 10
	acid = 10
	wound = 10

/obj/item/clothing/suit/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "suit", FALSE)

/obj/item/clothing/suit/vampire/trench/malkav
	icon_state = "malkav_coat"

/obj/item/clothing/suit/hooded/heisenberg
	name = "防化服"
	desc = "一套用于抵御化学危害的服装。"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	icon_state = "heisenberg"
	body_parts_covered = CHEST | GROIN | ARMS
	cold_protection = CHEST | GROIN | ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	clothing_flags = THICKMATERIAL
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/chemical_costume
	hoodtype = /obj/item/clothing/head/hooded/heisenberg_hood

/datum/armor/chemical_costume
	laser = 10
	energy = 10
	bomb = 50
	fire = 50
	acid = 100
	wound = 10

/obj/item/clothing/head/hooded/heisenberg_hood
	name = "防化兜帽"
	desc = "防化服附带的兜帽。"
	icon_state = "heisenberg_helm"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | HIDEEARS
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/chemical_costume

//** SPOOOOKY ROBES FROM THE CAPPADOCIAN UPDATE **//
/obj/item/clothing/suit/hooded/robes
	name = "白色长袍"
	desc = "一件如天使般圣洁的长袍。"
	icon_state = "robes"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	flags_inv = HIDEJUMPSUIT
	body_parts_covered = CHEST | GROIN | LEGS | ARMS
	cold_protection = CHEST | GROIN | LEGS | ARMS
	hoodtype = /obj/item/clothing/head/hooded/robes_hood

/obj/item/clothing/head/hooded/robes_hood
	name = "白色兜帽"
	desc = "一件如天使般圣洁的长袍所配的兜帽。"
	icon_state = "robes_hood"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = HEAD
	cold_protection = HEAD
	flags_inv = HIDEHAIR | HIDEEARS

/obj/item/clothing/suit/hooded/robes/black
	name = "黑色长袍"
	desc = "一件令人毛骨悚然的长袍。"
	icon_state = "robes_black"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/black

/obj/item/clothing/head/hooded/robes_hood/black
	name = "黑色兜帽"
	desc = "一件令人毛骨悚然的长袍所配的兜帽。"
	icon_state = "robes_black_hood"

/obj/item/clothing/suit/hooded/robes/grey
	name = "灰色长袍"
	desc = "一件显得沉郁的长袍。"
	icon_state = "robes_grey"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/grey

/obj/item/clothing/head/hooded/robes_hood/grey
	name = "灰色兜帽"
	desc = "一件显得沉郁的长袍所配的兜帽。"
	icon_state = "robes_grey_hood"

/obj/item/clothing/suit/hooded/robes/darkred
	name = "暗红色长袍"
	desc = "一件透着狂热气息的长袍。"
	icon_state = "robes_darkred"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/darkred

/obj/item/clothing/head/hooded/robes_hood/darkred
	name = "暗红色兜帽"
	desc = "一件透着狂热气息的长袍所配的兜帽。"
	icon_state = "robes_darkred_hood"

/obj/item/clothing/suit/hooded/robes/yellow
	name = "黄色长袍"
	desc = "一件洋溢着欢快气息的长袍。"
	icon_state = "robes_yellow"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/yellow

/obj/item/clothing/head/hooded/robes_hood/yellow
	name = "黄色兜帽"
	desc = "一件洋溢着欢快气息的长袍所配的兜帽。"
	icon_state = "robes_yellow_hood"

/obj/item/clothing/suit/hooded/robes/green
	name = "绿色长袍"
	desc = "一件透着大地气息的长袍。"
	icon_state = "robes_green"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/green

/obj/item/clothing/head/hooded/robes_hood/green
	name = "绿色兜帽"
	desc = "一件透着大地气息的长袍所配的兜帽。"
	icon_state = "robes_green_hood"

/obj/item/clothing/suit/hooded/robes/red
	name = "红色长袍"
	desc = "一件透着怒意的长袍。"
	icon_state = "robes_red"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/red

/obj/item/clothing/head/hooded/robes_hood/red
	name = "红色兜帽"
	desc = "一件透着怒意的长袍所配的兜帽。"
	icon_state = "robes_red_hood"

/obj/item/clothing/suit/hooded/robes/purple
	name = "紫色长袍"
	desc = "一件优雅的长袍。"
	icon_state = "robes_purple"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/purple

/obj/item/clothing/head/hooded/robes_hood/purple
	name = "紫色兜帽"
	desc = "一件优雅的长袍所配的兜帽。"
	icon_state = "robes_purple_hood"

/obj/item/clothing/suit/hooded/robes/blue
	name = "蓝色长袍"
	desc = "一件泛着水色的长袍。"
	icon_state = "robes_blue"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/blue

/obj/item/clothing/head/hooded/robes_hood/blue
	name = "蓝色兜帽"
	desc = "一件泛着水色的长袍所配的兜帽。"
	icon_state = "robes_blue_hood"

/obj/item/clothing/suit/hooded/robes/tremere
	name = "睿魔尔长袍"
	desc = "以红色点缀的黑色长袍，带有睿魔尔家系的徽记。"
	icon_state = "tremere_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/tremere

/obj/item/clothing/head/hooded/robes_hood/tremere
	name = "睿魔尔兜帽"
	desc = "以红色点缀的黑色兜帽，带有睿魔尔家系的徽记。"
	icon_state = "tremere_hood"

/obj/item/clothing/suit/hooded/robes/magister
	name = "导师长袍"
	desc = "带有华丽金色镶边的红色长袍，上面印有睿魔尔家系的徽记。"
	icon_state = "magister_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/magister

/obj/item/clothing/head/hooded/robes_hood/magister
	name = "导师兜帽"
	desc = "带有华丽金色镶边的红色兜帽，上面印有睿魔尔家系的徽记。"
	icon_state = "magister_hood"

/obj/item/clothing/suit/hooded/robes/apprentice
	name = "学徒长袍"
	desc = "带有华丽镶边的紫色长袍，上面印有睿魔尔家系的徽记。"
	icon_state = "apprentice_robes"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/apprentice

/obj/item/clothing/head/hooded/robes_hood/apprentice
	name = "学徒兜帽"
	desc = "带有华丽镶边的紫色兜帽，上面印有睿魔尔家系的徽记。"
	icon_state = "apprentice_hood"

/obj/item/clothing/suit/hooded/robes/tremere_capeless
	name = "无披肩睿魔尔长袍"
	desc = "以红色点缀的黑色长袍，带有睿魔尔家系的徽记。"
	icon_state = "tremere_robes_capeless"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/tremere_capeless

/obj/item/clothing/head/hooded/robes_hood/tremere_capeless
	name = "睿魔尔兜帽"
	desc = "以红色点缀的黑色兜帽，带有睿魔尔家系的徽记。"
	icon_state = "tremere_hood_capeless"

/obj/item/clothing/suit/hooded/robes/magister_capeless
	name = "无披肩导师长袍"
	desc = "带有华丽金色镶边的红色长袍，上面印有睿魔尔家系的徽记。"
	icon_state = "magister_robes_capeless"
	hoodtype = /obj/item/clothing/head/hooded/robes_hood/magister_capeless

/obj/item/clothing/head/hooded/robes_hood/magister_capeless
	name = "导师兜帽"
	desc = "带有华丽镶边的红色兜帽，上面印有睿魔尔家系的徽记。"
	icon_state = "magister_hood_capeless"

/obj/item/clothing/suit/vampire/coat
	name = "棕色大衣"
	desc = "一件厚重保暖的棕色大衣。"
	icon_state = "coat1"

/obj/item/clothing/suit/vampire/coat/alt
	name = "绿色大衣"
	desc = "一件厚重保暖的棕色大衣。"
	icon_state = "coat2"

/obj/item/clothing/suit/vampire/coat/winter
	name = "黑色毛皮大衣"
	desc = "厚重保暖的衣服。"
	icon_state = "winter1"

/obj/item/clothing/suit/vampire/coat/winter/alt
	name = "棕色毛皮大衣"
	icon_state = "winter2"

/obj/item/clothing/suit/vampire/coat/leopard
	name = "豹纹大衣"
	desc = "一件用人造毛皮制成的大衣。"
	icon_state = "leopard_coat"

/obj/item/clothing/suit/vampire/coat/milparka
	name = "军用派克大衣"
	desc = "一件采用沙漠夜间迷彩图案的厚派克大衣。"
	icon_state = "desertnightparka"


/obj/item/clothing/suit/hooded/hoodie
	name = "连帽衫"
	desc = "一件简单的连帽衫。"
	icon_state = "hoodie"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	hoodtype = /obj/item/clothing/head/hooded/hood_hood

/obj/item/clothing/head/hooded/hood_hood
	name = "连帽衫兜帽"
	desc = "连帽衫上那顶带帽子的帽子。"
	icon_state = "hoodie_hood"
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	// You should not expect this to have an onfloor
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEEARS
	hair_mask = /datum/hair_mask/winterhood

/obj/item/clothing/suit/hooded/hoodie/hoodie_pim
	name = "入侵者吉姆连帽衫"
	desc = "一件印有《入侵者吉姆》中人气角色格尔的连帽衫。"
	icon_state = "hoodie_zim"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/hood_pim

/obj/item/clothing/head/hooded/hood_hood/hood_pim
	name = "入侵者吉姆连帽衫兜帽"
	desc = "一顶仿照《入侵者吉姆》中人气角色格尔制作的兜帽。"
	icon_state = "hoodie_zim_hood"


/obj/item/clothing/suit/vampire/slickbackcoat
	name = "奢华大衣"
	desc = "华丽奢靡，紫色浓郁。油头服饰公司出品，气场十足。"
	icon_state = "slickbackcoat"
	armor_type = /datum/armor/opulent_coat

/datum/armor/opulent_coat
	melee = 5
	bullet = 5
	wound = 5

/obj/item/clothing/suit/vampire/jacket
	name = "黑色皮夹克"
	desc = "每个朋克都该拥有的行头。提供一定防护。"
	icon_state = "jacket1"
	armor_type = /datum/armor/vampire_jacket

/datum/armor/vampire_jacket
	melee = 25
	bullet = 25
	laser = 10
	energy = 10
	bomb = 25
	fire = 25
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/jacket/fbi
	name = "联邦调查局夹克"
	desc = "\"联邦调查局，开门！！\""
	icon_state = "fbi"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/cropped
	name = "黑色短款皮夹克"
	desc = "经典朋克服装的清凉短款。提供一定防护。"
	icon_state = "jacket1_cut"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/red
	name = "红色皮夹克"
	desc = "每个朋克都该拥有的行头。提供一定防护。"
	icon_state = "jacket3"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/cropped/red
	name = "红色短款皮夹克"
	desc = "经典朋克服装的清凉短款。提供一定防护。"
	icon_state = "jacket3_cut"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/jacket/punk
	icon_state = "punk"
	armor_type = /datum/armor/punk_jacket

/datum/armor/punk_jacket
	melee = 50
	bullet = 50
	laser = 10
	energy = 10
	bomb = 50
	fire = 25
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/jacket/better
	name = "棕色皮夹克"
	icon_state = "jacket2"
	armor_type = /datum/armor/brown_leather_jacket

/datum/armor/brown_leather_jacket
	melee = 35
	bullet = 35
	laser = 10
	energy = 10
	bomb = 35
	fire = 35
	acid = 10
	wound = 35

/obj/item/clothing/suit/vampire/jacket/better/armored
	name = "装甲皮夹克"
	armor_type = /datum/armor/armored_jackets

/datum/armor/armored_jackets
	melee = 50
	bullet = 50
	laser = 50
	energy = 10
	bomb = 40
	bio = 0
	fire = 40
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/trench/alt/armored
	name = "棕色装甲风衣"
	icon_state = "trench2"
	max_integrity = 400
	armor_type = /datum/armor/armored_jackets

/obj/item/clothing/suit/vampire/trench/armored
	name = "黑色装甲风衣"
	max_integrity = 400
	armor_type = /datum/armor/armored_jackets

/obj/item/clothing/suit/vampire/trench
	name = "风衣"
	desc = "夜间最适合穿的黑色电影风格服装。提供一定防护。"
	icon_state = "trench1"
	armor_type = /datum/armor/vampire_jacket

/obj/item/clothing/suit/vampire/trench/alt
	name = "棕色风衣"
	icon_state = "trench2"

/obj/item/clothing/suit/vampire/trench/archive
	name = "华贵风衣"
	desc = "享受美好生活的最佳选择……也许吧。"
	icon_state = "trench3"

/obj/item/clothing/suit/vampire/trench/strauss
	name = "红色风衣"
	desc = "真正的力量不在于财富，而在于财富能为你带来什么。"
	icon_state = "strauss_coat"

/obj/item/clothing/suit/vampire/trench/voivode
	name = "王者大衣"
	desc = "一件漂亮的夹克，主人必定是个大人物。"
	icon_state = "voicoat"
	armor_type = /datum/armor/regal_coat

/datum/armor/regal_coat
	melee = 60
	bullet = 60
	laser = 10
	energy = 10
	bomb = 55
	fire = 45
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/vest
	name = "防弹背心"
	desc = "耐用而轻便的背心，能够有效抵御大多数威胁。"
	icon_state = "vest"
	armor_type = /datum/armor/bulletproof_vest
	allowed = list(
		/obj/item/card/id,
		/obj/item/flashlight,
		/obj/item/melee/baton,
		/obj/item/restraints/handcuffs
	)

/datum/armor/bulletproof_vest
	melee = 55
	bullet = 55
	laser = 10
	energy = 10
	bomb = 55
	fire = 45
	acid = 10
	wound = 25

/obj/item/clothing/suit/vampire/vest/medieval
	name = "中世纪胸甲"
	desc = "大概是西班牙式的。提供良好的防护。"
	icon_state = "medieval"

//Police + Army

/obj/item/clothing/suit/vampire/coat/police
	name = "警用雨衣"
	icon_state = "policecoat"
	desc = "一件结实的反光雨衣，专为雨天巡逻而制。"
	custom_price = 20

/obj/item/clothing/suit/vampire/vest/police
	name = "警用执勤背心"
	icon_state = "pdvest"
	desc = "印有旧金山警察局标志的轻型防弹背心，专为执勤而制。"
	custom_price = 50

/obj/item/clothing/suit/vampire/vest/police/fbivest
	name = "联邦调查局执勤背心"
	icon_state = "fbivest"
	desc = "印有黄色联邦调查局标志的轻型防弹背心，专为执勤而制。这件还带有特别探员徽记。"

/obj/item/clothing/suit/vampire/vest/police/sergeant
	name = "警长背心"
	icon_state = "sgtvest"
	desc = "印有旧金山警察局标志的轻型防弹背心，专为执勤而制。这件还带有警长徽记。"

// They got an Army vest post-PD update. I am just giving them the same, instead coded into their equipment instead of mapped.
/obj/item/clothing/suit/vampire/vest/police/captain
	name = "警监执勤背心"
	icon_state = "capvest"
	desc = "印有旧金山警察局标志的复合防弹背心，提供更强的防护。这件还带有警监徽记。"
	armor_type = /datum/armor/highly_protective_vest

/datum/armor/highly_protective_vest
	melee = 70
	bullet = 70
	laser = 10
	energy = 10
	bomb = 60
	fire = 50
	acid = 10
	wound = 30

/obj/item/clothing/suit/vampire/vest/army
	name = "军用背心"
	desc = "军用装备。对钝击提供出色的防护。"
	icon_state = "army"
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/highly_protective_vest
	masquerade_violating = TRUE

/obj/item/clothing/suit/vampire/eod
	name = "排爆服"
	desc = "爆破人员的装备。对几乎所有威胁都能提供顶级防护。"
	icon_state = "eod"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 2
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/eod_suit
	masquerade_violating = TRUE

/datum/armor/eod_suit
	melee = 90
	bullet = 90
	laser = 50
	energy = 50
	bomb = 100
	fire = 70
	acid = 90
	wound = 50

/obj/item/clothing/suit/vampire/bogatyr
	name = "骨甲"
	desc = "由不明材料制成的一套威严护甲。"
	icon_state = "bogatyr_armor_light"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	clothing_flags = THICKMATERIAL
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.5
	w_class = WEIGHT_CLASS_NORMAL
	armor_type = /datum/armor/bulletproof_vest

/obj/item/clothing/suit/vampire/bogatyr/captain
	name = "金色骨甲"
	icon_state = "bogatyr_captain_armor"
	armor_type = /datum/armor/highly_protective_vest

/obj/item/clothing/suit/vampire/bogatyr/captain/heavy // ! Craftable only.
	name = "强化金色骨甲"
	armor_type = /datum/armor/eod_suit
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 1

/obj/item/clothing/suit/vampire/bogatyr/heavy
	name = "重型骨甲"
	icon_state = "bogatyr_armor"
	armor_type = /datum/armor/eod_suit
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 1

/obj/item/clothing/suit/vampire/labcoat
	name = "实验服"
	desc = "用于医疗和研究工作。"
	icon_state = "labcoat"
	armor_type = /datum/armor/labcoat

/datum/armor/labcoat
	acid = 90
	wound = 10

/obj/item/clothing/suit/vampire/labcoat/director
	name = "诊所主任实验服"
	desc = "诊所主任专用的实验服，带有圣约翰诊所徽记。"
	icon_state = "director"

/obj/item/clothing/suit/vampire/fancy_gray
	name = "奢华灰色夹克"
	desc = "一件灰色夹克。"
	icon_state = "fancy_gray_jacket"

/obj/item/clothing/suit/vampire/fancy_red
	name = "奢华红色夹克"
	desc = "一件红色夹克。"
	icon_state = "fancy_red_jacket"

/obj/item/clothing/suit/vampire/majima_jacket
	name = "过分华丽的夹克"
	desc = "哇哦，快看！两个猛男光着身子扭打在一起！？原来还有这么个离谱的世界，我以前压根不知道……"
	icon_state = "majima_jacket"

/obj/item/clothing/suit/vampire/bahari
	name = "黑暗之母服装"
	desc = "当我初次品尝那两棵树的果实，\
			感受生命与知识的种子在体内燃烧时，我便在那天立誓，绝不回头……"
	icon_state = "bahari"

/obj/item/clothing/suit/vampire/kasaya
	name = "袈裟"
	desc = "佛教僧尼穿着的传统长袍。"
	icon_state = "kasaya"

/obj/item/clothing/suit/vampire/imam
	name = "伊玛目长袍"
	desc = "伊斯兰教伊玛目穿着的传统长袍。"
	icon_state = "imam"

/obj/item/clothing/suit/vampire/noddist
	name = "挪得信徒长袍"
	desc = "太阳闪耀黑光！月亮映照血色！末日审判即将到来。"
	icon_state = "noddist"

/obj/item/clothing/suit/vampire/orthodox
	name = "东正教教士袍"
	desc = "东正教教士穿着的传统长袍。"
	icon_state = "vestments"

/obj/item/clothing/suit/vampire/dutch
	name = "达奇的夹克"
	desc = "陪你度过塔希提海滩上的漫漫长夜。"
	icon_state = "DutchJacket"

//Pentex Overwear
/obj/item/clothing/suit/vampire/pentex_labcoat
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "实验服"
	desc = "一件洁白挺括的实验服，胸前绣有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标志！"
	icon_state = "pentex_closedlabcoat"
	armor_type = /datum/armor/labcoat

/obj/item/clothing/suit/vampire/pentex_labcoat_alt
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "实验服"
	desc = "一件洁白挺括的实验服，带有绿色镶边，胸前绣有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标志！"
	icon_state = "pentex_labcoat_alt"
	armor_type = /datum/armor/labcoat

/obj/item/clothing/suit/vampire/bomber_jacket_classic
	name = "经典飞行夹克"
	desc = "一件经典飞行夹克。"
	icon_state = "bomber_classic"

/obj/item/clothing/suit/vampire/bomber_jacket_gray
	name = "灰色飞行夹克"
	desc = "一件灰色飞行夹克。"
	icon_state = "bomber_gray"

/obj/item/clothing/suit/vampire/shawl_black
	name = "黑色披肩"
	desc = "一条黑色披肩。"
	icon_state = "shawl_black"

/obj/item/clothing/suit/vampire/shawl_white
	name = "白色披肩"
	desc = "一条白色披肩。"
	icon_state = "shawl_white"
