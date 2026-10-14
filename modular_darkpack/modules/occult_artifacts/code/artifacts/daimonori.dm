/obj/item/occult_artifact/vampire/daimonori
	true_name = "戴蒙诺里"
	true_desc = "提高血魔法造成的伤害。"
	icon_state = "daimonori"
	research_value = 20

/obj/item/occult_artifact/vampire/daimonori/grant_powers()
	. = ..()
	owner.thaum_damage_plus = 20

/obj/item/occult_artifact/vampire/daimonori/ungrant_powers()
	. = ..()
	owner.thaum_damage_plus = 0
