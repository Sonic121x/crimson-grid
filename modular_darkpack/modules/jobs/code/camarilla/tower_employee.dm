/datum/job/vampire/towerwork
	title = JOB_TOWERWORK
	faction = FACTION_CAMARILLA
	total_positions = 4
	spawn_positions = 4
	supervisors = SUPERVISOR_SENESCHAL_PUBLIC
	config_tag = "TOWER_EMPLOYEE"
	outfit = /datum/outfit/job/vampire/towerwork
	job_flags = CITY_JOB_FLAGS
	display_order = JOB_DISPLAY_ORDER_TOWERWORK
	departments_list = list(
		/datum/job_department/camarilla,
	)

	tgui_icon = FA_ICON_PAPERCLIP

	alt_titles = list(
		"Tower Employee",
		"Tower Cleaner",
		"Tower Assistant",
		"Tower Security Guard",
		"Tower Personal Driver",
		"Tower Personal Attendant"
	)

	maximal_generation = 9
	maximum_immortal_age = 200
	known_contacts = list(
		JOB_PRINCE,
		JOB_SHERIFF,
		JOB_SENESCHAL,
		JOB_HOUND,
		JOB_TOWERWORK
	)
	allowed_splats = list(SPLAT_NONE, SPLAT_GHOUL, SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TRUE_BRUJAH, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_DOMINATE_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_BANU_HAQIM_VIZIER, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TLACIQUE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_NAGARAJA)
	description = "你直接为千禧大厦及其管理人员处理各类事务，甚至可能是三位最高管理者之一的私人随从。夜里耳闻目睹的那些怪事，你要么早已知情，要么就一笑置之，尽量不去多想。"
	minimum_masquerade = 4

/datum/outfit/job/vampire/towerwork
	name = JOB_TOWERWORK
	jobtype = /datum/job/vampire/towerwork

	id = /obj/item/card/tower_employee
	uniform = /obj/item/clothing/under/vampire/hound
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/camarilla/ghoul
	l_pocket = /obj/item/smartphone/tower_employee
	backpack_contents = list(/obj/item/card/credit=1)
