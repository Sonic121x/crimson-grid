/datum/job/vampire/gargoyle
	title = JOB_CHANTRY_GARGOYLE
	faction = FACTION_CAMARILLA
	total_positions = 5
	spawn_positions = 5
	supervisors = SUPERVISOR_REGENT
	config_tag = "CHANTRY_GARGOYLE"
	outfit = /datum/outfit/job/vampire/gargoyle
	job_flags = CITY_JOB_FLAGS
	departments_list = list(
		/datum/job_department/chantry,
	)
	display_order = JOB_DISPLAY_ORDER_GARGOYLE

	tgui_icon = FA_ICON_HILL_ROCKSLIDE

	description = "你为本地秘所看守门户、执行命令或侦察，是睿魔尔氏族法师麾下的突击战力。尽管大多数同族早已获得自由，你仍效忠睿魔尔，或出于责任，或遭受精神奴役，或只是无处可去。在主人眼中你低人一等，却仍留在这里。像你的同族历来所做的那样，守护秘所和主人。"
	maximal_generation = 8 // Crimson Grid Edit - Lock Adjustments - Was 9
	maximum_immortal_age = 842 // Crimson Grid Edit - Lock Adjustments - Gargoyles were first made in 1167 after all - Was 200
	minimum_masquerade = 3
	allowed_splats = list(SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_GARGOYLE)
	known_contacts = list(
		JOB_CHANTRY_REGENT,
		JOB_CHANTRY_ARCHIVIST,
		JOB_CHANTRY_GARGOYLE
	)

/datum/outfit/job/vampire/gargoyle
	name = JOB_CHANTRY_GARGOYLE
	jobtype = /datum/job/vampire/gargoyle
	id = /obj/item/card/archive
	glasses = /obj/item/clothing/glasses/vampire/red
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/work
	uniform = /obj/item/clothing/under/vampire/turtleneck_black
	suit = /obj/item/clothing/suit/hooded/robes/tremere
	mask = /obj/item/clothing/mask/vampire/venetian_mask
	belt = /obj/item/scythe/vamp
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/smartphone/gargoyle
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(
		/obj/item/ritual_tome/arcane = 1,
		/obj/item/card/credit = 1,
	)
