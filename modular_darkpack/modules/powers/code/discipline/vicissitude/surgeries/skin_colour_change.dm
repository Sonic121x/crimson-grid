/datum/surgery_operation/limb/modify_skin
	name = "皮肤着色手术"
	desc = "改变患者的肤色。"
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

/datum/surgery_operation/limb/modify_skin/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/modify_skin/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/modify_skin/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("你开始改变[patient]的肤色……"),
		span_notice("[surgeon]开始改变[patient]的肤色。"),
		span_notice("[surgeon]开始在[patient]身上切开一道口子。"),
	)
	display_pain(patient, "你感到身上传来切割般的疼痛！")

/datum/surgery_operation/limb/modify_skin/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/list/skin_tones = list()
	for(var/skin_tone in GLOB.skin_tone_names)
		var/skin_tone_name = GLOB.skin_tone_names[skin_tone]
		skin_tones[skin_tone_name] = skin_tone

	var/new_s_tone = tgui_input_list(surgeon, "选择肤色", "更改肤色", skin_tones)
	new_s_tone = skin_tones[new_s_tone]
	if(!new_s_tone)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.skin_tone = new_s_tone
	patient.dna.update_ui_block(/datum/dna_block/identity/skin_tone)
	patient.update_body(is_creating = TRUE)
	patient.update_appearance(UPDATE_OVERLAYS)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	display_results(
		surgeon,
		patient,
		span_notice("你彻底改变了[patient]的肤色。"),
		span_notice("[surgeon]改变了[patient]的肤色。"),
		span_notice("[surgeon]完成了对[patient]皮肤的手术。"),
	)
	display_pain(patient, "疼痛消退了，世界似乎变得不同了！")

/datum/surgery_operation/limb/modify_skin/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("你操作失误，挫伤了[patient]的皮肤！"),
		span_warning("[surgeon]操作失误，挫伤了[patient]的皮肤！"),
		span_notice("[surgeon]完成了对[patient]皮肤的手术。"),
	)
	display_pain(patient, "你的身体仿佛被撕裂了！")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)
