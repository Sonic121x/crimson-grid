// DARKPACK TODO - This should include clans.

/datum/preference/choiced/subsplat/compile_constant_data()
	var/list/data = ..()
	var/list/display_names = list()
	var/list/choices = get_choices()
	for(var/choice in choices)
		display_names[choice] = FERA_DISPLAY_NAME(choice)
	data[CHOICED_PREFERENCE_DISPLAY_NAMES] = display_names
	data["name"] = main_feature_name
	return data
/datum/subsplat
	abstract_type = /datum/subsplat

	/// Name of the splat
	var/name
	/// Description of what the splat is and what it does
	var/desc
	/// If set, the roleplay level that is displayed in preferences as a guide to players.
	var/roleplay_level
	/// ID for trait sources and whatnot
	var/id

	/// List of traits that are applied to members of this subsplat
	var/list/subsplat_traits = list()

	/// Typepath of keys for this subsplats's exclusive hideout
	var/obj/item/vamp/keys/subsplat_keys
	/// If we check the list of ids of city doors before granting the subsplat key
	var/check_doors_for_keys = TRUE

/datum/subsplat/proc/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	SHOULD_CALL_PARENT(TRUE)

	// Applies on_join_round effects when a client logs into this mob
	if(joining_round)
		RegisterSignal(gaining_mob, COMSIG_MOB_LOGIN, PROC_REF(on_join_round))
		RegisterSignal(gaining_mob, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED, PROC_REF(apply_after_setup))

	// Add unique subsplat features as traits
	for (var/trait in subsplat_traits)
		ADD_TRAIT(gaining_mob, trait, SUBSPLAT_TRAIT)

/**
 * Undoes the effects of on_gain more or less
 * remove the effects of gaining the subsplat.
 *
 * Arguments:
 * * losing_mob - Human losing the subsplat.
 */
/datum/subsplat/proc/on_lose(mob/living/carbon/human/losing_mob)
	SHOULD_CALL_PARENT(TRUE)
	UnregisterSignal(losing_mob, list(COMSIG_MOB_LOGIN, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED))

	// Remove unique subsplat feature traits
	for (var/trait in subsplat_traits)
		REMOVE_TRAIT(losing_mob, trait, SUBSPLAT_TRAIT)

	return


/**
 * Applies subsplat-specific effects when the
 * mob that has the subsplat logs into their mob
 * at roundstart. Anything that's not innate
 * to the subsplat and more part of its social
 * structure or whatnot should go in here.
 * Will give them their subsplat keys by
 * default.
 *
 * Arguments:
 * * joining - Human with this subsplat joining the round.
 */
/datum/subsplat/proc/on_join_round(mob/living/carbon/human/joining)
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)

	if(subsplat_keys && check_doors_for_keys && key_has_matching_door(subsplat_keys))
		joining.put_in_r_hand(new subsplat_keys(joining))

	UnregisterSignal(joining, COMSIG_MOB_LOGIN)

/**
 * Applies anything that should only be applied when joining the round through late-start or round-start
 * This exludes spawning as a ghost and other such sources. This is for stuff like outfits or teleporting players to locations.
 *
 * Arguments:
 * * source - Human with this subsplat joining the round.
 */
/datum/subsplat/proc/apply_after_setup(mob/living/carbon/human/source)
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)

	UnregisterSignal(source, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)

/// Displays description and roleplay level of the subsplat.
/datum/subsplat/proc/show_lore(mob/user)
	if(desc)
		to_chat(user, span_notice("[istype(src, /datum/subsplat/vampire_clan) ? CLAN_DISPLAY_NAME(name) : FERA_DISPLAY_NAME(name)]<br>[desc]"))
	if(roleplay_level)
		to_chat(user, span_notice("<br>扮演难度：[list("Beginner Friendly" = "新手友好", "Intermediate" = "中等", "Advanced" = "进阶")[roleplay_level] || roleplay_level]<br>扮演难度表示塑造此类角色所需的经验，分为：新手友好、中等、进阶。"))
