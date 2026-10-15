/obj/item/storage/belt/police/swat
	name = "特警腰带"
	desc = "可以收纳手铐等特警装备。"
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/police/swat/full

/obj/item/storage/belt/police/swat/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/vamp(src)

/obj/item/card/swat
	name = "身份识别牌"
	desc = "精锐执法人员的身份识别牌，上面印着姓名，以便被俘或阵亡时辨认身份。"
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "dogtags"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/lieutenant
	name = "警官徽章"
	desc = "精锐执法人员的闪亮徽章，散发着金色的权威光芒。"
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "leader"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "police_badge"

/obj/item/card/first_aid
	name = "急救员证件"
	desc = "战地医护员的专业塑封证件。你知道专门攻击战地医护人员是战争罪吗？"
	icon = 'modular_darkpack/modules/ert/icons/badges.dmi'
	icon_state = "first_aid"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ert/icons/badges_onfloor.dmi')
	worn_icon = 'modular_darkpack/modules/jobs/icons/id_worn.dmi'
	worn_icon_state = "grey_id"

/obj/item/clothing/suit/vampire/darkpack_ert/swat_armor
	name = "\improper 特警防弹背心"
	desc = "防护性能出色的背心，标明供特警使用。一定要在破门进入房间之前扔出闪光弹。"
	icon_state = "swatvest"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/highly_protective_vest
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	clothing_traits = list(TRAIT_BRAWLING_KNOCKDOWN_BLOCKED)

/obj/item/clothing/suit/vampire/darkpack_ert/swat_armor/fbi
	name = "\improper 联邦调查局特警防弹背心"
	icon_state = "fbivest"

/obj/item/clothing/head/vampire/darkpack_ert/swat_helmet
	name = "\improper 特警头盔"
	desc = "性能有所提升的改装旧金山警察局头盔。享受警察军事化带来的好处，感觉很棒吧？"
	icon_state = "swathelmet"
	armor_type = /datum/armor/army_helmet
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	visor_flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/vampire/darkpack_ert/swat_helmet/fbi
	name = "\improper 联邦调查局特警头盔"
	icon_state = "fbihelmet"
