/obj/item/ammo_box/darkpack
	icon = 'modular_darkpack/modules/weapons/icons/ammo.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/weapons/icons/ammo_onfloor.dmi')
	w_class = WEIGHT_CLASS_NORMAL
	abstract_type = /obj/item/ammo_box/darkpack

// 9x19mm Parabellum

/obj/item/ammo_box/darkpack/c9mm
	name = "弹药盒（9mm）"
	icon_state = "9box"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	max_ammo = 100
	custom_price = 300

/obj/item/ammo_box/darkpack/c9mm/plus
	name = "弹药盒（9mm，+P）"
	desc = "一盒高速（HV）弹药。"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/plus

/obj/item/ammo_box/darkpack/c9mm/silver
	name = "弹药盒（9mm银弹）"
	icon_state = "9box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm/silver
	max_ammo = 100

/obj/item/ammo_box/darkpack/c9mm/moonclip // Speedloader, technically.
	name = "弹夹（9mm）"
	desc = "可容纳3发9mm子弹的弹夹。这回叫它弹夹总算没叫错。"
	icon_state = "9moonclip"
	max_ammo = 3
	w_class = WEIGHT_CLASS_TINY
	multiple_sprites = AMMO_BOX_PER_BULLET

// .45 ACP
/obj/item/ammo_box/darkpack/c45acp
	name = "弹药盒（.45 ACP）"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp
	max_ammo = 100

/obj/item/ammo_box/darkpack/c45acp/hp
	name = "弹药盒（.45 ACP空尖弹）"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp/HP
	max_ammo = 100

/obj/item/ammo_box/darkpack/c45acp/silver
	name = "弹药盒（.45 ACP银弹）"
	icon_state = "45box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c45acp/silver
	max_ammo = 100

// .44 Magnum
/obj/item/ammo_box/darkpack/c44
	name = "弹药盒（.44）"
	icon_state = "44box"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	max_ammo = 60

/obj/item/ammo_box/darkpack/c44/silver
	name = "弹药盒（.44银弹）"
	icon_state = "44box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c44/silver
	max_ammo = 60

// .50 AE
/obj/item/ammo_box/darkpack/c50ae
	name = "弹药盒（.50 AE）"
	icon_state = "50box"	//placeholder, needs new box
	ammo_type = /obj/item/ammo_casing/vampire/c50ae
	max_ammo = 40

// .50 BMG
/obj/item/ammo_box/darkpack/c50
	name = "弹药盒（.50 BMG）"
	icon_state = "50box"
	ammo_type = /obj/item/ammo_casing/vampire/c50
	max_ammo = 20

// 5.56mm NATO
/obj/item/ammo_box/darkpack/c556
	name = "弹药盒（5.56）"
	icon_state = "556box"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	max_ammo = 60
	custom_price = 2000

/obj/item/ammo_box/darkpack/c556/incendiary
	name = "燃烧弹盒（5.56）"
	icon_state = "incendiary"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/incendiary

/obj/item/ammo_box/darkpack/c556/silver
	name = "弹药盒（5.56银弹）"
	icon_state = "556box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm/silver
	max_ammo = 60

// 5.45x39mm
/obj/item/ammo_box/darkpack/c545
	name = "弹药盒（5.45）"
	icon_state = "545box"
	ammo_type = /obj/item/ammo_casing/vampire/c545mm
	max_ammo = 60

// 4.6mm HK // DARKPACK TODO: Ammo box for 4.6mm NATO
/obj/item/ammo_box/darkpack/c46pdw
	name = "弹药盒（4.6mm）"
	icon_state = "46box"
	ammo_type = /obj/item/ammo_casing/vampire/c46pdw
	max_ammo = 100

// 12 Gauge
/obj/item/ammo_box/darkpack/c12g
	name = "弹药盒（12号）"
	icon_state = "12box"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	max_ammo = 30

/obj/item/ammo_box/darkpack/c12g/silver
	name = "弹药盒（12号银弹）"
	icon_state = "12box_silver"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/silver
	max_ammo = 30

/obj/item/ammo_box/darkpack/c12g/buck
	name = "弹药盒（12号，00号鹿弹）"
	icon_state = "12box_buck"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck
	custom_price = 400

/obj/item/ammo_box/darkpack/c12g/rubber
	name = "弹药盒（12号，橡胶弹）"
	icon_state = "12box_rubber"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/rubber

/obj/item/ammo_box/darkpack/c12g/incap
	name = "弹药盒（12号，高冲击失能弹）"
	icon_state = "12box_incap"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/incap

//obj/item/ammo_box/darkpack/c12g/buck/silver
//	name = "ammo box (12g, 00 buck silver)"
//	icon_state = "s12box_buck"
//	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck/silver

/obj/item/ammo_box/darkpack/c12g/buck/incendiary
	name = "弹药盒（12号，龙息弹）"
	icon_state = "12box_dragon"
	ammo_type = /obj/item/ammo_casing/vampire/c12g/buck/incendiary

// Crossbow Bolt
/obj/item/ammo_box/darkpack/arrows
	name = "弹药盒（弩箭）"
	icon_state = "arrows"
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	max_ammo = 30

// 7.62x51mm NATO
/obj/item/ammo_box/darkpack/c762x51mm
	name = "弹药盒（7.62x51mm）"
	icon_state = "762box"
	ammo_type = /obj/item/ammo_casing/vampire/c762x51mm
	max_ammo = 80

/obj/item/ammo_box/darkpack/c762x51mm/incendiary
	name = "燃烧弹盒（7.62x51）"
	icon_state = "762box-incendiary"
	ammo_type = /obj/item/ammo_casing/vampire/c762x51mm/incendiary

/obj/item/ammo_box/darkpack/c762x51mm/incendiary
	name = "弹药盒（7.62x51银弹）"
	icon_state = "762box-silver"
	ammo_type = /obj/item/ammo_casing/vampire/c762x51mm/silver

// .75 Ball
/obj/item/ammo_box/darkpack/c75
	name = "弹药袋（.75圆弹）"
	icon_state = "cartridge_bag"
	ammo_type = /obj/item/ammo_casing/vampire/c75
	max_ammo = 5

/obj/item/ammo_box/darkpack/c75/silver
	name = "弹药袋（.75银制圆弹）"
	ammo_type = /obj/item/ammo_casing/vampire/c75/silver

