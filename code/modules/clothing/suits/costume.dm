/obj/item/clothing/suit/costume
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	abstract_type = /obj/item/clothing/suit/costume

/obj/item/clothing/suit/hooded/flashsuit
	name = "闪光服"
	desc = "你还指望什么？"
	icon_state = "flashsuit"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "armor"
	body_parts_covered = CHEST|GROIN
	hoodtype = /obj/item/clothing/head/hooded/flashsuit

/obj/item/clothing/head/hooded/flashsuit
	name = "闪光按钮"
	desc = "你会学会畏惧闪光。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "flashsuit"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK|HIDESNOUT

/obj/item/clothing/head/hooded/flashsuit/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/wearable_client_colour, /datum/client_colour/flash_hood, ITEM_SLOT_HEAD, HELMET_TRAIT, forced = TRUE)

/obj/item/clothing/suit/costume/pirate
	name = "海盗大衣"
	desc = "呀吼。"
	icon_state = "pirate"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/melee/energy/sword/pirate,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/reagent_containers/cup/glass/bottle/rum,
		/obj/item/gun/energy/laser/musket,
		/obj/item/gun/energy/disabler/smoothbore,
	)
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/costume/pirate/armored
	armor_type = /datum/armor/pirate_armored
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	species_exception = null

/obj/item/clothing/suit/costume/pirate/armored/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/suit/costume/pirate/captain
	name = "海盗船长大衣"
	desc = "呀吼。"
	icon_state = "hgpirate"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/pirate/captain/armored
	armor_type = /datum/armor/pirate_armored
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	species_exception = null

/obj/item/clothing/suit/costume/cyborg_suit
	name = "半机械人扮装服"
	desc = "用于扮成半机械人的服装。"
	icon_state = "death"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	obj_flags = CONDUCTS_ELECTRICITY
	fire_resist = T0C+5200
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/costume/justice
	name = "正义战衣"
	desc = "这看起来实在很滑稽" //Needs no fixing
	icon_state = "justice"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor_type = /datum/armor/costume_justice

/obj/item/clothing/suit/costume/justice/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/datum/armor/costume_justice
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/suit/costume/judgerobe
	name = "法官袍"
	desc = "这件袍子自带威严。"
	icon_state = "judge"
	inhand_icon_state = "judge"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/fancy/cigarettes, /obj/item/stack/spacecash)

/obj/item/clothing/suit/syndicatefake
	name = "黑红太空服仿制品"
	icon_state = "syndicate-black-red"
	icon = 'icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'icons/mob/clothing/suits/spacesuit.dmi'
	inhand_icon_state = "syndicate-black-red"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	desc = "辛迪加太空服的塑料仿制品。穿上后，你就像真正杀人如麻的辛迪加特工！这是玩具，不能用于太空环境！"
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	resistance_flags = NONE

/obj/item/clothing/suit/costume/hastur
	name = "\improper 哈斯塔之袍"
	desc = "本不该由人类穿戴的长袍。"
	icon_state = "hastur"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/costume/imperium_monk
	name = "\improper 帝国修士服"
	desc = "今天你杀过异形了吗？"
	icon_state = "imperium_monk"
	inhand_icon_state = "imperium_monk"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/costume/imperium_monk/Initialize(mapload)
	. = ..()
	allowed = GLOB.chaplain_suit_allowed

/obj/item/clothing/suit/costume/chickensuit
	name = "鸡扮装服"
	desc = "很久以前由古老的肯德基帝国制作的服装。"
	icon_state = "chickensuit"
	inhand_icon_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/costume/monkeysuit
	name = "猴子扮装服"
	desc = "模样像灵长类动物的服装。"
	icon_state = "monkeysuit"
	inhand_icon_state = null
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "猫头鹰披风"
	desc = "由人造羽毛制成的柔软棕色披风。触感柔软、造型时髦，还有能让女士们为之疯狂的两米翼展。"
	icon_state = "owl_wings"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = null
	toggle_noun = "wings"
	body_parts_covered = ARMS|CHEST

