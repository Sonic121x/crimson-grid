/datum/surgery_operation/limb/modify_hair
	name = "毛发着色手术"
	desc = "改变患者的头发颜色。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_VESSELS_CLAMPED

/datum/surgery_operation/limb/modify_hair/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/modify_hair/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_HEAD

/datum/surgery_operation/limb/modify_hair/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("你开始改造[patient]的头发……"),
		span_notice("[surgeon]开始改造[patient]的头发。"),
		span_notice("[surgeon]开始在[patient]头部切开一道口子。"),
	)
	display_pain(patient, "你感到头部传来切割般的疼痛！")

/datum/surgery_operation/limb/modify_hair/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/new_style = localized_accessory_input(surgeon, "选择发型", "仪容修整", SSaccessories.hairstyles_list)
	if(!new_style)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_hairstyle(new_style, update = TRUE)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(surgeon, span_notice("你完成了对[patient]发型的改变。"))

	display_results(
		surgeon,
		patient,
		span_notice("你改变了[patient]的发型。"),
		span_notice("[surgeon]改变了[patient]的发型。"),
		span_notice("[surgeon]完成了对[patient]头发的手术。"),
	)
	display_pain(patient, "疼痛消退了！")

	var/new_hair_color = tgui_color_picker(surgeon, "选择发色", "头发颜色", patient.hair_color)
	if(!new_hair_color)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_haircolor(sanitize_hexcolor(new_hair_color))
	patient.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	display_results(
		surgeon,
		patient,
		span_notice("你改变了[patient]的发色。"),
		span_notice("[surgeon]改变了[patient]的发色。"),
		span_notice("[surgeon]完成了对[patient]头发的手术。"),
	)
	display_pain(patient, "疼痛再次消退了！")

/datum/surgery_operation/limb/modify_hair/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("你操作失误，挫伤了[patient]的头部！"),
		span_warning("[surgeon]操作失误，挫伤了[patient]的头部！"),
		span_notice("[surgeon]完成了对[patient]头部的手术。"),
	)
	display_pain(patient, "你的头部仿佛被撕裂了！")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)
