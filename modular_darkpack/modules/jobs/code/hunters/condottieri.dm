/datum/job/vampire/condottieri
	title = JOB_CONDOTTIERI
	description = "你是圣利奥波德协会的雇佣护卫，被派往这处地方会所，保护审判官和仍在见习的修士。你的职责以防卫为主，较少参与其他审判官执行的进攻任务。不过，雇佣护卫作为协会中精锐而致命的一支力量，始终备受尊重。"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_CITY
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_SOCIETY_OF_LEOPOLD
	minimal_player_age = 7

	config_tag = "CONDOTTIERI"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/condottieri

	display_order = JOB_DISPLAY_ORDER_CONDOTTIERI
	departments_list = list(
		/datum/job_department/society_of_leopold,
	)

	tgui_icon = FA_ICON_CROSS

	known_contacts = list(
		JOB_ABBE,
		JOB_INQUISITOR,
		JOB_NOVICE,
		JOB_CONDOTTIERI
	)

	allowed_splats = list(SPLAT_NONE)

/datum/outfit/job/vampire/condottieri
	name = JOB_CONDOTTIERI
	jobtype = /datum/job/vampire/condottieri

	id = /obj/item/card/hunter
	uniform = /obj/item/clothing/under/vampire/black
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/vest/medieval
	head = /obj/item/clothing/head/vampire/helmet/spain
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/hunter
	l_pocket = /obj/item/smartphone/condottieri
	backpack_contents = list(/obj/item/vampire_stake=1,  /obj/item/intel_report=1, /obj/item/card/credit=1, /obj/item/vampirebook/bible=1)

/datum/outfit/job/vampire/condottieri/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.set_holy_role(HOLY_ROLE_PRIEST)

/datum/outfit/job/vampire/condottieri/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.grant_language(/datum/language/latin, source = "job")
