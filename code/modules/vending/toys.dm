/obj/machinery/vending/donksofttoyvendor
	name = "\improper 当克软弹玩具售货机"
	desc = "一台获准向8岁及以上儿童出售玩具的售货机。"
	icon_state = "nt-donk"
	panel_type = "panel18"
	product_slogans = "今天就来买酷炫玩具！;今天就惹毛一个猎杀狂！;优质玩具武器，低廉价格！;送给人事主管，换取全站权限！;送给安保主管，换取终身监禁！"
	product_ads = "拿着玩具也能威风八面！;今天就释放你的童心！;玩具武器不杀人，但猎杀狂会！;都有玩具武器了，谁还需要责任？;让你的下一场谋杀充满乐趣！"
	vend_reply = "欢迎再来！"
	light_mask = "donksoft-light-mask"
	product_categories = list(
		list(
			"name" = "玩具",
			"icon" = "gifts",
			"products" = list(
				/obj/item/card/emagfake = 4,
				/obj/item/hot_potato/harmless/toy = 4,
				/obj/item/toy/sword = 12,
				/obj/item/toy/foamblade = 12,
				/obj/item/gun/ballistic/automatic/pistol/toy = 8,
				/obj/item/gun/ballistic/automatic/toy = 8,
				/obj/item/gun/ballistic/shotgun/toy = 8,
				/obj/item/ammo_box/foambox/mini = 20,
			)
		),
		list(
			"name" = "枕头武器",
			"icon" = "bed",
			"products" = list(
				/obj/item/shield/mattress = 10,
				/obj/item/spear/pillow = 10,
				/obj/item/spear/pillow = 10,
				/obj/item/pillow/clown = 10,
				/obj/item/pillow/mime = 10,
			)

		)
	)

	contraband = list(
		/obj/item/toy/balloon/syndicate = 1,
		/obj/item/gun/ballistic/shotgun/toy/crossbow = 8,
		/obj/item/storage/belt/sheath/katana/toy = 12,
		/obj/item/ammo_box/foambox/riot/mini = 20,
	)
	premium = list(
		/obj/item/dualsaber/toy = 4,
		/obj/item/storage/box/fakesyndiesuit = 4,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted = 4,
		/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted = 4,
	)
	refill_canister = /obj/item/vending_refill/donksoft
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES

/obj/item/vending_refill/donksoft
	machine_name = "当克软弹玩具售货机"
	icon_state = "refill_donksoft"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 12.5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7.5, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)
