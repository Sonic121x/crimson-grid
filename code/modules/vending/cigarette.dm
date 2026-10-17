/obj/machinery/vending/cigarette
	name = "\improper 暗巷烟草豪华版"
	desc = "既然想得癌症，何不也讲究点格调。"
	product_slogans = "太空香烟，抽出香烟该有的好味道。;宁挨工具箱，不换别家烟。;抽起来！;别信那些报告，今天就抽！"
	product_ads = "多半无害！;别信科学家！;有益健康！;别戒烟，多买点！;抽起来！;尼古丁天堂。;自2150年起供应上等香烟。;获奖香烟。"
	icon_state = "cigs"
	panel_type = "panel5"
	products = list(
		/obj/item/storage/fancy/cigarettes = 5,
		/obj/item/storage/fancy/cigarettes/cigpack_candy = 4,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	contraband = list(
		/obj/item/vape = 5,
		/obj/item/cigarette/dart = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_greytide = 1,
	)
	premium = list(
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 3,
		/obj/item/storage/box/gum/nicotine = 2,
		/obj/item/lighter = 3,
		/obj/item/storage/fancy/cigarettes/cigars = 1,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 1,
		/obj/item/storage/fancy/cigarettes/cigars/cohiba = 1,
	)

	refill_canister = /obj/item/vending_refill/cigarette
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_SRV
	light_mask = "cigs-light-mask"

/obj/machinery/vending/cigarette/syndicate
	name = "\improper Waffle Co Breakfast Cigarettes"
	product_slogans = "Start your day the right way!;Breakfast of champions!;Smokes that mean business!;Omnizine, your uplink to smooth taste!"
	product_ads = "Waffle Co's science advisory: omnizine may prevent most forms of smoking-related illness!*;New study: Rival corporations more trusting of men who smoke!;A Waffle Co cigarette makes yellow star feel like black orbit!"
	products = list(
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 7,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_candy = 2,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 2,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 1,
		/obj/item/storage/fancy/cigarettes/cigpack_greytide = 1,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	initial_language_holder = /datum/language_holder/syndicate
	refill_canister = /obj/item/vending_refill/cigarette/syndicate

/obj/item/vending_refill/cigarette/syndicate
	machine_name = "Waffle Co Breakfast Cigarettes"
	icon_state = "refill_syndismoke"


/obj/machinery/vending/cigarette/beach //Used in the lavaland_biodome_beach.dmm ruin
	name = "\improper ShadyCigs Ultra"
	desc = "Now with extra premium products!"
	product_ads = "Probably not bad for you!;Dope will get you through times of no money better than money will get you through times of no dope!;It's good for you!"
	product_slogans = "Turn on, tune in, drop out!;Better living through chemistry!;Toke!;Don't forget to keep a smile on your lips and a song in your heart!"
	products = list(
		/obj/item/storage/fancy/cigarettes = 5,
		/obj/item/storage/fancy/cigarettes/cigpack_uplift = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_robust = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_carp = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_midori = 3,
		/obj/item/storage/fancy/cigarettes/cigpack_cannabis = 5,
		/obj/item/storage/box/matches = 10,
		/obj/item/lighter/greyscale = 4,
		/obj/item/storage/fancy/rollingpapers = 5,
	)
	premium = list(
		/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker = 5,
		/obj/item/vape = 5,
		/obj/item/lighter = 3,
	)
	initial_language_holder = /datum/language_holder/beachbum
	allow_custom = FALSE

/obj/item/vending_refill/cigarette
	machine_name = "暗巷烟草豪华版"
	icon_state = "refill_smoke"

/obj/machinery/vending/cigarette/pre_throw(obj/item/thrown_item)
	if(istype(thrown_item, /obj/item/lighter))
		var/obj/item/lighter/thrown_lighter = thrown_item
		thrown_lighter.set_lit(TRUE)
