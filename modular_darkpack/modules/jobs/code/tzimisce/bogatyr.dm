
/datum/job/vampire/bogatyr
	title = JOB_BOGATYR
	faction = FACTION_SABBAT
	total_positions = 4
	spawn_positions = 4
	supervisors = "待客之律"
	config_tag = "BOGATYR"
	outfit = /datum/outfit/job/vampire/bogatyr
	job_flags = CITY_JOB_FLAGS
	exp_required_type_department = EXP_TYPE_MANOR
	departments_list = list(
		/datum/job_department/manor,
	)
	display_order = JOB_DISPLAY_ORDER_BOGATYR

	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_TZIMISCE)

	description = "无论你传承着沉眠领主的血脉，还是获赐了这份殊荣，你都是领主的亲族。守护家族，就如家族会守护你一样。"
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 2

	known_contacts = list(
		JOB_PRINCE,
		JOB_BARON,
		JOB_SHERIFF,
		JOB_VOIVODE,
		JOB_ZADRUGA
	)

/datum/outfit/job/vampire/bogatyr
	name = JOB_BOGATYR
	jobtype = /datum/job/vampire/bogatyr
	id = /obj/item/card/bogatyr
	glasses = /obj/item/clothing/glasses/vampire/yellow
	uniform = /obj/item/clothing/under/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/jacket/punk
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/bogatyr
	suit = /obj/item/clothing/suit/vampire/bogatyr
	belt = /obj/item/storage/belt/sheath/vamp/sword
	l_pocket = /obj/item/smartphone/bogatyr
	backpack_contents = list(/obj/item/vamp/keys/old_clan_tzimisce=1, /obj/item/card/credit=1)
