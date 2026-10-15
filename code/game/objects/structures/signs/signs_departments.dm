//departmental signs

/obj/structure/sign/departments
	is_editable = TRUE

///////MEDBAY

/obj/structure/sign/departments/med
	name = "\improper 医疗区标牌"
	sign_change_name = "部门——医疗区"
	desc = "标示医疗部门区域的标牌。"
	icon_state = "med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/med, 32)

/obj/structure/sign/departments/med_alt
	name = "\improper 医疗区标牌"
	sign_change_name = "部门——医疗区（另一款式）"
	icon_state = "medbay"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/med_alt, 32)

/obj/structure/sign/departments/medbay
	name = "\improper 医疗区标牌"
	sign_change_name = "通用医疗标志"
	desc = "星际通用的医疗机构标志。你大概能在这里得到帮助。"
	icon_state = "bluecross"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/medbay, 32)

/obj/structure/sign/departments/medbay/alt
	name = "\improper 医疗区标牌"
	sign_change_name = "通用医疗标志（另一款式）"
	icon_state = "bluecross2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/medbay/alt, 32)

/obj/structure/sign/departments/exam_room
	name = "\improper 诊室标牌"
	sign_change_name = "部门——医疗区：诊室"
	desc = "一块写着“诊室”的指示牌。"
	icon_state = "examroom"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/exam_room, 32)

/obj/structure/sign/departments/chemistry
	name = "\improper 化学室标牌"
	sign_change_name = "部门——医疗区：化学室"
	desc = "标示配有化学设备的区域的标牌。"
	icon_state = "chemistry1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry, 32)

/obj/structure/sign/departments/chemistry/alt
	sign_change_name = "部门——医疗区：化学室（另一款式）"
	icon_state = "chemistry2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry/alt, 32)

/obj/structure/sign/departments/chemistry/pharmacy
	name = "\improper 药房标牌"
	sign_change_name = "部门——医疗区：药房"
	desc = "标示配有制药设备的区域的标牌。"
	icon_state = "pharmacy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry/pharmacy, 32)

/obj/structure/sign/departments/psychology
	name = "\improper 心理咨询室标牌"
	sign_change_name = "部门——医疗区：心理咨询室"
	desc = "标示心理医生工作区域的标牌。他们大概能帮你理清思绪。"
	icon_state = "psychology"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/psychology, 32)

/obj/structure/sign/departments/virology
	name = "\improper 病毒实验室标牌"
	sign_change_name = "部门——医疗区：病毒实验室"
	desc = "标示病毒学家实验室所在区域的标牌。"
	icon_state = "pharmacy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/virology, 32)

/obj/structure/sign/departments/morgue
	name = "\improper 停尸间标牌"
	sign_change_name = "部门——医疗区：停尸间"
	desc = "标示空间站存放日益堆积的尸体的区域的标牌。"
	icon_state = "morgue"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/morgue, 32)

///////ENGINEERING

/obj/structure/sign/departments/engineering
	name = "\improper 工程部标牌"
	sign_change_name = "部门——工程部"
	desc = "标示工程师工作区域的标牌。"
	icon_state = "engine"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/engineering, 32)

/obj/structure/sign/departments/atmospherics
	name = "\improper 大气部标牌"
	sign_change_name = "部门——工程部：大气部"
	desc = "标示维持你生命的空气来源地的标牌。"
	icon_state = "atmos"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/atmospherics, 32)

///////SCIENCE

/obj/structure/sign/departments/science
	name = "\improper 科研部标牌"
	sign_change_name = "部门——科研部"
	desc = "标示开展科学研究的区域的标牌。"
	icon_state = "science1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/science, 32)

/obj/structure/sign/departments/science/alt
	sign_change_name = "部门——科研部（另一款式）"
	icon_state = "science2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/science/alt, 32)

/obj/structure/sign/departments/xenobio
	name = "\improper 异星生物实验室标牌"
	sign_change_name = "部门——科研部：异星生物实验室"
	desc = "标示研究异星生物的区域的标牌。"
	icon_state = "xenobio1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/xenobio, 32)

/obj/structure/sign/departments/xenobio/alt
	sign_change_name = "部门——科研部：异星生物实验室（另一款式）"
	icon_state = "xenobio2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/xenobio/alt, 32)

/obj/structure/sign/departments/genetics
	name = "\improper 遗传实验室标牌"
	sign_change_name = "部门——科研部：遗传实验室"
	desc = "标示开展遗传学研究的区域的标牌。"
	icon_state = "gene"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/genetics, 32)

/obj/structure/sign/departments/rndserver
	name ="\improper 研发服务器标牌"
	sign_change_name = "部门——科研部：研发服务器"
	desc = "标示储存科研数据的区域的标牌。"
	icon_state = "rndserver"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/rndserver, 32)

///////SERVICE

/obj/structure/sign/departments/botany
	name = "\improper 植物培育室标牌"
	sign_change_name = "部门——植物培育室（花朵）"
	desc = "标示植物种植区域的标牌。"
	icon_state = "hydro1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany, 32)

/obj/structure/sign/departments/botany/alt1
	sign_change_name = "部门——植物培育室（种植盘）"
	icon_state = "hydro2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt1, 32)

/obj/structure/sign/departments/botany/alt2
	sign_change_name = "部门——植物培育室（浇水壶）"
	icon_state = "hydro3"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt2, 32)

