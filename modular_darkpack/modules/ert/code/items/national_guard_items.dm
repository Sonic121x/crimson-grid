
//------------Mask------------
/obj/item/clothing/mask/gas/darkpack/military
	name = "\improper 军用防毒面具"
	desc = "贴合面部的战术防毒面具，旨在防范生物危害和公众问责。"
	icon_state = "gasmask_NG"
	icon = 'modular_darkpack/modules/ert/icons/clothing.dmi'
	inhand_icon_state = null
	worn_icon = 'modular_darkpack/modules/ert/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/onfloor.dmi')
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDEEYES | HIDEEARS | HIDEHAIR | HIDESNOUT
	visor_flags_inv = 0
	flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	visor_flags_cover = MASKCOVERSMOUTH | MASKCOVERSEYES | PEPPERPROOF
	fishing_modifier = 2
	pepper_tint = FALSE
	brand = "herculean"


/obj/item/clothing/mask/gas/darkpack/military/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('modular_darkpack/modules/ert/icons/worn.dmi', "gasmask_emissive", src, alpha = src.alpha)

/obj/item/clothing/mask/gas/darkpack/military/pentex
	name = "\improper 企业防毒面具"
	desc = "为你抵挡烟尘、烟雾，以及任何正在你的秘密实验室里横冲直撞的恐怖生物。"
	icon_state = "gasmask_pentex"
	brand = "endron"

//TODO: Finish CBRN Detachment + Equipment, masks are added seperately for atomization purposes
