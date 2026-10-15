/**
 * I am affectionally titling these "key memories"
 *
 * These memories aren't particularly special or interesting, but occuply an important role
 * in conveying information to the user about something important they need to check semi-often
 */
/datum/memory/key
	story_value = STORY_VALUE_KEY
	memory_flags = MEMORY_FLAG_NOMOOD|MEMORY_FLAG_NOLOCATION|MEMORY_FLAG_NOPERSISTENCE|MEMORY_SKIP_UNCONSCIOUS

/// Your bank account ID, can't get into it without it
/datum/memory/key/account
	var/remembered_id

/datum/memory/key/account/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	remembered_id,
)
	src.remembered_id = remembered_id
	return ..()

/datum/memory/key/account/get_names()
	return list("[protagonist_name]的银行账号：[remembered_id]。")

/datum/memory/key/account/get_starts()
	return list(
		"[protagonist_name]绞尽最后一点脑汁，骄傲地展示幸运数字[remembered_id]。",
		"[remembered_id]。那些数字，梅森，它们到底是什么意思！？",
	)

/// The code to the captain's spare ID, ONLY give to the real captain.
/datum/memory/key/captains_spare_code
	var/safe_code

/datum/memory/key/captains_spare_code/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	safe_code,
)
	src.safe_code = safe_code
	return ..()

/datum/memory/key/captains_spare_code/get_names()
	return list("舰桥上金色保险柜的密码：[safe_code]。")

/datum/memory/key/captains_spare_code/get_starts()
	return list(
		"[protagonist_name]对着墙上保险柜苦思冥想，终于输入了[safe_code]。",
		"[safe_code][rand(0,9)]。那些数字，梅森，它们到底是什么意思！？", // Same as the account code
	)


/// The nuclear bomb code, for nuke ops
/datum/memory/key/nuke_code
	var/nuclear_code

/datum/memory/key/nuke_code/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	nuclear_code,
)
	src.nuclear_code = nuclear_code
	return ..()

/datum/memory/key/nuke_code/get_names()
	return list("[protagonist_name]得知了核武器的引爆密码：[nuclear_code]。")

/datum/memory/key/nuke_code/get_starts()
	return list(
		"便签上写着数字[nuclear_code]，旁边潦草地写着“仅限辛迪加成员阅览”。",
		"一个身穿血红色模块服的人将写着数字[nuclear_code]的纸条递给[protagonist_name]。",
	)

/// Tracks what medicines someone with the "allergies" quirk is allergic to
/datum/memory/key/quirk_allergy
	memory_flags = MEMORY_FLAG_NOMOOD|MEMORY_FLAG_NOLOCATION|MEMORY_FLAG_NOPERSISTENCE|MEMORY_SKIP_UNCONSCIOUS|MEMORY_NO_STORY // No story for this
	var/allergy_string

/datum/memory/key/quirk_allergy/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	allergy_string,
)
	src.allergy_string = allergy_string
	return ..()

/datum/memory/key/quirk_allergy/get_names()
	return list("[protagonist_name]对[allergy_string]过敏。")

/datum/memory/key/quirk_allergy/get_starts()
	return list("[protagonist_name]接触[allergy_string]后打起了喷嚏。")

/// Tracks what kind of item the quirk user's heirloom is
/datum/memory/key/quirk_heirloom
	var/heirloom_name

/datum/memory/key/quirk_heirloom/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	heirloom_name,
)
	src.heirloom_name = heirloom_name
	return ..()

/datum/memory/key/quirk_heirloom/get_names()
	return list("[protagonist_name]的传家宝：[heirloom_name]。")

/datum/memory/key/quirk_heirloom/get_starts()
	return list(
		"一位亲爱的家人将传家宝[heirloom_name]留给了[protagonist_name]。",
		"[protagonist_name]在几个早已被遗忘的箱子里发现了传家宝[heirloom_name]。",
		"[protagonist_name]从一位不配拥有传家宝的家人手中偷走了[heirloom_name]。",
	)

/// Tracks what brand a smoker quirk user likes
/datum/memory/key/quirk_smoker
	memory_flags = MEMORY_FLAG_NOLOCATION|MEMORY_FLAG_NOPERSISTENCE|MEMORY_SKIP_UNCONSCIOUS // Does not have nomood
	var/preferred_brand

