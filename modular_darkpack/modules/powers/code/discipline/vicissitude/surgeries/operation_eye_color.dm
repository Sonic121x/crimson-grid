#define OPERATION_NEW_COLOR "chosen_color"

/datum/surgery_operation/organ/eye_color_surgery
	name = "角膜着色手术"
	desc = "改变患者的眼睛颜色。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	target_type = /obj/item/organ/eyes
	all_surgery_states_required = SURGERY_SKIN_OPEN
	any_surgery_states_blocked = SURGERY_VESSELS_UNCLAMPED
	required_organ_flag = NONE

/datum/surgery_operation/organ/eye_color_surgery/all_required_strings()
	return list("对眼睛进行手术（瞄准眼睛）") + ..()

/datum/surgery_operation/organ/eye_color_surgery/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/organ/eye_color_surgery/state_check(atom/movable/operating_on)
	return TRUE

/datum/surgery_operation/organ/eye_color_surgery/pre_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	operation_args[OPERATION_NEW_COLOR] = list()
	operation_args[OPERATION_NEW_COLOR] += tgui_color_picker(surgeon, "左眼", "角膜着色手术")
	operation_args[OPERATION_NEW_COLOR] += tgui_color_picker(surgeon, "右眼", "角膜着色手术")
	return !!operation_args[OPERATION_NEW_COLOR][1] || !!operation_args[OPERATION_NEW_COLOR][2]

/datum/surgery_operation/organ/eye_color_surgery/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	var/atom/movable/display_target = patient || operating_on
	display_results(
		surgeon,
		patient,
		span_notice("你开始改造[patient.name]的眼睛……"),
		span_notice("[surgeon]开始改造[patient.name]的眼睛。"),
		span_notice("[surgeon]开始在[patient.name]的[display_target]上切开一道口子。"),
	)
	display_pain(patient, "你感到脸上传来切割般的疼痛！")

/datum/surgery_operation/organ/eye_color_surgery/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/eye_color_left = operation_args[OPERATION_NEW_COLOR][1]
	var/eye_color_right = operation_args[OPERATION_NEW_COLOR][2]
	patient.set_eye_color(sanitize_hexcolor(eye_color_left), sanitize_hexcolor(eye_color_right))
	patient.dna.update_ui_block(/datum/dna_block/identity/eye_colors)
	patient.update_body()

	display_results(
		surgeon,
		patient,
		span_notice("你彻底改变了[patient.name]的眼睛。"),
		span_notice("[surgeon]彻底改变了[patient.name]的眼睛。"),
		span_notice("[surgeon]完成了对[patient.name]眼睛的手术。"),
	)
	display_pain(patient, "疼痛消退了，你的眼睛感觉焕然一新，却又十分陌生！")

/datum/surgery_operation/organ/eye_color_surgery/on_failure(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_warning("你操作失误，挫伤了[patient.name]的眼睛！"),
		span_warning("[surgeon]操作失误，挫伤了[patient.name]的眼睛！"),
		span_notice("[surgeon]完成了对[patient.name]眼睛的手术。"),
	)
	display_pain(patient, "你的眼睛仿佛被撕裂了！")
	ADD_TRAIT(patient, TRAIT_DISFIGURED, TRAIT_GENERIC)
	var/obj/item/organ/eyes/eyes = patient.get_organ_slot(ORGAN_SLOT_EYES)
	eyes.apply_organ_damage(1)

#undef OPERATION_NEW_COLOR

