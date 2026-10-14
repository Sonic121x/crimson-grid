/datum/job/vampire/famiglia
	title = JOB_LA_FAMIGLIA
	faction = FACTION_GIOVANNI
	total_positions = 10
	spawn_positions = 10
	supervisors = "家族"
	config_tag = "LA_FAMIGLIA"
	outfit = /datum/outfit/job/vampire/famiglia
	job_flags = CITY_JOB_FLAGS
	display_order = 4
	exp_required_type_department = EXP_TYPE_GIOVANNI
	departments_list = list(
		/datum/job_department/giovanni,
	)

	tgui_icon = FA_ICON_MONEY_BILL_1_WAVE

	known_contacts = list(
		JOB_CAPO,
		JOB_LA_SQUADRA,
		JOB_LA_FAMIGLIA
	)

	allowed_splats = list(SPLAT_GHOUL, SPLAT_NONE, SPLAT_KINDRED)
	allowed_clans = list(VAMPIRE_CLAN_CAITIFF)
	maximal_generation = 9
	maximum_immortal_age = 200
	description = "你的家族很古怪。也许你也一样，因为你十分向往有朝一日能与叔祖辈平起平坐。"
	minimum_masquerade = 0

/datum/outfit/job/vampire/famiglia
	name = JOB_LA_FAMIGLIA
	jobtype = /datum/job/vampire/famiglia
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/smartphone/giovanni_famiglia
	r_pocket = /obj/item/vamp/keys/giovanni
	backpack_contents = list(/obj/item/card/credit=1)

/datum/outfit/job/vampire/famiglia/post_equip(mob/living/carbon/human/H)
	. = ..()
	H.grant_language(/datum/language/italian, source = "job")
