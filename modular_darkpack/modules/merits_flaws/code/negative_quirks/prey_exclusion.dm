// alot of these npcs, like 'bacotell' 'bubway' and 'endronsecurity_2' should probably not be available to be taken since they're so specialized.
GLOBAL_LIST_INIT(prey_exclusion_choice, list(
	"Middle-income" = /mob/living/carbon/human/npc/incel,
	"Police Officers" = /mob/living/carbon/human/npc/police,
	"Criminals" = /mob/living/carbon/human/npc/bandit,
	"High income" = /mob/living/carbon/human/npc/business,
	//"Strippers" = /mob/living/carbon/human/npc/stripper, i feel like strippers would be the most powergamed option, keeping it here but commented.
	"Homeless" = /mob/living/carbon/human/npc/hobo,
))

/datum/quirk/darkpack/prey_exclusion
	name = "Prey Exclusion"
	desc = "你拒绝捕食某类猎物。进入游戏时，你需要选择一种不能从其身上进食的 NPC 类型。梵卓不能选择此缺陷。"
	ttrpg_sources = list(/datum/source_book/vtm20 = 485)
	value = -1
	mob_trait = TRAIT_PREY_EXCLUSION
	gain_text = span_notice("你对进食对象的类型变得十分挑剔。")
	lose_text = span_notice("你不再在乎从谁身上进食。")
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_VENTRUE)
	icon = FA_ICON_FACE_FROWN
	failure_message = "你不再在乎从谁身上进食。"
	/// which type of prey the user selected
	var/prey_exclusion
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/prey_exclusion/add(client/client_source)
	prey_exclusion = GLOB.prey_exclusion_choice[client_source?.prefs.read_preference(/datum/preference/choiced/prey_exclusion)] || /mob/living/carbon/human/npc/hobo

/datum/quirk_constant_data/prey_exclusion
	associated_typepath = /datum/quirk/darkpack/prey_exclusion
	customization_options = list(/datum/preference/choiced/prey_exclusion)

/datum/preference/choiced/prey_exclusion
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "prey_exclusion"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/prey_exclusion/init_possible_values()
	return GLOB.prey_exclusion_choice

/datum/preference/choiced/prey_exclusion/create_default_value()
	return "Homeless"

/datum/preference/choiced/prey_exclusion/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return /datum/quirk/darkpack/prey_exclusion::name in preferences.all_quirks

/datum/preference/choiced/prey_exclusion/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/datum/quirk/darkpack/prey_exclusion/quirk = target.get_quirk(/datum/quirk/darkpack/prey_exclusion)
	if(!quirk)
		return
	quirk.prey_exclusion = GLOB.prey_exclusion_choice[value] || /mob/living/carbon/human/npc/hobo
