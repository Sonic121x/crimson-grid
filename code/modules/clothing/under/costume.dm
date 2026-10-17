/obj/item/clothing/under/costume
	icon = 'icons/obj/clothing/under/costume.dmi'
	worn_icon = 'icons/mob/clothing/under/costume.dmi'

/obj/item/clothing/under/costume/roman
	name = "\improper 罗马护甲"
	desc = "古罗马护甲，由金属和皮革条带制成。"
	icon_state = "roman"
	inhand_icon_state = "armor"
	can_adjust = FALSE
	strip_delay = 10 SECONDS
	resistance_flags = NONE

/obj/item/clothing/under/costume/jabroni
	name = "杂鱼服"
	desc = "皮衣俱乐部还在往下两个区的地方。"
	icon_state = "darkholme"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/owl
	name = "猫头鹰制服"
	desc = "一件由人造羽毛和坚定信念制成的柔软棕色连身服。"
	icon_state = "owl"
	inhand_icon_state = "owl"
	can_adjust = FALSE

/obj/item/clothing/under/costume/griffin
	name = "狮鹫制服"
	desc = "柔软的棕色连身服，带有白色羽领，由人造羽毛与制造混乱的欲望制成。"
	icon_state = "griffin"
	can_adjust = FALSE

/obj/item/clothing/under/costume/seifuku
	name = "女学生制服"
	desc = "就跟我看的日本动画一模一样！"
	greyscale_colors = "#942737#4A518D#EBEBEB"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/seifuku"
	post_init_icon_state = "seifuku"
	greyscale_config_inhand_left = /datum/greyscale_config/seifuku_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/seifuku_inhands_right
	inhand_icon_state = "seifuku"
	greyscale_config = /datum/greyscale_config/seifuku
	greyscale_config_worn = /datum/greyscale_config/seifuku/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	alternate_worn_layer = UNDER_SUIT_LAYER

/obj/item/clothing/under/costume/seifuku/red
	icon_state = "/obj/item/clothing/under/costume/seifuku/red"
	greyscale_colors = "#3F4453#BB2E2E#EBEBEB"

/obj/item/clothing/under/costume/seifuku/teal
	icon_state = "/obj/item/clothing/under/costume/seifuku/teal"
	greyscale_colors = "#942737#2BA396#EBEBEB"

/obj/item/clothing/under/costume/seifuku/tan
	icon_state = "/obj/item/clothing/under/costume/seifuku/tan"
	greyscale_colors = "#87502E#B9A56A#EBEBEB"

/obj/item/clothing/under/costume/pirate
	name = "海盗服"
	desc = "呀吼。"
	icon_state = "pirate"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/soviet
	name = "苏联制服"
	desc = "为了祖国！"
	icon_state = "soviet"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/redcoat
	name = "红衫军制服"
	desc = "看起来很古老。"
	icon_state = "redcoat"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt
	name = "苏格兰裙"
	desc = "附带鞋子与格纹披布。"
	icon_state = "kilt"
	inhand_icon_state = "kilt"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/kilt/highlander
	desc = "只有你配得上这条苏格兰裙。"

/obj/item/clothing/under/costume/kilt/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER_TRAIT)

/obj/item/clothing/under/costume/gladiator
	name = "角斗士服"
	desc = "你们还不满意吗？你们不就是为此而来的吗？"
	icon_state = "gladiator"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = NO_FEMALE_UNIFORM
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/gladiator/ash_walker
	desc = "这套角斗士服似乎覆满灰烬，年代也相当久远。"
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/maid
	name = "女仆装"
	desc = "中国制仆。"
	greyscale_colors = "#494955#EEEEEE"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/maid"
	post_init_icon_state = "maid"
	greyscale_config = /datum/greyscale_config/maid
	greyscale_config_worn = /datum/greyscale_config/maid/worn
	greyscale_config_inhand_left = /datum/greyscale_config/maid_inhands_left
	greyscale_config_inhand_right = /datum/greyscale_config/maid_inhands_right
	inhand_icon_state = "maid"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	alternate_worn_layer = UNDER_SUIT_LAYER
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR //weebs are gonna love this

/obj/item/clothing/under/costume/geisha
	name = "艺伎服"
	desc = "不附带可爱的太空忍者前辈。"
	icon_state = "geisha"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/yukata
	name = "黑色浴衣"
	desc = "一件参考传统设计的舒适黑色棉浴衣，适合非正式场合。"
	icon_state = "yukata1"
	inhand_icon_state = "yukata1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/yukata/green
	name = "绿色浴衣"
	desc = "一件参考传统设计的舒适绿色棉浴衣，适合非正式场合。"
	icon_state = "yukata2"
	inhand_icon_state = "yukata2"

