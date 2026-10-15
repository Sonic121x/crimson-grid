/obj/item/gun/ballistic/automatic/darkpack
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = null
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	recoil = 5

	//Leave serial_type blank for no serial number/obliterated serial number.
	serial_type = "SF"

/*
/obj/item/ammo_box/magazine/darkpack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
*/

//REVOLVERS
/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = "左轮弹巢"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44MAG
	max_ammo = 6

/obj/item/gun/ballistic/revolver/darkpack
	name = "evil coder revolver"
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = "gun"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	initial_caliber = CALIBER_44MAG
	fire_sound = 'modular_darkpack/modules/weapons/sounds/revolver.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 85
	recoil = 3

/obj/item/gun/ballistic/revolver/darkpack/magnum
	name = "马格南左轮手枪"
	desc = "小子，觉得自己运气不错？"

/obj/item/gun/ballistic/revolver/darkpack/snub
	name = "短管左轮手枪"
	desc = "一把廉价的小型左轮手枪，有时也被称为‘手袋枪’。使用9mm弹药。"
	icon_state = "revolver_snub"
	inhand_icon_state = "revolver_snub"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev9mm
	w_class = WEIGHT_CLASS_SMALL
	initial_caliber = CALIBER_9MM
	fire_sound_volume = 65
	projectile_damage_multiplier = 1.2 //21.6 damage, slightly higher than the m1911, just so it is possible to kill NPCs within 6 bullets
	recoil = 2
	serial_type = "SN"

/obj/item/ammo_box/magazine/internal/cylinder/rev9mm
	name = "左轮弹巢"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MMPARA
	max_ammo = 6

//PISTOLS
/obj/item/gun/ballistic/automatic/pistol/darkpack
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = "gun"
	icon = 'modular_darkpack/modules/weapons/icons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	recoil = 3

/obj/item/ammo_box/magazine/m44
	name = "手枪弹匣（.44）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "deagle"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44MAG
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle
	name = "\improper 沙漠之鹰"
	desc = "一把威力强大的.44口径手枪。"
	icon_state = "deagle"
	inhand_icon_state = "deagle"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m44
	recoil = 4
	fire_sound = 'modular_darkpack/modules/weapons/sounds/deagle.ogg'
	serial_type = "MR"

/obj/item/ammo_box/magazine/m50
	name = "手枪弹匣（.50）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "deagle"
	ammo_type = /obj/item/ammo_casing/vampire/c50ae
	caliber = CALIBER_50CAL_AE
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/deagle/c50
	name = "\improper 麦克拉斯基.50口径手枪 "
	desc = "一把极其强大而罕见的手炮。"
	icon_state = "deagle50"
	inhand_icon_state = "deagle"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m50
	fire_sound_volume = 125 //MY EARS
	recoil = 5
	weapon_weight = WEAPON_MEDIUM	//Firing .50 at 70 dam, think this is fair.

/obj/item/ammo_box/magazine/darkpack45acp
	name = "手枪弹匣（.45 ACP）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "m1911"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45ACP
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/m1911
	name = "\improper 柯尔特1911"
	desc = "一把可靠的.45 ACP手枪。"
	icon_state = "m1911"
	inhand_icon_state = "m1911"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack45acp
	fire_sound = 'modular_darkpack/modules/weapons/sounds/m1911.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 100
	serial_type = "CM"

/obj/item/ammo_box/magazine/glock9mm
	name = "自动手枪弹匣（9mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "glock19"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MMPARA
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19
	name = "\improper 布洛克19"
	desc = "一把射速很快的9mm手枪。"
	icon_state = "glock19"
	inhand_icon_state = "glock19"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/glock9mm
	burst_size = 3
	fire_delay = 1
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 100
	serial_type = "GG"

/obj/item/ammo_box/magazine/glock45acp
	name = "自动手枪弹匣（.45 ACP）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "glock21"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45ACP
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/glock45acp/hp
	ammo_type = /obj/item/ammo_casing/vampire/c45acp/HP

/obj/item/gun/ballistic/automatic/pistol/darkpack/glock21
	name = "\improper 布洛克21"
	desc = "一把射速很快的45 ACP手枪。"
	icon_state = "glock19"
	inhand_icon_state = "glock19"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/glock45acp
	burst_size = 3
	fire_delay = 1
	recoil = 4
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 100
	serial_type = "GG"

