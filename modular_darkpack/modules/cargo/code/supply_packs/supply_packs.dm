// For items that exist in stores already, my current plan is a bulk order of 5-10 items with a 20% discount.
// This means the supply has to peddle off spare goods.
/datum/supply_pack/local
	group = "本地货品"
/datum/supply_pack/local/New() { . = ..(); name = list("Community Produce Seed Pack" = "社区果蔬种子包", "Community Flower Seed Pack" = "社区花卉种子包", "Plastic Planter Tray" = "塑料种植盘", "Hydroponics Tool Kit" = "水培工具套装", "Advanced Fertilizer" = "高级肥料", "Weed Supplies" = "大麻种植用品", "Fixing kit (wirecutters, lights)" = "维修套装（剪线钳、灯具）", "Door Repair Kit" = "门维修套装", "Medical Supplies" = "医疗用品", "Boxs of Handcuffs" = "盒装手铐", "Potassium Iodide" = "碘化钾", "Ephedrine" = "麻黄碱", "Gas Cans" = "汽油桶", "Thermal Drill" = "热能钻机")[name] || name; }
/datum/supply_pack/local/vegetable_supplies //behold, ordering legal things.
	name = "Community Produce Seed Pack" //aimed at helping the poorest members of community.
	desc = "包含多种适合社区或私人花园的种子。批量供应，价格更实惠。不含种植盘。"
	cost = 150
	contains = list(
		/obj/item/seeds/cabbage = 2,
		/obj/item/seeds/carrot = 2,
		/obj/item/seeds/corn = 2,
		/obj/item/seeds/onion = 2,
		/obj/item/seeds/carrot/parsnip = 2,
		/obj/item/seeds/peas = 2,
		/obj/item/seeds/potato = 2,
		/obj/item/seeds/pumpkin = 2,
		/obj/item/seeds/soya = 2,
		/obj/item/seeds/tomato = 2,
		/obj/item/seeds/apple = 2,
		/obj/item/seeds/wheat/rice = 2,
		/obj/item/seeds/wheat/oat = 2,
		/obj/item/seeds/aloe = 2,
	)
	crate_name = "果蔬种子箱"

/datum/supply_pack/local/flower_supplies
	name = "Community Flower Seed Pack" //verified as local, non-invasive from https://calscape.org/ & https://plants.usda.gov/
	desc = "包含多种花卉种子。不含种植盘。"
	cost = 150
	contains = list(
		/obj/item/seeds/poppy = 3,
		/obj/item/seeds/sunflower = 3,
		/obj/item/seeds/poppy/geranium = 3,
		/obj/item/seeds/poppy/lily = 3,
		// /obj/item/seeds/forgetmenot = 3,
	)
	crate_name = "花卉种子箱"

/*
/datum/supply_pack/local/hydro_tray
	name = "Hydroponics Tray"
	desc = "Everything you need to start your own hydroponics setup."
	cost = 1000
	contains = list(/obj/machinery/hydroponics/constructable)
	crate_name = "hydro crate"
*/

/datum/supply_pack/local/weed_tray
	name = "Plastic Planter Tray"
	desc = "包含一个用于栽种植物的种植盘。"
	cost = 300
	contains = list(/obj/machinery/hydroponics/simple/plastic/unanchored)
	crate_name = "种植盘箱"

/datum/supply_pack/local/hydro_supplies
	name = "Hydroponics Tool Kit"
	desc = "包含在家栽培植物所需的全套工具。"
	cost = 400
	contains = list(
		/obj/item/secateurs,
		/obj/item/cultivator/rake,
		/obj/item/cultivator,
		/obj/item/reagent_containers/spray/weedspray,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/shovel/spade,
		/obj/item/storage/bag/plants,
		/obj/item/reagent_containers/cup/bucket/wooden,
	)
	crate_name = "水培用品箱"

/datum/supply_pack/local/hydro_adv_supplies
	name = "Advanced Fertilizer"
	desc = "专为技艺精湛的家庭园艺爱好者调配的定制肥料。"
	cost = 500
	contains = list(
		/obj/item/reagent_containers/cup/bottle/nutrient/rh = 5,
		)
	crate_name = "水培用品箱"


/datum/supply_pack/local/weed_supplies
	name = "Weed Supplies"
	desc = "包含一把浇水壶和一些种子。不含种植盘。"
	cost = 100
	contains = list(
		/obj/item/reagent_containers/cup/watering_can/metal,
		/obj/item/seeds/cannabis = 5,
	)
	crate_name = "水培用品箱"

