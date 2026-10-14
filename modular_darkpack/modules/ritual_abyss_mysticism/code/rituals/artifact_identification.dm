/obj/ritual_rune/abyss/identification
	name = "神秘物品鉴定"
	desc = "鉴定一件神秘物品。"
	icon_state = "rune4"
	word = "WUS'ZAT"
	cost = 1

/obj/ritual_rune/abyss/identification/complete()
	. = ..()
	for(var/obj/item/occult_artifact/VA in loc)
		var/mob/living/carbon/human/identifier = usr
		if(VA.identified)
			to_chat(identifier, span_warning("你已经鉴定过这件遗物。"))
			return
		VA.identify()
		qdel(src)
		return