/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta
	name = "\improper 精英92G"
	desc = "一把因动作电影而深受执法人员和罪犯喜爱的9mm手枪。经常被成对使用。"
	icon_state = "beretta"
	inhand_icon_state = "beretta"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/semi9mm
	burst_size = 1
	fire_delay = 0 //spam it
	dual_wield_spread = 10 //DUAL ELITES!
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'modular_darkpack/modules/weapons/sounds/glock.ogg'
	fire_sound_volume = 75
	custom_price = 1200
	serial_type = "BH"

/obj/item/gun/ballistic/automatic/pistol/darkpack/beretta/toreador
	name = "\improper 利剑系列S型9mm手枪"
	desc = "一把经过精心装饰和深度定制的手枪。这些改进的效果好得近乎超自然，你感觉连雕花都能给你带来战术优势。"
	icon_state = "beretta_toreador"
	projectile_damage_multiplier = 2.5
	fire_sound_volume = 110

/obj/item/ammo_box/magazine/semi9mm
	name = "手枪弹匣（9mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "semi9mm"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MMPARA
	max_ammo = 18
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	custom_price = 200

/obj/item/ammo_box/magazine/semi9mm/toreador
	name = "定制手枪弹匣（9mm）"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/silver

//AUTOMATICS
/obj/item/ammo_box/magazine/darkpack9mm
	name = "乌兹弹匣（9mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "uzi"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MMPARA
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/uzi
	name = "\improper 杀戮者乌兹"
	desc = "一把轻便的点射冲锋枪，适合你铁了心要干掉某人的时候。使用9mm弹药。"
	icon_state = "uzi"
	inhand_icon_state = "uzi"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack9mm
	burst_size = 5
	spread = 11
	recoil = 5
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/uzi.ogg'
	serial_type = "IWI"

/obj/item/ammo_box/magazine/darkpack9mp5
	name = "MP5弹匣（9mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "mp5"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MMPARA
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/mp5
	name = "\improper HK MP5"
	desc = "一把轻便的冲锋枪，适合那些又脏又酷的差事。使用9mm弹药。"
	icon_state = "mp5"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	inhand_icon_state = "mp5"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack9mp5
	burst_size = 1
	spread = 4
	recoil = 3
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/mp5.ogg'
	serial_type = "H&K"
	var/rof = 0.15 SECONDS

/obj/item/gun/ballistic/automatic/darkpack/mp5/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)


/obj/item/ammo_box/magazine/darkpack45smg
	name = ".45冲锋枪弹匣"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "mac10" //uzi sprite placeholder
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45ACP
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/mac10
	name = "\improper 布拉多克.45"
	desc = "一个装满子弹的盒子。射速高、重量轻，除了扫射后祈祷，也干不了别的。使用.45口径弹药。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "mac10"
	inhand_icon_state = "mac10"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack45smg
	burst_size = 1
	spread = 16 //spray and pray
	burst_delay = 1
	recoil = 6
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	can_suppress = TRUE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/weapons/sounds/mac10.ogg' // DARKPACK sound effect
	serial_type = "GBI"
	var/rof = 0.055 SECONDS //1090 RPM, if any other gun has the same fire rate as this gun, increase this gun so its the new fastest

/obj/item/gun/ballistic/automatic/darkpack/mac10/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/obj/item/ammo_box/magazine/darkpack45custom
	name = ".45定制弹匣"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "mac10" //uzi sprite placeholder
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45ACP
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/mac10/super
	name = "\improper 清道夫定制型"
	desc = "一把枪口装有消音器的.45冲锋枪，有助于保持射击平衡。黑暗血魔法让它的钢丝枪托得以发挥作用。"
	icon = 'modular_darkpack/modules/deprecated/icons/64x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "mac10_super"
	recoil = 5
	spread = 8 //magic stock
	suppressed = SUPPRESSED_QUIET
	fire_sound = 'modular_darkpack/modules/weapons/sounds/mac10suppress.ogg'  //mac-10 recording
	suppressed_sound = 'modular_darkpack/modules/weapons/sounds/mac10suppress.ogg'
	suppressed_volume = 70
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack45custom
	can_unsuppress = FALSE

