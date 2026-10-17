/obj/item/storage/box/trackimp
	name = "追踪植入物套件盒"
	desc = "装满追踪混蛋所需工具的盒子。"
	icon_state = "secbox"
	illustration = "implant"

/obj/item/storage/box/trackimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/tracking = 4,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/minertracker
	name = "追踪植入物套件盒"
	desc = "用于寻找死在那该死熔岩世界上的人。"
	illustration = "implant"

/obj/item/storage/box/minertracker/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/tracking = 2,
		/obj/item/implantcase/beacon = 2,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
		/obj/item/locator = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/minerdeathrattle
	name = "远征临终讯号植入物套件盒"
	desc = "让你知道同事是死了，而不是故意不回通讯。需要手动设置。 \
		仅能报告发生在熔岩地带或冰月荒原野外的死亡。"
	illustration = "implant"

/obj/item/storage/box/minerdeathrattle/PopulateContents()
	var/static/items_inside = list(
		/obj/item/implantcase/deathrattle/lavaland = 5, // 3 miners 1 QM/paramed/etc, 1 for saving config, presumably
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/chemimp
	name = "化学植入物套件盒"
	desc = "装有植入化学物质所需物品的盒子。"
	illustration = "implant"

/obj/item/storage/box/chemimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/chem = 5,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/exileimp
	name = "流放植入物套件盒"
	desc = "装有流放植入物的盒子，上面画着小丑被一脚踢进传送门。"
	illustration = "implant"

/obj/item/storage/box/exileimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/exile = 5,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/beaconimp
	name = "信标植入物套件盒"
	desc = "内有一套信标植入物。侧面的警示标签提醒你务必检查传送目的地是否安全， \
		旁边画着笑容满面的安保警官，说着“先看清，再跳！”"
	illustration = "implant"

/obj/item/storage/box/beaconimp/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/beacon = 3,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/teleport_blocker
	name = "蓝空间接地植入物套件盒"
	desc = "装有蓝空间接地植入物的盒子，侧面画着一个身披威严长袍的人，皱着眉头流下一滴泪。"
	illustration = "implant"

/obj/item/storage/box/teleport_blocker/PopulateContents()
	var/list/items_inside = list(
		/obj/item/implantcase/teleport_blocker = 2,
		/obj/item/implanter = 1,
		/obj/item/implantpad = 1,
	)
	generate_items_inside(items_inside,src)

//BOX O' IMPLANTS
/obj/item/storage/box/cyber_implants
	name = "义体植入物盒"
	desc = "一个光滑结实的盒子。"
	icon_state = "cyber_implants"

/obj/item/storage/box/cyber_implants/PopulateContents()
	new /obj/item/autosurgeon/syndicate/xray_eyes(src)
	new /obj/item/autosurgeon/syndicate/anti_stun(src)
	new /obj/item/autosurgeon/syndicate/reviver(src)
