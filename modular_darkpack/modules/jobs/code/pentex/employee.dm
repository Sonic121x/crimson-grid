/datum/job/vampire/employee
	title = JOB_PENTEX_EMPLOYEE
	description = "你是" + MAIN_EVIL_COMPANY + "在旧金山的员工。上司们可能有些古怪；夜班时听从安保队与高管的工作安排，别让分部负责人或内务部门盯上你的问题。"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	faction = FACTION_PENTEX
	total_positions = 3
	spawn_positions = 3
	supervisors = "董事会与分部负责人"
	req_admin_notify = 1
	minimal_player_age = 25
	exp_required_type_department = EXP_TYPE_SPIRAL
	config_tag = "PENTEX_EMPLOYEE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/employee

	alt_titles = list(
		"Endron Employee",
		"Endron Janitor",
		"Endron Secretary",
		"Endron Researcher",
		"Endron Labourer"
	)

	allowed_tribes = list(TRIBE_BLACK_SPIRAL_DANCERS, TRIBE_RONIN)
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 3

	display_order = JOB_DISPLAY_ORDER_EMPLOYEE
	departments_list = list(
		/datum/job_department/pentex,
	)

	tgui_icon = FA_ICON_BUSINESS_TIME

	known_contacts = list(
		JOB_PENTEX_LEAD,
		JOB_PENTEX_EXEC,
		JOB_PENTEX_AFFAIRS,
		JOB_PENTEX_SEC_CHIEF,
		JOB_PENTEX_SEC,
		JOB_PENTEX_EMPLOYEE
	)

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

/datum/outfit/job/vampire/employee
	name = JOB_PENTEX_EMPLOYEE
	jobtype = /datum/job/vampire/employee

//	ears = /obj/item/p25radio
	id = /obj/item/card/pentex
	uniform = /obj/item/clothing/under/vampire/pentex_longleeve
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/pentex
	l_pocket = /obj/item/smartphone/endron_employee
	backpack_contents = list(/obj/item/card/credit=1)
