/datum/discipline/potence
	name = "Potence"
	desc = {"提升近战与徒手攻击的伤害。
● 巨力术 1：被动
●● 巨力术 2：被动
●●● 巨力术 3：被动
●●●● 巨力术 4：被动
●●●●● 巨力术 5：被动"}
	icon_state = "potence"
	power_type = /datum/discipline_power/potence

/datum/discipline_power/potence
	name = "Potence power name"
	desc = "Potence power description"
	abstract_type = /datum/discipline_power/potence

	activate_sound = 'modular_darkpack/modules/powers/sounds/potence_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg'

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 1 TURNS

/datum/discipline_power/potence/post_gain()
	owner.st_add_stat_mod(STAT_STRENGTH, level, "Potence")

/datum/discipline_power/potence/post_loss()
	owner.st_remove_stat_mod(STAT_STRENGTH, "Potence")

/datum/discipline_power/potence/activate()
	. = ..()

	if(level <= 5)
		var/max_level = min(discipline.level, 5)
		owner.apply_status_effect(/datum/status_effect/potence, max_level)

/datum/discipline_power/potence/deactivate()
	. = ..()
	if(level <= 5)
		owner.remove_status_effect(/datum/status_effect/potence)


//POTENCE 1
/datum/discipline_power/potence/one
	name = "巨力术 1"
	desc = "强化肌肉，每次出手都力道十足。"

	level = 1

	grouped_powers = list(
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 2
/datum/discipline_power/potence/two
	name = "巨力术 2"
	desc = "获得超越肌肉极限的力量，摧毁挡路的人与物。"

	level = 2

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 3
/datum/discipline_power/potence/three
	name = "巨力术 3"
	desc = "化身毁灭之力，举起不可撼动之物，击碎坚不可摧之物。"

	level = 3

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 4
/datum/discipline_power/potence/four
	name = "巨力术 4"
	desc = "只要血粹尚未耗尽，你就是一台永不停歇的机器。"

	level = 4

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/five
	)


//POTENCE 5
/datum/discipline_power/potence/five
	name = "巨力术 5"
	desc = "若向世人展示这股力量，他们或许会奉你为神。"

	level = 5

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four
	)
