//GLASSES

//GLASSES

//GLASSES

/obj/item/clothing/glasses/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	flags_cover = GLASSESCOVERSEYES

/obj/item/clothing/glasses/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "glasses", FALSE)

/obj/item/clothing/glasses/vampire/yellow
	name = "黄色飞行员墨镜"
	desc = "适合在昏暗环境中工作时佩戴。"
	icon_state = "yellow"
	inhand_icon_state = "glasses"

/obj/item/clothing/glasses/vampire/red
	name = "红色飞行员墨镜"
	desc = "适合在昏暗环境中工作时佩戴。"
	icon_state = "redg"
	inhand_icon_state = "glasses"

/obj/item/clothing/glasses/vampire/sun
	name = "太阳镜"
	desc = "戴上就是为了耍酷。"
	icon_state = "sun"
	inhand_icon_state = "glasses"
	tint = 1
	flash_protect = FLASH_PROTECTION_FLASH

/obj/item/clothing/glasses/vampire/perception
	name = "阅读眼镜"
	desc = "读书时戴的眼镜。"
	icon_state = "perception"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)
