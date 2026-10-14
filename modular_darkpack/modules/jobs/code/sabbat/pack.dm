/datum/job/vampire/sabbatpack
	title = JOB_SABBAT_PACK
	faction = FACTION_SABBAT
	total_positions = 5
	spawn_positions = 5
	supervisors = "该隐"
	config_tag = "SABBAT_PACK"
	outfit = /datum/outfit/job/vampire/sabbatpack
	job_flags = CITY_JOB_FLAGS
	allowed_splats = list(SPLAT_KINDRED)
	departments_list = list(
		/datum/job_department/sabbat,
	)

	tgui_icon = FA_ICON_CROSS

	description = "你是魔宴同盟的一员。你的使命是反抗长老与密党，反抗永恒圣战，反抗避世戒律与传统戒律，并奉该隐为全体血族真正的黑暗之父。【注意】选择此角色即表示你已阅读并同意服务器关于对抗角色冲突升级的规则。务必让双方都能参与其中、享受互动。仅因自己有能力就随意杀害其他玩家角色，可能导致你被禁止选择此类角色。"
	maximal_generation = 9
	maximum_immortal_age = 200
	minimum_masquerade = 0
	display_order = JOB_DISPLAY_ORDER_SABBATPACK
	whitelisted = TRUE

	known_contacts = list(
		JOB_SABBAT_DUCTUS,
		JOB_SABBAT_PRIEST
	)

/datum/outfit/job/vampire/sabbatpack
	name = JOB_SABBAT_PACK
	jobtype = /datum/job/vampire/sabbatpack
	l_pocket = /obj/item/smartphone/sabbat_pack
	r_pocket = /obj/item/vamp/keys/sabbat
	uses_default_clan_clothes = TRUE
	backpack_contents = list(/obj/item/card/credit=1)

/datum/outfit/job/vampire/sabbatpack/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist)

