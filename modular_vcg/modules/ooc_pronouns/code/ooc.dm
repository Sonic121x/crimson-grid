#define MAX_PRONOUNS 5
// This list is non-exhaustive
GLOBAL_LIST_INIT(pronouns_valid, list(
	"he", "him", "his",
	"she","her","hers",
	"hyr", "hyrs",
	"they", "them", "their","theirs",
	"it", "its",
	"any", "all",
	"xey", "xe", "xem", "xyr", "xyrs",
	"ze", "zir", "zirs",
	"ey", "em", "eir", "eirs",
	"fae", "faer", "faers",
	"ve", "ver", "vis", "vers",
	"ne", "nem", "nir", "nirs"
))

// examples:
// "she/fae"
// "she/fae - small comment"
// "she/her/they - sysadmin"
// "they/ve - sysadmin"

// at least ONE is required
GLOBAL_LIST_INIT(pronouns_required, list(
	"he", "her", "she", "they", "them", "fae", "faer", "it", "its", "any", "all",
))

/datum/preference/text/ooc_pronouns
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "oocpronouns"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/text/ooc_pronouns/create_default_value()
	return ""

/datum/preference/text/ooc_pronouns/is_valid(value)
	value = LOWER_TEXT(value)

	if (!value || trim(value) == "")
		return TRUE

	var/regex/reg = regex(@"^[a-z/]+", "i")
	reg.Find(value)
	if (!length(reg.match))
		to_chat(usr, span_warning("未识别出代词。请仅使用英文字母，并以斜线（/）分隔各代词。"))
		return FALSE
	var/pronouns = splittext(reg.match, "/")
	if (length(pronouns) > MAX_PRONOUNS)
		to_chat(usr, span_warning("你最多只能设置[MAX_PRONOUNS]种不同的代词。"))
		return FALSE


	for (var/pronoun in pronouns)
		// while parsing, remove common suffixes

		if (endswith(pronoun, "s"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 1)
		if (endswith(pronoun, "self"))
			pronoun = copytext(pronoun, 1, length(pronoun) - 4)
		pronoun = trim(pronoun)

		if (!(pronoun in GLOB.pronouns_valid))
			to_chat(usr, span_warning("无效代词：[pronoun]。可用代词：[GLOB.pronouns_valid.Join(", ")]"))
			return FALSE

	if (length(pronouns) != length(unique_list(pronouns)))
		to_chat(usr, span_warning("同一个代词不能重复使用。"))
		return FALSE

	for (var/pronoun in GLOB.pronouns_required)
		if (pronoun in pronouns)
			return TRUE

	to_chat(usr, span_warning("请至少包含以下代词中的一种：[GLOB.pronouns_required.Join(", ")]"))
	// Someone may yell at me i dont know
	return FALSE

#undef MAX_PRONOUNS
