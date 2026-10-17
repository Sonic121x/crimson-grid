// This file contains all boxes used by the Science department and its purpose on the station.

/obj/item/storage/box/swab
	name = "微生物采样拭子盒"
	desc = "内有多支用于采集微生物样本的无菌拭子。"
	illustration = "swab"

/obj/item/storage/box/swab/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/swab(src)

/obj/item/storage/box/petridish
	name = "培养皿盒"
	desc = "这盒子声称装有多个高边培养皿。"
	illustration = "petridish"

/obj/item/storage/box/petridish/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/petri_dish(src)

/obj/item/storage/box/plumbing
	name = "管道用品盒"
	desc = "内有少量管道、水回收器和铁，用于接入空间站其他部分。"

//Disk boxes

/obj/item/storage/box/disks
	name = "软盘盒"
	illustration = "disk_kit"
	desc = "八张纳诺传讯认证软盘，均为独立包装。"

/obj/item/storage/box/disks/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/delivery/small/floppy(src)

/obj/item/storage/box/monkeycubes
	name = "猴子方块盒"
	desc = "干伴牌猴子方块，加水即用！"
	icon_state = "monkeycubebox"
	illustration = null
	custom_price = PAYCHECK_CREW * 2
	storage_type = /datum/storage/box/monkey_cube
	/// Which type of cube are we spawning in this box?
	var/cube_type = /obj/item/food/monkeycube

/obj/item/storage/box/monkeycubes/PopulateContents()
	for(var/i in 1 to 5)
		new cube_type(src)

/obj/item/storage/box/monkeycubes/syndicate
	desc = "华夫公司牌猴子方块，加水和一点阴谋即可！"
	cube_type = /obj/item/food/monkeycube/syndicate

/obj/item/storage/box/monkeycubes/random
	name = "怪物方块盒"
	desc = "装有一堆随机方块的盒子，加水看看会出来什么！"
	cube_type = /obj/item/food/monkeycube/random

/obj/item/storage/box/gorillacubes
	name = "大猩猩方块盒"
	desc = "华夫公司牌大猩猩方块，请勿挑衅。"
	icon_state = "monkeycubebox"
	illustration = null
	storage_type = /datum/storage/box/gorilla_cube_box

/obj/item/storage/box/gorillacubes/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/food/monkeycube/gorilla(src)

/obj/item/storage/box/stockparts/basic //for ruins where it's a bad idea to give access to an autolathe/protolathe, but still want to make stock parts accessible
	name = "机器零件盒"
	desc = "内有各类基础机器零件。"

/obj/item/storage/box/stockparts/basic/PopulateContents()
	var/list/items_inside = list(
		/obj/item/stock_parts/capacitor = 3,
		/obj/item/stock_parts/servo = 3,
		/obj/item/stock_parts/matter_bin = 3,
		/obj/item/stock_parts/micro_laser = 3,
		/obj/item/stock_parts/scanning_module = 3,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/stockparts/deluxe
	name = "高级机器零件盒"
	desc = "内有各类高级机器零件。"
	icon_state = "syndiebox"

/obj/item/storage/box/stockparts/deluxe/PopulateContents()
	var/list/items_inside = list(
		/obj/item/stock_parts/capacitor/quadratic = 3,
		/obj/item/stock_parts/scanning_module/triphasic = 3,
		/obj/item/stock_parts/servo/femto = 3,
		/obj/item/stock_parts/micro_laser/quadultra = 3,
		/obj/item/stock_parts/matter_bin/bluespace = 3,
		)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/rndboards
	name = "\proper 解放者的遗产"
	desc = "盒中装有赠予配得上它的魔像的礼物。"
	illustration = "scicircuit"

/obj/item/storage/box/rndboards/PopulateContents()
	new /obj/item/circuitboard/machine/protolathe/offstation(src)
	new /obj/item/circuitboard/machine/destructive_analyzer(src)
	new /obj/item/circuitboard/machine/circuit_imprinter/offstation(src)
	new /obj/item/circuitboard/computer/rdconsole/unlocked(src)

/obj/item/storage/box/stabilized //every single stabilized extract from xenobiology
	name = "稳定提取物盒"
	icon_state = "syndiebox"
	storage_type = /datum/storage/box/stabilized

/obj/item/storage/box/stabilized/PopulateContents()
	var/list/items_inside = list(
		/obj/item/slimecross/stabilized/adamantine=1,
		/obj/item/slimecross/stabilized/black=1,
		/obj/item/slimecross/stabilized/blue=1,
		/obj/item/slimecross/stabilized/bluespace=1,
		/obj/item/slimecross/stabilized/cerulean=1,
		/obj/item/slimecross/stabilized/darkblue=1,
		/obj/item/slimecross/stabilized/darkpurple=1,
		/obj/item/slimecross/stabilized/gold=1,
		/obj/item/slimecross/stabilized/green=1,
		/obj/item/slimecross/stabilized/grey=1,
		/obj/item/slimecross/stabilized/lightpink=1,
		/obj/item/slimecross/stabilized/metal=1,
		/obj/item/slimecross/stabilized/oil=1,
		/obj/item/slimecross/stabilized/orange=1,
		/obj/item/slimecross/stabilized/pink=1,
		/obj/item/slimecross/stabilized/purple=1,
		/obj/item/slimecross/stabilized/pyrite=1,
		/obj/item/slimecross/stabilized/rainbow=1,
		/obj/item/slimecross/stabilized/red=1,
		/obj/item/slimecross/stabilized/sepia=1,
		/obj/item/slimecross/stabilized/silver=1,
		/obj/item/slimecross/stabilized/yellow=1,
		)
	generate_items_inside(items_inside,src)