/obj/item/ammo_box/magazine/darkpack/c46pdw
	name = "4.6mm MP7弹匣"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "mp7"
	ammo_type = /obj/item/ammo_casing/vampire/c46pdw
	caliber = CALIBER_46HK
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/darkpack/c46pdw/ext
	name = "4.6mm MP7加长弹匣"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "mp7"
	ammo_type = /obj/item/ammo_casing/vampire/c46pdw
	caliber = CALIBER_46HK
	max_ammo = 40
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/mp7
	name = "\improper HK MP7"
	desc = "德国军队近期采用的一种自动手枪。装有穿甲弹，请谨慎使用。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "mp7"
	inhand_icon_state = "mp7"
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack/c46pdw
	burst_size = 1
	spread = 3
	recoil = 2
	weapon_weight = WEAPON_MEDIUM
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/mp5.ogg'
	serial_type = "H&K"
	var/rof = 0.1 SECONDS //600 RPM,

/obj/item/gun/ballistic/automatic/darkpack/mp7/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/obj/item/ammo_box/magazine/darkpack556
	name = "卡宾枪弹匣（5.56mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "rifle"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556NATO
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/darkpack556/hunt
	name = "步枪弹匣（5.56mm）"
	icon_state = "hunt556"
	max_ammo = 20
	custom_price = 200

/obj/item/gun/ballistic/automatic/darkpack/ar15
	name = "\improper CAR-15卡宾枪"
	desc = "一把黑色的性感突击步枪，型号为‘CAR-15’。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "rifle"
	inhand_icon_state = "rifle"
	worn_icon_state = "rifle"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack556
	burst_size = 2
	fire_delay = 2
	recoil = 5
	spread = 4
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = TRUE
	serial_type = "CAR"

/obj/item/gun/ballistic/automatic/darkpack/huntrifle
	name = "猎枪"
	desc = "一把半自动猎枪，就像你老爸以前用的那种。当然，前提是他没有借口买牛奶就一去不回。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	worn_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "huntrifle"
	inhand_icon_state = "huntrifle"
	worn_icon_state = "sks"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack556/hunt
	burst_size = 1
	fire_delay = 1
	spread = 2
	recoil = 3
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = FALSE
	custom_price = 2000
	serial_type = "R&C"

/obj/item/ammo_box/magazine/darkpack545
	name = "步枪弹匣（5.45mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "ak"
	ammo_type = /obj/item/ammo_casing/vampire/c545mm
	caliber = CALIBER_545SOVIET
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/ak74
	name = "\improper 卡拉什尼科夫74型自动步枪"
	desc = "虽然老旧，但操作简单，还能用伏特加清洗。使用5.45弹药。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	worn_icon = 'icons/mob/clothing/back.dmi'
	icon_state = "ak74"
	inhand_icon_state = "ak74"
	worn_icon_state = "sks"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack545
	recoil = 5
	burst_size = 1
	spread = 5
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/ak.ogg'
	masquerade_violating = TRUE
	can_be_sawn_off	= TRUE
	serial_type = "KA"
	var/rof = 0.2 SECONDS //300 RPM

/obj/item/gun/ballistic/automatic/darkpack/ak74/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/obj/item/gun/ballistic/automatic/darkpack/ak74/sawn
	name = "锯短卡拉什尼科夫74型自动步枪"
	desc = "虽然老旧，但操作简单，还能用伏特加清洗。这把的枪托被拆掉了，枪管也被锯短，居然还能正常供弹，真是奇迹！使用5.45弹药。"
	icon_state = "ak74_sawn"
	inhand_icon_state = "ak74_sawn"
	worn_icon_state = "sks"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	recoil = 8	//Increased recoil due to sawing off the stock on a full-auto. Bootleg draco.

/obj/item/ammo_box/magazine/darkpackaug
	name = "AUG弹匣（5.56mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "aug"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556NATO
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/aug
	name = "\improper 斯泰尔AUG-77"
	desc = "奥地利设计的5.56口径无托步枪，型号为‘斯泰尔AUG-77’。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "aug"
	inhand_icon_state = "aug"
	worn_icon_state = "aug"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackaug
	burst_size = 3
	fire_delay = 2
	spread = 3
	recoil = 5
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/rifle.ogg'
	masquerade_violating = TRUE
	obj_flags = NONE
	serial_type = "SA"

/obj/item/ammo_box/magazine/darkpackthompson
	name = "汤普森冲锋枪弹匣（.45 ACP）"
	icon_state = "thompson"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	caliber = CALIBER_45ACP
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/thompson
	name = "\improper 汤普森冲锋枪"
	desc = "‘再见了，你这个蠢逼。’" // a legendary wod13 screenshot
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "thompson"
	inhand_icon_state = "thompson"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackthompson
	recoil = 5
	burst_size = 1
	spread = 15
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/thompson.ogg'
	masquerade_violating = TRUE
	serial_type = "AO"
	var/rof = 0.15 SECONDS //400 RPM

