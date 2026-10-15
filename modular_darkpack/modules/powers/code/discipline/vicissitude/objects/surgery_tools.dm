/obj/item/organ/cyberimp/arm/toolkit/surgery/vicissitude
	icon_state = "toolkit_implant_vic"
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'
	organ_flags = ORGAN_ORGANIC
	aug_overlay = ""
	items_to_create = list(
		/obj/item/retractor/augment/vicissitude,
		/obj/item/hemostat/augment/vicissitude,
		/obj/item/cautery/augment/vicissitude,
		/obj/item/surgicaldrill/augment/vicissitude,
		/obj/item/scalpel/augment/vicissitude,
		/obj/item/circular_saw/augment/vicissitude,
		/obj/item/surgical_drapes/vicissitude,
		/obj/item/bonesetter/augment/vicissitude,
		/obj/item/blood_filter/augment/vicissitude,
		/obj/item/healthanalyzer/vicissitude,
		/obj/item/shockpaddles/cyborg/vicissitude)
	extend_sound = 'modular_darkpack/modules/powers/sounds/vicissitude.ogg'
	retract_sound =  'modular_darkpack/modules/powers/sounds/vicissitude.ogg'

/obj/item/retractor/augment/vicissitude
	name = "牵开附肢"
	desc = "一对能够抓握的钳肢。"
	icon_state = "retractor_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/hemostat/augment/vicissitude
	name = "止血钳肢"
	desc = "一对由手指变成的细长附肢，尖端会分泌止血液。"
	icon_state = "hemostat_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/cautery/augment/vicissitude
	name = "化学烧灼器官"
	desc = "一种特化器官，会流出能在极短时间内释放大量热量的化学混合物。"
	icon_state = "cautery_vic"
	inhand_icon_state = "cautery_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/surgicaldrill/augment/vicissitude
	name = "手术钻牙"
	desc = "一颗螺旋状尖牙，肆意欢快地钻入血肉。"
	icon_state = "drill_vic"
	inhand_icon_state = "drill_vic"
	hitsound = 'sound/effects/wounds/blood2.ogg'
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/scalpel/augment/vicissitude
	name = "手术刀爪"
	desc = "一片经过改造的指甲，能切出精细的切口。"
	icon_state = "scalpel_vic"
	inhand_icon_state = "scalpel_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/circular_saw/augment/vicissitude
	name = "环形锯颚"
	desc = "由牙齿组成的旋转圆盘，尖啸着咬穿血肉。"
	icon_state = "saw_vic"
	inhand_icon_state = "saw_vic"
	hitsound = 'sound/effects/wounds/blood2.ogg'
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/surgical_drapes/vicissitude
	name = "皮肤手术巾"
	desc = "一片展开的皮肤，渗出抗生素和消毒剂，为手术提供一个大致无菌的环境。"
	icon_state = "surgical_drapes_vic"
	inhand_icon_state = "drapes_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/bonesetter/augment/vicissitude
	name = "接骨附肢"
	desc = "一对用于接骨的有机钳肢。"
	icon_state = "bone setter_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/blood_filter/augment/vicissitude
	name = "过滤器官"
	desc = "一组能够安全过滤血液的特化器官。"
	icon_state = "bone-gel_vic"
	inhand_icon_state = "clamps_vic"
	lefthand_file = 'modular_darkpack/modules/powers/icons/righthand.dmi'
	righthand_file = 'modular_darkpack/modules/powers/icons/lefthand.dmi'
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'

/obj/item/healthanalyzer/vicissitude
	name = "突触触须"
	desc = "一组能迅速评估患者健康状况的感知触须。"
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "hivenode"
	scanpower = SCANPOWER_ADVANCED

/obj/item/shockpaddles/cyborg/vicissitude
	name = "电细胞簇"
	desc = "一簇发电细胞，能产生强烈电击，但充电时间太长，不适合用于战斗。"
	icon = 'modular_darkpack/modules/powers/icons/fleshcrafting_surgery_tools.dmi'
	icon_state = "shockpaddles0"
	inhand_icon_state = "syndiepaddles0"
	base_icon_state = "shockpaddles"
	req_defib = FALSE

/obj/item/shockpaddles/cyborg/vicissitude/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NEEDS_TWO_HANDS, "implant_requirement")