/obj/item/clothing/suit/toggle/owlwings/Initialize(mapload)
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/owlwings/griffinwings
	name = "狮鹫披风"
	desc = "由人造羽毛制成的蓬松白色披风。触感柔软、造型时髦，还有能让俘虏们为之疯狂的两米翼展。"
	icon_state = "griffin_wings"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/cardborg
	name = "纸板半机械人服"
	desc = "一个侧面开了几个洞的普通纸箱。"
	icon_state = "cardborg"
	inhand_icon_state = "cardborg"
	body_parts_covered = CHEST|GROIN|LEGS
	flags_inv = HIDEJUMPSUIT
	dog_fashion = /datum/dog_fashion/back
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT * 3)
	var/in_use = FALSE

/obj/item/clothing/suit/costume/cardborg/equipped(mob/living/user, slot)
	..()
	if(slot & ITEM_SLOT_OCLOTHING)
		disguise(user)

/obj/item/clothing/suit/costume/cardborg/dropped(mob/living/user)
	..()
	if (!in_use)
		return
	user.remove_alt_appearance("standard_borg_disguise")
	in_use = FALSE
	var/mob/living/carbon/human/human_user = user
	if (istype(human_user.head, /obj/item/clothing/head/costume/cardborg))
		UnregisterSignal(human_user.head, COMSIG_ITEM_DROPPED)

/obj/item/clothing/suit/costume/cardborg/proc/disguise(mob/living/carbon/human/human_user, obj/item/clothing/head/costume/cardborg/borghead)
	if(!istype(human_user))
		return
	if(!borghead)
		borghead = human_user.head
	if(!istype(borghead, /obj/item/clothing/head/costume/cardborg)) //why is this done this way? because equipped() is called BEFORE THE ITEM IS IN THE SLOT WHYYYY
		return
	RegisterSignal(borghead, COMSIG_ITEM_DROPPED, PROC_REF(helmet_drop)) // Don't need to worry about qdeleting since dropped will be called from there
	in_use = TRUE
	var/image/override_image = image(icon = 'icons/mob/silicon/robots.dmi' , icon_state = "robot", loc = human_user)
	override_image.override = TRUE
	override_image.add_overlay(mutable_appearance('icons/mob/silicon/robots.dmi', "robot_e")) //gotta look realistic
	add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "standard_borg_disguise", override_image) //you look like a robot to robots! (including yourself because you're totally a robot)

/obj/item/clothing/suit/costume/cardborg/proc/helmet_drop(datum/source, mob/living/user)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_ITEM_DROPPED)
	user.remove_alt_appearance("standard_borg_disguise")
	in_use = FALSE

/obj/item/clothing/suit/costume/snowman
	name = "雪人服"
	desc = "两个覆着白色闪粉的白色球体。又到了这个季节。"
	icon_state = "snowman"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/costume/poncho
	name = "斗篷"
	desc = "经典斗篷，不带种族歧视。"
	icon_state = "classicponcho"
	inhand_icon_state = null
	species_exception = list(/datum/species/golem)
	flags_inv = HIDEBELT

/obj/item/clothing/suit/costume/poncho/green
	name = "绿色斗篷"
	desc = "经典斗篷，不带种族歧视。这件是绿色的。"
	icon_state = "greenponcho"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/poncho/red
	name = "红色斗篷"
	desc = "经典斗篷，不带种族歧视。这件是红色的。"
	icon_state = "redponcho"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/poncho/ponchoshame
	name = "耻辱斗篷"
	desc = "你被迫一直维持假扮墨西哥人的羞耻表演，如今已经与斗篷形影不离。字面意义上的。"
	icon_state = "ponchoshame"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/poncho/ponchoshame/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, SHAMEBRERO_TRAIT)

/obj/item/clothing/suit/costume/whitedress
	name = "白色礼服"
	desc = "一件精美的白色礼服。"
	icon_state = "white_dress"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|LEGS|FEET
	flags_inv = HIDEJUMPSUIT|HIDESHOES|HIDEBELT

/obj/item/clothing/suit/hooded/carp_costume
	name = "鲤鱼扮装服"
	desc = "用'人造'鲤鱼鳞制成的服装，有股怪味。"
	icon_state = "carp_casual"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT //Space carp like space, so you should too
	clothing_flags = CARP_STYLE_FACTOR
	allowed = list(/obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/gun/ballistic/rifle/boltaction/harpoon)
	hoodtype = /obj/item/clothing/head/hooded/carp_hood

/obj/item/clothing/suit/hooded/carp_costume/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/head/hooded/carp_hood
	name = "鲤鱼兜帽"
	desc = "连在鲤鱼扮装服上的兜帽。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "carp_casual"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	clothing_flags = CARP_STYLE_FACTOR