/obj/item/gun/ballistic/automatic/darkpack/thompson/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/obj/item/ammo_box/magazine/darkpack762x51fal
	name = "战斗步枪弹匣（7.62x51mm）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "308mag"
	ammo_type = /obj/item/ammo_casing/vampire/c762x51mm
	caliber = CALIBER_762NATO
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/fal
	name = "战斗步枪"
	desc = "一把使用全威力7.62弹药的强力步枪。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "fal"
	inhand_icon_state = "fal"
	worn_icon_state = "fal"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpack762x51fal
	burst_size = 1
	fire_delay = 3
	spread = 2
	recoil = 5
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/sniper.ogg'
	masquerade_violating = FALSE
	serial_type = "BR"

/obj/item/gun/ballistic/automatic/darkpack/fal/automatic
	name = "军用战斗步枪"
	desc = "一把使用全威力7.62弹药的强力步枪。这把是具备全自动射击能力的军用型号。"
	icon_state = "falgreen"
	inhand_icon_state = "falgreen"
	worn_icon_state = "falgreen"
	var/rof = 0.2 SECONDS //300 RPM

/obj/item/gun/ballistic/automatic/darkpack/fal/automatic/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/obj/item/ammo_box/magazine/internal/darkpack/lever
	name = "杠杆式步枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44MAG
	max_ammo = 13

/obj/item/gun/ballistic/rifle/darkpack/lever
	name = "杠杆式步枪"
	desc = "一把.44口径杠杆式步枪，非常适合休闲猎人、历史重演爱好者和都市牛仔。驾！"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "lever"
	inhand_icon_state = "lever"
	worn_icon_state = "lever"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/darkpack/lever
	bolt_wording = "bolt"
	need_bolt_lock_to_interact = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'modular_darkpack/modules/weapons/sounds/lever.ogg'
	vary_fire_sound = FALSE
	can_be_sawn_off	= TRUE
	rack_sound = 'modular_darkpack/modules/weapons/sounds/bolt/lever_out.ogg'
	bolt_drop_sound = 'modular_darkpack/modules/weapons/sounds/bolt/lever_in.ogg'
	tac_reloads = FALSE
	recoil = 3
	fire_delay = 1					//It's bolt-action. Fast as you can go really; which is still pretty slow.
	burst_size = 1
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	projectile_damage_multiplier = 1.5 //~52 damage vs 35 base .44 damage. It's ok, on par with 5.56 but lower pen and slower to fire due to bolt action.
	masquerade_violating = FALSE
	serial_type = "WN"

/obj/item/ammo_box/magazine/internal/darkpack/lever/sawnoff
	name = "马腿式杠杆卡宾枪内置弹仓"
	max_ammo = 8	//7+1

/obj/item/gun/ballistic/rifle/darkpack/lever/sawnoff
	name = "马腿式杠杆卡宾枪"
	desc = "一把.44口径杠杆式步枪，非常适合休闲猎人、历史重演爱好者和都市牛仔。这把的枪管和枪托都被锯短了。"
	icon_state = "lever_sawn"
	inhand_icon_state = "lever_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/darkpack/lever/sawnoff

/obj/item/ammo_box/magazine/internal/vampire/sniper
	name = "狙击步枪内置弹仓"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/vampire/c50
	caliber = CALIBER_50CAL_BMG
	max_ammo = 5
	//multiload = TRUE

/obj/item/gun/ballistic/automatic/darkpack/sniper
	name = "狙击步枪"
	desc = "一把能造成重大伤害的远程武器。不，你不能瞬镜。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "sniper"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampire/sniper
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/sniper.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/items/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	fire_delay = 40
	recoil = 10
	burst_size = 1
	//zoomable = TRUE
	//zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	//zoom_out_amt = 5
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 2 //140 damage. Nice.
	actions_types = list()
	masquerade_violating = TRUE
	serial_type = "RB"

/obj/item/gun/ballistic/automatic/darkpack/autosniper
	name = "半自动狙击步枪"
	desc = "一把半自动精确射手步枪。这个型号最近在电子游戏中颇受欢迎。"
	icon = 'modular_darkpack/modules/weapons/icons/weapons48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "psg1"
	inhand_icon_state = "psg1"
	worn_icon_state = "sniper"
	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY
	accepted_magazine_type = /obj/item/ammo_box/magazine/vamp762x51PSG1
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_LOCKING
	semi_auto = TRUE

	//zoomable = TRUE
	//zoom_amt = 4 //It's known for having a shitty scope
	//zoom_out_amt =  1

	fire_sound = 'modular_darkpack/modules/deprecated/sounds/sniper.ogg'
	fire_sound_volume = 90
	tac_reloads = TRUE
	burst_size = 1
	fire_delay = 5
	spread = 2
	recoil = 6
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 1.5
	actions_types = list()
	masquerade_violating = TRUE
	serial_type = "DS"

