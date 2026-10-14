/datum/discipline/celerity
	name = "Celerity"
	desc = {"提升你的速度。违反避世戒律。
● 迅捷术 1：被动
●● 迅捷术 2：被动
●●● 迅捷术 3：被动
●●●● 迅捷术 4：被动
●●●●● 迅捷术 5：被动"}
	icon_state = "celerity"
	power_type = /datum/discipline_power/celerity

/datum/discipline_power/celerity
	name = "Celerity power name"
	desc = "Celerity power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/celerity_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/celerity_deactivate.ogg'

/datum/discipline_power/celerity/proc/temporis_explode(datum/source, datum/discipline_power/power, atom/target)
	SIGNAL_HANDLER

	if (!istype(power, /datum/discipline_power/temporis/patience_of_the_norns) && !istype(power, /datum/discipline_power/temporis/clothos_gift))
		return

	to_chat(owner, span_userdanger("你试图施展时流术，但正在生效的迅捷术使你的时间场加速，彻底失去了控制！"))
	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/living/carbon/human, gib)), 3 SECONDS)

	return POWER_CANCEL_ACTIVATION

//CELERITY 1
/datum/discipline_power/celerity/one
	name = "迅捷术 1"
	desc = "提升速度，让一切都稍微轻松一些。"

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/one/activate()
	. = ..()

	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	owner.apply_status_effect(/datum/status_effect/celerity/one)

/datum/discipline_power/celerity/one/deactivate()
	. = ..()

	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.remove_status_effect(/datum/status_effect/celerity/one)

/datum/discipline_power/celerity/one/post_gain()
	owner.st_add_stat_mod(STAT_DEXTERITY, 1, "Celerity")

//CELERITY 2
/datum/discipline_power/celerity/two
	name = "迅捷术 2"
	desc = "显著提升速度，让反应更加敏捷。"

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/two/activate()
	. = ..()

	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	owner.apply_status_effect(/datum/status_effect/celerity/two)

/datum/discipline_power/celerity/two/deactivate()
	. = ..()

	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.remove_status_effect(/datum/status_effect/celerity/two)

/datum/discipline_power/celerity/two/post_gain()
	owner.st_add_stat_mod(STAT_DEXTERITY, 2, "Celerity")

//CELERITY 3
/datum/discipline_power/celerity/three
	name = "迅捷术 3"
	desc = "移动更快，反应更迅速。你的身体尽在掌控之中。"

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/four,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/three/activate()
	. = ..()

	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	owner.apply_status_effect(/datum/status_effect/celerity/three)

/datum/discipline_power/celerity/three/deactivate()
	. = ..()

	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.remove_status_effect(/datum/status_effect/celerity/three)

/datum/discipline_power/celerity/three/post_gain()
	owner.st_add_stat_mod(STAT_DEXTERITY, 3, "Celerity")

//CELERITY 4
/datum/discipline_power/celerity/four
	name = "迅捷术 4"
	desc = "突破人类极限，行动如同闪电。"

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/five
	)

/datum/discipline_power/celerity/four/activate()
	. = ..()

	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	owner.apply_status_effect(/datum/status_effect/celerity/four)

/datum/discipline_power/celerity/four/deactivate()
	. = ..()

	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.remove_status_effect(/datum/status_effect/celerity/four)

/datum/discipline_power/celerity/four/post_gain()
	owner.st_add_stat_mod(STAT_DEXTERITY, 4, "Celerity")

//CELERITY 5
/datum/discipline_power/celerity/five
	name = "迅捷术 5"
	desc = "你宛如一道光，飞驰于世间。"

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/celerity/one,
		/datum/discipline_power/celerity/two,
		/datum/discipline_power/celerity/three,
		/datum/discipline_power/celerity/four
	)

/datum/discipline_power/celerity/five/activate()
	. = ..()

	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(temporis_explode))
	owner.apply_status_effect(/datum/status_effect/celerity/five)

/datum/discipline_power/celerity/five/deactivate()
	. = ..()

	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)
	owner.remove_status_effect(/datum/status_effect/celerity/five)

/datum/discipline_power/celerity/five/post_gain()
	owner.st_add_stat_mod(STAT_DEXTERITY, 5, "Celerity")