/obj/structure/sign/departments/botany/botany/alt3
	sign_change_name = "部门——植物培育室（种植盘另一款式）"
	icon_state = "botany"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt3, 32)

/obj/structure/sign/departments/custodian
	name = "\improper 清洁工房间标牌"
	sign_change_name = "部门——清洁工"
	desc = "标示清洁工工作区域的标牌。"
	icon_state = "custodian1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/custodian, 32)

/obj/structure/sign/departments/custodian_alt
	name = "\improper 清洁工房间标牌"
	sign_change_name = "部门——清洁工（另一款式）"
	desc = "标示清洁工工作区域的标牌。"
	icon_state = "custodian2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/custodian_alt, 32)

/obj/structure/sign/departments/holy
	name = "\improper 礼拜堂标牌"
	sign_change_name = "部门——礼拜堂"
	desc = "标示宗教活动区域的标牌。"
	icon_state = "holy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/holy, 32)

/obj/structure/sign/departments/holy_alt
	name = "\improper 礼拜堂标牌"
	sign_change_name = "部门——礼拜堂（另一款式）"
	desc = "标示宗教活动区域的标牌。"
	icon_state = "chapel"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/holy, 32)

/obj/structure/sign/departments/lawyer
	name = "\improper 法务部标牌"
	sign_change_name = "部门——法务部"
	desc = "标示律师工作区域的标牌。乘入站穿梭机扭伤了脖子，可来这里申请赔偿。"
	icon_state = "lawyer"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/lawyer, 32)

/obj/structure/sign/departments/restaurant
	name = "\improper 餐厅标牌"
	sign_change_name = "部门——餐厅"
	desc = "标示供应食物的区域的标牌。"
	icon_state = "restaurant"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/restaurant, 32)

/obj/structure/sign/departments/bar
	name = "\improper 酒吧标牌"
	sign_change_name = "部门——酒吧"
	desc = "标示调制饮品的区域的标牌。"
	icon_state = "bar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/bar, 32)

///////SUPPLY

/obj/structure/sign/departments/cargo
	name = "\improper 货运部标牌"
	sign_change_name = "部门——货运部"
	desc = "标示货船停靠区域的标牌。"
	icon_state = "cargo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/cargo, 32)

/obj/structure/sign/departments/exodrone
	name = "\improper 探索无人机标牌"
	sign_change_name = "部门——货运部：探索无人机"
	desc = "标示使用探索无人机的区域的标牌。"
	icon_state = "exodrone"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/exodrone, 32)

///////SECURITY

/obj/structure/sign/departments/security
	name = "\improper 安保部标牌"
	sign_change_name = "部门——安保部"
	desc = "标示法律说了算的区域的标牌。"
	icon_state = "security"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/security, 32)

////MISC LOCATIONS

/obj/structure/sign/departments/restroom
	name = "\improper 卫生间标牌"
	sign_change_name = "地点——卫生间"
	desc = "标示卫生间的标牌。"
	icon_state = "restroom"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/restroom, 32)

/obj/structure/sign/departments/maint
	name = "\improper 维护通道标牌"
	sign_change_name = "地点——维护通道"
	desc = "标示连接空间站各部门的区域的标牌。"
	icon_state = "mait1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/maint, 32)

/obj/structure/sign/departments/maint/alt
	name = "\improper 维护通道标牌"
	sign_change_name = "地点——维护通道（另一款式）"
	desc = "标示连接空间站各部门的区域的标牌。"
	icon_state = "mait2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/maint/alt, 32)

/obj/structure/sign/departments/evac
	name = "\improper 撤离区标牌"
	sign_change_name = "地点——撤离区"
	desc = "标示执行撤离流程的区域的标牌。"
	icon_state = "evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/evac, 32)

/obj/structure/sign/departments/drop
	name = "\improper 空降舱标牌"
	sign_change_name = "地点——空降舱"
	desc = "标示空降舱装载区域的标牌。"
	icon_state = "drop"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/drop, 32)

/obj/structure/sign/departments/court
	name = "\improper 法庭标牌"
	sign_change_name = "地点——法庭"
	desc = "标示法庭的标牌，神圣不可侵犯的太空法在这里得到维护。"
	icon_state = "court"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/court, 32)

/obj/structure/sign/departments/telecomms
	name = "\improper 通讯机房标牌"
	sign_change_name = "地点——通讯机房"
	desc = "标示空间站无线电与纳诺网络服务器所在区域的标牌。"
	icon_state = "telecomms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/telecomms, 32)

/obj/structure/sign/departments/telecomms/alt
	icon_state = "telecomms2"
	sign_change_name = "地点——通讯机房（另一款式）"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/telecomms/alt, 32)

/obj/structure/sign/departments/aiupload
	name = "\improper 人工智能上传室标牌"
	sign_change_name = "地点——人工智能上传室"
	desc = "标示向空间站人工智能与机器人上传法则的区域的标牌。"
	icon_state = "aiupload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/aiupload, 32)

/obj/structure/sign/departments/aisat
	name = "\improper 人工智能卫星标牌"
	sign_change_name = "地点——人工智能卫星"
	desc = "标示人工智能那座戒备森严的卫星的标牌。"
	icon_state = "aisat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/aisat, 32)

/obj/structure/sign/departments/vault
	name = "\improper 金库标牌"
	sign_change_name = "地点——金库"
	desc = "标示存放空间站资源和自毁装置的安全室的标牌。"
	icon_state = "vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/vault, 32)
