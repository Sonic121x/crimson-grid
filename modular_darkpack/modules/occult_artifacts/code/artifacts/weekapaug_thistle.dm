/datum/armor/weekapaug_thistle
	melee = 10
	bullet = 10

/obj/item/occult_artifact/vampire/weekapaug_thistle
	true_name = "威卡帕格蓟"
	true_desc = "提高战斗防御能力。"
	icon_state = "w_thistle"
	research_value = 10

/obj/item/occult_artifact/vampire/weekapaug_thistle/grant_powers()
	. = ..()
	owner.add_inner_armor(/datum/armor/weekapaug_thistle)

/obj/item/occult_artifact/vampire/weekapaug_thistle/ungrant_powers()
	. = ..()
	owner.remove_inner_armor(/datum/armor/weekapaug_thistle)
