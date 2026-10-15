/obj/structure/sign/clock
	name = "挂钟"
	desc = "一只普通挂钟，同时显示当地的纳诺传讯标准时间与银河条约协调时间。不想工作时，盯着它发呆再合适不过。"
	icon_state = "clock"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/clock, 32)

/obj/structure/sign/clock/examine(mob/user)
	. = ..()
	. += span_info("当前CST（当地）时间：[server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]。") // DAKRPACK EDIT CHANGE - CITY_TIME
	/* //DARKPACK EDIT REMOVAL
	if(user.is_literate())
		. += span_info("That means it is currently [round_timestamp()] into the shift.")
	*/

/obj/structure/sign/calendar
	name = "挂历"
	desc = "一本老式挂历。现代科技或许早已让它过时，但仍很难想象没有挂历的办公室。"
	icon_state = "calendar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/calendar, 32)

/obj/structure/sign/calendar/examine(mob/user)
	. = ..()
	. += span_info("当前日期：[CURRENT_STATION_YEAR]年[time2text(world.realtime, "MM月DD日", world.timezone)]，[list("Sun" = "星期日", "Mon" = "星期一", "Tue" = "星期二", "Wed" = "星期三", "Thu" = "星期四", "Fri" = "星期五", "Sat" = "星期六", "Sunday" = "星期日", "Monday" = "星期一", "Tuesday" = "星期二", "Wednesday" = "星期三", "Thursday" = "星期四", "Friday" = "星期五", "Saturday" = "星期六")[time2text(world.realtime, "DDD", world.timezone)]]。")
	if(length(GLOB.holidays))
		. += span_info("节日活动：")
		for(var/holidayname in GLOB.holidays)
			. += span_info("[holidayname]")
