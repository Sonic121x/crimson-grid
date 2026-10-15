/obj/structure/lectern
	name = "讲台"
	desc = "要是有人朝你扔鞋，这东西会是个不错的掩体。"
	icon = 'modular_darkpack/modules/decor/icons/lectern.dmi'
	icon_state = "lectern"
	density = FALSE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER
	pass_flags_self = PASSSTRUCTURE | PASSTABLE | LETPASSTHROW

/obj/structure/lectern/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/soapbox)

/obj/structure/lectern/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(default_unfasten_wrench(user, tool))
		return ITEM_INTERACT_SUCCESS

/obj/structure/lectern/pulpit // TODO: make holy for baali repulsion
	name = "布道台"
	desc = "跟讲台差不多，只是更神圣。"
	icon_state = "pulpit"
