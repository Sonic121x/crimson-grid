//warning signs


///////DANGEROUS THINGS

/obj/structure/sign/warning
	name = "\improper 警告标牌"
	sign_change_name = "警告"
	desc = "一块警告标牌。"
	icon_state = "securearea"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning, 32)

/obj/structure/sign/warning/secure_area
	name = "\improper 管制区域标牌"
	sign_change_name = "警告——管制区域"
	desc = "一块写着“管制区域”的警告标牌。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)
MAPPING_DIAGONAL_HELPERS(/obj/structure/sign/warning/secure_area, 32)

/obj/structure/sign/warning/docking
	name = "\improper 停靠区域禁止逗留标牌"
	sign_change_name = "警告——停靠区域"
	desc = "一块写着“停靠区域禁止逗留”的警告标牌。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/docking, 32)

/obj/structure/sign/warning/biohazard
	name = "\improper 生物危害标牌"
	sign_change_name = "警告——生物危害"
	desc = "一块写着“生物危害”的警告标牌。"
	icon_state = "bio"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/biohazard, 32)

/obj/structure/sign/warning/electric_shock
	name = "\improper 高压电标牌"
	sign_change_name = "警告——高压电"
	desc = "一块写着“高压电”的警告标牌。"
	icon_state = "shock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/electric_shock, 32)

/obj/structure/sign/warning/vacuum
	name = "\improper 前方高真空标牌"
	sign_change_name = "警告——高真空"
	desc = "一块写着“前方高真空”的警告标牌。"
	icon_state = "space"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum, 32)

/obj/structure/sign/warning/vacuum/external
	name = "\improper 外部气闸标牌"
	sign_change_name = "警告——外部气闸"
	desc = "一块写着“外部气闸”的警告标牌。"
	layer = MOB_LAYER

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/vacuum/external, 32)

/obj/structure/sign/warning/deathsposal
	name = "\improper 废弃物管道通往太空标牌"
	sign_change_name = "警告——废弃物管道：通往太空"
	desc = "一块写着“废弃物管道：通往太空”的警告标牌。"
	icon_state = "deathsposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/deathsposal, 32)

/obj/structure/sign/warning/bodysposal
	name = "\improper 废弃物管道通往停尸间标牌"
	sign_change_name = "警告——废弃物管道：通往停尸间"
	desc = "一块写着“废弃物管道：通往停尸间”的警告标牌。"
	icon_state = "bodysposal"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/bodysposal, 32)

/obj/structure/sign/warning/fire
	name = "\improper 当心火灾标牌"
	sign_change_name = "警告——火灾危险"
	desc = "一块写着“危险：当心火灾”的警告标牌。"
	icon_state = "fire"
	resistance_flags = FIRE_PROOF

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/fire, 32)

/obj/structure/sign/warning/no_smoking
	name = "\improper 禁止吸烟标牌"
	sign_change_name = "警告——禁止吸烟"
	desc = "一块写着“禁止吸烟”的警告标牌。"
	icon_state = "nosmoking2"
	resistance_flags = FLAMMABLE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking, 32)

/obj/structure/sign/warning/no_smoking/circle
	name = "\improper 禁止吸烟标牌"
	sign_change_name = "警告——禁止吸烟（另一款式）"
	desc = "一块写着“禁止吸烟”的警告标牌。"
	icon_state = "nosmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/no_smoking/circle, 32)

/obj/structure/sign/warning/yes_smoking/circle
	name = "\improper 允许吸烟标牌"
	sign_change_name = "警告——允许吸烟"
	desc = "一块写着“允许吸烟”的警告标牌。"
	icon_state = "yessmoking"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/yes_smoking/circle, 32)

/obj/structure/sign/warning/radiation
	name = "\improper 辐射危险标牌"
	sign_change_name = "警告——辐射"
	desc = "提醒人们注意潜在辐射危险的警告标牌。"
	icon_state = "radiation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation, 32)

