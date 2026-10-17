
/// Aquarium upgrades, can be applied to a basic aquarium to upgrade it into an advanced subtype.
/obj/item/aquarium_upgrade
	name = "鱼缸升级套件"
	desc = "一套升级组件。"

	icon = 'icons/obj/aquarium/supplies.dmi'
	icon_state = "construction_kit"
	/// What kind of aquarium can accept this upgrade. Strict type check, no subtypes.
	var/upgrade_from_type = /obj/structure/aquarium
	/// typepath of the new aquarium subtype created.
	var/upgrade_to_type = /obj/structure/aquarium

/obj/item/aquarium_upgrade/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(interacting_with, TRAIT_IS_AQUARIUM))
		return NONE
	if(upgrade_from_type != interacting_with.type)
		interacting_with.balloon_alert(user, "鱼缸类型不匹配！")
		return ITEM_INTERACT_BLOCKING
	interacting_with.balloon_alert(user, "正在升级……")
	if(!PERFORM_ALL_TESTS(aquarium_upgrade) && !do_after(user, 5 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING
	var/atom/movable/upgraded_aquarium = new upgrade_to_type(interacting_with.drop_location())
	//This should transfer all the fish, reagents and settings from the aquarium component
	interacting_with.TransferComponents(upgraded_aquarium)
	upgraded_aquarium.balloon_alert(user, "升级完成")
	qdel(src)
	qdel(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/aquarium_upgrade/bioelec_gen
	name = "鱼缸生物发电套件"
	desc = "使鱼缸能够利用发电鱼电能所需的全套组件。"
	icon_state = "bioelec_kit"
	upgrade_to_type = /obj/structure/aquarium/bioelec_gen
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT)

/obj/structure/aquarium/bioelec_gen
	name = "生物发电机"
	desc = "放大并收集发电鱼产生电能的非常规发电机。"

	icon_state = "bioelec_map"
	base_icon_state = "bioelec"

	default_beauty = 0

/obj/structure/aquarium/bioelec_gen/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_BIOELECTRIC_GENERATOR, INNATE_TRAIT)

/obj/structure/aquarium/bioelec_gen/zap_act(power, zap_flags)
	var/explosive = zap_flags & ZAP_MACHINE_EXPLOSIVE
	if(!explosive)
		return //immune to all other shocks to make sure power can be generated without breaking the generator itself
	return ..()

/obj/structure/aquarium/bioelec_gen/examine(mob/user)
	. = ..()
	. += span_boldwarning("警告！警告！警告！")
	. += span_warning("发电机将缸内鱼类的生物电势放大到了危险水平。")
	. += span_notice("需要特斯拉线圈收集放大后的电能……最好再用接地棒保护自己。")

/obj/item/aquarium_upgrade/bluespace_tank
	name = "蓝空间便携鱼缸套件"
	desc = "将便携鱼缸升级为无底手持鱼缸所需的组件。"
	icon_state = "bluespace_kit"
	upgrade_from_type = /obj/item/fish_tank
	upgrade_to_type = /obj/item/fish_tank/bluespace
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT)

/obj/item/fish_tank/bluespace
	name = "蓝空间便携鱼缸"
	desc = "将大型室内鱼缸的容量，压缩在一个手提袋大小的长方体中。"
	icon_state = "fish_tank_bluespace_map"
	base_icon_state = "fish_tank_bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	maximum_relative_size = INFINITY
	max_total_size = 2000
	slowdown_coeff = 0.15
	min_fluid_temp = MIN_AQUARIUM_TEMP
	max_fluid_temp = MAX_AQUARIUM_TEMP
	reagent_size = 6
