/obj/item/ammo_casing/vampire
	icon_state = "9"
	base_icon_state = "9"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	abstract_type = /obj/item/ammo_casing/vampire

// 9x19mm Parabellum
/obj/item/ammo_casing/vampire/c9mm
	name = "9mm弹壳"
	desc = "一枚9mm弹壳。"
	caliber = CALIBER_9MMPARA
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm

/obj/item/ammo_casing/vampire/c9mm/plus
	name = "9mm高速弹弹壳"
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm/plus
	caliber = CALIBER_9MMPARA

/obj/item/ammo_casing/vampire/c9mm/silver
	name = "9mm银弹弹壳"
	desc = "一枚9mm银弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp9mm/silver
	icon_state = "s9"
	base_icon_state = "s9"

// .45 ACP
/obj/item/ammo_casing/vampire/c45acp
	name = ".45 ACP弹壳"
	desc = "一枚.45 ACP弹壳。"
	caliber = CALIBER_45ACP
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp
	icon_state = "45"
	base_icon_state = "45"

/obj/item/ammo_casing/vampire/c45acp/HP
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp/HP

/obj/item/ammo_casing/vampire/c45acp/silver
	name = ".45 ACP银弹弹壳"
	desc = "一枚.45 ACP银弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp45acp/silver

// .44 Magnum
/obj/item/ammo_casing/vampire/c44
	name = ".44弹壳"
	desc = "一枚.44弹壳。"
	caliber = CALIBER_44MAG
	projectile_type = /obj/projectile/bullet/darkpack/vamp44
	icon_state = "44"
	base_icon_state = "44"

/obj/item/ammo_casing/vampire/c44/silver
	name = ".44银弹弹壳"
	desc = "一枚.44银弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp44/silver
	icon_state = "s44"
	base_icon_state = "s44"

// .50 BMG/AE
/obj/item/ammo_casing/vampire/c50ae
	name = ".50 AE弹壳"
	desc = "一枚.50 AE弹壳。"
	caliber = CALIBER_50CAL_AE
	projectile_type = /obj/projectile/bullet/darkpack/vamp50ae
	icon_state = "44"		//placeholder
	base_icon_state = "44"	//placeholder

/obj/item/ammo_casing/vampire/c50
	name = ".50 BMG弹壳"
	desc = "一枚.50 BMG弹壳。"
	caliber = CALIBER_50CAL_BMG
	projectile_type = /obj/projectile/bullet/darkpack/vamp50
	icon_state = "50"
	base_icon_state = "50"

// 5.56mm NATO
/obj/item/ammo_casing/vampire/c556mm
	name = "5.56mm弹壳"
	desc = "一枚5.56mm弹壳。"
	caliber = CALIBER_556NATO
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm
	icon_state = "556"
	base_icon_state = "556"

/obj/item/ammo_casing/vampire/c556mm/silver
	name = "5.56mm银弹弹壳"
	desc = "一枚5.56mm银弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm/silver
	icon_state = "s556"
	base_icon_state = "s556"

// 5.45x39mm
/obj/item/ammo_casing/vampire/c545mm
	name = "5.45mm弹壳"
	desc = "一枚5.45mm弹壳。"
	caliber = CALIBER_545SOVIET
	projectile_type = /obj/projectile/bullet/darkpack/vamp545mm
	icon_state = "545"
	base_icon_state = "545"

// 4.6mm HK
/obj/item/ammo_casing/vampire/c46pdw
	name = "4.6mm弹壳"
	desc = "一枚4.6mm弹壳。"
	caliber = CALIBER_46HK
	projectile_type = /obj/projectile/bullet/darkpack/vamp46mm
	icon_state = "46"
	base_icon_state = "46"

/obj/item/ammo_casing/vampire/c556mm/incendiary
	projectile_type = /obj/projectile/bullet/darkpack/vamp556mm/incendiary

// 12 Gauge
/obj/item/ammo_casing/vampire/c12g
	name = "12号霰弹弹壳"
	desc = "一枚12号霰弹弹壳。"
	caliber = CALIBER_12G
	projectile_type = /obj/projectile/bullet/shotgun_slug/vamp
	icon_state = "12"
	base_icon_state = "12"

/obj/item/ammo_casing/vampire/c12g/silver
	name = "12号银弹弹壳"
	desc = "一枚12号银弹弹壳。"
	icon_state = "s12"
	base_icon_state = "s12"
	projectile_type = /obj/projectile/bullet/shotgun_slug/vamp/silver

/obj/item/ammo_casing/vampire/c12g/buck
	desc = "一枚12号霰弹弹壳（00号鹿弹）。"
	projectile_type = /obj/projectile/bullet/darkpack/shotpellet
	pellets = 8
	variance = 25

/obj/item/ammo_casing/vampire/c12g/rubber
	desc = "一枚12号霰弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/rubber
	icon_state = "12r"
	base_icon_state = "12r"

/obj/item/ammo_casing/vampire/c12g/incap
	desc = "一枚12号霰弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/incap
	icon_state = "12i"
	base_icon_state = "12i"

/obj/item/ammo_casing/vampire/c12g/buck/incendiary
	name = "12号龙息弹弹壳"
	desc = "一枚12号燃烧弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/dragonsbreath
	pellets = 6		//Decresed due to damage output + firestacks
	variance = 25
	icon_state = "12d"
	base_icon_state = "12d"

// Crossbow Bolt
/obj/item/ammo_casing/caseless/bolt
	name = "弩箭"
	desc = "欢迎来到中世纪！"
	projectile_type = /obj/projectile/bullet/crossbow_bolt
	caliber = CALIBER_CROSSBOWBOLT
	icon_state = "arrow"
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	harmful = TRUE

// 7.62x51mm NATO
/obj/item/ammo_casing/vampire/c762x51mm // DARKPACK TODO: can you believe these never had a sprite? tfn...
	name = "7.62x51mm弹壳"
	desc = "一枚7.62x51mm弹壳。"
	caliber = CALIBER_762NATO
	projectile_type = /obj/projectile/bullet/darkpack/vamp762x51mm
	icon_state = "762"
	base_icon_state = "762"

/obj/item/ammo_casing/vampire/c762x51mm/incendiary
	name = "7.62x51mm曳光弹弹壳"
	projectile_type = /obj/projectile/bullet/darkpack/vamp762x51mm/incendiary

/obj/item/ammo_casing/vampire/c762x51mm/silver
	name = "7.62x51mm银弹弹壳"
	desc = "一枚7.62x51mm银弹弹壳。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp762x51mm/silver
	icon_state = "s762"
	base_icon_state = "s762"

/obj/item/ammo_casing/vampire/c75
	name = ".75火枪弹药包"
	desc = "一个.75口径火枪弹药包，内含圆弹和火药。"
	caliber = CALIBER_75BALL
	projectile_type = /obj/projectile/bullet/darkpack/vamp75
	icon_state = "cartridge"
	base_icon_state = "cartridge"

/obj/item/ammo_casing/vampire/c75/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/vampire/c75/silver
	name = ".75银弹火枪弹药包"
	desc = "一个.75口径火枪弹药包，内含纯银圆弹和火药。"
	projectile_type = /obj/projectile/bullet/darkpack/vamp75/silver
	icon_state = "scartridge"
	base_icon_state = "scartridge"
