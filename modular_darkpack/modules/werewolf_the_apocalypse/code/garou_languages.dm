/datum/language_holder/garou //for homid and glabro
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
	)

/datum/language_holder/crinos
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)

/datum/language_holder/primal //for lupus and hispos form
	understood_languages = list(
		/datum/language/common = list(LANGUAGE_ATOM),
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
		/datum/language/garou_tongue = list(LANGUAGE_ATOM),
	)
	spoken_languages = list(
		/datum/language/primal_tongue = list(LANGUAGE_ATOM),
	)

/datum/language/garou_tongue
	name = "Garou Tongue"
	desc = "狼人能够学习并使用的语言，又称“高等语”，以喉音和多变的音调为特点。人类形态很难说出这种语言。"
	key = "w"
	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 40
	syllables = list(
		"to", "lo", "of", "li", "ka", "ha", "he", "ah", "ny", "ro",
		"li", "me", "ad", "he", "ah", "um", "co", "ga", "gar", "fa",
		"el", "ra", "ia", "of", "os", "ra", "ta", "na", "ga", "ho",
		"lu", "lu", "fe", "zi", "mo", "sha", "ru", "te", "vo", "ni",
		"xa", "jo", "da", "ku", "pe", "su", "yo", "ve", "mi", "ba"
	)
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_languages.dmi'
	icon_state = "garou"
	default_priority = 90

/datum/language/primal_tongue
	name = "Primal Tongue"
	desc = "所有出身的狼人都天生通晓的语言，仅能在野兽形态、战斗形态和巨兽形态下使用。"
	key = "p"
	flags = LANGUAGE_TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD
	space_chance = 40
	syllables = list (
		"gra", "grr", "gru", "gha", "sha", "zho", "yip", "whu", "zar", "ruk",
		"kra", "hya", "tza", "ska", "yrr", "fru", "thra", "hwo", "vra", "snar",
		"kru", "pha", "gha", "hro", "tzo", "wha", "brak", "thru", "chur", "dra",
		"vru", "sna", "yru", "hru", "yla", "fro", "rik", "zru", "skra", "zhu",
		"kro", "thro", "zyi", "sha", "hza", "mru", "wru", "bruk", "hka", "tza"
	)
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_languages.dmi'
	icon_state = "garou"
	default_priority = 90
