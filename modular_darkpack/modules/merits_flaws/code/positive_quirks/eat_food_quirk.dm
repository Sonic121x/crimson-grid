/datum/quirk/darkpack/eat_food
	name = "Eat Food"
	desc = "与大多数不死者不同，你保留了正常进食和消化食物的能力，仿佛仍过着凡人的生活。虽然无法从中获得营养，但你吃东西时不会像其他血族那样感到恶心。请记住：吃下去的东西，迟早还是要吐出来。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 480)
	value = 1
	mob_trait = TRAIT_EAT_FOOD
	gain_text = span_notice("你的胃开始蠕动，仿佛这个器官活了过来。你现在可以进食了。")
	lose_text = span_notice("你失去了进食的能力。")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_UTENSILS

/datum/quirk/darkpack/eat_food/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	var/obj/item/organ/tongue/tongue = human_holder.get_organ_by_type(/obj/item/organ/tongue)
	tongue?.liked_foodtypes = initial(tongue.liked_foodtypes)
	tongue?.disliked_foodtypes = initial(tongue.disliked_foodtypes)
	tongue?.toxic_foodtypes = initial(tongue.toxic_foodtypes)
