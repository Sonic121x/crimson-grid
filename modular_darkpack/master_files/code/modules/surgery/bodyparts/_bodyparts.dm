/obj/item/bodypart
	///The current amount of aggravated damage the limb has
	var/aggravated_dam = 0
	/// Aggravated damage gets multiplied by this on receive_damage()
	var/aggravated_modifier = 1

	var/light_aggravated_msg = "有瘀伤，感觉麻木"
	var/medium_aggravated_msg = "血肉撕裂"
	var/heavy_aggravated_msg = "仿佛随时会碎裂脱落"

	/// Stores a weakref for the last owner assigned to the limb. NOT cleared when being dropped from the limb.
	var/datum/weakref/last_owner


/obj/item/bodypart/apply_ownership(mob/living/carbon/new_owner)
	. = ..()
	last_owner = WEAKREF(new_owner)
