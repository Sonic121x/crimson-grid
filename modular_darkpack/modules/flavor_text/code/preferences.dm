///////////////////////////////////////////////////////////////////////////

/datum/preference/text/headshot
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "headshot"
	maximum_value_length = MAX_MESSAGE_LEN
	///How much time between the informational chat messages?
	var/cooldown_duration = 1 MINUTES
	///Handles the informational chat message timer.
	COOLDOWN_DECLARE(headshot_cooldown)
	///Assoc list of ckeys and their links, used to cut down on chat spam
	var/static/list/stored_links = list()
	var/static/link_regex = regex("files.catbox.moe|images2.imgbox.com|i.gyazo.com|postimages.org|i.postimg.cc|toyhou.se|filegarden.com|file.garden|file.house") // CRIMSON EDIT - added more sites
	var/static/list/valid_extensions = list("jpg", "png", "jpeg", "webp") // Regex works fine, if you know how it works // CRIMSON EDIT - added webp

/datum/preference/text/headshot/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target?.dna.features[EXAMINE_DNA_HEADSHOT] = value

/datum/preference/text/headshot/is_valid(value)
	if(!length(value))
		return TRUE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		to_chat(usr, span_warning("链接必须使用 https！"))
		return

	if(!findtext(value, "."))
		to_chat(usr, span_warning("无效的链接！"))
		return
	var/list/value_split = splittext(value, ".")

	// extension will always be the last entry
	var/extension = value_split[length(value_split)]
	if(!(LOWER_TEXT(extension) in valid_extensions))
		to_chat(usr, span_warning("图片必须使用以下扩展名之一：'[english_list(valid_extensions)]'"))
		return

	find_index = findtext(value, link_regex)
	if(find_index != 9)
		to_chat(usr, span_warning("图片必须托管在以下网站之一：'Gyazo (i.gyazo.com), Catbox (catbox.moe), Imgbox (images2.imgbox.com), Postimages (i.postimg.cc), toyhou.se, file.garden, file.house'"))// CRIMSON EDIT - added more hosts
		return

	if(stored_links[usr.ckey] && stored_links[usr.ckey][type] != value && COOLDOWN_FINISHED(src, headshot_cooldown))
		COOLDOWN_START(src, headshot_cooldown, cooldown_duration)
		to_chat(usr, span_notice("请使用不含成人内容的头肩肖像，以保持代入感，就像角色的证件照一样。另请注意：[span_bold("不要使用真人照片或不严肃的图片。")]"))
		to_chat(usr, span_notice("如果图片未在游戏中正常显示，请确认链接直接指向图片，且能在浏览器中正常打开。"))
		to_chat(usr, span_notice("图片会缩放至 250x250 像素，因此越接近正方形，显示效果越好。"))
		log_game("[usr] has set their Headshot image to '[value]'.")

	apply_headshot(value)
	return TRUE

/datum/preference/text/headshot/proc/apply_headshot(value)
	if(isnull(stored_links[usr?.ckey]))
		stored_links[usr?.ckey] = list()
	stored_links[usr?.ckey][type] = value
	return TRUE

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_FLAVOR_TEXT] = value


/datum/preference/text/war_form_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODYPARTS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "war_form_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	relevant_inherent_trait = TRAIT_FERA_FORMS
	must_have_relevant_trait = TRUE

/datum/preference/text/war_form_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_WAR_FORM_FLAVOR_TEXT] = value


/datum/preference/text/feral_form_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_BODYPARTS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "feral_form_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN
	relevant_inherent_trait = TRAIT_FERA_FORMS
	must_have_relevant_trait = TRUE

/datum/preference/text/feral_form_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_FERAL_FORM_FLAVOR_TEXT] = value

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/nsfw_flavor_text
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "nsfw_flavor_text"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/nsfw_flavor_text/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(CONFIG_GET(flag/nsfw_content))
		target.dna.features[EXAMINE_DNA_NSFW_FLAVOR_TEXT] = value

/datum/preference/text/nsfw_flavor_text/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	if(CONFIG_GET(flag/nsfw_content) && preferences.read_preference(/datum/preference/toggle/nsfw_content_pref))
		return TRUE

	return FALSE

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/character_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "character_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/character_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features[EXAMINE_DNA_CHARACTER_NOTES] = value

///////////////////////////////////////////////////////////////////////////

/datum/preference/text/ooc_notes
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ooc_notes"
	maximum_value_length = MAX_FLAVOR_LEN

/datum/preference/text/ooc_notes/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(CONFIG_GET(flag/nsfw_content))
		target.dna.features[EXAMINE_DNA_OOC_NOTES] = value

/datum/preference/text/ooc_notes/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	if(CONFIG_GET(flag/nsfw_content) && preferences.read_preference(/datum/preference/toggle/nsfw_content_pref))
		return TRUE

	return FALSE
