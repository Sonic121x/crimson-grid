/datum/discipline/fortitude
	name = "Fortitude"
	desc = {"增强防护。
● 坚韧术 1：被动
●● 坚韧术 2：被动
●●● 坚韧术 3：被动
●●●● 坚韧术 4：被动
●●●●● 坚韧术 5：被动"}
	icon_state = "fortitude"
	power_type = /datum/discipline_power/fortitude

/datum/discipline_power/fortitude
	name = "Fortitude power name"
	desc = "Fortitude power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/fortitude_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/fortitude_deactivate.ogg'

//FORTITUDE 1
/datum/discipline_power/fortitude/one
	name = "坚韧术 1"
	desc = "让肌肉更加坚实，比健美运动员还要强健。"

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/one/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/fortitude/one)

/datum/discipline_power/fortitude/one/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/fortitude/one)

/datum/discipline_power/fortitude/one/post_gain()
	owner.st_add_stat_mod(STAT_STAMINA, 1, "Fortitude")

//FORTITUDE 2
/datum/discipline_power/fortitude/two
	name = "坚韧术 2"
	desc = "身如磐石，让一切都无法突破你的防护。"

	level = 2

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/two/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/fortitude/two)

/datum/discipline_power/fortitude/two/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/fortitude/two)

/datum/discipline_power/fortitude/two/post_gain()
	owner.st_add_stat_mod(STAT_STAMINA, 2, "Fortitude")

//FORTITUDE 3
/datum/discipline_power/fortitude/three
	name = "坚韧术 3"
	desc = "蔑视那些妄图杀死你的人，轻松承受猛烈的攻击。"

	level = 3

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/four,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/three/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/fortitude/three)

/datum/discipline_power/fortitude/three/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/fortitude/three)

/datum/discipline_power/fortitude/three/post_gain()
	owner.st_add_stat_mod(STAT_STAMINA, 3, "Fortitude")

//FORTITUDE 4
/datum/discipline_power/fortitude/four
	name = "坚韧术 4"
	desc = "身如钢铁，穿过火海也只留下轻微灼痕。"

	level = 4

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/five
	)

/datum/discipline_power/fortitude/four/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/fortitude/four)

/datum/discipline_power/fortitude/four/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/fortitude/four)

/datum/discipline_power/fortitude/four/post_gain()
	owner.st_add_stat_mod(STAT_STAMINA, 4, "Fortitude")

//FORTITUDE 5
/datum/discipline_power/fortitude/five
	name = "坚韧术 5"
	desc = "将坚韧提升至巅峰，从此无所畏惧。"

	level = 5

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/fortitude/one,
		/datum/discipline_power/fortitude/two,
		/datum/discipline_power/fortitude/three,
		/datum/discipline_power/fortitude/four
	)

/datum/discipline_power/fortitude/five/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/fortitude/five)

/datum/discipline_power/fortitude/five/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/fortitude/five)

/datum/discipline_power/fortitude/five/post_gain()
	owner.st_add_stat_mod(STAT_STAMINA, 5, "Fortitude")
