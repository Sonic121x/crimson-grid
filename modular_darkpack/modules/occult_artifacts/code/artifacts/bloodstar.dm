/obj/item/occult_artifact/vampire/bloodstar
	true_name = "血星"
	true_desc = "提高血能的使用效率。"
	icon_state = "bloodstar"
	research_value = 10

/obj/item/occult_artifact/vampire/bloodstar/grant_powers()
	. = ..()
	owner.blood_efficiency = 0.8

/obj/item/occult_artifact/vampire/bloodstar/ungrant_powers()
	. = ..()
	owner.blood_efficiency = 1
