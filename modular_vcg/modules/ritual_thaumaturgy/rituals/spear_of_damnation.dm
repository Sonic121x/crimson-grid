/obj/ritual_rune/thaumaturgy/spear_of_damnation
	name = "执掌诅咒之矛"
	desc = "此仪式追溯该隐的传说，将一件武器献祭给吸血鬼的嗜血天性。\
			武器造成的致命伤害有一半会转化为血点，补充持有者的血池。"
	icon_state = "rune9"
	// Whisper this because...we are saying it outloud as we engrave it I guess
	word = "#他说：‘你做了什么事呢？你兄弟的血有声音从地里向我哀告。’"
	level = 3
	cost = 3

/obj/ritual_rune/thaumaturgy/spear_of_damnation/complete()
	. = ..()

	var/obj/item/weapon

	for(var/obj/item/item in get_turf(src))
		if(!(item.get_sharpness() & SHARP_EDGED) && !(item.get_sharpness() & SHARP_POINTY))
			to_chat(last_activator, span_warning("这件物品必须足够锋利！"))
			break
		else
			weapon = item

	if(!weapon)
		to_chat(last_activator, span_warning("你需要一件可供附魔的物品！"))
		return

	if(!ritual_roll_datum)
		return

	// Amount of blood we can steal equals to success count + thaum discipline level
	var/blood_to_steal = last_sucess_amount + last_activator.get_discipline_dots(/datum/discipline/thaumaturgy)
	// Amount of BP harvested is proportional to half lethal damage done
	var/theft_per_hit = round(weapon.force / (2 LETHAL_TTRPG_DAMAGE), 0.1)

	weapon.AddComponent(/datum/component/blood_theft, blood_to_steal, theft_per_hit)
	to_chat(last_activator, span_notice("[weapon]总共能汲取[blood_to_steal]血点，每次命中汲取[theft_per_hit]血点！"))
	last_activator.visible_message(span_notice("[last_activator]在[weapon]上刻下了一些文字！"))

	qdel(src)

/**
 * Blood theft component
 *
 * Can be applied to any item, on hit takes target's blood points
 * and gives them to the user
 *
 */
/datum/component/blood_theft
	/// How many bloodpoints we have left to steal
	var/blood_to_steal
	/// Amount of BP stolen per hit
	var/theft_per_hit

/datum/component/blood_theft/Initialize(blood_to_steal, theft_per_hit)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.blood_to_steal = blood_to_steal
	src.theft_per_hit = theft_per_hit

	return ..()

/datum/component/blood_theft/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_successful_attack))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/blood_theft/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_ATTACK))

/datum/component/blood_theft/proc/on_examine(datum/source, mob/viewer, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_cult("你看到[parent]上刻着一些奇怪的文字……")

/// Signal handler for landing a hit on the target
/datum/component/blood_theft/proc/on_successful_attack(datum/source, mob/living/target, mob/user, list/modifiers)
	SIGNAL_HANDLER

	if(!isliving(target) || !isliving(user))
		return

	steal_blood(user, target)

/// Take BP from targets, appropriately adjust blood pools of both
/datum/component/blood_theft/proc/steal_blood(mob/living/thief, mob/living/target)
	// Make sure we can't steal more than we have left to
	var/bp_theft_amount = clamp(theft_per_hit, 0, blood_to_steal)

	if(get_kindred_splat(target) || get_ghoul_splat(target))
		var/blood_taken = clamp(bp_theft_amount, 0, target.bloodpool)
		target.adjust_blood_pool(-blood_taken)

		var/blood_gained = blood_taken * max(1, target.bloodquality-1)
		thief.adjust_blood_pool(blood_gained)

		blood_to_steal -= blood_taken
	else
		if(!target.bloodpool || !target.blood_volume)
			return

		var/blood_coefficient = (5 / target.bloodpool)

		var/blood_taken = clamp(bp_theft_amount, 0, target.bloodpool)
		target.blood_volume = max(0, (target.blood_volume - (blood_taken * (70 * blood_coefficient))))
		blood_to_steal -= blood_taken

		var/blood_gained = blood_taken * max(1, target.bloodquality - 1)
		target.adjust_blood_pool(-blood_gained)
		thief.adjust_blood_pool(blood_gained)

	// Remove our component once we run out of blood to steal
	if(blood_to_steal <= 0)
		qdel(src)
