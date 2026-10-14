/atom/movable/screen/blob
	icon = 'icons/hud/blob.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/blob/MouseEntered(location,control,params)
	. = ..()
	openToolTip(usr,src,params,title = name,content = desc, theme = "blob")

/atom/movable/screen/blob/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/blob/jump_to_node
	name = "跳转至节点"
	desc = "将视角移至选定的黏液团节点。"
	icon_state = "ui_tonode"
	screen_loc = ui_inventory

/atom/movable/screen/blob/jump_to_node/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	blob.jump_to_node()

/atom/movable/screen/blob/jump_to_core
	name = "跳转至核心"
	desc = "将视角移至你的黏液团核心。"
	icon_state = "ui_tocore"
	screen_loc = ui_zonesel

/atom/movable/screen/blob/jump_to_core/MouseEntered(location,control,params)
	if(hud?.mymob && isovermind(hud.mymob))
		var/mob/eye/blob/B = hud.mymob
		if(!B.placed)
			name = "放置黏液团核心"
			desc = "尝试在此处放置你的黏液团核心。"
		else
			name = initial(name)
			desc = initial(desc)
	return ..()

/atom/movable/screen/blob/jump_to_core/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	if(!blob.placed)
		blob.place_blob_core(BLOB_NORMAL_PLACEMENT)
	blob.transport_core()

/atom/movable/screen/blob/blobbernaut
	// Name and description get given their proper values on Initialize()
	name = "生产黏液巨兽（错误）"
	desc = "消耗（错误）资源，从黏液团工厂中生成一只强壮而有智慧的黏液巨兽。<br>使用的工厂会变得脆弱，且无法再生产孢子。"
	icon_state = "ui_blobbernaut"
	screen_loc = ui_belt

/atom/movable/screen/blob/blobbernaut/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	name = "生产黏液巨兽（[BLOBMOB_BLOBBERNAUT_RESOURCE_COST]）"
	desc = "消耗[BLOBMOB_BLOBBERNAUT_RESOURCE_COST]资源，从黏液团工厂中生成一只强壮而有智慧的黏液巨兽。<br>使用的工厂会变得脆弱，且无法再生产孢子。"

/atom/movable/screen/blob/blobbernaut/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	blob.create_blobbernaut()

/atom/movable/screen/blob/resource_blob
	// Name and description get given their proper values on Initialize()
	name = "生产资源黏液团（错误）"
	desc = "消耗错误数量的资源，生成资源黏液团。<br>资源黏液团每隔几秒就会为你提供资源。"
	icon_state = "ui_resource"
	screen_loc = ui_back

/atom/movable/screen/blob/resource_blob/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	name = "生产资源黏液团（[BLOB_STRUCTURE_RESOURCE_COST]）"
	desc = "消耗[BLOB_STRUCTURE_RESOURCE_COST]资源，生成资源黏液团。<br>资源黏液团每隔几秒就会为你提供资源。"

/atom/movable/screen/blob/resource_blob/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	blob.create_special(BLOB_STRUCTURE_RESOURCE_COST, /obj/structure/blob/special/resource, BLOB_RESOURCE_MIN_DISTANCE, TRUE)

/atom/movable/screen/blob/node_blob
	// Name and description get given their proper values on Initialize()
	name = "生产黏液团节点（错误）"
	desc = "消耗错误数量的资源，生成黏液团节点。<br>节点会向外扩张，并激活附近的资源黏液团和工厂。"
	icon_state = "ui_node"

/atom/movable/screen/blob/node_blob/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	name = "生产黏液团节点（[BLOB_STRUCTURE_NODE_COST]）"
	desc = "消耗[BLOB_STRUCTURE_NODE_COST]资源，生成黏液团节点。<br>节点会向外扩张，并激活附近的资源黏液团和工厂。"

/atom/movable/screen/blob/node_blob/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	blob.create_special(BLOB_STRUCTURE_NODE_COST, /obj/structure/blob/special/node, BLOB_NODE_MIN_DISTANCE, FALSE)

/atom/movable/screen/blob/factory_blob
	// Name and description get given their proper values on Initialize()
	name = "生产黏液团工厂（错误）"
	desc = "消耗错误数量的资源，生成黏液团工厂。<br>工厂每隔几秒就会生产孢子。"
	icon_state = "ui_factory"

/atom/movable/screen/blob/factory_blob/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	name = "生产黏液团工厂（[BLOB_STRUCTURE_FACTORY_COST]）"
	desc = "消耗[BLOB_STRUCTURE_FACTORY_COST]资源，生成黏液团工厂。<br>工厂每隔几秒就会生产孢子。"

/atom/movable/screen/blob/factory_blob/Click()
	if(!isovermind(usr))
		return FALSE
	var/mob/eye/blob/blob = usr
	blob.create_special(BLOB_STRUCTURE_FACTORY_COST, /obj/structure/blob/special/factory, BLOB_FACTORY_MIN_DISTANCE, TRUE)

/atom/movable/screen/blob/readapt_strain
	// Description gets given its proper values on Initialize()
	name = "重新适应品系"
	desc = "消耗错误数量的资源，从错误数量的随机选项中选择一个新品系。"
	icon_state = "ui_chemswap"
	screen_loc = ui_storage1

/atom/movable/screen/blob/readapt_strain/MouseEntered(location,control,params)
	if(hud?.mymob && isovermind(hud.mymob))
		var/mob/eye/blob/B = hud.mymob
		if(B.free_strain_rerolls)
			name = "[initial(name)]（免费）"
			desc = "免费随机重选你的品系。"
		else
			name = "[initial(name)] ([BLOB_POWER_REROLL_COST])"
			desc = "消耗[BLOB_POWER_REROLL_COST]资源，从[BLOB_POWER_REROLL_CHOICES]个随机选项中选择一个新品系。"
	return ..()

/atom/movable/screen/blob/readapt_strain/Click()
	if(isovermind(usr))
		var/mob/eye/blob/B = usr
		B.strain_reroll()

/atom/movable/screen/blob/relocate_core
	// Name and description get given their proper values on Initialize()
	name = "转移核心（错误）"
	desc = "消耗错误数量的资源，交换一个节点与你的核心的位置。"
	icon_state = "ui_swap"
	screen_loc = ui_storage2

/atom/movable/screen/blob/relocate_core/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	name = "转移核心（[BLOB_POWER_RELOCATE_COST]）"
	desc = "消耗[BLOB_POWER_RELOCATE_COST]资源，交换一个节点与你的核心的位置。"

/atom/movable/screen/blob/relocate_core/Click()
	if(isovermind(usr))
		var/mob/eye/blob/B = usr
		B.relocate_core()

/atom/movable/screen/blob/blob_power
	name = "黏液团能量"
	icon_state = "block"
	screen_loc = ui_health
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = ABOVE_HUD_PLANE