/obj/item/clothing/under/costume/yukata/white
	name = "白色浴衣"
	desc = "一件参考传统设计的舒适白色棉浴衣，适合非正式场合。"
	icon_state = "yukata3"
	inhand_icon_state = "yukata3"

/obj/item/clothing/under/costume/kimono
	name = "黑色和服"
	desc = "一件富有传统韵味的华贵黑色丝绸和服，适合典雅的节庆场合。"
	icon_state = "kimono1"
	inhand_icon_state = "yukata1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/kimono/red
	name = "红色和服"
	desc = "一件富有传统韵味的华贵红色丝绸和服，适合典雅的节庆场合。"
	icon_state = "kimono2"
	inhand_icon_state = "kimono2"

/obj/item/clothing/under/costume/kimono/purple
	name = "紫色和服"
	desc = "一件富有传统韵味的华贵紫色丝绸和服，适合典雅的节庆场合。"
	icon_state = "kimono3"
	inhand_icon_state = "kimono3"

/obj/item/clothing/under/costume/villain
	name = "反派服"
	desc = "想抓住真正的超级英雄，就得先换身行头。"
	icon_state = "villain"
	can_adjust = FALSE

/obj/item/clothing/under/costume/sailor
	name = "水手服"
	desc = "船长正在军官休息室喝杜松子酒。"
	icon_state = "sailor"
	inhand_icon_state = "b_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer
	abstract_type = /obj/item/clothing/under/costume/singer
	desc = "光是看着它就让你想唱歌。"
	body_parts_covered = CHEST|GROIN|ARMS
	alternate_worn_layer = ABOVE_SHOES_LAYER
	can_adjust = FALSE

/obj/item/clothing/under/costume/singer/yellow
	name = "黄色演出服"
	icon_state = "ysing"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/costume/singer/blue
	name = "蓝色演出服"
	icon_state = "bsing"
	inhand_icon_state = null
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/singer/red
	name = "红色演出服"
	icon_state = "rsing"
	inhand_icon_state = null
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/costume/mummy
	name = "木乃伊裹布"
	desc = "归还石板，否则承受我这陈年老梗的诅咒。"
	icon_state = "mummy"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/scarecrow
	name = "稻草人服"
	desc = "藏在植物园里的完美伪装。"
	icon_state = "scarecrow"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/costume/draculass
	name = "德古拉女郎大衣"
	desc = "一件灵感源自古老\"维多利亚\"时代的裙装。"
	icon_state = "draculass"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/costume/drfreeze
	name = "冰冻博士连身服"
	desc = "一件经过改造、看起来格外冷酷的科学家连身服。"
	icon_state = "drfreeze"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/lobster
	name = "泡沫龙虾服"
	desc = "谁把大学吉祥物的头砍掉了？"
	icon_state = "lobster"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/gondola
	name = "冈多拉皮服"
	desc = "这下你可上道了。"
	icon_state = "gondola"
	inhand_icon_state = "lb_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/skeleton
	name = "骷髅连身服"
	desc = "印着白色骨骼图案的黑色连身服。真吓人！"
	icon_state = "skeleton"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

// Mech suit skins
/datum/atom_skin/mech_suit
	abstract_type = /datum/atom_skin/mech_suit

/datum/atom_skin/mech_suit/red
	preview_name = "Red" //Asuka from evangelion
	new_icon_state = "red_mech_suit"

/datum/atom_skin/mech_suit/white
	preview_name = "White" //Rei from evangelion
	new_icon_state = "white_mech_suit"

/datum/atom_skin/mech_suit/blue
	preview_name = "Blue" //Shinji from Evangelion
	new_icon_state = "blue_mech_suit"

/datum/atom_skin/mech_suit/black
	preview_name = "Black" //Based on the robotics jumpsuot
	new_icon_state = "black_mech_suit"

/datum/atom_skin/mech_suit/royal
	preview_name = "royal division" //Kallen Stadtfeld from Code Geass
	new_icon_state = "royal_mech_suit"

/datum/atom_skin/mech_suit/royal_alt
	preview_name = "royal division - alternate" //Kallen again, with her alternate design
	new_icon_state = "royal_mech_suit_alt"

