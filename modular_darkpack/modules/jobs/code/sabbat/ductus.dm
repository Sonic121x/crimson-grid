/datum/job/vampire/sabbatductus
	title = JOB_SABBAT_DUCTUS
	faction = FACTION_SABBAT
	total_positions = 1
	spawn_positions = 1
	supervisors = "该隐"
	config_tag = "SABBAT_DUCTUS"
	outfit = /datum/outfit/job/vampire/sabbatductus
	allowed_splats = list(SPLAT_KINDRED)
	job_flags = CITY_JOB_FLAGS
	departments_list = list(
		/datum/job_department/sabbat,
	)

	tgui_icon = FA_ICON_CROSS

	exp_requirements = EXP_REQ_HEAD
	exp_required_type_department = EXP_TYPE_SABBAT

	description = "你是魔宴同盟的战团首领。你的使命是反抗长老与密党，反抗永恒圣战，反抗避世戒律与传统戒律，并奉该隐为全体血族真正的黑暗之父。【注意】选择此角色即表示你已阅读并同意服务器关于对抗角色冲突升级的规则。务必让双方都能参与其中、享受互动。仅因自己有能力就随意杀害其他玩家角色，可能导致你被禁止选择此类角色。"
	minimum_masquerade = 0
	display_order = JOB_DISPLAY_ORDER_SABBATDUCTUS
	whitelisted = TRUE

	known_contacts = list(
		JOB_SABBAT_PACK,
		JOB_SABBAT_PRIEST
	)

/datum/antagonist/sabbatist/ductus
	antag_hud_name = "ductus"

/datum/outfit/job/vampire/sabbatductus
	name = JOB_SABBAT_DUCTUS
	jobtype = /datum/job/vampire/sabbatductus
	l_pocket = /obj/item/smartphone/sabbat_ductus
	r_pocket = /obj/item/vamp/keys/sabbat
	uses_default_clan_clothes = TRUE
	backpack_contents = list(/obj/item/card/credit=1)

/datum/outfit/job/vampire/sabbatductus/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.mind)
		H.mind.add_antag_datum(/datum/antagonist/sabbatist/ductus)