/* Does nothing atm
/datum/supply_pack/local/methlab
	name = "Lab Equipment"
	desc = "Contains lab equipment."
	cost = 4000
	contains = list(/obj/structure/methlab/movable)
*/

/datum/supply_pack/local/fixing
	name = "Fixing kit (wirecutters, lights)"
	desc = "包含剪线钳、灯具及其他用于恢复区域照明的用品。"
	cost = 100
	contains = list(/obj/item/wirecutters, /obj/item/storage/box/lights/mixed)

/*
/datum/supply_pack/local/window_kit
	name = "Window Repair Kit"
	desc = "Contains a window repair kit, good for 10 window replacements."
	cost = 250
	contains = list(/obj/item/window_repair_kit)
*/

/datum/supply_pack/local/door_kit
	name = "Door Repair Kit"
	desc = "包含一套门维修工具，可用来更换损坏的门。"
	cost = 200 // CRIMSON EDIT - Shop Inventories Additions - Original: cost = 1000
	contains = list(/obj/item/door_repair_kit)

/datum/supply_pack/local/medicalsupplies
	name = "Medical Supplies"
	desc = "包含一些急救用品。"
	cost = 500
	contains = list(
		/obj/item/stack/medical/wrap/gauze = 4,
		/obj/item/stack/medical/bruise_pack = 4,
		/obj/item/stack/medical/suture = 4,
		/obj/item/stack/medical/ointment = 4
	)

/datum/supply_pack/local/cuffs
	name = "Boxs of Handcuffs"
	desc = "包含数盒手铐。"
	cost = 400
	contains = list(/obj/item/storage/box/handcuffs = 4)
	crate_name = "手铐箱"

/datum/supply_pack/local/potassiodide
	name = "Potassium Iodide"
	desc = "包含数瓶碘化钾。"
	cost = /obj/item/storage/pill_bottle/potassiodide::custom_price * 4
	contains = list(/obj/item/storage/pill_bottle/potassiodide = 5)

/datum/supply_pack/local/ephedrine
	name = "Ephedrine"
	desc = "包含数瓶麻黄碱。"
	cost = /obj/item/storage/pill_bottle/ephedrine::custom_price * 4
	contains = list(/obj/item/storage/pill_bottle/ephedrine = 5)

/datum/supply_pack/local/gas_can
	name = "Gas Cans"
	desc = "包含数个汽油桶。"
	cost = /obj/item/gas_can/full::custom_price * 4
	contains = list(/obj/item/gas_can/full = 5)

/datum/supply_pack/local/thermal_drill
	name = "Thermal Drill"
	desc = "包含一台热能钻机。"
	cost = 4000
	contains = list(/obj/structure/drill)
	crate_name = "钻机箱"

/datum/supply_pack/medical/organs
	name = "Organs (Ethically sourced)"
	desc = "一箱人体器官。‘道德’是我们外科医生的名字。谢谢他吧！"
	cost = 7500
	crate_type = /obj/structure/closet/crate/freezer
	crate_name = "器官冷藏箱"
	contains = list(
		/obj/item/organ/heart,
		/obj/item/organ/lungs,
		/obj/item/organ/eyes,
		/obj/item/organ/ears,
		/obj/item/organ/tongue,
		/obj/item/organ/liver,
		/obj/item/organ/stomach,
		/obj/item/organ/appendix)
/datum/supply_pack/medical/organs/New() { . = ..(); name = list("Organs (Ethically sourced)" = "器官（道德来源）", "Organ Multi-pack (Ethically sourced)" = "器官组合装（道德来源）")[name] || name; }
/datum/supply_pack/medical/organs/multi
	name = "Organ Multi-pack (Ethically sourced)"
	desc = "一箱装得满满当当的人体器官。‘道德’是我们外科医生的名字。谢谢他吧！"
	cost = 29500
	contains = list(
		/obj/item/organ/heart = 4,
		/obj/item/organ/lungs = 4,
		/obj/item/organ/eyes = 4,
		/obj/item/organ/ears = 4,
		/obj/item/organ/tongue = 4,
		/obj/item/organ/liver = 4,
		/obj/item/organ/stomach = 4,
		/obj/item/organ/appendix = 4)
