/datum/job/vampire/primogen_lasombra
	title = JOB_PRIMOGEN_LASOMBRA
	description = "以渊博的学识辅佐本市亲王。监管氏族成员与旁支亲族，必要时召开血之法庭；只需一次失误，密党就可能与你反目。你和氏族获封的领地位于本地教堂，周围盘踞着一群狼人，务必控制住局面。"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	faction = FACTION_CAMARILLA
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_TRADITIONS
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = EXP_REQ_HEAD
	config_tag = "PRIMOGEN_LASOMBRA"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/lasombraprim

	display_order = JOB_DISPLAY_ORDER_LASOMBRA
	departments_list = list(
		/datum/job_department/church,
		/datum/job_department/camarilla,
	)

	tgui_icon = FA_ICON_CROWN

	minimal_generation = 12
	minimum_immortal_age = 50
	minimum_masquerade = 5
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_LASOMBRA)

	known_contacts = list(
		JOB_PRINCE,
		JOB_SHERIFF,
		JOB_SENESCHAL,
		JOB_HARPY,
		JOB_PRIMOGEN_BANU_HAQIM,
		JOB_PRIMOGEN_TOREADOR,
		JOB_PRIMOGEN_MALKAVIAN,
		JOB_PRIMOGEN_VENTRUE,
		JOB_PRIMOGEN_NOSFERATU,
		JOB_CHANTRY_REGENT
	)

/datum/outfit/job/vampire/lasombraprim
	name = JOB_PRIMOGEN_LASOMBRA
	jobtype = /datum/job/vampire/primogen_lasombra

	ears = /obj/item/radio/headset/darkpack
	id = /obj/item/card/primogen
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/smartphone/lasombra_primo
	backpack_contents = list(/obj/item/vamp/keys/lasombra/primogen=1, /obj/item/card/credit/elder=1, /obj/item/card/whip, /obj/item/card/steward, /obj/item/card/myrmidon)
