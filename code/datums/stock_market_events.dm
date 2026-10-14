/datum/stock_market_event
	/// The name of the event, used to describe it in the news.
	var/name = "股市事件！"
	/// A list of company names to use for the event and the circumstance.
	var/static/list/company_name = list(
		"中村工程",
		"坚实工业有限责任公司",
		"模块化解决方案公司",
		"太阳系政府",
		"澳星工业矿业",
		"纳诺传讯—迪福瑞斯公司",
		"奥塞克军械库",
		"梦境机器人公司"
	)
	/// A list of strings selected from the event that's used to describe the event in the news.
	var/list/circumstance = list()
	/// What material is affected by the event?
	var/datum/material/mat
	/// Constant to multiply the original material value by to get the new minimum value, unless the material has a minimum override.
	var/price_minimum = SHEET_MATERIAL_AMOUNT * 0.5
	/// Constant to multiply the original material value by to get the new maximum value.
	var/price_maximum = SHEET_MATERIAL_AMOUNT * 3

	/// When this event is ongoing, what direction will the price trend in?
	var/trend_value
	/// When this event is triggered, for how long will its effects last?
	var/trend_duration

/**
 * When a new stock_market_event is created, this proc is called to set up the event if there's anything that needs to happen upon it starting.
 * @param _mat The material that this event will affect.
 */
/datum/stock_market_event/proc/start_event(datum/material/mat)
	if(istype(mat, /datum/material))
		return FALSE
	src.mat = mat
	if(!isnull(trend_value))
		SSstock_market.materials_trends[mat] =	trend_value
		if(!isnull(trend_duration))
			SSstock_market.materials_trend_life[mat] = trend_duration
	return TRUE

/**
 * This proc is called every tick while the event is ongoing by SSstock_market.
 */
/datum/stock_market_event/proc/handle()
	trend_duration--
	if(trend_duration <= 0)
		end_event()
	return

/**
 * When a stock_market_event is ended, this proc is called to apply any final effects and clean up anything that needs to be cleaned up.
 */
/datum/stock_market_event/proc/end_event()
	SSstock_market.active_events -= src
	qdel(src)

/**
 * This proc is called to create a news string for the event, which is passed along to SSstock_market to be appended to the automatic newscaster messages.
 */
/datum/stock_market_event/proc/create_news()
	var/temp_company = pick(company_name)
	var/temp_circumstance = pick(circumstance)
	SSstock_market.news_string += "<b>[name] [temp_company]</b>[replacetext(temp_circumstance, "%MATERIAL%", "<b>[mat.name]</b>")]<br>"


/datum/stock_market_event/market_reset
	name = "市场重置！"
	trend_value = MARKET_TREND_STABLE
	trend_duration = 1
	circumstance = list(
		"被一家私人投资公司收购，%MATERIAL%的价格随之重置。",
		"进行了重组，%MATERIAL%的价格随之重置。",
		"被并入一家更大的公司，%MATERIAL%的价格随之重置。",
	)

/datum/stock_market_event/market_reset/start_event()
	. = ..()
	SSstock_market.materials_prices[mat] = (initial(mat.value_per_unit)) * SHEET_MATERIAL_AMOUNT
	create_news()

/datum/stock_market_event/large_boost
	name = "大幅上涨！"
	trend_value = MARKET_TREND_UPWARD
	trend_duration = 4
	circumstance = list(
		"刚刚发布了一款新产品，推动%MATERIAL%的价格上涨。",
		"发现了%MATERIAL%一种极具价值的新用途。",
		"发布了一份报告，推动%MATERIAL%的价格上涨。",
	)

/datum/stock_market_event/large_boost/start_event()
	. = ..()
	var/price_units = SSstock_market.materials_prices[mat]
	SSstock_market.materials_prices[mat] += round(gaussian(price_units, price_units * 0.15))
	SSstock_market.materials_prices[mat] = clamp(SSstock_market.materials_prices[mat], price_minimum * mat.value_per_unit, price_maximum * mat.value_per_unit)
	create_news()

/datum/stock_market_event/large_drop
	name = "大幅下跌！"
	trend_value = MARKET_TREND_DOWNWARD
	trend_duration = 4
	circumstance = list(
		"的最新产品引发重大争议，导致%MATERIAL%的价格下跌。",
		"卷入重大诉讼，导致%MATERIAL%的价格下跌。",
		"发布了一份报告，导致%MATERIAL%的价格下跌。",
	)

/datum/stock_market_event/large_drop/start_event()
	. = ..()
	var/price_units = SSstock_market.materials_prices[mat]
	SSstock_market.materials_prices[mat] -= round(gaussian(price_units * 1.5, price_units * 0.15))
	SSstock_market.materials_prices[mat] = clamp(SSstock_market.materials_prices[mat], price_minimum * mat.value_per_unit, price_maximum * mat.value_per_unit)
	create_news()

/datum/stock_market_event/hotcakes
	name = "供不应求！"
	trend_value = MARKET_TREND_UPWARD
	trend_duration = 1
	circumstance = list(
		"刚刚发布了一款新产品，正在主导%MATERIAL%市场。",
		"大获成功！正大举囤积%MATERIAL%，并抬高其价格。",
		"出人意料地垄断了供应，并抬高了%MATERIAL%的价格。",
	)

/datum/stock_market_event/hotcakes/start_event()
	. = ..()
	SSstock_market.materials_prices[mat] = round(price_maximum * mat.value_per_unit)
	create_news()

/datum/stock_market_event/lockdown
	name = "交易封锁！"
	trend_value = MARKET_TREND_DOWNWARD
	trend_duration = 2
	circumstance = list(
		"正在接受银河贸易委员会的调查，%MATERIAL%的交易因此暂停。",
		"意外遭到地球政府禁运，%MATERIAL%的交易因此暂停。",
	)

/datum/stock_market_event/lockdown/handle()
	. = ..()
	SSstock_market.materials_quantity[mat] = 0 //Force the material to be unavailable.

/datum/stock_market_event/lockdown/end_event()
	. = ..()
	SSstock_market.materials_quantity[mat] = initial(mat.tradable_base_quantity) //Force the material to be available again.
	SSstock_market.materials_prices[mat] = initial(mat.value_per_unit) * SHEET_MATERIAL_AMOUNT //Force the price to be reset once the lockdown is over.
	create_news()
