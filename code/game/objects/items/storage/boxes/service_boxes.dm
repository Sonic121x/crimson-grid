// This file contains all boxes used by the Service department and its purpose on the station.
// Because we want to avoid some sort of "miscellaneous" file, let's put all the bureaucracy (pens and stuff) and the HoP's stuff here as well.

/obj/item/storage/box/drinkingglasses
	name = "玻璃饮料杯盒"
	desc = "上面印着玻璃饮料杯的图案。"
	illustration = "drinkglass"

/obj/item/storage/box/drinkingglasses/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/cup/glass/drinkingglass(src)
/obj/item/storage/box/cups
	name = "纸杯盒"
	desc = "正面印着纸杯图案。"
	illustration = "cup"

/obj/item/storage/box/cups/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/cup/glass/sillycup(src)

//Some spare PDAs in a box
/obj/item/storage/box/pdas
	name = "备用PDA盒"
	desc = "一盒备用PDA微型电脑。"
	illustration = "pda"

/obj/item/storage/box/pdas/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/modular_computer/pda/crew(src)

/obj/item/storage/box/ids
	name = "备用身份卡盒"
	desc = "装着许多空白身份卡。"
	illustration = "id"

/obj/item/storage/box/ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced(src)
/obj/item/storage/box/silver_ids
	name = "备用银色身份卡盒"
	desc = "为重要人物准备的闪亮身份卡。"
	illustration = "id"

/obj/item/storage/box/silver_ids/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/card/id/advanced/silver(src)

/obj/item/storage/box/mousetraps
	name = "灭害灵捕鼠夹盒"
	desc = span_alert("请置于儿童无法触及处。")
	illustration = "mousetrap"

/obj/item/storage/box/mousetraps/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/assembly/mousetrap(src)

/obj/item/storage/box/snappops
	name = "摔炮盒"
	desc = "八包欢乐！适用年龄八岁以上。不适合儿童。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "spbox"
	illustration = ""
	storage_type = /datum/storage/box/snappops

/obj/item/storage/box/snappops/PopulateContents()
	for(var/i in 1 to 8)
		new /obj/item/toy/snappop(src)

/obj/item/storage/box/matches
	name = "火柴盒"
	desc = "一小盒“差一点就是等离子”高级火柴。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "matchbox"
	inhand_icon_state = "zippo"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "lighter"
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BELT
	drop_sound = 'sound/items/handling/matchbox_drop.ogg'
	pickup_sound = 'sound/items/handling/matchbox_pickup.ogg'
	custom_price = 5 // DARKPACK EDIT CHANGE - ECONOMY
	base_icon_state = "matchbox"
	illustration = null
	storage_type = /datum/storage/box/match

/obj/item/storage/box/matches/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ignites_matches)

/obj/item/storage/box/matches/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/match(src)

/obj/item/storage/box/matches/update_icon_state()
	. = ..()
	switch(length(contents))
		if(10)
			icon_state = base_icon_state
		if(5 to 9)
			icon_state = "[base_icon_state]_almostfull"
		if(1 to 4)
			icon_state = "[base_icon_state]_almostempty"
		if(0)
			icon_state = "[base_icon_state]_e"

/obj/item/storage/box/lights
	name = "替换灯泡盒"
	desc = "内部形状只适合放入灯管和灯泡。"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	foldable_result = /obj/item/stack/sheet/cardboard //BubbleWrap
	illustration = "light"
	storage_type = /datum/storage/box/lights

/obj/item/storage/box/lights/bulbs/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/lights/tubes
	name = "替换灯管盒"
	illustration = "lighttube"

/obj/item/storage/box/lights/tubes/PopulateContents()
	for(var/i in 1 to 21)
		new /obj/item/light/tube(src)

/obj/item/storage/box/lights/mixed
	name = "替换灯具盒"
	illustration = "lightmixed"

/obj/item/storage/box/lights/mixed/PopulateContents()
	for(var/i in 1 to 14)
		new /obj/item/light/tube(src)
	for(var/i in 1 to 7)
		new /obj/item/light/bulb(src)

/obj/item/storage/box/fountainpens
	name = "钢笔盒"
	illustration = "fpen"

/obj/item/storage/box/fountainpens/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/pen/fountain(src)

/obj/item/storage/box/dishdrive
	name = "自制餐盘回收器套件"
	desc = "内含自制餐盘回收器所需的一切！"
	custom_premium_price = PAYCHECK_CREW * 3

/obj/item/storage/box/dishdrive/PopulateContents()
	var/list/items_inside = list(
		/obj/item/circuitboard/machine/dish_drive = 1,
		/obj/item/screwdriver = 1,
		/obj/item/stack/cable_coil/five = 1,
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/sheet/iron/five = 1,
		/obj/item/stock_parts/servo = 1,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/wrench = 1,
	)
	generate_items_inside(items_inside,src)

/obj/item/storage/box/actionfigure
	name = "可动人偶盒"
	desc = "最新一套收藏版可动人偶。"
	icon_state = "box"

/obj/item/storage/box/actionfigure/PopulateContents()
	for(var/i in 1 to 4)
		var/random_figure = pick(subtypesof(/obj/item/toy/figure))
		new random_figure(src)

