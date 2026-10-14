/obj/machinery/atm
	name = "\improper 自动取款机"
	desc = "查询余额或办理存取款业务。"
	icon = 'modular_darkpack/modules/economy/icons/atm.dmi'
	icon_state = "atm"
	anchored = TRUE

	max_integrity = 250
	damage_deflection = 50 // CRIMSON EDIT CHANGE - ORIGINAL: damage_deflection = 20

	light_color = COLOR_GREEN
	light_range = 2

	circuit = /obj/item/circuitboard/machine/atm

	var/logged_in = FALSE
	var/total_stored_cash = 0
	var/inserted_cash = 0
	// Just because there is account selected does not nesicarrly indicate logged_in is true. (you still have to enter your pin)
	var/datum/bank_account/logged_account

/obj/machinery/atm/Initialize(mapload)
	. = ..()
	if(mapload)
		total_stored_cash = rand(1000, 10000)

/obj/machinery/atm/on_deconstruction(disassembled)
	dump_cash()
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_ATM_TAMPERING, get_turf(src))

/obj/machinery/atm/examine(mob/user)
	. = ..()
	if(logged_account)
		. += span_notice("屏幕亮着，已有账户登录。")

/obj/machinery/atm/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_creditcard(tool))
		var/obj/item/card/credit/card = tool
		if(logged_in)
			to_chat(user, span_notice("已经有人登录了。"))
			return ITEM_INTERACT_BLOCKING
		logged_account = card.registered_account
		to_chat(user, span_notice("刷卡成功。"))
		return ITEM_INTERACT_SUCCESS
	else if(iscash(tool))
		if(!logged_in)
			to_chat(user, span_notice("你需要先登录。"))
			return ITEM_INTERACT_BLOCKING
		var/value = tool.get_item_credit_value()
		inserted_cash += value
		to_chat(user, span_notice("你向[src]放入了[value] [MONEY_NAME]。[src]目前有[inserted_cash] [MONEY_NAME]待存入账户。"))
		qdel(tool)
		return ITEM_INTERACT_SUCCESS

/obj/machinery/atm/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Atm", name)
		ui.open()

/obj/machinery/atm/ui_data(mob/user)
	var/list/data = list()
	data["logged_in"] = logged_in
	data["card"] = logged_account ? TRUE : FALSE
	data["inserted_cash"] = inserted_cash
	if(logged_account)
		data["account_balance"] = logged_account.account_balance
		data["account_holder"] = logged_account.account_holder
		data["account_id"] = logged_account.account_id
		data["bank_pin"] = logged_account.bank_pin
	else
		data["account_balance"] = null
		data["account_holder"] = null
		data["account_id"] = null
		data["bank_pin"] = null

	return data

/obj/machinery/atm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(!logged_account)
		to_chat(usr, span_notice("使用[src]前需要先刷卡。"))
		return FALSE
	switch(action)
		if("login")
			if(params["bank_pin"] == logged_account.bank_pin)
				logged_in = TRUE
				return TRUE
			else
				return FALSE
		if("logout")
			logged_in = FALSE
			logged_account = null
			return TRUE
		if("withdraw")
			var/amount = round(text2num(params["withdraw_amount"]))
			dispense_cash(amount, usr)
			return TRUE
		if("change_pin")
			var/new_pin = params["new_pin"]
			logged_account.bank_pin = new_pin
			return TRUE
		if("deposit")
			if(inserted_cash > 0)
				logged_account.adjust_money(inserted_cash, "ATM: Deposit")
				to_chat(usr, span_notice("你已向银行卡存入[inserted_cash] [MONEY_NAME]。当前余额为[logged_account.account_balance] [MONEY_NAME]。"))
				total_stored_cash += inserted_cash
				inserted_cash = 0
				return TRUE
			else
				to_chat(usr, span_notice("[src]内没有待存入的现金。"))
				return TRUE

/obj/machinery/atm/proc/dispense_cash(amount, mob/user)
	if(logged_account.account_balance < amount)
		to_chat(usr, span_notice("余额不足。"))
		return
	var/amount_drawn = 0
	while(amount > 0)
		var/drop_amount = min(amount, 1000)
		if(drop_amount > total_stored_cash)
			to_chat(user, span_notice("[src]的剩余现金不足，无法继续取款。"))
			break
		var/obj/item/stack/dollar/cash = new(loc, drop_amount)
		to_chat(user, span_notice("你已取出[drop_amount] [MONEY_NAME]。"))
		try_put_in_hand(cash, user)
		amount -= drop_amount
		total_stored_cash -= drop_amount
		amount_drawn += drop_amount
	logged_account.adjust_money(-amount_drawn, "ATM: Withdraw")

/obj/machinery/atm/proc/dump_cash()
	while(total_stored_cash > 0)
		var/drop_amount = min(total_stored_cash, 1000)
		new /obj/item/stack/dollar(loc, drop_amount)
		total_stored_cash -= drop_amount

/obj/item/circuitboard/machine/atm
	name = "\improper 自动取款机"
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/atm
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/datum/stock_part/servo = 2,
	)

