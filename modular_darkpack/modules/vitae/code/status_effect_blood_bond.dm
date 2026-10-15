/datum/status_effect/blood_bond
	id = "circulation"
	duration = INFINITY
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/blood_bond

/datum/status_effect/blood_bond/on_creation(mob/living/new_owner, mob/living/regnant)
	. = ..()
	if(.)
		linked_alert.desc = "你受到了[regnant.real_name]的血缚！"

/atom/movable/screen/alert/status_effect/blood_bond
	name = "血缚"
	desc = "你受到了血缚！"
	icon_state = "blood_bond"
	icon = 'modular_darkpack/modules/vitae/icons/blood_bond.dmi'