/obj/item/storage/box/tail_pin
	name = "柯基贴尾巴游戏用品"
	desc = "适用年龄十岁以上。……你玩这种宝宝游戏是不是大了点？" //Intentional typo. // DARKPACK EDIT CHANGE
	custom_price = PAYCHECK_COMMAND * 1.25

/obj/item/storage/box/tail_pin/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/poster/tail_board(src)
		new /obj/item/tail_pin(src)

/obj/item/storage/box/party_poppers
	name = "派对礼花盒"
	desc = "让任何活动都变成庆典，顺便保证清洁工有活干。"

/obj/item/storage/box/party_poppers/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/spray/chemsprayer/party(src)

/obj/item/storage/box/balloons
	name = "长气球盒"
	desc = "一盒款式完全随机的古怪长气球，直接采自小丑星的气球农场。"
	illustration = "balloon"
	storage_type = /datum/storage/box/balloon

/obj/item/storage/box/balloons/PopulateContents()
	for(var/i in 1 to 24)
		new /obj/item/toy/balloon/long(src)

/obj/item/storage/box/stickers
	name = "贴纸包"
	desc = "一包可移除贴纸。可移除？真坑人！<br>背面用大字印着：<b>不要交给小丑！</b>"
	icon = 'icons/obj/toys/stickers.dmi'
	icon_state = "stickerpack"
	illustration = null
	w_class = WEIGHT_CLASS_TINY
	storage_type = /datum/storage/box/stickers

	var/static/list/pack_labels = list(
		"smile",
		"frown",
		"heart",
		"silentman",
		"tider",
		"star",
	)

/obj/item/storage/box/stickers/Initialize(mapload)
	. = ..()
	if(isnull(illustration))
		illustration = pick(pack_labels)
		update_appearance()

/obj/item/storage/box/stickers/proc/generate_non_contraband_stickers_list()
	var/list/allowed_stickers = list()

	for(var/obj/item/sticker/sticker_type as anything in subtypesof(/obj/item/sticker))
		if(!sticker_type::exclude_from_random)
			allowed_stickers += sticker_type

	return allowed_stickers

/obj/item/storage/box/stickers/PopulateContents()
	var/static/list/non_contraband

	if(isnull(non_contraband))
		non_contraband = generate_non_contraband_stickers_list()

	for(var/i in 1 to rand(4, 8))
		var/type = pick(non_contraband)
		new type(src)

/obj/item/storage/box/stickers/googly
	name = "活动眼睛贴纸包"
	desc = "让万事万物看起来都有点活了！"
	illustration = "googly-alt"

/obj/item/storage/box/stickers/googly/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/sticker/googly(src)

/// A box containing a skub, for easier carry because skub is a bulky item.
/obj/item/storage/box/stickers/skub
	name = "斯库布粉丝包"
	desc = "用于收纳斯库布及拥护斯库布衬衫的乙烯基袋，背面标签写着：“斯库布浪潮，席卷全站”。"
	icon_state = "skubpack"
	illustration = "label_skub"
	w_class = WEIGHT_CLASS_SMALL
	storage_type = /datum/storage/box/skub

/obj/item/storage/box/stickers/skub/PopulateContents()
	new /obj/item/skub(src)
	new /obj/item/sticker/skub(src)
	new /obj/item/sticker/skub(src)

/obj/item/storage/box/stickers/anti_skub
	name = "反斯库布贴纸包"
	desc = "敌人也许有斯库布和衬衫，但我有更多贴纸！这包还能装我的反斯库布衬衫。"
	icon_state = "skubpack"
	illustration = "label_anti_skub"
	storage_type = /datum/storage/box/anti_skub

/obj/item/storage/box/stickers/anti_skub/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/anti_skub(src)

/obj/item/storage/box/pinpointer_pairs
	name = "成对定位仪盒"

/obj/item/storage/box/pinpointer_pairs/PopulateContents()
	var/obj/item/pinpointer/pair/A = new(src)
	var/obj/item/pinpointer/pair/B = new(src)

	A.other_pair = B
	B.other_pair = A

/obj/item/storage/box/heretic_box
	name = "现实裂隙玩具盒"
	desc = "一盒模仿现实裂隙的玩具。"

/obj/item/storage/box/heretic_box/PopulateContents()
	for(var/i in 1 to rand(1,4))
		new /obj/item/toy/reality_pierce(src)


/obj/item/storage/box/purity_seal_box
	name = "纯洁印记盒"
	desc = "内有数枚受祝福的纯洁印记。"

/obj/item/storage/box/purity_seal_box/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/sticker/purity_seal(src)
		new /obj/item/sticker/purity_seal/purity_seal_2(src)

/obj/item/storage/box/stamps
	name = "印章盒"
	desc = "适用于各类文件的印章。"
	illustration = "stamp"
	custom_price = PAYCHECK_CREW

/obj/item/storage/box/stamps/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stamp/granted = 1,
		/obj/item/stamp/denied = 1,
		/obj/item/stamp/void = 1,
	)
	generate_items_inside(items_inside,src)