/obj/item/ammo_box/magazine/vamp762x51PSG1
	name = "半自动狙击步枪弹匣（7.62 NATO）"
	desc = "用于半自动狙击步枪的弹匣，装填7.62 NATO弹药。"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	//lefthand_file = 'code/modules/wod13/lefthand.dmi'
	//righthand_file = 'code/modules/wod13/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi') // DARKPACK TODO: this needs a sprite
	icon_state = "psg1"
	ammo_type = /obj/item/ammo_casing/vampire/c762x51mm
	caliber = CALIBER_762NATO
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/internal/vampshotgun
	name = "霰弹枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	caliber = CALIBER_12G
	//multiload = FALSE
	max_ammo = 6
	masquerade_violating = FALSE

/obj/item/gun/ballistic/shotgun/vampire
	name = "霰弹枪"
	desc = "一把传统霰弹枪，配有木质护木、枪托和六发管式弹仓。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "pomp"
	inhand_icon_state = "pomp"
	worn_icon_state = "pomp"
	recoil = 6
	fire_delay = 6
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun
	can_be_sawn_off	= TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/pomp.ogg'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	custom_price = 1000
	serial_type = "L"

/obj/item/ammo_box/magazine/internal/vampshotgun/sawnoff
	name = "锯短霰弹枪内置弹仓"
	max_ammo = 4

/obj/item/gun/ballistic/shotgun/vampire/sawnoff
	name = "锯短霰弹枪"
	desc = "一把被锯短的传统霰弹枪……这改装恐怕不合法。配有三发管式弹仓。"
	icon_state = "pomp_sawn"
	inhand_icon_state = "pomp_sawn"
	recoil = 10
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun/sawnoff

/obj/item/ammo_box/magazine/internal/vampshotgun
	name = "霰弹枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	caliber = CALIBER_12G
	//multiload = FALSE
	max_ammo = 6
	masquerade_violating = FALSE

/obj/item/gun/ballistic/shotgun/vamp_remington
	name = "雷明顿霰弹枪"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "1187"
	inhand_icon_state = "1187"
	worn_icon_state = "1187"
	can_suppress = TRUE
	recoil = 6
	fire_delay = 6
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun
	can_be_sawn_off	= TRUE
	suppressed_sound = 'modular_darkpack/modules/weapons/sounds/1187_silenced.ogg'
	fire_sound = 'modular_darkpack/modules/weapons/sounds/1187.ogg'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	custom_price = 1000
	serial_type = "R"

/obj/item/gun/ballistic/shotgun/vamp_remington/shoot_live_shot(mob/living/user)
	..()
	rack()

/obj/item/gun/ballistic/shotgun/vamp_remington/sawnoff
	name = "锯短雷明顿1187"
	desc = "一把枪管延长段被粗暴锯掉的雷明顿11-87霰弹枪……这绝对是非法改装。"
	icon_state = "1187_sawn"
	inhand_icon_state = "1187_sawn"
	worn_icon_state = "1187_sawn"
	recoil = 10
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampshotgun/sawnoff

//Suppressor code is currently borking during unit tests, so i'm just gonna get rid of it and see if that helps
/obj/item/suppressor/darkpack_oil
	name = "改装机油滤芯"
	desc = "一个旧机油滤芯……筒身似乎车出了用于雷明顿11-87的连接槽。"
	icon = 'modular_darkpack/modules/weapons/icons/attachments.dmi'
	icon_state = "oil_filter"

/obj/item/ammo_box/magazine/internal/darkpack_dbarrel
	name = "双管霰弹枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	caliber = CALIBER_12G
	max_ammo = 2
	masquerade_violating = FALSE

