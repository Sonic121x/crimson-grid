///Pipe info
/datum/pipe_info
	///Name of this pipe
	var/name
	///Icon state of this pipe
	var/icon_state
	///Description of how the pipe is used
	var/desc
	///Type path of this recipe
	var/obj/machinery/id
	/// see code/__DEFINES/pipe_construction.dm
	var/dirtype = PIPE_BENDABLE
	/// Is this pipe layer indenpendent
	var/all_layers

/**
 * Get preview image of an pipe
 * Arguments
 *
 * * selected_dir - the direction of the pipe to get preview of
 * * selected - is this pipe meant to be highlighted in the UI
 */
/datum/pipe_info/proc/get_preview(selected_dir, selected = FALSE)
	SHOULD_BE_PURE(TRUE)

	var/list/dirs
	switch(dirtype)
		if(PIPE_STRAIGHT, PIPE_BENDABLE)
			dirs = list("[NORTH]" = "纵向", "[EAST]" = "横向")
			if(dirtype == PIPE_BENDABLE)
				dirs += list("[NORTHWEST]" = "西接北", "[NORTHEAST]" = "北接东",
							"[SOUTHWEST]" = "南接西", "[SOUTHEAST]" = "东接南")
		if(PIPE_TRINARY)
			dirs = list("[NORTH]" = "西、南、东", "[SOUTH]" = "东、北、西",
						"[EAST]" = "北、西、南", "[WEST]" = "南、东、北")
		if(PIPE_TRIN_M)
			dirs = list("[NORTH]" = "北、东、南", "[SOUTHWEST]" = "北、西、南",
						"[NORTHEAST]" = "南、东、北", "[SOUTH]" = "南、西、北",
						"[WEST]" = "西、北、东", "[SOUTHEAST]" = "西、南、东",
						"[NORTHWEST]" = "东、北、西", "[EAST]" = "东、南、西",)
		if(PIPE_UNARY)
			dirs = list("[NORTH]" = "北", "[SOUTH]" = "南", "[WEST]" = "西", "[EAST]" = "东")
		if(PIPE_ONEDIR)
			dirs = list("[SOUTH]" = name)
		if(PIPE_UNARY_FLIPPABLE)
			dirs = list("[NORTH]" = "北", "[EAST]" = "东", "[SOUTH]" = "南", "[WEST]" = "西",
						"[NORTHEAST]" = "北（翻转）", "[SOUTHEAST]" = "东（翻转）", "[SOUTHWEST]" = "南（翻转）", "[NORTHWEST]" = "西（翻转）")
		if(PIPE_ONEDIR_FLIPPABLE)
			dirs = list("[SOUTH]" = name, "[SOUTHEAST]" = "[name]（翻转）")

	var/list/rows = list()
	for(var/dir in dirs)
		var/numdir = text2num(dir)
		var/flipped = ((dirtype == PIPE_TRIN_M && !ispath(id, /obj/structure/disposalpipe)) || (dirtype == PIPE_UNARY_FLIPPABLE) || (dirtype == PIPE_ONEDIR_FLIPPABLE)) && (ISDIAGONALDIR(numdir))
		var/is_variant_selected = selected && (!selected_dir ? FALSE : (dirtype == PIPE_ONEDIR ? TRUE : (numdir == selected_dir)))
		rows += list(list(
			"selected" = is_variant_selected,
			"dir" = dir2text(numdir),
			"dir_name" = dirs[dir],
			"icon_state" = icon_state,
			"flipped" = flipped,
		))

	return rows

//==============================================================================================

///Meter pipe info
/datum/pipe_info/meter
	icon_state = "meter"
	dirtype = PIPE_ONEDIR
	all_layers = TRUE

/datum/pipe_info/pipe
	dirtype = null

/datum/pipe_info/pipe/New(label, obj/machinery/atmospherics/path, use_five_layers)
	if(isnull(name)) // name ??= label
		name = label
	if(isnull(id)) // id ??= path
		id = path
	if(isnull(all_layers)) // all_layers ??= use_five_layers
		all_layers = use_five_layers

	if(!ispath(id, /obj/machinery/atmospherics))
		return

	var/obj/machinery/atmospherics/id_atmos = id
	if(isnull(icon_state)) // icon_state ??= initial(path.pipe_state)
		icon_state = id_atmos::pipe_state
	if(isnull(dirtype)) // dirtype ??= id_atmos::construction_type::RPD_type
		dirtype = id_atmos::construction_type::RPD_type