/obj/item/clothing/head/hooded/carp_hood/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5)

/obj/item/clothing/head/hooded/carp_hood/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot & ITEM_SLOT_HEAD)
		user.add_faction("carp")

/obj/item/clothing/head/hooded/carp_hood/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		user.remove_faction("carp")

/obj/item/clothing/suit/hooded/carp_costume/spaceproof
	name = "鲤鱼太空服"
	desc = "一件来路可疑的太空鲤鱼科技产物，穿着显瘦。你怀疑它承受不住近身打击。"
	icon_state = "carp_suit"
	inhand_icon_state = "space_suit_syndicate"
	armor_type = /datum/armor/carp_costume_spaceproof
	allowed = list(/obj/item/tank/internals, /obj/item/gun/ballistic/rifle/boltaction/harpoon) //I'm giving you a hint here
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | CARP_STYLE_FACTOR
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/carp_hood/spaceproof
	resistance_flags = NONE

/datum/armor/carp_costume_spaceproof
	melee = -20
	bio = 100
	fire = 60
	acid = 75

/obj/item/clothing/head/hooded/carp_hood/spaceproof
	name = "鲤鱼头盔"
	desc = "能用于太空，外形像太空鲤鱼的脑袋，闻起来也像。"
	icon_state = "carp_helm"
	armor_type = /datum/armor/carp_hood_spaceproof
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR //facial hair will clip with the helm, this'll need a dynamic_fhair_suffix at some point.
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	clothing_flags = STOPSPRESSUREDAMAGE|THICKMATERIAL|SNUG_FIT|STACKABLE_HELMET_EXEMPT|CARP_STYLE_FACTOR
	body_parts_covered = HEAD
	resistance_flags = NONE
	flash_protect = FLASH_PROTECTION_WELDER
	flags_cover = HEADCOVERSEYES|HEADCOVERSMOUTH|PEPPERPROOF

/datum/armor/carp_hood_spaceproof
	melee = -20
	bio = 100
	fire = 60
	acid = 75

/obj/item/clothing/head/hooded/carp_hood/spaceproof/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)

/obj/item/clothing/suit/hooded/carp_costume/spaceproof/old
	name = "破旧鲤鱼太空服"
	desc = "遍布咬痕和划伤，却似乎仍能正常运作。"
	slowdown = 1

/obj/item/clothing/suit/hooded/ian_costume //It's Ian, rub his bell- oh god what happened to his inside parts?
	name = "柯基扮装服"
	desc = "看起来像有人做了一只人形柯基的服装，可不保证有人来摸肚皮。"
	icon_state = "ian"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	allowed = list()
	hoodtype = /obj/item/clothing/head/hooded/ian_hood
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/head/hooded/ian_hood
	name = "柯基兜帽"
	desc = "模样酷似柯基脑袋的兜帽，可不保证有人喂狗饼干。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "ian"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/bee_costume // It's Hip!
	name = "蜜蜂扮装服"
	desc = "蜂为真正的女王！"
	icon_state = "bee"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/bee_hood

/obj/item/clothing/head/hooded/bee_hood
	name = "蜜蜂兜帽"
	desc = "连在蜜蜂扮装服上的兜帽。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "bee"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/shark_costume // Blahaj
	name = "鲨鱼扮装服"
	desc = "终于有一件能搭配你最爱玩偶的服装了。"
	icon_state = "shark"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "shark"
	body_parts_covered = CHEST|GROIN|ARMS
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/shark_hood

/obj/item/clothing/suit/hooded/shark_costume/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -4)

/obj/item/clothing/head/hooded/shark_hood
	name = "鲨鱼兜帽"
	desc = "连在鲨鱼扮装服上的兜帽。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "shark"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/hooded/shark_hood/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5)

/obj/item/clothing/suit/hooded/shork_costume // Oh God Why
	name = "鲨鲨扮装服"
	desc = "你为什么要这么做？"
	icon_state = "sharkcursed"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "sharkcursed"
	body_parts_covered = CHEST|GROIN|ARMS
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/shork_hood

/obj/item/clothing/suit/hooded/shork_costume/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 4)

/obj/item/clothing/head/hooded/shork_hood
	name = "鲨鲨兜帽"
	desc = "连在鲨鲨扮装服上的兜帽。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "sharkcursed"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/head/hooded/shork_hood/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 5)

