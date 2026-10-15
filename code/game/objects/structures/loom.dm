///This is a loom. It's usually made out of wood and used to weave fabric like durathread or cotton into their respective cloth types.
/obj/structure/loom
	name = "织布机"
	desc = "将纤维编织成布匹等可用织物的简单装置。"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "loom"
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)

/obj/structure/loom/Initialize(mapload)
	. = ..()

	var/static/list/hovering_item_typechecks = list(
		/obj/item/stack/sheet/cotton = list(
			SCREENTIP_CONTEXT_LMB = "织布",
		),
	)

	AddElement(/datum/element/contextual_screentip_item_typechecks, hovering_item_typechecks)

/obj/structure/loom/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 0.5 SECONDS)
	return ITEM_INTERACT_SUCCESS