/datum/memory/key/quirk_smoker/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	preferred_brand,
)
	src.preferred_brand = preferred_brand
	return ..()

/datum/memory/key/quirk_smoker/get_names()
	return list("[protagonist_name]对[preferred_brand]上瘾。")

/datum/memory/key/quirk_smoker/get_starts()
	return list(
		"[protagonist_name]搜刮着[preferred_brand]。",
		"[protagonist_name]买了一盒[preferred_brand]。",
		"[protagonist_name]烟瘾难耐，渴望来点[preferred_brand]。",
	)

/datum/memory/key/quirk_smoker/get_moods()
	return list("[memorizer]又点燃一支香烟，[mood_verb]。")

/// Tracks what beverage an alcoholic quirk user likes
/datum/memory/key/quirk_alcoholic
	memory_flags = MEMORY_FLAG_NOLOCATION|MEMORY_FLAG_NOPERSISTENCE|MEMORY_SKIP_UNCONSCIOUS // Does not have nomood
	var/preferred_brandy //haha, get it because brandy is a type of alcohol wow!

/datum/memory/key/quirk_alcoholic/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	preferred_brandy,
)
	src.preferred_brandy = preferred_brandy
	return ..()

/datum/memory/key/quirk_alcoholic/get_names()
	return list("[protagonist_name]对[preferred_brandy]上瘾。")

/datum/memory/key/quirk_alcoholic/get_starts()
	return list(
		"[protagonist_name]将[preferred_brandy]一饮而尽。",
		"[protagonist_name]买了一整箱[preferred_brandy]。",
		"[protagonist_name]酒瘾难耐，渴望喝点[preferred_brandy]。",
	)

/datum/memory/key/quirk_alcoholic/get_moods()
	return list("[memorizer]喝着[preferred_brandy]，[mood_verb]。")

/// Where our traitor uplink is, and what is its code
/datum/memory/key/traitor_uplink
	var/uplink_loc
	var/uplink_code

/datum/memory/key/traitor_uplink/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	uplink_loc,
	uplink_code,
)
	src.uplink_loc = uplink_loc
	src.uplink_code = uplink_code
	return ..()

/datum/memory/key/traitor_uplink/get_names()
	return list("[protagonist_name]的装备上行终端藏在[uplink_loc]中，可通过[uplink_code]开启。")

/datum/memory/key/traitor_uplink/get_starts()
	return list(
		"[protagonist_name]在[uplink_loc]上输入[uplink_code]。",
		"[protagonist_name]将[uplink_loc]放在身旁，记下[uplink_code]以免遗忘。",
	)

/datum/memory/key/traitor_uplink/implant

/datum/memory/key/traitor_uplink/implant/get_names()
	return list("[protagonist_name]体内植入的装备上行终端。")

/datum/memory/key/traitor_uplink/implant/get_starts()
	return list(
		"一名科学家为[protagonist_name]安装植入物。",
		"一名科学家为[protagonist_name]实施手术。",
	)

/datum/memory/key/permabrig_crimes
	var/crimes

/datum/memory/key/permabrig_crimes/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	crimes,
)
	src.crimes = crimes
	return ..()

/datum/memory/key/permabrig_crimes/get_names()
	return list("[protagonist_name]所犯的罪行：“[crimes]”。")

/datum/memory/key/permabrig_crimes/get_starts()
	return list(
		"[protagonist_name]因[crimes]被安保逮捕。",
		"[protagonist_name]犯下了[crimes]的罪行。",
	)

/datum/memory/key/message_server_key
	var/decrypt_key

/datum/memory/key/message_server_key/New(
	datum/mind/memorizer_mind,
	atom/protagonist,
	atom/deuteragonist,
	atom/antagonist,
	decrypt_key,
)
	src.decrypt_key = decrypt_key
	return ..()

/datum/memory/key/message_server_key/get_names()
	return list("今日消息服务器的密钥是[decrypt_key]。别让小丑知道。")

/datum/memory/key/message_server_key/get_starts()
	return list(
		"显示器上贴着一张写有[decrypt_key]的便签。",
		"鹦鹉波利一遍遍尖叫着“[decrypt_key]！”。",
		"[protagonist_name]输入[decrypt_key]时，将咖啡洒在消息监控器上。",
	)
