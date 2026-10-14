/datum/job/vampire/inquisitor
	title = JOB_INQUISITOR
	description = "你是圣利奥波德协会经验丰富的成员，早已完成见习，并在多年艰苦钻研超自然现象后成为议事修士。如今你的任务很简单：铲除一切威胁上帝国度及其子民的超自然存在，一个也不可放过。上帝早已昭示，这些所谓的血族与狼人究竟在为谁效命。"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SOCIETY_OF_LEOPOLD
	minimal_player_age = 7
	config_tag = "INQUISITOR"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/inquisitor

	display_order = JOB_DISPLAY_ORDER_INQUISITOR
	departments_list = list(
		/datum/job_department/society_of_leopold,
	)

	tgui_icon = FA_ICON_CROSS

	known_contacts = list(
		JOB_ABBE,
		JOB_CONDOTTIERI,
		JOB_NOVICE,
		JOB_INQUISITOR
	)

	splat_slots = list(SPLAT_GHOUL = 1, SPLAT_KINFOLK = 1, SPLAT_NONE = 3)
	allowed_splats = list(SPLAT_NONE, SPLAT_GHOUL, SPLAT_KINFOLK) // infiltrators and betrayal arcs

/datum/outfit/job/vampire/inquisitor
	name = JOB_INQUISITOR
	jobtype = /datum/job/vampire/inquisitor

	id = /obj/item/card/hunter
	head = /obj/item/clothing/head/vampire/cowboy
	uniform = /obj/item/clothing/under/vampire/brujah
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/trench/alt/armored
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/hunter
	l_pocket = /obj/item/smartphone/inquisitor
	backpack_contents = list(/obj/item/vampire_stake=2, /obj/item/intel_report=1, /obj/item/vampirebook/bible=1, /obj/item/masquerade_contract=1, /obj/item/card/credit=1)

/datum/outfit/job/vampire/inquisitor/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.set_holy_role(HOLY_ROLE_PRIEST)

/datum/outfit/job/vampire/inquisitor/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.grant_language(/datum/language/latin, source = "job")
