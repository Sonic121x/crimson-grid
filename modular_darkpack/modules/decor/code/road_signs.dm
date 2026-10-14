/obj/structure/roadsign
	name = "道路标志"
	desc = "开车可别不看路。"
	icon = 'modular_darkpack/modules/decor/icons/road_signs.dmi'
	icon_state = "stop"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/roadsign/stop
	name = "停车让行标志"
	icon_state = "stop"

/obj/structure/roadsign/fourway
	icon_state = "4way"

/obj/structure/roadsign/allway
	icon_state = "allway"

/obj/structure/roadsign/wrongway
	icon_state = "wrongway"

/obj/structure/roadsign/noparking
	name = "禁止停车标志"
	icon_state = "noparking"

/obj/structure/roadsign/noturnleft
	icon_state = "noturnleft"

/obj/structure/roadsign/noturnright
	icon_state = "noturnright"

/obj/structure/roadsign/noturnforward
	icon_state = "noturnforward"

/obj/structure/roadsign/noturnback
	icon_state = "noturnback"

/obj/structure/roadsign/nopedestrian
	name = "禁止行人通行标志"
	icon_state = "nopedestrian"

/obj/structure/roadsign/exitright
	icon_state = "exitright"

/obj/structure/roadsign/exitleft
	icon_state = "exitleft"


/obj/structure/roadsign/street
	name = "街道标牌"
	icon_state = "street"
	/// IF set, will override the getter for the area's name
	var/custom_street_name

/obj/structure/roadsign/street/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/roadsign/street/update_name(updates)
	. = ..()
	var/street_name = get_street_name()
	if(!street_name)
		return
	name = "街道标牌（[street_name]）"

/obj/structure/roadsign/street/update_desc(updates)
	. = ..()
	var/street_name = get_street_name()
	if(!street_name)
		return
	desc = "街道标牌，标明这里是\"[street_name]\"。"

/obj/structure/roadsign/street/proc/get_street_name()
	if(custom_street_name)
		return custom_street_name
	var/area/my_area = get_area(src)
	if(my_area)
		return my_area


/obj/structure/roadsign/onewayleft
	icon_state = "onewayleft"

/obj/structure/roadsign/onewayright
	icon_state = "onewayright"

/obj/structure/roadsign/busstop
	name = "公交站牌"
	icon_state = "busstop"

/obj/structure/roadsign/railcrossing
	icon_state = "railcrossing"

/obj/structure/roadsign/onlyforward
	icon_state = "onlyforward"

/obj/structure/roadsign/onlyright
	icon_state = "onlyright"

/obj/structure/roadsign/onlyleft
	icon_state = "onlyleft"

/obj/structure/roadsign/speedlimit
	name = "限速标志"
	icon_state = "speed50"

/obj/structure/roadsign/speedlimit40
	name = "限速标志"
	icon_state = "speed40"

/obj/structure/roadsign/speedlimit25
	name = "限速标志"
	icon_state = "speed25"

/obj/structure/roadsign/warningtrafficlight
	name = "注意交通信号灯标志"
	icon_state = "warningtrafficlight"

/obj/structure/roadsign/warningdeer
	icon_state = "warningdeer"

/obj/structure/roadsign/warningpedestrian
	name = "注意行人标志"
	icon_state = "warningpedestrian"

/obj/structure/roadsign/circleofdoom
	icon_state = "circleofdoom"

/obj/structure/roadsign/parking
	name = "停车标志"
	icon_state = "parking"

/obj/structure/roadsign/crosswalk
	name = "人行横道标志"
	icon_state = "crosswalk"