/obj/structure/sign/warning/radiation/rad_area
	name = "\improper 放射性区域标牌"
	sign_change_name = "警告——放射性区域"
	desc = "一块写着“放射性区域”的警告标牌。"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/radiation/rad_area, 32)

/obj/structure/sign/warning/xeno_mining
	name = "\improper 危险外星生物标牌"
	sign_change_name = "警告——外星生物"
	desc = "提醒准备前行的旅人附近存在敌对外星生物的标牌。"
	icon = 'icons/obj/signs.dmi'
	icon_state = "xeno_warning"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/xeno_mining, 32)

/obj/structure/sign/warning/engine_safety
	name = "\improper 工程安全标牌"
	sign_change_name = "警告——工程安全规程"
	desc = "详细列出现场作业各项安全规程、保障当班安全的标牌。"
	icon_state = "safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/engine_safety, 32)

/obj/structure/sign/warning/explosives
	name = "\improper 高爆炸药标牌"
	sign_change_name = "警告——爆炸物"
	desc = "一块写着“高爆炸药”的警告标牌。"
	icon_state = "explosives"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives, 32)

/obj/structure/sign/warning/explosives/alt
	name = "\improper 高爆炸药标牌"
	sign_change_name = "警告——爆炸物（另一款式）"
	desc = "一块写着“高爆炸药”的警告标牌。"
	icon_state = "explosives2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/explosives/alt, 32)

/obj/structure/sign/warning/test_chamber
	name = "\improper 试验区域标牌"
	sign_change_name = "警告——试验区域"
	desc = "警告此区域内有高功率试验设备的标牌。"
	icon_state = "testchamber"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/test_chamber, 32)

/obj/structure/sign/warning/firing_range
	name = "\improper 射击场标牌"
	sign_change_name = "警告——射击场"
	desc = "提醒你待在射击线后方并佩戴听力防护用品的标牌。"
	icon_state = "firingrange"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/firing_range, 32)

/obj/structure/sign/warning/cold_temp
	name = "\improper 极寒空气标牌"
	sign_change_name = "警告——温度：极寒"
	desc = "警告附近空气极其寒冷的标牌。"
	icon_state = "cold"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/cold_temp, 32)

/obj/structure/sign/warning/hot_temp
	name = "\improper 过热空气标牌"
	sign_change_name = "警告——温度：酷热"
	desc = "警告附近空气极其炎热的标牌。"
	icon_state = "heat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/hot_temp, 32)

/obj/structure/sign/warning/gas_mask
	name = "\improper 空气污染标牌"
	sign_change_name = "警告——空气污染"
	desc = "警告空气中存在危险颗粒或气体，并要求使用内部供气设备的标牌。"
	icon_state = "gasmask"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/gas_mask, 32)

/obj/structure/sign/warning/chem_diamond
	name = "\improper 活性化学品标牌"
	sign_change_name = "警告——危险化学品"
	desc = "警告附近可能存在易发生反应的化学品，包括爆炸性、易燃或酸性物质的标牌。"
	icon_state = "chemdiamond"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/chem_diamond, 32)

/obj/structure/sign/warning/doors
	name = "\improper 防爆门标牌"
	sign_change_name = "警告——防爆门"
	desc = "告诉你这里有门的标牌。到处都是门啊！"
	icon_state = "doors"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/doors, 32)

////MISC LOCATIONS

/obj/structure/sign/warning/pods
	name = "\improper 逃生舱标牌"
	sign_change_name = "地点——逃生舱"
	desc = "一块写着“逃生舱”的警告标牌。"
	icon_state = "pods"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/pods, 32)

/obj/structure/sign/warning/rad_shelter
	name = "\improper 辐射风暴避难所标牌"
	sign_change_name = "地点——辐射风暴避难所"
	desc = "一块写着“辐射风暴避难所”的警告标牌。"
	icon_state = "radshelter"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/warning/rad_shelter, 32)
