/obj/item/clothing/mask/gas/vampire
	name = "呼吸防护面罩"
	desc = "可以连接供气设备的覆面面罩。虽然很适合隐藏身份，但阻隔气体流通的效果并不好。" //More accurate
	icon_state = "respirator"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACE | HIDEFACIALHAIR|HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	custom_price = 30

/obj/item/clothing/mask/vampire
	// This USED to be the default resperatior for wod13 moved that to /obj/item/clothing/mask/gas/vampire
	abstract_type = /obj/item/clothing/mask/vampire
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 15, "mask", FALSE)

/obj/item/clothing/mask/vampire/balaclava
	name = "巴拉克拉瓦头套"
	desc = "大把钞票！"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/pentex_balaclava
	name = "加厚巴拉克拉瓦头套"
	desc = "一顶黑色巴拉克拉瓦头套。这顶格外厚实。"
	icon_state = "pentex_balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/tragedy
	name = "悲剧面具"
	desc = "希腊悲剧面具。"
	icon_state = "tragedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/comedy
	name = "喜剧面具"
	desc = "希腊喜剧面具。"
	icon_state = "comedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/shemagh
	name = "阿拉伯方巾"
	desc = "能把你的脸遮得严严实实。"
	icon_state = "shemagh"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/venetian_mask
	name = "威尼斯面具"
	desc = "你可以戴着它参加一场真正的化装舞会。"
	icon_state = "venetian_mask"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/vampire/venetian_mask/fancy
	name = "华丽威尼斯面具"
	desc = "那些古怪的有钱人肯定会戴这种东西。"
	icon_state = "venetian_mask_fancy"

/obj/item/clothing/mask/vampire/venetian_mask/jester
	name = "弄臣面具"
	desc = "他们都会被逗乐的，一个也不例外。"
	icon_state = "venetian_mask_jester"

/obj/item/clothing/mask/vampire/venetian_mask/scary
	name = "染血面具"
	desc = "戴上它，你看起来就像正准备把谁大卸八块。"
	icon_state = "venetian_mask_scary"
	flags_inv = HIDEFACE
	flags_cover = NONE

/obj/item/clothing/mask/vampire/fomori_chaser
	name = "恐怖面具"
	desc = "你喜欢恐怖电影吗？"
	icon_state = "chaser"

//Bandanas use TG sprites except the inventory icon sprite, we use Flav's for that.
/obj/item/clothing/mask/bandana/vampire
	desc = "一条方巾，很适合遮住脸、脖子或头部！"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/onfloor/vampire

/obj/item/clothing/mask/bandana/striped/vampire
	desc = "一条条纹方巾，很适合遮住脸、脖子或头部！"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/striped/onfloor/vampire

/obj/item/clothing/mask/bandana/skull/vampire
	desc = "一条骷髅图案方巾，很适合遮住脸、脖子或头部！"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/bandana/skull/onfloor/vampire

/obj/item/clothing/mask/facescarf/vampire
	desc = "一条厚实的蒙面围巾，非常适合为脖子和脸保暖，也能隐藏身份……"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	greyscale_config_onfloor = /datum/greyscale_config/facescarf/onfloor/vampire
