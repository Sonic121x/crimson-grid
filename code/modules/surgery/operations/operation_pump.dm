/datum/surgery_operation/organ/stomach_pump
	name = "洗胃"
	rnd_name = "洗胃术（清空胃部）"
	desc = "手动挤压患者的胃部，诱发呕吐并排出有害化学物质。"
	operation_flags = OPERATION_NOTABLE
	implements = list(
		IMPLEMENT_HAND = 1,
	)
	time = 2 SECONDS
	required_organ_flag = ORGAN_TYPE_FLAGS & ~ORGAN_ROBOTIC
	target_type = /obj/item/organ/stomach
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT

/datum/surgery_operation/organ/stomach_pump/get_default_radial_image()
	return image(/atom/movable/screen/alert/disgusted::overlay_icon, /atom/movable/screen/alert/disgusted::overlay_state)

/datum/surgery_operation/organ/stomach_pump/all_required_strings()
	return ..() + list("患者不能处于干瘪状态")

/datum/surgery_operation/organ/stomach_pump/state_check(obj/item/organ/stomach/organ)
	return !HAS_TRAIT(organ.owner, TRAIT_HUSK)

/datum/surgery_operation/organ/stomach_pump/on_preop(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("你开始为[organ.owner]洗胃……"),
		span_notice("[surgeon]开始为[organ.owner]洗胃。"),
		span_notice("[surgeon]开始按压[organ.owner]的腹部。"),
	)
	display_pain(organ.owner, "你的肚子里一阵可怕的翻腾！你快要吐了！")

/datum/surgery_operation/organ/stomach_pump/on_success(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_notice("[surgeon]让[organ.owner]吐了出来，清除了胃中的部分化学物质！"),
		span_notice("[surgeon]让[organ.owner]吐了出来，清除了胃中的部分化学物质！"),
		span_notice("[surgeon]让[organ.owner]吐了出来！"),
	)
	organ.owner.vomit((MOB_VOMIT_MESSAGE | MOB_VOMIT_STUN), lost_nutrition = 20, purge_ratio = 0.67)

/datum/surgery_operation/organ/stomach_pump/on_failure(obj/item/organ/stomach/organ, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		organ.owner,
		span_warning("You screw up, bruising [organ.owner]'s chest!"),
		span_warning("[surgeon] screws up, bruising [organ.owner]'s chest!"),
		span_warning("[surgeon] screws up!"),
	)
	organ.apply_organ_damage(5)
	organ.bodypart_owner.receive_damage(5)

/datum/surgery_operation/organ/stomach_pump/mechanic
	name = "purge nutrient processor"
	rnd_name = "Nutrient Processor Purge (Stomach Pump)"
	required_organ_flag = ORGAN_ROBOTIC
	operation_flags = parent_type::operation_flags | OPERATION_MECHANIC
