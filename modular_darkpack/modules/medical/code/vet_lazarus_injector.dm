/**
 * Players can revive simplemobs with this.
 * In-game item that can be used to revive a simplemob once. Does not make mobs friendly.
 */
/obj/item/lazarus_injector/lazadon
	name = "拉撒顿复苏注射器"
	desc = "装有混合药剂的注射器，能够让宠物起死回生。"
	icon = 'modular_darkpack/modules/medical/icons/lazadon_injector.dmi'
	lefthand_file = 'modular_darkpack/modules/medical/icons/lazadon_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/medical/icons/lazadon_righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/medical/icons/lazadon_onfloor.dmi')

	brand = "magadon"
	should_tame = FALSE
