/obj/ritual_rune/abyss/pierce_the_veil
	name = "穿透帷幕"
	desc = "施行此仪式，在手中凝聚暗影球并凝视它们，使双眼化为深渊般的漆黑，赋予你暗视能力。"
	icon_state = "rune9"
	word = "暗影，笼罩我的视线。"
	cost = 1
	level = 1
	var/datum/action/innate/darkvision/darkvision_action

/obj/ritual_rune/abyss/pierce_the_veil/complete()
	. = ..()
	var/mob/living/carbon/human/H = last_activator
	to_chat(H, span_notice("黑暗涌入你的视野，随后退去——仪式成功了。"))
	darkvision_action = new(H)
	darkvision_action.Grant(H)
	qdel(src)

/datum/action/innate/darkvision
	name = "暗视"
	desc = "使双眼化为深渊般的漆黑，赋予你在黑暗中视物的能力。"
	button_icon = 'modular_darkpack/modules/ritual_abyss_mysticism/icons/pierce_the_veil.dmi'
	button_icon_state = "darkvision_off"

/datum/action/innate/darkvision/Activate()
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/eyes/owners_eyes = H.get_organ_by_type(/obj/item/organ/eyes)
	ADD_TRAIT(H, TRAIT_TRUE_NIGHT_VISION, type)
	ADD_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_EYES, type)
	ADD_TRAIT(H, TRAIT_ABYSSAL_EYES, type)
	owners_eyes?.refresh()
	H.add_eye_color(COLOR_BLACK, EYE_COLOR_DISC)
	active = TRUE
	button_icon_state = "darkvision_on"
	build_all_button_icons(force = TRUE)

/datum/action/innate/darkvision/Deactivate()
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/eyes/owners_eyes = H.get_organ_by_type(/obj/item/organ/eyes)
	REMOVE_TRAIT(H, TRAIT_TRUE_NIGHT_VISION, type)
	REMOVE_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_EYES, type)
	REMOVE_TRAIT(H, TRAIT_ABYSSAL_EYES, type)
	owners_eyes?.refresh()
	H.remove_eye_color(EYE_COLOR_DISC)
	active = FALSE
	button_icon_state = "darkvision_off"
	build_all_button_icons(force = TRUE)

/obj/ritual_rune/abyss/pierce_the_veil/ritual_failure()
	. = ..()
	to_chat(last_activator, span_warning("暗影从你的指缝间溜走……"))
	qdel(src)

/obj/ritual_rune/abyss/pierce_the_veil/ritual_botch()
	. = ..()
	var/mob/living/carbon/human/H = last_activator
	var/obj/item/organ/eyes/owners_eyes = H.get_organ_by_type(/obj/item/organ/eyes)
	ADD_TRAIT(H, TRAIT_TRUE_NIGHT_VISION, "pierce_the_veil_botch")
	ADD_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_EYES, "pierce_the_veil_botch")
	ADD_TRAIT(H, TRAIT_ABYSSAL_EYES, "pierce_the_veil_botch")
	owners_eyes?.refresh()
	H.add_eye_color(COLOR_BLACK, EYE_COLOR_DISC)
	to_chat(H, span_userdanger("仪式反噬了你！你的双眼化为墨黑的暗影深坑，目光穿透了黑暗。"))
	qdel(src)
