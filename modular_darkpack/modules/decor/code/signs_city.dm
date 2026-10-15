//Considering having a subtype of this for "hanging" signs
/obj/structure/sign/city
	icon = 'modular_darkpack/modules/decor/icons/city_sign.dmi'

/obj/structure/sign/city/get_turfs_to_mount_on()
	return list(get_step(src, dir))

/obj/structure/sign/city/police_department
	name = "\improper 旧金山警察局标牌"
	desc = "站住，你这犯罪渣滓！有我在，谁都别想违法！！"
	icon_state = "police1"
	pixel_z = 4

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/police_department, 32)

/obj/structure/sign/city/order
	name = "秩序标牌"
	icon_state = "order"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/order, 32)

/obj/structure/sign/city/hotel
	name = "招牌"
	desc = "上面写着：旅　馆。"
	icon_state = "hotel"
	//plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/hotel, 0)

/obj/structure/sign/city/hotel/Initialize(mapload)
	. = ..()
	set_light(3, 3, "#8e509e")
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"

/obj/structure/sign/city/millenium
	name = "招牌"
	desc = "上面写着：千　禧。"
	icon = 'modular_darkpack/modules/decor/icons/city_sign.dmi'
	icon_state = "millenium1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	dir = NORTH
	pixel_y = 32

/obj/structure/sign/city/millenium/Initialize(mapload)
	. = ..()
	set_light(3, 3, "#4299bb")

/obj/structure/sign/city/anarch
	name = "招牌"
	desc = "上面写着：酒　吧。"
	icon = 'modular_darkpack/modules/decor/icons/city_sign.dmi'
	icon_state = "bar"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	dir = WEST

/obj/structure/sign/city/anarch/Initialize(mapload)
	. = ..()
	set_light(3, 3, "#ffffff")
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"

/obj/structure/sign/city/chinese
	name = "招牌"
	desc = "阴雨天，可能会下血雨。"
	icon = 'modular_darkpack/modules/decor/icons/city_sign.dmi'
	icon_state = "chinese1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese, 0)

/obj/structure/sign/city/chinese/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"

/obj/structure/sign/city/chinese/alt
	icon_state = "chinese2"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese/alt, 0)

/obj/structure/sign/city/chinese/alt2
	icon_state = "chinese3"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese/alt2, 0)

/obj/structure/sign/city/chinese/alt3
	icon_state = "chinese4"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese/alt3, 0)

/obj/structure/sign/city/chinese/alt4
	icon_state = "chinese5"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese/alt4, 0)

/obj/structure/sign/city/chinese/alt5
	icon_state = "chinese6"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/chinese/alt5, 0)

// Hrm. Not synced with PRIMARY_NIGHTCLUB_COMPANY and it cant really be..
/obj/structure/sign/city/strip_club
	name = "招牌"
	desc = "上面写着：多　拉。也许是某种脱衣舞俱乐部……"
	icon = 'modular_darkpack/modules/deprecated/icons/48x48.dmi'
	icon_state = "dora"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	pixel_w = -8
	//pixel_z = 32

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/strip_club, 32)

/obj/structure/sign/city/strip_club/Initialize(mapload)
	. = ..()
	set_light(3, 2, "#8e509e")

/obj/structure/sign/city/cabaret_sign
	name = "歌舞厅招牌"
	desc = "一双诱人的美腿……不知道里面有什么？"
	icon = 'modular_darkpack/modules/decor/icons/cabaret.dmi'
	icon_state = "cabar"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/cabaret_sign, 32)

/obj/structure/sign/city/cabaret_sign/Initialize(mapload)
	. = ..()
	set_light(3, 2, "#d98aec")

/obj/structure/sign/city/cabaret_sign/two
	icon_state = "et"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/cabaret_sign/two, 32)

/obj/structure/sign/city/store
	icon = 'modular_darkpack/modules/decor/icons/store_sign.dmi'
	icon_state = "bacotell"
	anchored = TRUE
	pixel_w = -16

/obj/structure/sign/city/store/bacotell
	name = "巴可特尔"
	desc = "来尝尝美味的塔可和披萨吧！"
	icon_state = "bacotell"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/bacotell, 32)

/obj/structure/sign/city/store/bubway
	name = "巴布威"
	desc = "来尝尝美味的汉堡和披萨吧！"
	icon_state = "bubway"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/bubway, 32)

/obj/structure/sign/city/store/gummaguts
	name = "咕玛肚"
	desc = "来尝尝美味的鸡块和甜甜圈吧！"
	icon_state = "gummaguts"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/gummaguts, 32)

/obj/structure/sign/city/skateshop
	name = "贝拉尔塔滑板店"
	icon_state = "beralta1"
	desc = "鲍威尔·贝拉尔塔的名字虽然不太吉利，却是正宗山寨滑板界数一数二的响亮招牌。"

/obj/structure/sign/city/skateshop/two
	icon_state = "beralta2"

/obj/structure/sign/city/skateshop/three
	icon_state = "beralta3"

/obj/structure/sign/city/skateshop/four
	icon_state = "beralta4"
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/skateshop, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/skateshop/two, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/skateshop/three, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/skateshop/four, 32)

/obj/structure/sign/city/store/reddragon
	name = "红龙"
	desc = "来吃香喷喷的烈焰火面吧！"
	icon_state = "reddragon"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/reddragon, 32)

/obj/structure/sign/city/store/otolleys
	name = "奥托利"
	desc = "奥、奥、奥——奥托利，欢迎全家光临！"
	icon_state = "otolleys"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/otolleys, 32)

/obj/structure/sign/city/store/magadon
	name = "玛加顿公司"
	desc = "玛加顿：塑造更好的你。"
	icon_state = "magadon"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/city/store/magadon, 32)
