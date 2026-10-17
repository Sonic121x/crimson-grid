/obj/item/dyespray
	name = "染发喷雾"
	desc = "将头发染成任意渐变色的喷雾。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/cosmetic.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	icon_state = "dyespray"

/obj/item/dyespray/attack_self(mob/user)
	dye(user, user)

/obj/item/dyespray/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	dye(target, user)
	return ..()

/**
 * Applies a gradient and a gradient color to a mob.
 *
 * Arguments:
 * * target - The mob who we will apply the gradient and gradient color to.
 */

/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/human_target = target
	var/list/dyables = list("头发", "胡须")
	for(var/obj/item/organ/organ as anything in human_target.organs)
		if(!istype(organ.bodypart_overlay, /datum/bodypart_overlay/mutant))
			continue
		var/datum/bodypart_overlay/mutant/overlay = organ.bodypart_overlay
		if(overlay.dyable && overlay.sprite_datum.color_src)
			dyables += list("外部身体部位")
			break
	var/obj/item/bodypart/head/head =  human_target.get_bodypart(BODY_ZONE_HEAD)
	if(!head || !(head.head_flags & HEAD_HAIR) || HAS_TRAIT(human_target, TRAIT_BALD))
		dyables -= "头发"
	if(!head || !(head.head_flags & HEAD_FACIAL_HAIR) || HAS_TRAIT(human_target, TRAIT_SHAVED))
		dyables -= "胡须"
	if(!length(dyables))
		if(target != user)
			to_chat(user, span_warning("[human_target]没有可以染色的部位。"))
		else
			to_chat(user, span_warning("你没有可以染色的部位。"))
		return
	var/what_to_dye = tgui_alert(user, "要给哪里染色？", "角色偏好", dyables)
	if(!what_to_dye || !user.can_perform_action(src, NEED_DEXTERITY))
		return

	if(what_to_dye == "外部身体部位")
		dye_organ(target, user)
		return

	var/list/choices = what_to_dye == "头发" ? SSaccessories.hair_gradients_list : SSaccessories.facial_hair_gradients_list
	var/new_grad_style = tgui_input_list(user, "选择染色图案", "角色偏好", choices)
	if(isnull(new_grad_style))
		return
	if(!user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/hair_key = what_to_dye == "头发" ? GRADIENT_HAIR_KEY : GRADIENT_FACIAL_HAIR_KEY
	var/new_grad_color = tgui_color_picker(user, "选择第二种毛发颜色：", "角色偏好", human_target.get_hair_gradient_color(hair_key))
	if(!new_grad_color || !user.can_perform_action(src, NEED_DEXTERITY) || !target.IsReachableBy(user))
		return

	to_chat(user, span_notice("你开始喷涂染发剂……"))
	if(!do_after(user, 3 SECONDS, target))
		return
	if(what_to_dye == "头发")
		human_target.set_hair_gradient_style(new_grad_style, update = FALSE)
		human_target.set_hair_gradient_color(new_grad_color, update = TRUE)
	else
		human_target.set_facial_hair_gradient_style(new_grad_style, update = FALSE)
		human_target.set_facial_hair_gradient_color(new_grad_color, update = TRUE)
	playsound(src, 'sound/effects/spray.ogg', 10, vary = TRUE)

/obj/item/dyespray/proc/dye_organ(mob/living/carbon/human/target, mob/user)
	var/list/dyables = list()
	var/list/choices = list()
	for(var/obj/item/organ/organ as anything in target.organs)
		if(!istype(organ.bodypart_overlay, /datum/bodypart_overlay/mutant))
			continue
		var/datum/bodypart_overlay/mutant/overlay = organ.bodypart_overlay
		if(overlay.dyable && overlay.sprite_datum.color_src)
			var/choice_name = full_capitalize(organ.name)
			dyables[choice_name] = organ
			choices += choice_name
	if(!length(choices))
		return
	var/what_to_dye = tgui_alert(user, "要给哪里染色？", "角色偏好", choices)
	if(!what_to_dye || !user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/obj/item/organ/selected = dyables[what_to_dye]
	if(QDELETED(selected) || !(selected in target.organs))
		return

	var/datum/bodypart_overlay/mutant/overlay = selected.bodypart_overlay
	if(overlay.dye_color)
		var/remove_dye = tgui_alert(user, "要移除[selected]的染色吗？", "角色偏好", list("是", "否"))
		if(isnull(remove_dye) || !user.can_perform_action(src, NEED_DEXTERITY))
			return
		if(QDELETED(selected) || !(selected in target.organs))
			return
		if(remove_dye == "是")
			overlay.set_dye_color(null, selected)
			return

	var/default_color = overlay.dye_color || overlay.draw_color
	var/new_color = tgui_color_picker(user, "选择[selected]的颜色：", "角色偏好", default_color)
	if(isnull(new_color) || new_color == default_color || !user.can_perform_action(src, NEED_DEXTERITY))
		return
	if(QDELETED(selected) || !(selected in target.organs))
		return
	if(!do_after(user, 4.5 SECONDS, target))
		return
	if(QDELETED(selected) || !(selected in target.organs))
		return
	overlay.set_dye_color(new_color, selected)