/datum/pipe_info/pipe/bridge_pipe
	name = "跨接管"
	desc = "可使同层同色的管路交叉通过，避免意外相连。<br>\
		不同层或不同颜色的管路无需使用。"
	id = /obj/machinery/atmospherics/pipe/bridge_pipe
	all_layers = TRUE

/datum/pipe_info/pipe/multiz_connector
	name = "跨层接头"
	desc = "沿垂直方向直接连接空间站不同楼层的管路。"
	id = /obj/machinery/atmospherics/pipe/multiz
	all_layers = FALSE

/datum/pipe_info/pipe/manual_valve
	name = "手动阀"
	desc = "阻断管路中的气流。<br>硅基生命无法操作。无需电力。"
	id = /obj/machinery/atmospherics/components/binary/valve
	all_layers = TRUE

/datum/pipe_info/pipe/digital_valve
	name = "数字阀"
	desc = "阻断管路中的气流。<br>硅基生命可以操作。虽采用数字控制，但无需电力。"
	id = /obj/machinery/atmospherics/components/binary/valve/digital
	all_layers = TRUE

/datum/pipe_info/pipe/gas_pump
	name = "气压泵"
	desc = "将气体从一条管路输送至另一条。<br>按需输送气体，直到输出端管网达到设定气压。"
	id = /obj/machinery/atmospherics/components/binary/pump
	all_layers = TRUE

/datum/pipe_info/pipe/volume_pump
	name = "容积泵"
	desc = "将气体从一条管路输送至另一条。<br>按照设定容积输送固定体积的气体。<br>\
		可通过超频增加输送量，但可能导致泄漏。"
	id = /obj/machinery/atmospherics/components/binary/volume_pump
	all_layers = TRUE

/datum/pipe_info/pipe/passive_gate
	name = "被动阀"
	desc = "当输出端管路气压高于设定气压或输入端管路气压时，\
		阻断管路中的气流。<br>不允许气体倒流，无需电力。"
	id = /obj/machinery/atmospherics/components/binary/passive_gate
	all_layers = TRUE

/datum/pipe_info/pipe/pressure_valve
	name = "压力阀"
	desc = "当输入端管路气压\
		低于设定气压时，阻断管路中的气流。<br>不允许气体倒流，无需电力。"
	id = /obj/machinery/atmospherics/components/binary/pressure_valve
	all_layers = TRUE

/datum/pipe_info/pipe/temperature_gate
	name = "温控阀"
	desc = "当输入端管路温度低于设定温度时，阻断管路中的气流。<br>\
		不允许气体倒流。可用多功能工具改为在温度高于设定值时阻断气流。"
	id = /obj/machinery/atmospherics/components/binary/temperature_gate
	all_layers = TRUE

/datum/pipe_info/pipe/temperature_pump
	name = "热泵"
	desc = "将热量从一条管路传递至另一条，使输入端管路降温、输出端管路升温。不输送气体。"
	id = /obj/machinery/atmospherics/components/binary/temperature_pump
	all_layers = TRUE

/datum/pipe_info/pipe/vent
	name = "泵式通风口"
	desc = "内置气压泵的通风口。<br>根据空气警报器的设置，将相连管路中的气体泵入外界，\
		或将外界气体吸入相连管路。<br>\
		可超频运行。"
	id = /obj/machinery/atmospherics/components/unary/vent_pump
	all_layers = TRUE

/datum/pipe_info/pipe/passive_vent
	name = "被动通风口"
	desc = "使外界空气与相连管路中的气体连通。<br>无需电力。"
	id = /obj/machinery/atmospherics/components/unary/passive_vent
	all_layers = TRUE

/datum/pipe_info/pipe/heat_exchanger
	name = "热交换器"
	desc = "与另一台热交换器正面相对时，使双方相连管路中的气体温度趋于一致。"
	id = /obj/machinery/atmospherics/components/unary/heat_exchanger
	all_layers = FALSE

//==============================================================================================

///Disposal pipe info
/datum/pipe_info/disposal

/datum/pipe_info/disposal/New(label, obj/path, dt=PIPE_UNARY)
	name = label
	id = path

	icon_state = initial(path.icon_state)
	if(ispath(path, /obj/structure/disposalpipe))
		icon_state = "con[icon_state]"

	dirtype = dt


//==============================================================================================

///Transient tube pipe info
/datum/pipe_info/transit

/datum/pipe_info/transit/New(label, obj/path, dt=PIPE_UNARY)
	name = label
	id = path
	dirtype = dt
	icon_state = initial(path.icon_state)
	if(dt == PIPE_UNARY_FLIPPABLE)
		icon_state = "[icon_state]_preview"