/datum/atom_skin/mech_suit/explorer
	preview_name = "explorer corps" //Sleeker version of the robotics jumpsuit
	new_icon_state = "explorer_mech_suit"

/datum/atom_skin/mech_suit/explorer
	preview_name = "explorer corps - alternate" //Elster from SIGNALIS
	new_icon_state = "explorer_mech_suit_alt"

/obj/item/clothing/under/costume/mech_suit
	name = "机甲驾驶服"
	desc = "机甲驾驶员的服装，可能会显得屁股很大。按住Alt点击更换外观。"
	icon_state = "explorer_mech_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	alternate_worn_layer = GLOVES_LAYER //covers hands but gloves can go over it. This is how these things work in my head.
	can_adjust = FALSE

/obj/item/clothing/under/costume/mech_suit/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/mech_suit)

/obj/item/clothing/under/costume/russian_officer
	name = "\improper 俄式军官制服"
	desc = "俄式时装的最新潮流。"
	icon = 'icons/obj/clothing/under/security.dmi'
	icon_state = "hostanclothes"
	inhand_icon_state = null
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	alt_covers_chest = TRUE
	armor_type = /datum/armor/clothing_under/costume_russian_officer
	strip_delay = 5 SECONDS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	can_adjust = FALSE

/datum/armor/clothing_under/costume_russian_officer
	melee = 10
	fire = 30
	acid = 30

/obj/item/clothing/under/costume/buttondown
	gender = PLURAL
	female_sprite_flags = NO_FEMALE_UNIFORM
	custom_price = PAYCHECK_CREW
	icon = 'icons/obj/clothing/under/shorts_pants_shirts.dmi'
	worn_icon = 'icons/mob/clothing/under/shorts_pants_shirts.dmi'
	species_exception = list(/datum/species/golem)
	can_adjust = TRUE
	alt_covers_chest = TRUE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/buttondown/slacks
	name = "纽扣衬衫配西裤"
	desc = "一件讲究的纽扣衬衫，搭配西裤。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/slacks"
	post_init_icon_state = "buttondown_slacks"
	greyscale_config = /datum/greyscale_config/buttondown_slacks
	greyscale_config_worn = /datum/greyscale_config/buttondown_slacks/worn
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/buttondown/slacks/service //preset one to be a formal white shirt and black pants
	icon_state = "/obj/item/clothing/under/costume/buttondown/slacks/service"
	greyscale_colors = "#EEEEEE#CBDBFC#17171B#222227"

/obj/item/clothing/under/costume/buttondown/shorts
	name = "纽扣衬衫配短裤"
	desc = "一件讲究的纽扣衬衫，搭配短裤。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/shorts"
	post_init_icon_state = "buttondown_shorts"
	greyscale_config = /datum/greyscale_config/buttondown_shorts
	greyscale_config_worn = /datum/greyscale_config/buttondown_shorts/worn
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/buttondown/skirt
	name = "纽扣衬衫配裙子"
	desc = "一件讲究的纽扣衬衫，搭配裙子。"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/buttondown/skirt"
	post_init_icon_state = "buttondown_skirt"
	greyscale_config = /datum/greyscale_config/buttondown_skirt
	greyscale_config_worn = /datum/greyscale_config/buttondown_skirt/worn
	greyscale_colors = "#EEEEEE#EE8E2E#222227#D8D39C"
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/costume/buttondown/skirt/service //preset one to be a formal white shirt and black skirt
	icon_state = "/obj/item/clothing/under/costume/buttondown/skirt/service"
	greyscale_colors = "#EEEEEE#CBDBFC#17171B#222227"

/obj/item/clothing/under/costume/jackbros
	name = "杰克兄弟服"
	desc = "该来点嘻嘻吼吼了。"
	icon_state = "JackFrostUniform"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/deckers
	name = "戴克服"
	icon_state = "decker_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/football_suit
	name = "橄榄球服"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/football_suit"
	post_init_icon_state = "football_suit"
	can_adjust = FALSE
	greyscale_config = /datum/greyscale_config/football_suit
	greyscale_config_worn = /datum/greyscale_config/football_suit/worn
	greyscale_colors = "#D74722"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/costume/swagoutfit
	name = "潮人服"
	desc = "你怎么不去勾搭几个妞呢？"
	icon_state = "SwagOutfit"
	inhand_icon_state = null
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/referee
	name = "裁判服"
	desc = "一套标示权威的标准黑白条纹制服。"
	icon_state = "referee"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/joker
	name = "喜剧演员服"
	desc = "患有精神疾病最糟糕的地方，就是人们总希望你表现得像没病一样。"
	icon_state = "joker"
	can_adjust = FALSE

