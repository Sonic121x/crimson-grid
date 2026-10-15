/obj/item/smartphone/prince
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "首席执行官", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "泛美公司首席执行官", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/seneschal
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "首席运营官", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "泛美公司首席运营官", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sheriff
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "安保主管", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "千禧集团安保主管", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/harpy
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "公关专员", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "千禧集团公关专员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/hound
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "大厦保安", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/tower_employee
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MILLENIUM_TOWER_NETWORK, OUR_ROLE = "大厦员工", USE_JOB_TITLE = TRUE)
		)

// VENTRUE

/obj/item/smartphone/ventrue_primo
	important_contact_of = VAMPIRE_CLAN_VENTRUE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "蓝冠爵士俱乐部老板", USE_JOB_TITLE = FALSE)
		)

// TOREADOR

/obj/item/smartphone/toreador_primo
	important_contact_of = VAMPIRE_CLAN_TOREADOR
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = (PRIMARY_NIGHTCLUB_COMPANY + "夜总会老板"), USE_JOB_TITLE = FALSE)
		)

// NOSFERATU

/obj/item/smartphone/nosferatu_primo
	important_contact_of = VAMPIRE_CLAN_NOSFERATU
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "公用设施主管", USE_JOB_TITLE = FALSE)
		)

// MALKAVIAN

/obj/item/smartphone/malkavian_primo
	important_contact_of = VAMPIRE_CLAN_MALKAVIAN
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "精神病院院长", USE_JOB_TITLE = FALSE)		// CRIMSON EDIT — Original: OUR_ROLE = "Hospital Administrator"
		)

// LASOMBRA

/obj/item/smartphone/lasombra_primo
	important_contact_of = VAMPIRE_CLAN_LASOMBRA
	contact_networks_pre_init = list(
		alist(NETWORK_ID = LASOMBRA_NETWORK, OUR_ROLE = "教堂主管", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "教堂主管", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/lasombra_caretaker
	contact_networks_pre_init = list(
		alist(NETWORK_ID = LASOMBRA_NETWORK, OUR_ROLE = "教堂看守", USE_JOB_TITLE = FALSE)
		)

// BANU HAQIM

/obj/item/smartphone/banu_primo
	important_contact_of = VAMPIRE_CLAN_BANU_HAQIM
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "旧金山警察局民间顾问", USE_JOB_TITLE = FALSE)
		)

// TREMERE

/obj/item/smartphone/tremere_regent
	important_contact_of = VAMPIRE_CLAN_TREMERE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "图书馆馆长", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "图书馆馆长", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/archivist
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "图书馆档案员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/gargoyle
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TREMERE_NETWORK, OUR_ROLE = "图书馆维修员", USE_JOB_TITLE = FALSE)
		)

// GIOVANNI

/obj/item/smartphone/giovanni_capo
	important_contact_of = VAMPIRE_CLAN_GIOVANNI
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "银行经理", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "银行经理", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_nonni
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "银行股东", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_squadra
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "银行保安", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/giovanni_famiglia
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GIOVANNI_NETWORK, OUR_ROLE = "银行员工", USE_JOB_TITLE = FALSE)
		)

// TZMISCE

/obj/item/smartphone/voivode
	important_contact_of = VAMPIRE_CLAN_TZIMISCE
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "庄园领主", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "庄园领主", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/bogatyr
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "庄园住客", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/zadruga
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TZMISCE_NETWORK, OUR_ROLE = "庄园仆从", USE_JOB_TITLE = FALSE)
		)

// ANARCHS

/obj/item/smartphone/baron
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部经理", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "无政府玫瑰俱乐部经理", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/emissary
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部代表", USE_JOB_TITLE = FALSE)
		, alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "无政府玫瑰俱乐部代表", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/bruiser
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部保镖", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sweeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部调酒师", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/liaison
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部推广员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/tapster
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ANARCH_NETWORK, OUR_ROLE = "俱乐部调酒师", USE_JOB_TITLE = FALSE)
		)

