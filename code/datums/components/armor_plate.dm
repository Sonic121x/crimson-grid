/datum/component/armor_plate
	/// The current number of upgrades applied to the parent via this component.
	var/amount = 0
	/// The maximum number of upgarde items that can be applied. Once var/amount reaches this value, no more upgrades can be applied
	var/maxamount = 3
	/// The path for our upgrade item. Each one is expended to improve the parent's armor values.
	var/upgrade_item = /obj/item/stack/sheet/animalhide/goliath_hide
	/// The armor datum path for our upgrade values. This value is added per upgrade item applied
	var/datum/armor/armor_mod = /datum/armor/armor_plate
	/// The name of the upgrade item.
	var/upgrade_name
	/// Adds a prefix to the item, demonstrating that it is upgraded in some way.
	var/upgrade_prefix = "reinforced"
	/// Tracks whether or not we've received an upgrade or not.
	var/have_upgraded = FALSE
	/// Abstract armor equipment we're using to take up the slot and show up in the mech UI
	var/obj/item/mecha_parts/mecha_equipment/armor/armor_plate/plate_component = null

/datum/armor/armor_plate
	melee = 10

/datum/component/armor_plate/Initialize(maxamount, obj/item/upgrade_item, datum/armor/armor_mod, upgrade_prefix = "reinforced")
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(applyplate))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(dropplates))
	if(istype(parent, /obj/vehicle/sealed/mecha/ripley))
		RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(apply_mech_overlays))

	if(maxamount)
		src.maxamount = maxamount
	if(upgrade_item)
		src.upgrade_item = upgrade_item
	if(armor_mod)
		src.armor_mod = armor_mod
	if(upgrade_prefix)
		src.upgrade_prefix = upgrade_prefix
	var/obj/item/typecast = src.upgrade_item
	src.upgrade_name = initial(typecast.name)

/datum/component/armor_plate/Destroy(force)
	QDEL_NULL(plate_component)
	return ..()

/datum/component/armor_plate/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	//upgrade_item could also be typecast here instead
	if(ismecha(parent))
		if(amount)
			if(amount < maxamount)
				examine_list += span_notice("其护甲已用[amount]份[upgrade_name]加固。")
			else
				examine_list += span_notice("它披着完全由[upgrade_name]组成的骇人甲壳——驾驶员一定是位经验丰富的怪物猎人。")
		else
			examine_list += span_notice("它设有固定点，可绑上怪物皮革以增强防护。")
	else
		if(amount)
			examine_list += span_notice("已用[amount]/[maxamount]份[upgrade_name]加固。")
		else
			examine_list += span_notice("最多可用[maxamount]份[upgrade_name]加固。")

/datum/component/armor_plate/proc/applyplate(datum/source, obj/item/our_upgrade_item, mob/user, params)
	SIGNAL_HANDLER

	if(!istype(our_upgrade_item, upgrade_item))
		return

	if(amount >= maxamount)
		to_chat(user, span_warning("你无法再进一步强化[parent]了！"))
		return

	if(ismecha(parent) && !plate_component)
		var/obj/vehicle/sealed/mecha/as_mecha = parent
		if (LAZYLEN(as_mecha.equip_by_category[MECHA_ARMOR]) >= as_mecha.max_equip_by_category[MECHA_ARMOR])
			to_chat(user, span_warning("[as_mecha]没有可用的护甲槽位！"))
			return

	if(isstack(our_upgrade_item))
		our_upgrade_item.use(1)
	else
		if(length(our_upgrade_item.contents))
			to_chat(user, span_warning("[our_upgrade_item]里面还有东西，无法用于加固护甲！"))
			return
		qdel(our_upgrade_item)

	var/obj/target_for_upgrading = parent
	amount++
	target_for_upgrading.set_armor(target_for_upgrading.get_armor().add_other_armor(armor_mod))
	SEND_SIGNAL(target_for_upgrading, COMSIG_ARMOR_PLATED, amount, maxamount)

	if(!ismecha(target_for_upgrading))
		if(upgrade_prefix && !have_upgraded)
			target_for_upgrading.name = "[list("reinforced" = "加固的", "empowered" = "强化的")[upgrade_prefix] || upgrade_prefix][target_for_upgrading.name]"
			have_upgraded = TRUE
		to_chat(user, span_info("你加固了[target_for_upgrading]，提升了它抵御攻击的能力。"))
		return

	var/obj/vehicle/sealed/mecha/mecha_for_upgrading = target_for_upgrading
	mecha_for_upgrading.update_appearance()
	to_chat(user, span_info("你加固了[mecha_for_upgrading]，提升了它抵御攻击的能力。"))
	if (plate_component)
		return
	plate_component = new(mecha_for_upgrading)
	plate_component.name = our_upgrade_item.name
	plate_component.desc = our_upgrade_item.desc
	plate_component.icon = our_upgrade_item.icon
	plate_component.icon_state = our_upgrade_item.icon_state
	plate_component.attach(mecha_for_upgrading)

/datum/component/armor_plate/proc/dropplates(datum/source, force)
	SIGNAL_HANDLER

	if(ismecha(parent)) //items didn't drop the plates before and it causes erroneous behavior for the time being with collapsible helmets
		for(var/i in 1 to amount)
			new upgrade_item(get_turf(parent))

/datum/component/armor_plate/proc/apply_mech_overlays(obj/vehicle/sealed/mecha/mech, list/overlays)
	SIGNAL_HANDLER

	if(amount)
		var/overlay_string = "ripley-g"
		if(amount >= 3)
			overlay_string += "-full"
		if(!LAZYLEN(mech.occupants))
			overlay_string += "-open"
		overlays += overlay_string

/// Abstract armor module used just to occupy a slot and show up in the UI
/obj/item/mecha_parts/mecha_equipment/armor/armor_plate
	name = "护甲占位模块"
	desc = "如果你看到这条说明，请向开发人员报告！"
	detachable = FALSE
