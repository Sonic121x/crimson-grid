//NECK

//NECK

//NECK

/obj/item/clothing/neck/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 5, "neck", FALSE)

/obj/item/clothing/neck/vampire/scarf
	name = "黑色围巾"
	desc = "可抵御寒冷。"
	icon_state = "scarf"

/obj/item/clothing/neck/vampire/scarf/red
	name = "红色围巾"
	icon_state = "scarf_red"

/obj/item/clothing/neck/vampire/scarf/blue
	name = "蓝色围巾"
	icon_state = "scarf_blue"

/obj/item/clothing/neck/vampire/scarf/green
	name = "绿色围巾"
	icon_state = "scarf_green"

/obj/item/clothing/neck/vampire/scarf/white
	name = "白色围巾"
	icon_state = "scarf_white"

/obj/item/clothing/neck/vampire/prayerbeads
	name = "念珠"
	desc = "用于祈祷的珠串。"
	icon_state = "beads"