/obj/item/clothing/suit/hooded/bloated_human //OH MY GOD WHAT HAVE YOU DONE!?!?!?
	name = "肿胀人皮服"
	desc = "一件用人皮制成、肿胀得骇人的服装。"
	icon_state = "lingspacesuit"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	allowed = list()
	hoodtype = /obj/item/clothing/head/hooded/human_head
	species_exception = list(/datum/species/golem) //Finally, flesh
	clothing_flags = parent_type::clothing_flags | PLASMAMAN_PREVENT_IGNITION

/obj/item/clothing/head/hooded/human_head
	name = "肿胀人头"
	desc = "一颗肿胀得骇人、拼接错乱的人头。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "lingspacehelmet"
	body_parts_covered = HEAD
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	clothing_flags = parent_type::clothing_flags | PLASMAMAN_PREVENT_IGNITION | HEADINTERNALS
	clothing_traits = list(TRAIT_HUMAN_DISGUISE) // Just the helmet is fine because it's attached to the suit

/obj/item/clothing/suit/costume/shrine_maiden
	name = "巫女服"
	desc = "让你想去退治几个麻烦的妖怪。"
	icon_state = "shrine_maiden"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/costume/striped_sweater
	name = "条纹毛衣"
	desc = "让你想起某个人，却怎么也说不出是谁……"
	icon_state = "waldo_shirt"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/dracula
	name = "德古拉大衣"
	desc = "看起来像从非常古老的电影片场里拿出来的。"
	icon_state = "draculacoat"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/drfreeze_coat
	name = "冰冻博士实验服"
	desc = "一件蕴含特性与冻结之力的实验服。"
	icon_state = "drfreeze_coat"
	inhand_icon_state = null

/obj/item/clothing/suit/costume/gothcoat
	name = "哥特大衣"
	desc = "最适合那些想在酒吧角落徘徊潜行的人。"
	icon_state = "gothcoat"
	inhand_icon_state = null
	flags_inv = HIDEBELT

/obj/item/clothing/suit/costume/xenos
	name = "异形服"
	desc = "用外星生物的几丁质外皮制成的服装。"
	icon_state = "xenos"
	inhand_icon_state = "xenos_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDEBELT
	allowed = list(/obj/item/clothing/mask/facehugger/toy)

/obj/item/clothing/suit/costume/nemes
	name = "法老长衣"
	desc = "不附带豪华太空陵墓。"
	icon_state = "pharoah"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/suit/costume/changshan_red
	name = "红色长衫"
	desc = "一件刺绣华美的丝绸长衫。"
	icon_state = "changshan_red"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/costume/changshan_blue
	name = "蓝色长衫"
	desc = "一件刺绣华美的丝绸长衫。"
	icon_state = "changshan_blue"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/costume/cheongsam_red
	name = "红色旗袍"
	desc = "一件刺绣华美的丝绸旗袍。"
	icon_state = "cheongsam_red"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/costume/cheongsam_blue
	name = "蓝色旗袍"
	desc = "一件刺绣华美的丝绸旗袍。"
	icon_state = "cheongsam_blue"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/costume/bronze
	name = "青铜服"
	desc = "一件硕大、哐当作响的青铜服，毫无防护，还土得掉渣。真棒。"
	icon_state = "clockwork_cuirass_old"
	allowed = list(
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/tank/jetpack/captain,
		/obj/item/storage/belt/holster,
		//new
		/obj/item/toy/clockwork_watch,
		)
	armor_type = /datum/armor/costume_bronze
	custom_materials = list(/datum/material/bronze = SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/suit/hooded/mysticrobe
	name = "神秘者长袍"
	desc = "穿上它，你感觉更贴近宇宙的本质……也变得更不负责任了一点。"
	icon_state = "mysticrobe"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	inhand_icon_state = "mysticrobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/spellbook, /obj/item/book/bible)
	flags_inv = HIDEJUMPSUIT
	hoodtype = /obj/item/clothing/head/hooded/mysticrobe

/obj/item/clothing/head/hooded/mysticrobe
	name = "神秘者兜帽"
	desc = "现实的天平向秩序倾斜。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "mystichood"
	inhand_icon_state = null
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK

/obj/item/clothing/suit/coordinator
	name = "派对协调员夹克"
	desc = "派对协调员的夹克，真时髦！"
	icon_state = "capformal"
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	inhand_icon_state = null
	armor_type = /datum/armor/suit_coordinator

/datum/armor/suit_coordinator
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	fire = 50
	acid = 50

/obj/item/clothing/suit/costume/hawaiian
	name = "夏威夷外搭衬衫"
	desc = "一件适合在海滩放松的清爽衬衫。"
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/costume/hawaiian"
	post_init_icon_state = "hawaiian_shirt"
	inhand_icon_state = null
	greyscale_config = /datum/greyscale_config/hawaiian_shirt
	greyscale_config_worn = /datum/greyscale_config/hawaiian_shirt/worn
	greyscale_colors = "#313B82#CCCFF0"
	flags_1 = IS_PLAYER_COLORABLE_1
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/costume/hawaiian/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5)
	allowed += GLOB.personal_carry_allowed

