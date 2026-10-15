/datum/quirk/darkpack/time_sense
	name = "Time Sense"
	desc = {"你天生具有时间感，无需手表或其他机械装置，就能准确估计时间的流逝，
		即使长时间失去意识也不例外。这还让你能够知道当前月相等信息。"}
	ttrpg_sources = list(
		/datum/source_book/wta20 = 475,
		/datum/source_book/vtm20 = 484,
		/datum/source_book/htr3/pg = 111,
		)
	value = 1
	mob_trait = TRAIT_TIME_SENSE
	icon = FA_ICON_STOPWATCH

	excluded_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH)

/mob/proc/get_time_status()
	. = list()
	. += "本地城市时间：[SSticker.round_start_timeofday ? "[server_timestamp("hh:mm", ic_time = TRUE, twelve_hour_clock = client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))] [server_timestamp("YYYY年MM月", ic_time = TRUE)]" : "本轮尚未开始！"]"

/mob/living/get_time_status()
	. = list()
	if(HAS_TRAIT(src, TRAIT_TIME_SENSE))
		. += "本地城市时间：[server_timestamp("hh:mm", ic_time = TRUE, twelve_hour_clock = client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))] [server_timestamp("YYYY年MM月", ic_time = TRUE)]"
		. += "月相：[list(MOON_NEW = "新月", MOON_WAXING_CRESENT = "盈眉月", MOON_FIRST_QUARTER = "上弦月", MOON_WAXING_GIBBOUS = "盈凸月", MOON_FULL = "满月", MOON_WANING_GIBBOUS = "亏凸月", MOON_LAST_QUARTER = "下弦月", MOON_WANING_CRESCENT = "残月")[get_moon_state()]]"
	else
		. += "本地城市时间：[CURRENT_STATION_YEAR] 年？找块手表看看吧。"

