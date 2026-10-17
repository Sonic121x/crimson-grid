/obj/item/clothing/under/rank/centcom
	icon = 'icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'icons/mob/clothing/under/centcom.dmi'
	abstract_type = /obj/item/clothing/under/rank/centcom

/obj/item/clothing/under/rank/centcom/commander
	name = "\improper 中央指挥部指挥官制服"
	desc = "中央指挥部最高级别指挥官穿着的制服。"
	icon_state = "centcom"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/official
	name = "\improper 中央指挥部官员制服"
	desc = "中央指挥部官员穿着的制服，银色腰带扣让人一眼就能认出其级别。"
	icon_state = "official"
	inhand_icon_state = "dg_suit"

/obj/item/clothing/under/rank/centcom/intern
	name = "\improper 中央指挥部实习生连身服"
	desc = "中央指挥部实习生穿着的连身服，上身采用便于识别的翻领运动衫款式。"
	icon_state = "intern"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/centcom/officer
	name = "\improper 中央指挥部高领制服"
	desc = "中央指挥部军官穿着的绿色高领服，休闲而精致，带着芦荟清香。"
	icon_state = "officer"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/centcom/officer/replica
	name = "\improper CentCom turtleneck replica"
	desc = "A cheap copy of the CentCom turtleneck! A Donk Co. logo can be seen on the collar."

/obj/item/clothing/under/rank/centcom/officer_skirt
	name = "\improper 中央指挥部高领裙装"
	desc = "中央指挥部高领制服的裙装款式，比原版更罕见，也更抢手。"
	icon_state = "officer_skirt"
	inhand_icon_state = "dg_suit"
	alt_covers_chest = TRUE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/officer_skirt/replica
	name = "\improper CentCom turtleneck skirt replica"
	desc = "A cheap copy of the CentCom turtleneck skirt! A Donk Co. logo can be seen on the collar."

/obj/item/clothing/under/rank/centcom/centcom_skirt
	name = "\improper 中央指挥部指挥官裙装"
	desc = "中央指挥部最高级别指挥官穿着的裙装制服。"
	icon_state = "centcom_skirt"
	inhand_icon_state = "dg_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/centcom/military
	name = "tactical combat uniform"
	desc = "A dark colored uniform worn by CentCom's conscripted military forces."
	icon_state = "military"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE
	armor_type = /datum/armor/clothing_under/centcom_military

/datum/armor/clothing_under/centcom_military
	melee = 10
	fire = 50
	acid = 40
	wound = 10

/obj/item/clothing/under/rank/centcom/military/eng
	name = "tactical engineering uniform"
	desc = "A dark colored uniform worn by CentCom's regular military engineers."
	icon_state = "military_eng"
