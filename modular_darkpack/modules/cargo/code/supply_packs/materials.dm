/datum/supply_pack/materials/iron50
	name = "50 iron Sheets"
	desc = "用来制作一批货箱。"
	cost = 400
	contains = list(/obj/item/stack/sheet/iron/fifty)
	crate_name = "铁板箱"
/datum/supply_pack/materials/New() { . = ..(); name = list("50 iron Sheets" = "50张铁板", "50 glass Sheets" = "50张玻璃板")[name] || name; }
/datum/supply_pack/materials/glass50
	name = "50 glass Sheets"
	desc = "用来制作一批窗户。"
	cost = 200
	contains = list(/obj/item/stack/sheet/glass/fifty)
	crate_name = "玻璃板箱"
