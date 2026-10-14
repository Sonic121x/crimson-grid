/datum/action/cooldown/power/gift/sense_magic
	name = "感知魔法"
	desc = {"狼人能感知神秘能量的脉动与流转，无论是狼人正义的天赋、
	法师傲慢的巫术、吸血鬼堕落的力量，甚至妖蛆爪牙的黑暗秘术。"}
	button_icon_state = "sense_magic"
	cooldown_time = DEFAULT_REROLL_COOLDOWN
	rank = 1
	/*
	/// List of old atoms we already rolled for.
	var/list/datum/weakref/old_attempts = list()
	*/

/datum/storyteller_roll/gift/sense_magic
	bumper_text = /datum/action/cooldown/power/gift/sense_magic::name
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION) // DARKPACK TODO - STAT_ENIGMA is not real yet.
	difficulty = 6
	numerical = TRUE
	// hide_result = TRUE

// Not crazy accurate is turns out trying to have a varible difficulty within a single roll makes me want to blow my head off.
// In theory each source should have a diffrent difficulty and success determine the distance PER FUCKING SOUCE. AGHHHHHHHHHH
/datum/action/cooldown/power/gift/sense_magic/Activate(atom/target)
	// Nested before activate to build list before we spawn our own magic after effect.
	var/list/magic_sources = list()
	for(var/atom/movable/nearby_atom in orange(owner, DEFAULT_SIGHT_DISTANCE))
		if(length(nearby_atom.get_magic_sources()))
			magic_sources += nearby_atom

	. = ..()

	/*
	for(var/datum/weakref/old_ref in old_attempts)
		var/atom/resolved = old_ref.resolve()
		if(!resolved)
			old_attempts -= old_ref
		else
			magic_sources -= resolved
	*/

	var/datum/storyteller_roll/gift/sense_magic/roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result <= 0)
		return

	var/list/extra_info = list()
	for(var/atom/magic_of_intrest in magic_sources)
		var/turf/current_turf = get_turf(magic_of_intrest)
		var/image/blip_image = image(icon = 'icons/effects/effects.dmi', icon_state = "purplesparkles", layer = HIGH_PIPE_LAYER, loc = current_turf)
		SET_PLANE(blip_image, GAME_PLANE, current_turf)
		if(istype(magic_of_intrest, /obj/effect/abstract/magic_after_effect))
			blip_image.alpha = blip_image.alpha/2
		current_turf.flick_overlay(blip_image, list(owner.client), 1 TURNS)

		var/list/object_info = magic_of_intrest.get_magic_sources()
		if(length(object_info))
			for(var/datum/magic_information/magic_information in object_info)
				if(roll_result >= 3)
					if(magic_information.magic_type)
						extra_info |= list(MAGIC_TYPE_BLOOD = "血魔法", MAGIC_TYPE_SPIRIT = "灵性魔法")[magic_information.magic_type] || magic_information.magic_type
				if(roll_result >= 4)
					if(magic_information.magic_subtype)
						extra_info |= list(MAGIC_SUBTYPE_BLOOD_TIME = "时间扭曲")[magic_information.magic_subtype] || magic_information.magic_subtype

	if(length(extra_info))
		to_chat(owner, span_notice("你感知到[jointext(extra_info, "、")]的痕迹。"))

	/*
	for(var/atom/magic_of_intrest in magic_sources)
		old_attempts += WEAKREF(magic_of_intrest)
	*/
