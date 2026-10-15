/obj/structure/sign/flag
	name = "空白旗帜"
	desc = "什么都不代表的旗帜，上面什么也没有。真壮观。"
	custom_materials = null
	buildable_sign = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user]拿起并折好了[src.name]。"), span_notice("你拿起并折好了[src.name]。"))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
		qdel(src)


/obj/item/sign/flag
	name = "折叠的空白旗帜"
	desc = "折叠起来的空白旗帜，上面什么也没有。真漂亮。"
	icon_state = "folded_coder"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'
	custom_materials = null
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

// Subtypes

/obj/structure/sign/flag/usa
	name = "美国国旗"
	desc = "美利坚合众国的旗帜。我们信仰上帝！"
	icon_state = "flag_usa"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/california
	name = "加利福尼亚州旗"
	desc = "伟大的加利福尼亚州的旗帜。我发现了！"
	icon_state = "flag_california"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/california, 32)

/obj/structure/sign/flag/california/rare
	var/always = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/califorina/rare, 32)

/obj/structure/sign/flag/california/rare/Initialize(mapload)
	. = ..()
	if(prob(1) || always)
		name = "新加利福尼亚旗帜"
		desc = "伟大的……州的旗帜。它一直都长这样吗？"
		icon_state = "flag_california_rare"

/obj/structure/sign/flag/britain
	name = "英国国旗"
	desc = "大不列颠及北爱尔兰联合王国的旗帜。天佑我权！"
	icon_state = "flag_britain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/britain, 32)

/obj/structure/sign/flag/france
	name = "法国国旗"
	desc = "法兰西共和国的旗帜。自由、平等、博爱！"
	icon_state = "flag_france"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/france, 32)

/obj/structure/sign/flag/germany
	name = "德国国旗"
	desc = "德意志联邦共和国的旗帜。"
	icon_state = "flag_germany"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/germany, 32)

/obj/structure/sign/flag/spain
	name = "西班牙国旗"
	desc = "西班牙王国的旗帜。不断超越！"
	icon_state = "flag_spain"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/spain, 32)

/obj/structure/sign/flag/italy
	name = "意大利国旗"
	desc = "意大利共和国的旗帜。"
	icon_state = "flag_italy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/italy, 32)

/obj/structure/sign/flag/vatican
	name = "梵蒂冈旗帜"
	desc = "梵蒂冈城国的旗帜。"
	icon_state = "flag_vatican"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/vatican, 32)

/obj/structure/sign/flag/russia
	name = "俄罗斯国旗"
	desc = "俄罗斯联邦的旗帜。"
	icon_state = "flag_russia"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/russia, 32)

/obj/structure/sign/flag/soviet
	name = "苏联国旗"
	desc = "苏维埃社会主义共和国联盟的旗帜。全世界无产者，联合起来！"
	icon_state = "flag_soviet"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/soviet, 32)

/obj/structure/sign/flag/china
	name = "中国国旗"
	desc = "中华人民共和国的旗帜。"
	icon_state = "flag_china"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/china, 32)

/obj/structure/sign/flag/taiwan
	name = "台湾旗帜"
	desc = "中华民国的旗帜。"
	icon_state = "flag_taiwan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/taiwan, 32)

/obj/structure/sign/flag/japan
	name = "日本国旗"
	desc = "日本国的旗帜。"
	icon_state = "flag_japan"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/japan, 32)

/obj/structure/sign/flag/anarchy
	name = "无政府主义旗帜"
	desc = "无政府主义运动的旗帜。"
	icon_state = "flag_anarchy"
	icon = 'modular_darkpack/modules/flags/icons/flags.dmi'

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/anarchy, 32)