/obj/item/gun/ballistic/shotgun/vampire/doublebarrel
	name = "双管霰弹枪"
	desc = "一把老式双管霰弹枪，配有精美的木质护木和枪托，以及双扳机系统。"
	sawn_desc = "一把配有双扳机系统的老式双管霰弹枪。这把的枪管已被锯得远短于法定长度……"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	worn_icon = 'modular_darkpack/modules/weapons/icons/worn_guns.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	w_class = WEIGHT_CLASS_BULKY
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	icon_state = "dbarrel"
	inhand_icon_state = "dbarrel"
	base_icon_state = "dbarrel"
	worn_icon_state = "pomp"
	actions_types = list(/datum/action/item_action/toggle_firemode)
	burst_fire_selection = TRUE
	burst_size = 2	//So you can fire both barrels at once.
	burst_delay = 2
	recoil = 5
	spread = 2
	fire_delay = 3
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/darkpack_dbarrel
	can_be_sawn_off	= TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/pomp.ogg'
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	custom_price = 1200
	serial_type = "BH"	//Beretta makes a lot of hunting shotguns so - w/e

// Allows break-action appearance when shells are ejected.
/obj/item/gun/ballistic/shotgun/vampire/doublebarrel/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][!chambered ? "_empty" : ""][sawn_off ? "_sawn" : ""]"

//Unique sawn-off checks
/obj/item/gun/ballistic/shotgun/vampire/doublebarrel/do_sawoff()
	. = ..()
	w_class = WEIGHT_CLASS_NORMAL	//Lets you stow it in a bag
	weapon_weight = WEAPON_MEDIUM	//Lets you one-hand it on sawing.

/obj/item/ammo_box/magazine/darkpackautoshot
	name = "霰弹枪弹匣（12号）"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	icon_state = "spas15"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck
	caliber = CALIBER_12G
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/darkpack/autoshotgun
	name = "\improper 猎兵SPAS-XV"
	desc = "一把半自动霰弹枪。外观更像突击步枪，射速快得致命。"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "spas15"
	inhand_icon_state = "spas15"
	worn_icon_state = "rifle"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/darkpackautoshot
	burst_size = 1
	fire_delay = 2
	spread = 4
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'modular_darkpack/modules/deprecated/sounds/pomp.ogg'
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.9
	masquerade_violating = TRUE
	recoil = 6
	serial_type = "AL"

/obj/item/gun/ballistic/shotgun/toy/crossbow/vampire
	name = "弩"
	desc = "欢迎来到中世纪！"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "crossbow0"
	inhand_icon_state = "crossbow0"
	fire_delay = 16
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampcrossbow
	fire_sound = 'sound/items/syringeproj.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	masquerade_violating = FALSE
	obj_flags = NONE
	serial_shown = FALSE	//No serial, it's a crossbow.

/obj/item/ammo_box/magazine/internal/vampcrossbow
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	caliber = CALIBER_CROSSBOWBOLT
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/vampire/musket
	name = "火枪内置弹仓"
	ammo_type = /obj/item/ammo_casing/vampire/c75
	caliber = CALIBER_75BALL
	max_ammo = 1	//It's a fucking musket

/obj/item/gun/ballistic/automatic/darkpack/musket
	name = "古董火枪"
	desc = "一把可能来自19世纪中期的古董火枪。幸好它似乎采用简单的弹药包装填方式，只需装填、压实、扳起击锤，再开火！"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/weapons_onfloor.dmi')
	icon_state = "musket"
	inhand_icon_state = "musket"
	worn_icon_state = "musket"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/vampire/musket
	bolt_type = BOLT_TYPE_NO_BOLT
	semi_auto = TRUE	//This is so it ejects/destroys the casing on firing.
	internal_magazine = TRUE
	fire_sound = 'modular_darkpack/modules/weapons/sounds/musket.ogg'
	vary_fire_sound = FALSE
	fire_delay = 50
	burst_size = 1
	recoil = 10	//tee hee
	spread = 14
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	can_be_sawn_off	= TRUE
	projectile_damage_multiplier = 1.5 //150 damage; it is a single-shot.
	serial_shown = FALSE	//No serial, it's a musket.
	actions_types = list()

/obj/item/gun/ballistic/automatic/darkpack/musket/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	..()
	new /obj/effect/particle_effect/fluid/smoke(get_ranged_target_turf(user, user.dir, 1))

/obj/item/gun/ballistic/automatic/darkpack/musket/sawn
	name = "惨遭锯短的古董火枪"
	desc = "一把可能来自19世纪中期的古董火枪，它……等、等等，你他妈为什么要这样糟蹋一把火枪！？"
	icon_state = "musket_sawn"
	inhand_icon_state = "musket_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT	//TALLY HOOOO!!!
	recoil = 12
	spread = 25		//+25 from sawing off anyway, good fucking luck
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