/obj/item/clothing/suit/costume/football_armor
	name = "橄榄球护具"
	desc = "配发给橄榄球队队员！"
	icon = 'icons/map_icons/clothing/suit/costume.dmi'
	icon_state = "/obj/item/clothing/suit/costume/football_armor"
	post_init_icon_state = "football_armor"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	greyscale_config = /datum/greyscale_config/football_armor
	greyscale_config_worn = /datum/greyscale_config/football_armor/worn
	greyscale_colors = "#D74722"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/costume/joker
	name = "喜剧演员大衣"
	desc = "我是说，当喜剧演员难道不该有点幽默感吗？"
	icon_state = "joker_coat"

/obj/item/clothing/suit/costume/joker/Initialize(mapload)
	. = ..()
	allowed += GLOB.personal_carry_allowed

/obj/item/clothing/suit/costume/deckers
	name = "戴克连帽衫"
	desc = "有主见？主见是基于什么？"
	icon_state = "decker_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/soviet
	name = "苏联装甲大衣"
	desc = "动员兵报到！当克软弹公司赞助，用于第三次世界大战历史重演！"
	icon_state = "soviet_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/costume/yuri
	name = "尤里新兵大衣"
	desc = "尤里是主人！当克软弹公司赞助，用于第三次世界大战历史重演！"
	icon_state = "yuri_coat"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/costume/tmc
	name = "\improper 失落摩托帮背心"
	desc = "确保所有人都知道，你属于奥尔德尼这一带最棒的摩托帮。"
	icon_state = "tmc_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/pg
	name = "火药帮夹克"
	desc = "提醒安保部门，把爆破炸药交给囚犯是多大的错误。"
	icon_state = "pg_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/irs
	name = "美国国税局夹克"
	desc = "我疯到敢跟猫头鹰叫板，可国税局？不——还是算了吧！"
	icon_state = "irs_suit"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/bear_suit
	name = "熊皮服"
	desc = "一件百分之百熊皮制成的服装。要不是正面那条巨大的拉链，伪装大概会更像。"
	icon_state = "bear"
	worn_icon_state = "bear"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	///Are we friendly with bears (wearing the full head/suit combo)?
	var/full_suit = FALSE

/obj/item/clothing/suit/costume/bear_suit/equipped(mob/living/user, slot)
	..()
	if(slot & ITEM_SLOT_OCLOTHING)
		var/mob/living/carbon/human/human_user = user
		make_friendly(user, human_user.head)

/obj/item/clothing/suit/costume/bear_suit/dropped(mob/living/user)
	..()
	if (!full_suit)
		return
	full_suit = FALSE
	var/mob/living/carbon/human/human_user = user
	UnregisterSignal(human_user.head, COMSIG_ITEM_DROPPED)
	user.remove_faction(FACTION_BEAR)

/obj/item/clothing/suit/costume/bear_suit/proc/make_friendly(mob/living/carbon/human/human_user, obj/item/clothing/head/costume/bearpelt/bear_head)
	if(!istype(human_user))
		return
	if(!bear_head || !istype(bear_head))
		return
	RegisterSignal(bear_head, COMSIG_ITEM_DROPPED, PROC_REF(helmet_drop))
	full_suit = TRUE
	human_user.add_faction(FACTION_BEAR)

/obj/item/clothing/suit/costume/bear_suit/proc/helmet_drop(datum/source, mob/living/user)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_ITEM_DROPPED)
	full_suit = FALSE
	user.remove_faction(FACTION_BEAR)
