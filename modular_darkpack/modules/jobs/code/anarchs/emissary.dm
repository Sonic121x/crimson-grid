/datum/job/vampire/emissary
	title = JOB_EMISSARY
	faction = FACTION_ANARCHS
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_BARON
	config_tag = "EMISSARY"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/emissary

	display_order = JOB_DISPLAY_ORDER_EMISSARY
	departments_list = list(
		/datum/job_department/anarch,
	)

	tgui_icon = FA_ICON_WINE_GLASS_ALT

	known_contacts = list(
		JOB_BARON,
		JOB_BRUISER,
		JOB_SWEEPER,
		JOB_TAPSTER,
		JOB_PRINCE,
		JOB_SHERIFF,
		JOB_SENESCHAL,
		JOB_HARPY,
		JOB_DEALER
	)
	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_HEALER_SALUBRI, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_NAGARAJA)
	allowed_splats = list(SPLAT_KINDRED)
	description = "你是自由派的外交使者。通过言辞而非暴力达成交易、维持和平。不过，谈判失败后，武力也可能派上用场。"
	minimum_masquerade = 2

/datum/outfit/job/vampire/emissary
	name = JOB_EMISSARY
	jobtype = /datum/job/vampire/emissary

	id = /obj/item/card/emissary
	ears = /obj/item/radio/headset/darkpack
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch
	l_pocket = /obj/item/smartphone/emissary
	backpack_contents = list(/obj/item/vamp/keys/hack=1, /obj/item/card/credit/rich=1)
