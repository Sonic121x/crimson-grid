/datum/preference/loadout
	savefile_key = "loadout_list"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_LOADOUT
	can_randomize = FALSE
	// Loadout preference is an assoc list [item_path] = [loadout item information list]
	//
	// it may look something like
	// - list(/obj/item/glasses = list())
	// or
	// - list(/obj/item/plush/lizard = list("name" = "Tests-The-Loadout", "color" = "#FF0000"))

// Loadouts are applied with job equip code.
/datum/preference/loadout/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

// Sanitize on load to ensure no invalid paths from older saves get in
/datum/preference/loadout/deserialize(input, datum/preferences/preferences)
	return sanitize_loadout_list(input, preferences.parent?.mob)

// Default value is null - the loadout list is a lazylist
/datum/preference/loadout/create_default_value(datum/preferences/preferences)
	return null

/datum/preference/loadout/is_valid(value)
	return isnull(value) || islist(value)

/**
 * Removes all invalid paths from loadout lists.
 * This is a general sanitization for preference loading.
 *
 * Returns a list, or null if empty
 */
/datum/preference/loadout/proc/sanitize_loadout_list(list/passed_list, mob/optional_loadout_owner) as /list
	var/list/sanitized_list
	for(var/path in passed_list)
		// Loading from json has each path in the list as a string that we need to convert back to typepath
		var/obj/item/real_path = istext(path) ? text2path(path) : path
		if(!ispath(real_path, /obj/item))
			if(optional_loadout_owner)
				to_chat(optional_loadout_owner, span_boldnotice("在你的角色初始装备中 \
					发现了无效的物品路径：[real_path || "空值"]。 \
					该物品已被移除、重命名或因其他原因无法找到。 \
					请检查初始装备设置。"))
			continue

		else if(!istype(GLOB.all_loadout_datums[real_path], /datum/loadout_item))
			if(optional_loadout_owner)
				to_chat(optional_loadout_owner, span_boldnotice("在你的角色初始装备中 \
					发现了无效的装备条目：[real_path || "空值"]。 \
					该物品已被移除、重命名或因其他原因无法找到。 \
					请检查初始装备设置。"))
			continue

		var/datum/loadout_item/loadout_item = GLOB.all_loadout_datums[real_path]
		if(loadout_item.is_disabled())
			continue // this just falls off silently

		// Set into sanitize list using converted path key
		var/list/data = passed_list[path]
		LAZYSET(sanitized_list, real_path, LAZYLISTDUPLICATE(data))

	return sanitized_list
