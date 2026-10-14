/datum/job/vampire/red_news_reporter
	title = JOB_RED_NEWS_REPORTER
	description = "你是潘特克斯控股品牌“红色新闻”的记者。你负责报道城中事件，让公众了解最新消息；红色新闻也播出大量资讯娱乐节目，所以你也可以主持自己的娱乐秀。无论选哪条路，你都有专属时段，可得好好利用！"
	faction = FACTION_PENTEX
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/vampire/red_news_reporter
	config_tag = "RED_NEWS_REPORTER"
	display_order = JOB_DISPLAY_ORDER_RED_NEWS_REPORTER
	departments_list = list(
		/datum/job_department/citizen
	)

	tgui_icon = FA_ICON_CAMERA

	job_flags = CITY_JOB_FLAGS
	minimum_masquerade = 0
	alt_titles = list(
		"Red News Cameraman",
		"Red News Talking Head",
		"Red News Infomercial Salesperson",
		"Red News Entertainment Host",
		"Red News Late Night Talkshow Host"
	)
	disallowed_clans = list(VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_NOSFERATU)

	known_contacts = list(
		JOB_RED_NEWS_REPORTER
	)

/datum/outfit/job/vampire/red_news_reporter
	name = JOB_RED_NEWS_REPORTER
	jobtype = /datum/job/vampire/red_news_reporter
	l_pocket = /obj/item/smartphone/red_news
	backpack_contents = list(/obj/item/card/credit)
	uniform = /obj/item/clothing/under/vampire/suit
	l_hand = /obj/item/broadcast_camera/darkpack
