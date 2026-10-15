// Base radio type we use for our custom behaviors.
/obj/item/radio/headset/darkpack
	name = "\improper P25无线电"
	desc = "采用P25数字通信标准的便携式无线电耳机。"
	icon = 'modular_darkpack/modules/radios/icons/radio.dmi'
	icon_state = "p25"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/radios/icons/onfloor.dmi')
	freqlock = RADIO_FREQENCY_LOCKED

// Military Radio
/obj/item/radio/headset/darkpack/military
	name = "军用无线电"
	radio_network = NETWORK_MILITARY

/obj/item/radio/headset/darkpack/military/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_MILITARY)
	radio_id = rand(1, 999) // Since we wont have a tranceiver for these, we're just auto-assigning a random ID. This isn't foolproof.

/obj/item/radio/headset/darkpack/pmc
	name = "军用无线电"
	radio_network = NETWORK_ENDRON

/obj/item/radio/headset/darkpack/pmc/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_ENDRON)
	AddElement(/datum/element/earhealing)
	AddComponent(/datum/component/wearertargeting/earprotection) //Allows for explosive fuckups to not fuck up communication
	radio_id = rand(1, 999) // Since we wont have a tranceiver for these, we're just auto-assigning a random ID. This isn't foolproof.

// Police Radio get a special button to call for backup.
/obj/item/radio/headset/darkpack/police
	name = "警用无线电"
	icon_state = "pp25"
	COOLDOWN_DECLARE(emergency_cooldown)
	custom_price = 50

/obj/item/radio/headset/darkpack/police/examine(mob/user)
	. = ..()
	var/turf/current_turf = get_turf(src)
	. += span_info("GPS坐标：" + english_list(list(current_turf.x, current_turf.y, current_turf.z), and_text = "、", comma_text = "、", final_comma_text = ""))
	. += span_notice("侧面有一个用于呼叫支援的红色按钮，可通过[EXAMINE_HINT("Ctrl+Shift+单击")]启动。")

/obj/item/radio/headset/darkpack/police/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = NONE
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_CTRL_SHIFT_LMB] = "紧急呼叫支援"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/radio/headset/darkpack/police/click_ctrl_shift(mob/user)
	var/confirmation_popup = tgui_alert(user, "确定要发出紧急支援呼叫吗？", "紧急呼叫支援", list("取消", "确认"))
	if(confirmation_popup != "确认")
		return
	if(!COOLDOWN_FINISHED(src, emergency_cooldown))
		balloon_alert(user, "忙碌中！")
		return
	if(radio_network != NETWORK_POLICE)
		balloon_alert(user, "未连接！")
		return
	user.balloon_alert_to_viewers("哔！", "已启动！")
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, CRIME_EMERGENCY, get_turf(src))
	COOLDOWN_START(src, emergency_cooldown, 30 SECONDS)
