//GLOVES

//GLOVES

//GLOVES

/obj/item/clothing/gloves/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	undyeable = TRUE

/obj/item/clothing/gloves/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 4, "gloves", FALSE)

/obj/item/clothing/gloves/vampire/leather
	name = "皮革手套"
	desc = "看起来很不好惹。能提供一定的防护。"
	icon_state = "leather"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/leather_gloves

/datum/armor/leather_gloves
	acid = 30

/obj/item/clothing/gloves/vampire/work
	name = "劳保手套"
	desc = "为极端环境中的工作提供防火保护。"
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/work_gloves

/datum/armor/work_gloves
	fire = 70
	acid = 30

/obj/item/clothing/gloves/vampire/investigator
	name = "调查员手套"
	desc = "为调查员定制的联邦调查局制式工作手套。乳胶外层搭配衬垫，可防酸、防火。"
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/investigator_gloves

/datum/armor/investigator_gloves
	fire = 70
	acid = 70

/obj/item/clothing/gloves/vampire/cleaning
	name = "清洁手套"
	desc = "可防护酸液。"
	icon_state = "cleaning"
	armor_type = /datum/armor/anti_acid_gloves

/datum/armor/anti_acid_gloves
	acid = 70

/obj/item/clothing/gloves/vampire/latex
	name = "乳胶手套"
	desc = "可防护酸液。"
	icon_state = "latex"
	armor_type = /datum/armor/anti_acid_gloves
	siemens_coefficient = /obj/item/clothing/gloves/latex::siemens_coefficient
	clothing_traits = /obj/item/clothing/gloves/latex::clothing_traits
	resistance_flags = /obj/item/clothing/gloves/latex::resistance_flags
	equip_sound = /obj/item/clothing/gloves/latex::equip_sound

/obj/item/clothing/gloves/vampire/white
	name = "白手套"
	desc = "一副精致的白手套，象征整洁与品位，除此之外没什么用。弄脏它们只会显得你很不专业。"
	icon_state = "white_gloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/vampire/brassknuckles
	name = "黄铜指虎"
	desc = "将一组失去光泽的黄铜指环连成一体，便成了暗巷斗殴的凶器。在大多数地方都属违禁品。"
	icon_state = "brassknuckles"
	resistance_flags = FIRE_PROOF
	armor_type = /datum/armor/brassknuckles
	clothing_traits = list(TRAIT_BRASSKNUCKLES)

/datum/armor/brassknuckles
	acid = 50


/obj/item/clothing/gloves/vampire/brassknuckles/spiked
	name = "尖刺钢指虎"
	desc = "一组失去光泽的钢制指环连成一体，上面装着尖锐的金属刺。在大多数地方都属违禁品。"
	icon_state = "spikedknuckles"

/obj/item/clothing/gloves/vampire/brassknuckles/spiked/equipped(mob/living/carbon/human/user, slot)
	..()
	if(ishuman(user) && slot == ITEM_SLOT_GLOVES)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = SHARP_POINTY

/obj/item/clothing/gloves/vampire/brassknuckles/spiked/dropped(mob/living/carbon/human/user, slot)
	..()
	if(user.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		var/mob/living/carbon/carbon_owner = user
		for(var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if(istype(limb, /obj/item/bodypart/arm))
				limb.unarmed_sharpness = initial(limb.unarmed_sharpness)
