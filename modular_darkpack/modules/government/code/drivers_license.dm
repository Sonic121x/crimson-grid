/obj/item/card/drivers_license
	name = "驾驶执照"
	desc = "允许持证人拥有和驾驶机动车辆的证件，也可作为有效身份证明。"
	icon = 'modular_darkpack/modules/government/icons/docs.dmi'
	icon_state = "drivers"
	worn_icon_state = ""
	slot_flags = NONE
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/government/icons/docsonfloor.dmi')
	/// Issuing state
	var/issuing_state = "California"
	/// Owner
	var/owner = ""
	/// If the ID is a counterfit.
	var/fake = FALSE
	/// If the NAME does not belong to the person.
	var/fake_identity = FALSE
	var/datum/storyteller_roll/investigation/examine_roll

/obj/item/card/drivers_license/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/user = null
	if(ishuman(loc)) // In pockets
		user = loc
	else if(ishuman(loc?.loc)) // In backpack
		user = loc.loc
	if(user)
		link_human(user)

/obj/item/card/drivers_license/proc/link_human(mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_ILLEGAL_IDENTITY))
		fake = TRUE
		fake_identity = TRUE

	if(fake_identity)
		owner = user.generate_random_mob_name(TRUE)
	else
		owner = user.real_name
	if(user.client?.prefs)
		var/pref_country = user.client.prefs.read_preference(/datum/preference/choiced/country_of_origin)
		if(pref_country == "United States")
			var/pref_state = user.client.prefs.read_preference(/datum/preference/choiced/state_of_origin)
			if(pref_state)
				issuing_state = pref_state

/obj/item/card/drivers_license/examine(mob/user)
	. = ..()
	if(!examine_roll)
		examine_roll = new()
		examine_roll.reroll_cooldown = 1 SCENES
	var/roll_result = examine_roll.st_roll(user, src); var/datum/preference/choiced/state_preference = GLOB.preference_entries[/datum/preference/choiced/state_of_origin]; var/list/state_names = state_preference.get_choices()
	if(owner)
		. += span_notice("证件上写着：持证人[owner]，签发地[state_names[issuing_state] ? state_names[issuing_state] : issuing_state]。")
		if(fake && (roll_result == ROLL_SUCCESS))
			. += span_notice("这看起来是一份粗制滥造的假证。")
