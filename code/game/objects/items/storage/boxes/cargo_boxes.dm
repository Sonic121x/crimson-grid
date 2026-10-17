// This file contains all boxes used by the Cargo department and its purpose on the station.

/obj/item/storage/box/shipping
	name = "货运用品盒"
	desc = "内有运输货物所需的扫描器和标签工具，不含包装纸。"
	illustration = "shipping"

/obj/item/storage/box/shipping/PopulateContents()
	var/list/items_inside = list(
		/obj/item/dest_tagger = 1,
		/obj/item/universal_scanner = 1,
		/obj/item/stack/package_wrap/small = 2,
		/obj/item/stack/wrapping_paper/small = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/shipping/debug
	name = "大型货运用品盒"
	desc = "自建货运部门所需的一切。"

/obj/item/storage/box/shipping/debug/PopulateContents()
	var/list/items_inside = list(
		/obj/item/universal_scanner = 1,
		/obj/item/stack/package_wrap/small = 2,
		/obj/item/stack/wrapping_paper/small = 2,
		/obj/item/boulder_beacon = 1,
		/obj/item/stack/conveyor/thirty = 1,
		/obj/item/conveyor_switch_construct = 1,
		/obj/item/construction/plumbing = 1,
	)
	generate_items_inside(items_inside,src)
