#define MAX_PAGE_LINES 20

/obj/machinery/logging_machine
	name = "监控设备"
	desc = "这台装置似乎能存储各种记录，看起来连接着城里的移动通信天线。"
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "relay"
	density = TRUE
	var/list/saved_logs
	var/datum/looping_sound/logging_machine/clearing_sound
	COOLDOWN_DECLARE(printing_noise)

/obj/machinery/logging_machine/Initialize(mapload)
	. = ..()
	saved_logs = new()
	clearing_sound = new(src,  FALSE)
	GLOB.logging_machines += src

	register_context()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "打印记录", rmb_text = "清除记录")

/obj/machinery/logging_machine/Destroy(force)
	GLOB.logging_machines -= src
	QDEL_NULL(clearing_sound)
	saved_logs = null
	return ..()

/obj/machinery/logging_machine/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(!isnull(held_item))
		return
	context[SCREENTIP_CONTEXT_LMB] = "打印记录"
	context[SCREENTIP_CONTEXT_RMB] = "清除记录"
	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/logging_machine/examine(mob/user)
	. = ..()
	. += span_info(span_bold("左键点击")) + span_info("[src]以打印所有已获取的记录。")
	. += span_info(span_bold("右键点击")) + span_info("[src]以清除所有已获取的记录，并消除所有通话造成的避世戒律违规记录。")

/obj/machinery/logging_machine/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(!length(saved_logs))
		balloon_alert_to_viewers("没有记录！")
		return
	balloon_alert_to_viewers("正在清除记录！")
	do_log_clearing(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/logging_machine/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(!length(saved_logs))
		balloon_alert_to_viewers("没有记录！")
		return
	balloon_alert_to_viewers("正在打印记录！")
	do_log_printing(user)

/obj/machinery/logging_machine/proc/do_log_printing(mob/living/user)
	var/list/log_save_cache = list()
	log_save_cache += saved_logs
	var/pages_to_print = length(log_save_cache) / MAX_PAGE_LINES
	var/clearing_stats = user.st_get_stat(STAT_TECHNOLOGY) + user.st_get_stat(STAT_INTELLIGENCE)
	var/clearing_time = (1.5 - (clearing_stats / 10)) SECONDS
	for(var/page in 1 to ceil(pages_to_print))
		if(!do_after(user, clearing_time, src))
			break
		var/obj/item/paper/printed_paper = new /obj/item/paper(get_turf(src))

		var/list/page_text = list()
		for(var/page_line in 1 to min(MAX_PAGE_LINES, length(log_save_cache)))
			var/text = log_save_cache[1][1]
			page_text += text
			page_text += "<br>"
			log_save_cache -= list(log_save_cache[1])

		printed_paper.add_raw_text(page_text.Join()) //Print the oldest logs first.
		printed_paper.update_appearance()
		if(!COOLDOWN_FINISHED(src, printing_noise))
			continue
		playsound(src, 'sound/machines/printer.ogg', 50, TRUE)
		COOLDOWN_START(src, printing_noise, 5 SECONDS)

/obj/machinery/logging_machine/proc/do_log_clearing(mob/living/user)
	clearing_sound.start()
	if(!do_after(user, 7 SECONDS, src))
		addtimer(CALLBACK(src, PROC_REF(stop_sound)), 7 SECONDS)
		return
	var/clearing_stats = user.st_get_stat(STAT_TECHNOLOGY) + user.st_get_stat(STAT_INTELLIGENCE)
	var/clearing_time = max((1.5 - (clearing_stats / 10)) SECONDS, 0.1 SECONDS)
	for(var/paper in 1 to length(saved_logs))
		if(!do_after(user, clearing_time, src))
			stop_sound()
			break
		var/obj/phone = saved_logs[1][2]
		if(phone)
			SEND_SIGNAL(phone, COMSIG_ALL_MASQUERADE_REINFORCE)
		saved_logs -= list(saved_logs[1]) //Clear the oldest logs first.
	stop_sound()

/obj/machinery/logging_machine/proc/stop_sound()
	clearing_sound.stop()

#undef MAX_PAGE_LINES
