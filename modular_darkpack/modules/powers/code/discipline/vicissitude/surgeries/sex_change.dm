/datum/surgery_operation/limb/sex_change
	name = "性别重塑手术" //  someone come back and woke-ify this
	desc = "改变患者的性别。"
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	required_bodytype = ~BODYTYPE_ROBOTIC
	time = 20 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_VESSELS_CLAMPED|SURGERY_BONE_SAWED

/datum/surgery_operation/limb/sex_change/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/sex_change/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/sex_change/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("你开始重塑[patient]的身体……"),
		span_notice("[surgeon]开始以骇人的方式操弄[patient]的血肉！"),
		span_notice("[surgeon]开始以骇人的方式操弄[patient]的血肉！"),
	)
	display_pain(patient, "你感觉自己的血肉正在蠕动！")

/datum/surgery_operation/limb/sex_change/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/chosen_sex = tgui_input_list(surgeon, "选择性别。", "确认", list("男性", "女性", "复数称谓", "中性"))
	if(!chosen_sex)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	switch(chosen_sex)
		if("男性")
			patient.gender = MALE
		if("女性")
			patient.gender = FEMALE
		if("复数称谓")
			patient.gender = PLURAL
		if("中性")
			patient.gender = NEUTER
	to_chat(surgeon, span_notice("你完成了对[patient]性别的改变。"))
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	var/chosen_physique = tgui_input_list(surgeon, "也要改变体型吗？", "确认", list("男性体型", "女性体型"))
	if(!chosen_physique)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.physique = (chosen_physique == "男性体型") ? MALE : FEMALE
	patient.dna.update_ui_block(/datum/dna_block/identity/gender)
	patient.update_body(is_creating = TRUE) // or else physique won't change properly
	patient.update_appearance(UPDATE_OVERLAYS)
	patient.update_clothing(ITEM_SLOT_ICLOTHING) // update gender shaped clothing
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(surgeon, span_notice("你完成了对[patient]体型的改变。"))

	display_results(
		surgeon,
		patient,
		span_notice("你完成了对[patient]性别的重塑！"),
		span_notice("[surgeon]将[patient]重塑成了新的模样。"),
		span_notice("[surgeon]完成了对[patient]的手术。"))
	display_pain(patient, "疼痛消退了，你感觉焕然一新！")

/datum/surgery_operation/limb/sex_change/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("你操作失误，挫伤了[patient]！"),
		span_warning("[surgeon]操作失误，挫伤了[patient]！"),
		span_notice("[surgeon]完成了对[patient]的手术。"),
	)
	display_pain(patient, "你的胸口仿佛被撕裂了！")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)
