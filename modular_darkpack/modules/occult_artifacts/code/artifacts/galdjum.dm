/obj/item/occult_artifact/vampire/galdjum
	true_name = "加尔朱姆"
	true_desc = "延长律能的持续时间。"
	icon_state = "galdjum"
	research_value = 10

/obj/item/occult_artifact/vampire/galdjum/grant_powers()
	. = ..()
	owner.discipline_time_plus = 25

/obj/item/occult_artifact/vampire/galdjum/ungrant_powers()
	. = ..()
	owner.discipline_time_plus = 0
