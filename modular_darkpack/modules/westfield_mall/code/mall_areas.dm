/area/vtm/westfield_mall
	name = "Mall Exterior"
	outdoors = TRUE
	icon_state = "outside"
	icon = 'modular_darkpack/modules/westfield_mall/icons/mall_areas.dmi'
/area/vtm/westfield_mall/Initialize(mapload) { GLOB.localized_darkpack_area_names += list("Mall Exterior" = "购物中心外部", "Westfield Drive Skatepark" = "韦斯特菲尔德大道滑板公园", "Westfield Mall" = "韦斯特菲尔德购物中心", "Beralta Skateshop" = "贝拉尔塔滑板店", "Staff Only Area" = "员工专用区", "Staff Only Area, Floor -1" = "员工专用区－地下一层", "Staff Only Area, Floor 2" = "员工专用区－二层", "Staff Only Area, Roof" = "员工专用区－屋顶", "Parking Lot" = "停车场", "Subterranean Parking Lot" = "地下停车场", "\improper Public Restroom" = "\improper 公共卫生间", "Penzera Foodcourt at Westfield" = "韦斯特菲尔德彭泽拉美食广场", "Combination Gummaguts Bubway Bacotell" = "咕玛肚、巴布威与巴可特尔联合餐厅", "Beffley's Green Grocer" = "贝夫利蔬果店", "Lick Ur Chops Deli and Butcher" = "垂涎欲滴熟食肉铺", "Master Controller Arcade" = "主控游戏厅", "Paqadube Smokestuff and Tobacco" = "帕卡杜布烟具烟草店", "Snarshals Clothing and Fabric" = "斯纳歇尔服装布料店", "Westfield Management" = "韦斯特菲尔德管理处", "Silchester & Thorne Body Art" = "西尔切斯特与索恩身体艺术工作室", "Noble's Books" = "诺布尔书店", "Nottingham's Pet Emporium" = "诺丁汉宠物百货", "Custodial Office" = "保洁办公室", "Matrak Self-Defence" = "马特拉克防身术道馆", "Absolute Cinema" = "绝对影院", "Transistor Town Hobbyist Electronics" = "晶体管小镇电子爱好者商店", "Bianchi Banking Westfield Branch" = "比安基银行韦斯特菲尔德分行", "Trout Expert Store" = "鳟鱼专家商店", "Glamour Games" = "迷魅游戏店", "Rosie Confections" = "罗茜糖果店", "The Drawn Line" = "线条美术用品店", "Groundskeeping Garage" = "园林维护车库", "Venture Law LLC" = "开拓法律事务有限公司", "Forest Cave" = "森林洞穴", "Logging Facility" = "伐木设施"); return ..(); }
/area/vtm/westfield_mall/skatepark
	name = "Westfield Drive Skatepark"
	icon_state = "skatepark"

/area/vtm/westfield_mall/interior
	name = "Westfield Mall"
	icon_state = "interior"
	ambience_index = AMBIENCE_OFFICE
	outdoors = FALSE

/area/vtm/westfield_mall/interior/skatepark
	name = "Beralta Skateshop"
	icon_state = "skatepark_interior"

/area/vtm/westfield_mall/interior/maintenance
	name = "Staff Only Area"
	icon_state = "staffonly"

/area/vtm/westfield_mall/interior/maintenance/basement
	name = "Staff Only Area, Floor -1"
	icon_state = "staffonly_basement"

/area/vtm/westfield_mall/interior/maintenance/atrium
	name = "Staff Only Area, Floor 2"
	icon_state = "staffonly_atrium"

/area/vtm/westfield_mall/interior/maintenance/roof
	name = "Staff Only Area, Roof"
	icon_state = "staffonly_roof"

/area/vtm/westfield_mall/parking_lot
	name = "Parking Lot"
	icon_state = "parking"
/area/vtm/westfield_mall/interior/underground_parking
	name = "Subterranean Parking Lot"
	icon_state = "parking_interior"

/area/vtm/westfield_mall/interior/bathroom
	name = "\improper Public Restroom"
	icon_state = "pooper"

/area/vtm/westfield_mall/interior/foodcourt
	name = "Penzera Foodcourt at Westfield"
	icon_state = "foodcourt"

/area/vtm/westfield_mall/interior/foodcourt/restaurant
	name = "Combination Gummaguts Bubway Bacotell"
	icon_state = "foodcourt2"

/area/vtm/westfield_mall/interior/foodcourt/grocery
	name = "Beffley's Green Grocer"
	icon_state = "foodcourt3"

/area/vtm/westfield_mall/interior/foodcourt/deli
	name = "Lick Ur Chops Deli and Butcher"
	icon_state = "foodcourt4"

/area/vtm/westfield_mall/interior/arcade
	name = "Master Controller Arcade"
	icon_state = "arcade"

/area/vtm/westfield_mall/interior/smokeshop
	name = "Paqadube Smokestuff and Tobacco"
	icon_state = "smoke_shop"

/area/vtm/westfield_mall/interior/clothing_store
	name = "Snarshals Clothing and Fabric"
	icon_state = "clothing"
/area/vtm/westfield_mall/interior/hot_ishu
	name = "Hot Ishu"
	icon_state = "clothing_ishu"

/area/vtm/westfield_mall/interior/camarilla
	name = "Westfield Management"
	icon_state = "camallrilla"

/area/vtm/westfield_mall/interior/anarch
	name = "Silchester & Thorne Body Art"
	icon_state = "anarch"

/area/vtm/westfield_mall/interior/chantry
	name = "Noble's Books"
	icon_state = "chantry"

/area/vtm/westfield_mall/interior/vet_clinic
	name = "Nottingham's Pet Emporium"
	icon_state = "vet"

/area/vtm/westfield_mall/interior/janitor
	name = "Custodial Office"
	icon_state = "janitor"

/area/vtm/westfield_mall/interior/dojo
	name = "Matrak Self-Defence"
	icon_state = "dojo"

/area/vtm/westfield_mall/interior/theatre
	name = "Absolute Cinema"
	icon_state = "arcade"

/area/vtm/westfield_mall/interior/techshop
	name = "Transistor Town Hobbyist Electronics"
	icon_state = "tech"

/area/vtm/westfield_mall/interior/bank
	name = "Bianchi Banking Westfield Branch"
	icon_state = "bank"

/area/vtm/westfield_mall/interior/supply
	name = "Trout Expert Store"
	icon_state = "supply"

/area/vtm/westfield_mall/interior/games_store
	name = "Glamour Games"
	icon_state = "arcade"

/area/vtm/westfield_mall/interior/candy_store
	name = "Rosie Confections"
	icon_state = "arcade"

/area/vtm/westfield_mall/interior/art_store
	name = "The Drawn Line"
	icon_state = "arcade"

/area/vtm/westfield_mall/interior/groundskeeper_garage
	name = "Groundskeeping Garage"
	icon_state = "janitor"

/area/vtm/westfield_mall/interior/groundskeeper_garage
	name = "Groundskeeping Garage"
	icon_state = "janitor"

/area/vtm/westfield_mall/interior/law_office
	name = "Venture Law LLC"
	icon_state = "bank"

/area/vtm/westfield_mall/interior/cave
	name = "Forest Cave"

/area/vtm/westfield_mall/forest
	name = "Forest"

/area/vtm/westfield_mall/interior/endron_logging
	name = "Logging Facility"
