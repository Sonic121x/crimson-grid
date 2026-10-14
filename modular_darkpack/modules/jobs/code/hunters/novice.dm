/datum/job/vampire/novice
	title = JOB_NOVICE
	description = "你是宗教裁判所下属圣利奥波德协会的见习修士，正在经历见习期；也可能是刚完成见习的在俗修士。无论你此前是普通信徒，还是接受过正式的神职或修会训练，如今在协会的主要任务都是学习、侦察并记录那些威胁上帝国度及其秩序的超自然生物，同时随时准备响应召唤。"
	faction = FACTION_CITY
	total_positions = 3
	spawn_positions = 3
	supervisors = SUPERVISOR_SOCIETY_OF_LEOPOLD
	minimal_player_age = 7

	config_tag = "NOVICE"
	job_flags = CITY_JOB_FLAGS
	outfit = /datum/outfit/job/vampire/novice

	display_order = JOB_DISPLAY_ORDER_NOVICE
	departments_list = list(
		/datum/job_department/society_of_leopold,
	)

	tgui_icon = FA_ICON_CROSS

	known_contacts = list(
		JOB_ABBE,
		JOB_CONDOTTIERI,
		JOB_INQUISITOR,
		JOB_NOVICE
	)

	allowed_splats = list(SPLAT_NONE)


/datum/outfit/job/vampire/novice
	name = JOB_NOVICE
	jobtype = /datum/job/vampire/novice

	id = /obj/item/card/hunter
	uniform = /obj/item/clothing/under/vampire/turtleneck_white
	suit = /obj/item/clothing/suit/vampire/labcoat
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/hunter
	l_pocket = /obj/item/smartphone/novice
	backpack_contents = list(/obj/item/camera=1, /obj/item/vampirebook/bible=1, /obj/item/card/credit=1)


/datum/outfit/job/vampire/novice/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.set_holy_role(HOLY_ROLE_DEACON)

/datum/outfit/job/vampire/novice/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.grant_language(/datum/language/latin, source = "job")
