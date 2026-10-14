/datum/status_effect/blood_of_potency
	id = "blood_of_potency"
	duration = 30 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/blood_of_potency
	var/stored_generation

/datum/status_effect/blood_of_potency/on_creation(mob/living/new_owner, generation, time)
	. = ..()
	if(time)
		duration = time
	stored_generation = owner.get_generation()
	get_kindred_splat(owner)?.set_generation(generation)

/datum/status_effect/blood_of_potency/on_remove()
	. = ..()

	//Can't do initial() due to it giving bad results.
	get_kindred_splat(owner)?.set_generation(stored_generation)
	stored_generation = null

	if(owner.bloodpool > owner.maxbloodpool)
		owner.set_blood_pool(owner.maxbloodpool)

/atom/movable/screen/alert/status_effect/blood_of_potency
	name = "强效之血"
	desc = "你能感觉到血液变得更强大了！"
	icon_state = "blooddrunk"
