/obj/ritual_rune/thaumaturgy/identification
	name = "神秘遗物鉴定"
	desc = "鉴定一件神秘物品。"
	icon_state = "rune4"
	word = "IN'DAR"

/obj/ritual_rune/thaumaturgy/identification/complete()
	. = ..()
	for(var/obj/item/occult_artifact/VA in loc)
		var/mob/living/carbon/human/identifier = usr
		if(VA.identified)
			to_chat(identifier, span_warning("你已经鉴定过这件遗物。"))
			return
		VA.identify()
		identifier.research_points += VA.research_value
		qdel(src)
		return

