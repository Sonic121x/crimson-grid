//map and direction signs

/obj/structure/sign/map
	name = "空间站地图"
	desc = "一张空间站导览图。"
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"
	desc = "一张已退役的旋臂星区SS-02空间站导览图：方盒级前哨站。"

/obj/structure/sign/map/right
	icon_state = "map-right"
	desc = "一张已退役的旋臂星区SS-02空间站导览图：方盒级前哨站。"

/obj/structure/sign/map/meta
	desc = "一张装框的空间站图。从顶部安保部（红色）顺时针看去，依次是工程部（黄色）、科研部（紫色）、\
			撤离区（红白色）、医疗区（绿色）、入站区（蓝白色），最后是货运部（棕色）。"

/obj/structure/sign/map/meta/left
	icon_state = "map-left-MS"

/obj/structure/sign/map/meta/right
	icon_state = "map-right-MS"

/obj/structure/sign/map/pubby
	icon_state = "map-pubby"

/obj/structure/sign/directions/science
	name = "科研部指路牌"
	desc = "指向科研部的方向指示牌。"
	icon_state = "direction_sci"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, 32)

/obj/structure/sign/directions/engineering
	name = "工程部指路牌"
	desc = "指向工程部的方向指示牌。"
	icon_state = "direction_eng"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, 32)

/obj/structure/sign/directions/security
	name = "安保部指路牌"
	desc = "指向安保部的方向指示牌。"
	icon_state = "direction_sec"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, 32)

/obj/structure/sign/directions/medical
	name = "医疗区指路牌"
	desc = "指向医疗区的方向指示牌。"
	icon_state = "direction_med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, 32)

/obj/structure/sign/directions/evac
	name = "撤离区指路牌"
	desc = "指向逃生穿梭机码头的方向指示牌。"
	icon_state = "direction_evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, 32)

/obj/structure/sign/directions/supply
	name = "货运部指路牌"
	desc = "指向货舱的方向指示牌。"
	icon_state = "direction_supply"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, 32)

/obj/structure/sign/directions/command
	name = "指挥部指路牌"
	desc = "指向指挥部的方向指示牌。"
	icon_state = "direction_bridge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, 32)

/obj/structure/sign/directions/vault
	name = "金库指路牌"
	desc = "指向空间站金库的方向指示牌。"
	icon_state = "direction_vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, 32)

/obj/structure/sign/directions/upload
	name = "上传室指路牌"
	desc = "指向空间站人工智能上传室的方向指示牌。"
	icon_state = "direction_upload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, 32)

/obj/structure/sign/directions/dorms
	name = "宿舍指路牌"
	desc = "指向宿舍的方向指示牌。"
	icon_state = "direction_dorms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms, 32)

/obj/structure/sign/directions/lavaland
	name = "熔岩指路牌"
	desc = "指向滚烫之物的方向指示牌。"
	icon_state = "direction_lavaland"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland, 32)

/obj/structure/sign/directions/arrival
	name = "入站区指路牌"
	desc = "指向入站穿梭机码头的方向指示牌。"
	icon_state = "direction_arrival"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival, 32)