/obj/item/clothing/under/costume/yuri
	name = "尤里新兵连身服"
	icon_state = "yuri_uniform"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/dutch
	name = "达奇西装"
	desc = "你感觉一个<b>他妈的好计划</b>就要成形了。"
	icon_state = "DutchUniform"
	inhand_icon_state = null
	can_adjust = FALSE

// For the nuke-ops cowboy fit. Sadly no Lone Ranger fit & I don't wanna bloat costume files further.
/obj/item/clothing/under/costume/dutch/syndicate
	desc = "你感觉一个<b>他妈的好计划</b>就要成形了，而这身西装的装甲内衬能为计划顺利实施立下奇功。"
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/costume/osi
	name = "O.S.I.连身服"
	icon_state = "osi_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/tmc
	name = "失落摩托帮服装"
	icon_state = "tmc_jumpsuit"
	inhand_icon_state = null
	can_adjust = FALSE

/obj/item/clothing/under/costume/gi
	name = "武道服"
	desc = "助理、核特工，都无所谓。你能打败任何人，这就叫刻苦修行！"
	icon = 'icons/map_icons/clothing/under/costume.dmi'
	icon_state = "/obj/item/clothing/under/costume/gi"
	post_init_icon_state = "martial_arts_gi"
	greyscale_config = /datum/greyscale_config/gi
	greyscale_config_worn = /datum/greyscale_config/gi/worn
	greyscale_colors = "#f1eeee#000000"
	flags_1 = IS_PLAYER_COLORABLE_1
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/under/costume/gi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/costume/gi/goku
	name = "神圣武道服"
	desc = "创造它的人曾触动无数人的心，也改变了他们的人生。"
	icon_state = "/obj/item/clothing/under/costume/gi/goku"
	post_init_icon_state = "martial_arts_gi_goku"
	greyscale_colors = "#f89925#3e6dd7"

/obj/item/clothing/under/costume/traditional
	name = "传统服饰"
	desc = "一套色彩鲜艳的完整服装，似乎有传统用途。颜色也许代表家族、氏族或地位，谁知道呢。"
	icon_state = "tradition"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/loincloth
	name = "皮革腰布"
	desc = "只是一块遮住私处的皮革，碰着就痒。做它的人不是走投无路，就是野蛮至极。"
	icon_state = "loincloth"
	inhand_icon_state = null
	body_parts_covered = GROIN
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/costume/henchmen
	name = "随从连身服"
	desc = "正牌随从穿的花哨连身服。公会规定，你懂的。"
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'
	icon_state = "henchmen"
	inhand_icon_state = null
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS|HEAD
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEEARS|HIDEEYES|HIDEHAIR

/obj/item/clothing/under/costume/gamberson
	name = "历史重演棉甲"
	desc = "一套模仿中世纪棉甲外形的彩色服装。"
	icon_state = "gamberson"
	inhand_icon_state = null
	female_sprite_flags = NO_FEMALE_UNIFORM
	can_adjust = FALSE

/obj/item/clothing/under/costume/gamberson/military
	name = "剑士棉甲"
	desc = "一件带衬垫的中世纪棉甲，层层羊毛足以缓冲各种小型武器的打击。"
	armor_type = /datum/armor/clothing_under/rank_security
	has_sensor = NO_SENSORS

/obj/item/clothing/under/costume/captain
	name = "船长西装"
	desc = "绿色西装搭配黄色领带，尽显权威。"
	icon_state = "green_suit"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/captain/skirt
	name = "绿色西装裙"
	desc = "绿色西装裙搭配黄色领带，尽显权威。"
	icon_state = "green_suit_skirt"
	inhand_icon_state = "dg_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/costume/head_of_personnel
	name = "人事主管西装"
	desc = "蓝绿色西装搭配黄色领带，一套有威严却俗气的行头。"
	icon_state = "teal_suit"
	inhand_icon_state = "g_suit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/head_of_personnel/skirt
	name = "蓝绿色西装裙"
	desc = "蓝绿色西装裙搭配黄色领带，一套有威严却俗气的行头。"
	icon_state = "teal_suit_skirt"
	inhand_icon_state = "g_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
