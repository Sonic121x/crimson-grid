/datum/action/change_pointer_color/get_display_name(action_name = name)
	return "更改指示箭头颜色"
/datum/action/cooldown/fishing_tip/get_display_name(action_name = name)
	return "钓鱼小贴士"
/obj/item/skillchip/big_pointer
	name = "号令技能芯片"
	desc = "一枚介绍历代领袖指点江山技巧的生物芯片，让你像真正的老板那样发号施令。"
	skill_name = "强化指点"
	skill_description = "学会用更引人注目的方式指向物体。"
	skill_icon = FA_ICON_ARROW_DOWN
	activate_message = span_notice("摘自《有志领袖肢体语言权威大全》第164页第3段……")
	deactivate_message = span_notice("所以，呃，那个，指东西该怎么做来着？")

	actions_types = list(/datum/action/change_pointer_color)

/obj/item/skillchip/big_pointer/on_activate(mob/living/carbon/user, silent=FALSE)
	. = ..()
	RegisterSignal(user, COMSIG_MOVABLE_POINTED, PROC_REF(fancier_pointer))

/obj/item/skillchip/big_pointer/on_deactivate(mob/living/carbon/user, silent=FALSE)
	UnregisterSignal(user, COMSIG_MOVABLE_POINTED)
	var/datum/action/change_pointer_color/action = locate() in actions
	action?.arrow_color = null
	action?.arrow_overlay = null
	return ..()

/obj/item/skillchip/big_pointer/proc/fancier_pointer(mob/living/user, atom/pointed, obj/effect/temp_visual/point/point)
	SIGNAL_HANDLER
	if(HAS_TRAIT(user, TRAIT_UNKNOWN_APPEARANCE))
		return
	point.cut_overlays()
	var/datum/action/change_pointer_color/action = locate() in actions
	if(!action.arrow_color)
		point.icon_state = "arrow_large"
		return
	point.icon_state = "arrow_large_white"
	point.color = action.arrow_color
	var/mutable_appearance/highlight = mutable_appearance(point.icon, "arrow_large_white_highlights", appearance_flags = RESET_COLOR)
	point.add_overlay(highlight)

/datum/action/change_pointer_color
	name = "Change Pointer Color"
	desc = "设置指示箭头的自定义颜色，或恢复默认颜色。"
	button_icon = /obj/effect/temp_visual/point::icon
	button_icon_state = "arrow_large_still"
	check_flags = AB_CHECK_CONSCIOUS
	///the color of our arrow
	var/arrow_color
	///the arrow overlay shown on the button
	var/mutable_appearance/arrow_overlay

/datum/action/change_pointer_color/Destroy()
	. = ..()
	arrow_overlay = null

/datum/action/change_pointer_color/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/mob/user = owner
	if(!arrow_color)
		pick_color(user)
		return
	var/choice = tgui_alert(owner, "重置还是更改指示箭头颜色？","指示箭头颜色", list("重置","更改"))
	if(user != owner || !choice || !IsAvailable(feedback = TRUE))
		return
	if(choice == "更改")
		pick_color(user)
	else
		arrow_color = null
		owner.balloon_alert(owner, "指示箭头已重置")
		build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/proc/pick_color(mob/user)
	var/ncolor = tgui_color_picker(owner, "选择新颜色", "指示箭头颜色", arrow_color)
	if(user != owner || !IsAvailable(feedback = TRUE))
		return
	arrow_color = ncolor
	owner.balloon_alert(owner, "指示箭头已更改")
	build_all_button_icons(update_flags = UPDATE_BUTTON_ICON, force = TRUE)

/datum/action/change_pointer_color/apply_button_icon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	var/initial_icon = /obj/effect/temp_visual/point::icon
	current_button.cut_overlay(arrow_overlay)
	if(!arrow_color)
		current_button.icon = initial_icon
		current_button.icon_state = /obj/effect/temp_visual/point::icon_state
		return ..()

	current_button.icon = current_button.icon_state = null
	arrow_overlay = mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still")
	arrow_overlay.color = arrow_color
	arrow_overlay.overlays += mutable_appearance(icon = initial_icon, icon_state = "arrow_large_white_still_highlights", appearance_flags = RESET_COLOR)
	current_button.add_overlay(arrow_overlay)
