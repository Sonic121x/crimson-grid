/datum/surgery_operation/limb/height_change
	name = "身高调整手术"
	desc = "改变患者的身高。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_VESSELS_CLAMPED|SURGERY_BONE_SAWED

/datum/surgery_operation/limb/height_change/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/height_change/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/height_change/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("你开始改变[patient]的身高……"),
		span_notice("[surgeon]开始改变[patient]的身高。"),
		span_notice("[surgeon]开始在[patient]背部切开一道口子。"),
	)
	display_pain(patient, "你感到背部传来切割般的疼痛！")

/datum/surgery_operation/limb/height_change/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/list/heights = list(
		"很高" = HUMAN_HEIGHT_TALLER,
		"高" = HUMAN_HEIGHT_TALL,
		"中等" = HUMAN_HEIGHT_MEDIUM,
		"矮" = HUMAN_HEIGHT_SHORT,
		"很矮" = HUMAN_HEIGHT_SHORTEST,
		)

	var/new_height = tgui_input_list(surgeon, "选择身高", "更改身高", heights)
	new_height = heights[new_height]
	if(!new_height)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_mob_height(new_height)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	display_results(
		surgeon,
		patient,
		span_notice("你彻底改变了[patient]的脊柱。"),
		span_notice("[surgeon]彻底改变了[patient]的脊柱。"),
		span_notice("[surgeon]完成了对[patient]脊柱的手术。"),
	)
	display_pain(patient, "疼痛消退了，世界似乎变得不同了！")

/datum/surgery_operation/limb/height_change/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("你操作失误，挫伤了[patient]的脊柱！"),
		span_warning("[surgeon]操作失误，挫伤了[patient]的脊柱！"),
		span_notice("[surgeon]完成了对[patient]脊柱的手术。"),
	)
	display_pain(patient, "你的背部仿佛被撕裂了！")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)
