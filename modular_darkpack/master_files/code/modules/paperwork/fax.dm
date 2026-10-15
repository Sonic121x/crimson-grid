/obj/machinery/fax
	special_networks = list(
		nanotrasen = list(fax_name = "NT人力资源部", fax_id = "central_command", color = "teal", emag_needed = TRUE),
		syndicate = list(fax_name = "破坏活动部", fax_id = "syndicate", color = "red", emag_needed = TRUE),
		camarillaadmin = list(fax_name = "高等议会", fax_id = "camarillaadmin", color = "teal", emag_needed = TRUE),
		anarchsadmin = list(fax_name = "自由邦运动", fax_id = "anarchsadmin", color = "red", emag_needed = TRUE),
		policeadmin = list(fax_name = "联邦政府", fax_id = "policeadmin", color = "blue", emag_needed = TRUE),
		fbiadmin = list(fax_name = "联邦调查局全国总部", fax_id = "fbiadmin", color = "blue", emag_needed = TRUE),
		endronadmin = list(fax_name = EVIL_COMPANY_DISPLAY_NAME + "公司总部", fax_id = "endronadmin", color = "green", emag_needed = TRUE),
		aasimitesadmin = list(fax_name = "元素联络站", fax_id = "aasimitesadmin", color = "purple", emag_needed = TRUE),
		glasswalkeradmin = list(fax_name = "夜狼公司总部", fax_id = "glasswalkeradmin", color = "grey", emag_needed = TRUE),
	)

/obj/machinery/fax/admin/camarilla
	fax_name = "高等议会"
	fax_id = "camarillaadmin"

/obj/machinery/fax/admin/anarch
	fax_name = "自由邦运动"
	fax_id = "anarchsadmin"

/obj/machinery/fax/admin/police
	fax_name = "联邦政府"
	fax_id = "policeadmin"

/obj/machinery/fax/admin/fbi
	fax_name = "联邦调查局全国总部"
	fax_id = "fbi"

/obj/machinery/fax/admin/endron
	fax_name = EVIL_COMPANY_DISPLAY_NAME + "公司总部"
	fax_id = "endronadmin"

/obj/machinery/fax/admin/aasimites
	fax_name = "元素联络站"
	fax_id = "aasimitesadmin"

//The tremere dont get a fax machine because of what happened in Vienna

/obj/machinery/fax/admin/glasswalker
	fax_name = "夜狼公司总部"
	fax_id = "glasswalkeradmin"

/////////////////////////////////////////////

/obj/machinery/fax/camarilla
	fax_name = "千禧大厦"
	fax_id = "camarilla"
	special_networks = list(camarillaadmin = list(fax_name = "高等议会", fax_id = "camarillaadmin", color = "teal", emag_needed = FALSE))


// CRIMSON EDIT ADD - #206
/obj/machinery/fax/clinic
	fax_name = "圣约翰诊所"
	fax_id = "clinic"
	special_networks = list(clinicadmin = list(fax_name = "圣约翰医院", fax_id = "clinicadmin", color = "blue", emag_needed = FALSE))
// CRIMSON EDIT ADD END - #206

/obj/machinery/fax/anarch
	fax_name = "无政府玫瑰酒吧"
	fax_id = "anarchs"
	special_networks = list(anarchsadmin = list(fax_name = "自由邦运动", fax_id = "anarchsadmin", color = "red", emag_needed = FALSE))

/obj/machinery/fax/police
	fax_name = "旧金山警察局"
	fax_id = "police"
	special_networks = list(policeadmin = list(fax_name = "联邦政府", fax_id = "policeadmin", color = "blue", emag_needed = FALSE))

/obj/machinery/fax/fbi
	fax_name = "联邦调查局"
	fax_id = "fbi"
	special_networks = list(fbiadmin = list(fax_name = "联邦调查局全国总部", fax_id = "fbiadmin", color = "blue", emag_needed = TRUE))
	visible_to_network = FALSE

/obj/machinery/fax/endron
	fax_name = MAIN_EVIL_COMPANY_DISPLAY_NAME + "总部"
	fax_id = "endron"
	special_networks = list(endronadmim = list(fax_name = EVIL_COMPANY_DISPLAY_NAME + "公司总部", fax_id = "endronadmin", color = "green", emag_needed = FALSE))

/obj/machinery/fax/aasimites
	fax_name = "胖狮咖啡馆"
	fax_id = "aasimites"
	special_networks = list(aasimitesadmin = list(fax_name = "元素联络站", fax_id = "aasimitesadmin", color = "purple", emag_needed = FALSE))

/obj/machinery/fax/tremere
	fax_name = "图书馆"
	fax_id = "library"
	special_networks = list()

/obj/machinery/fax/glasswalker
	fax_name = "夜狼科技商店"
	fax_id = "glasswalkers"
	special_networks = list(glasswalkeradmin = list(fax_name = "夜狼公司总部", fax_id = "glasswalkeradmin", color = "grey", emag_needed = FALSE))