// SUPPLY

/obj/item/smartphone/supply_tech
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "补给技师", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/dealer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "补给主管", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "仓库主管", USE_JOB_TITLE = FALSE)
	)

// ENDRON

/obj/item/smartphone/endron_lead
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆分部主管", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_exec
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆高管", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_affairs
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆内务调查员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_sec_chief
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆安保主管", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_security
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆安保员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/endron_employee
	contact_networks_pre_init = list(
		alist(NETWORK_ID = ENDRON_NETWORK, OUR_ROLE = "安德隆员工", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/novice
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "见习修士", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/condottieri
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "雇佣护卫", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/inquisitor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "审判官", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/abbe
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SOCIETY_OF_LEOPOLD_NETWORK, OUR_ROLE = "修道院长", USE_JOB_TITLE = TRUE)
		)

// CIVILIAN

/obj/item/smartphone/janitor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "清洁工", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/taxi
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "出租车司机", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/club_worker
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "俱乐部员工", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/priest
	contact_networks_pre_init = list(
		alist(NETWORK_ID = CIVILIAN_NETWORK, OUR_ROLE = "神父", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/clinic_director
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "诊所主任", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/red_news
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "红色新闻记者", USE_JOB_TITLE = TRUE)
		)

/obj/item/smartphone/doctor
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "诊所职员", USE_JOB_TITLE = FALSE)
		)

// SEPT

/obj/item/smartphone/garou_council
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "国家公园管理局监督委员会", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_guardian
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "公园巡护员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_truthcatcher
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "公园向导", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_warder
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "公园巡护队长", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_wyrmfoe
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "国家公园管理局生物学家", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_keeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "公园职员", USE_JOB_TITLE = FALSE)
		)

// POLICE

/obj/item/smartphone/police_captain
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "旧金山警察局警监", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/dispatch
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "紧急调度员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/federal_investigator
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "联邦调查员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/police_officer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "旧金山警察局警员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/police_sergeant
	contact_networks_pre_init = list(
		alist(NETWORK_ID = POLICE_NETWORK, OUR_ROLE = "旧金山警察局警长", USE_JOB_TITLE = FALSE)
		)

// SABBAT

/obj/item/smartphone/sabbat_ductus
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "值班经理", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sabbat_pack
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "蠢货同事", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/sabbat_priest
	contact_networks_pre_init = list(
		alist(NETWORK_ID = SABBAT_NETWORK, OUR_ROLE = "副经理", USE_JOB_TITLE = FALSE)
		)

// CRIMSON EDIT ADD - Triads and Rolelocks

/obj/item/smartphone/brujah_primo
	important_contact_of = VAMPIRE_CLAN_BRUJAH
	contact_networks_pre_init = list(
		alist(NETWORK_ID = VAMPIRE_LEADER_NETWORK, OUR_ROLE = "健身房老板", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/garou_keeper
	contact_networks_pre_init = list(
		alist(NETWORK_ID = GAROU_NETWORK, OUR_ROLE = "公园职员", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/mountain_master
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "老大", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "唐人街地产商", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/deputy_mountain_master
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "二当家", USE_JOB_TITLE = FALSE),
		alist(NETWORK_ID = SUPPLY_NETWORK, OUR_ROLE = "唐人街经纪人", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/red_pole
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "唐人街打手", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/blue_lantern
	contact_networks_pre_init = list(
		alist(NETWORK_ID = TRIAD_NETWORK, OUR_ROLE = "唐人街店主", USE_JOB_TITLE = FALSE)
		)

/obj/item/smartphone/clinic_officer
	contact_networks_pre_init = list(
		alist(NETWORK_ID = MEDICAL_NETWORK, OUR_ROLE = "诊所护工", USE_JOB_TITLE = FALSE)
		)
// CRIMSON EDIT ADD END - Triads and Rolelocks


#undef NETWORK_ID
#undef OUR_ROLE
#undef USE_JOB_TITLE
