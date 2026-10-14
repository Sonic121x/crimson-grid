/datum/job/vampire/pentex_sec
	title = JOB_PENTEX_SEC
	description = "你是" + MAIN_EVIL_COMPANY + "在旧金山的现任安保人员。在安保主管指挥下，你负责阻止好事者闯入厂区、拘拿违约者，并协助主管应对危及公司资产的威胁。"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	faction = FACTION_PENTEX
	total_positions = 2
	spawn_positions = 2
	supervisors = "董事会、分部负责人与安保主管"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = EXP_REQ_MINOR
	config_tag = "PENTEX_SEC"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/pentex_sec

	allowed_tribes = list(TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_RONIN)
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 3

	display_order = JOB_DISPLAY_ORDER_PENTEX_SEC
	departments_list = list(
		/datum/job_department/pentex,
	)

	tgui_icon = FA_ICON_SHIELD_VIRUS

	known_contacts = list(
		JOB_PENTEX_LEAD,
		JOB_PENTEX_EXEC,
		JOB_PENTEX_AFFAIRS,
		JOB_PENTEX_SEC_CHIEF,
		JOB_PENTEX_EMPLOYEE,
		JOB_PENTEX_SEC
	)

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

/datum/outfit/job/vampire/pentex_sec
	name = JOB_PENTEX_SEC
	jobtype = /datum/job/vampire/pentex_sec

//	ears = /obj/item/p25radio
	id = /obj/item/card/pentex/sec
	uniform =  /obj/item/clothing/under/vampire/pentex_shortsleeve
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/vest
	belt = /obj/item/storage/belt/holster/detective/darkpack/endron
	l_pocket = /obj/item/smartphone/endron_security
	r_pocket = /obj/item/vamp/keys/pentex
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/card/credit=1, /obj/item/clothing/mask/gas/darkpack/military/pentex=1)
