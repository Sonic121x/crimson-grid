/obj/machinery/bitcoin_miner
	name = "比特币矿机"
	desc = "一套用于挖掘加密货币的设备，连接着一台显示器。\n它居然还有个出钞口，能把挖矿收益直接变成现金。"
	icon = 'modular_darkpack/modules/bitcoinminer/icons/bitcoinminer.dmi'
	icon_state = "miner_off"
	density = TRUE
	var/active = FALSE
	var/starting = FALSE
	var/money_stored = 0
	var/money_per_tick_min = 1
	var/money_per_tick_max = 2

/obj/machinery/bitcoin_miner/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/bitcoin_miner/process(seconds_per_tick)
	if(active)
		money_stored += rand(money_per_tick_min, money_per_tick_max)  * seconds_per_tick
	else
		STOP_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/update_icon_state()
	icon_state = active ? "miner_on" : "miner_off"
	if(starting)
		icon_state = "miner_starting"
	return ..()

/obj/machinery/bitcoin_miner/examine(mob/user)
	. = ..()
	if(active && in_range(user, src))
		. += span_notice("当前有[money_stored / 222] BTC，已兑换为$[money_stored]。") // division by 222 to replicate 2015 BTC prices
		. += span_notice("<i>Alt+单击</i>关闭[src]。")
	if(starting)
		. += span_notice("它似乎正在启动。")
	if(!active && !starting)
		. += span_notice("它似乎处于关闭状态。")

/obj/machinery/bitcoin_miner/proc/toggle_on(mob/user)
	starting = TRUE
	playsound(src, 'sound/machines/computer/computer_start.ogg', 40)
	update_appearance()
	sleep(5 SECONDS)
	starting = FALSE
	active = TRUE
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/proc/toggle_off(mob/user)
	active = FALSE
	playsound(src, 'sound/machines/computer/computer_start.ogg', 40)
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/bitcoin_miner/Destroy()
	toggle_off()
	return ..()

/obj/machinery/bitcoin_miner/proc/dump_loot(mob/user)
	if(money_stored > 0)
		var/money_to_spawn = min(money_stored, /obj/item/stack/dollar::max_amount)
		new /obj/item/stack/dollar(drop_location(), money_to_spawn)
		money_stored -= money_to_spawn
		playsound(src, 'sound/machines/eject.ogg', 30)
		to_chat(user, span_notice("你从[src]中取出了[MONEY_SYMBOL][money_to_spawn]！"))
	else
		to_chat(user, span_notice("余额为零！"))

/obj/machinery/bitcoin_miner/interact(mob/user)
	. = ..()
	if(!in_range(user, src))
		return

	if(!active)
		if(starting)
			to_chat(user, span_warning("[src]正在启动！"))
			return
		if(tgui_alert(user, "你要启动[src]吗？", "挖矿", list("是", "否")) == "是")
			to_chat(user, span_notice("你启动了[src]。"))
			toggle_on(user)
	else
		dump_loot(user)

/obj/machinery/bitcoin_miner/click_alt(mob/user)
	. = ..()
	if(!in_range(user, src))
		return

	if(active)
		if(tgui_alert(user, "你要关闭[src]吗？", "挖矿", list("是", "否")) == "是")
			to_chat(user, span_notice("你关闭了[src]。"))
			toggle_off()
