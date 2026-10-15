/obj/structure/coclock
	name = "时钟"
	desc = "用来查看时间。"
	icon = 'modular_darkpack/modules/city_time/icons/clock.dmi'
	icon_state = "clock"
	anchored = TRUE
	pixel_z = 32

/obj/structure/coclock/examine(mob/user)
	. = ..()
	. += "[src]显示：<b>[server_timestamp("hh:mm:ss", ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]"

/obj/structure/coclock/grandpa
	icon = 'modular_darkpack/modules/city_time/icons/grandpa_cock.dmi'
	icon_state = "cock"
	density = TRUE
	pixel_z = 0
