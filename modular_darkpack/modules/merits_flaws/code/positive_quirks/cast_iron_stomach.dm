/datum/quirk/darkpack/cast_iron_stomach
	name = "Cast-Iron Stomach"
	desc = {"只要稍微像是食物的东西，你都吃得下，
			还能从中获得营养。腐肉、稻草、骨头，统统都是晚餐。
			至于气味嘛，习惯就好…… "}
	value = 1
	icon = FA_ICON_FACE_GRIN_BEAM_SWEAT
	gain_text = span_notice("你觉得自己什么都吃得下！")
	lose_text = span_danger("看着地上的食物，你有点反胃。")
	forbidden_splats = list(SPLAT_KINDRED)
	ttrpg_sources = list(/datum/source_book/mta20/bos = 36)

/datum/quirk/darkpack/cast_iron_stomach/add(client/client_source)
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = CLOTH

/datum/quirk/darkpack/cast_iron_stomach/remove()
	var/obj/item/organ/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(!tongue)
		return
	tongue.disliked_foodtypes = initial(tongue.disliked_foodtypes)
