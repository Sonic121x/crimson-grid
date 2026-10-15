/obj/structure/sign/gym
	name = "\improper 健身励志标牌"
	sign_change_name = "gym_left"
	desc = "一块画着魁梧绿巨人的标牌，鼓励你“释放内心的浩克”。"
	icon_state = "gym-left"

/obj/structure/sign/gym/right
	icon_state = "gym-right"

/obj/structure/sign/gym/mirrored
	icon_state = "gymmirror-left"

/obj/structure/sign/gym/mirrored/right
	icon_state = "gymmirror-right"

/obj/structure/sign/xenobio_guide
	name = "\improper 史莱姆谱系标牌"
	sign_change_name = "异星生物学指南"
	desc = "一块描绘史莱姆颜色如何随变异改变的标牌，灰色史莱姆位于谱系根部。"
	icon_state = "xenobio-guide"
	is_editable = TRUE

/obj/structure/sign/chalkboard_menu
	name = "咖啡菜单黑板"
	icon_state = "chalkboard_menu"
	icon = 'icons/obj/machines/barsigns.dmi'
	desc = "一杯无乳糖冰焦糖奶昔要85信用点？！谁会买啊？！"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/xenobio_guide, 32)

// Tram-mounted statistics plate
/obj/structure/sign/tram_plate
	/// The tram we have info about
	var/specific_transport_id = TRAMSTATION_LINE_1
	/// Weakref to the tram we have info about
	var/datum/weakref/transport_ref
	/// Serial number of the tram
	var/tram_serial
	name = "电车信息铭牌"
	sign_change_name = "信息——电车统计"
	icon_state = "tram_plate"
	max_integrity = 150
	armor_type = /datum/armor/tram_structure
	is_editable = FALSE

/obj/structure/sign/tram_plate/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/sign/tram_plate/LateInitialize()
	link_tram()
	set_tram_serial()

/obj/structure/sign/tram_plate/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "查看详情"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sign/tram_plate/proc/link_tram()
	for(var/datum/transport_controller/linear/tram/tram as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(tram.specific_transport_id == specific_transport_id)
			transport_ref = WEAKREF(tram)
			break

/obj/structure/sign/tram_plate/proc/set_tram_serial()
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	if(isnull(tram) || isnull(tram.tram_registration))
		return

	tram_serial = tram.tram_registration.serial_number
	desc = "一块标注制造商信息的铭牌，介绍这辆中村工程天际电车六型，序列号为[tram_serial]。<br><br>我们对使用电车造成的任何伤亡概不负责。\
	使用电车本身存在风险，我们无法保证所有乘客的安全。使用电车即表示你承担、知晓并接受一切风险与责任。<br><br>\
	请注意，乘坐电车可能造成多种伤害，包括但不限于：滑倒、绊倒和跌落；与其他乘客或物体碰撞；拉伤、扭伤及其他肌肉骨骼损伤；\
	割伤、瘀伤和撕裂伤；以及头部创伤、脊髓损伤乃至死亡等更严重的后果。这些伤害可能由多种因素引起，包括电车的运动、\
	其他乘客的行为，以及人为破坏或机械故障等不可预见的情况。<br><br>\
	进入电车、导轨或道口，即表示你同意纳诺传讯不对可能发生的任何伤害、损害或损失承担责任。若你不同意这些条款，请勿使用电车。<br>"

/obj/structure/sign/tram_plate/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TramPlaque")
		ui.autoupdate = FALSE
		ui.open()

/obj/structure/sign/tram_plate/ui_static_data(mob/user)
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	var/list/data = list()
	var/list/current_tram = list()
	var/list/previous_trams = list()

	current_tram += list(list(
		"serialNumber" = tram.tram_registration.serial_number,
		"mfgDate" = tram.tram_registration.mfg_date,
		"distanceTravelled" = tram.tram_registration.distance_travelled,
		"tramCollisions" = tram.tram_registration.collisions,
	))

	for(var/datum/tram_mfg_info/previous_tram as anything in tram.tram_history)
		previous_trams += list(list(
		"serialNumber" = previous_tram.serial_number,
		"mfgDate" = previous_tram.mfg_date,
		"distanceTravelled" = previous_tram.distance_travelled,
		"tramCollisions" = previous_tram.collisions,
	))

	data["currentTram"] = current_tram
	data["previousTrams"] = previous_trams
	return data

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/tram_plate, 32)

/obj/structure/sign/nanotrasen
	name = "\improper 纳诺传讯徽标牌"
	sign_change_name = "企业徽标——纳诺传讯"
	desc = "一块带有纳诺传讯徽标的标牌。荣耀归于纳诺传讯！"
	icon_state = "nanotrasen"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/nanotrasen, 32)

/obj/structure/sign/logo
	name = "\improper 纳诺传讯徽标牌"
	desc = "纳诺传讯的企业徽标。"
	icon_state = "nanotrasen_sign1"
	buildable_sign = FALSE
