/obj/item/watch
	name = "手表"
	desc = "用来查看时间的便携设备。"
	icon = 'modular_darkpack/modules/city_time/icons/clock.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "watch"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/card_id
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slot_flags = ITEM_SLOT_GLOVES
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	custom_price = 20 // ECONOMY

/obj/item/watch/examine(mob/user)
	. = ..()
	. += "[src]：<b>[server_timestamp("hh:mm:ss", ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]，[server_timestamp("MM", ic_time = TRUE)]月[server_timestamp("DD", ic_time = TRUE)]日</b>"
	. += "今天应该是<b>[list("Monday" = "星期一", "Tuesday" = "星期二", "Wednesday" = "星期三", "Thursday" = "星期四", "Friday" = "星期五", "Saturday" = "星期六", "Sunday" = "星期日")[server_timestamp("Day", ic_time = TRUE)]]</b>。"

// CRIMSON EDIT ADD START - Sell Valuables
/obj/item/watch/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "watch", FALSE)
// CRIMSON EDIT ADD END - Sell Valuables
