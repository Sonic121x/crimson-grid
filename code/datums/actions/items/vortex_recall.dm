/datum/action/item_action/vortex_recall
	name = "Vortex Recall"
	desc = "随时将自己及附近的人召回至已调谐的教皇信标。<br>若信标尚未分离，则将其拆下。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "vortex_recall"

/datum/action/item_action/vortex_recall/IsAvailable(feedback = FALSE)
	if(!istype(target, /obj/item/hierophant_club))
		return
	var/obj/item/hierophant_club/teleport_stick = target
	if(teleport_stick.teleporting)
		return FALSE
	if(teleport_stick.beacon && !check_teleport_valid(owner, get_turf(teleport_stick.beacon), TELEPORT_CHANNEL_FREE))
		return FALSE
	return ..()
