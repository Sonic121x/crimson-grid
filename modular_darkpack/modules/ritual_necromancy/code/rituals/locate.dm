/obj/ritual_rune/necromancy/locate
	name = "死亡之汤"
	desc = "确认一个灵魂的状态，并尝试占卜其所在之处。"
	icon_state = "rune5"
	word = "UAH'V OUH'RAN"
	level = 3
	sacrifices = list(/obj/item/shard)

/obj/ritual_rune/necromancy/locate/complete()

	var/chosen_name = tgui_input_text(usr, "呼唤你所寻灵魂的真名：", "死亡之汤")
	var/target = find_target(chosen_name)

	if(!target)
		to_chat(usr, span_warning("冥幕彼端和生者世界都找不到这个灵魂！"))
		return

	var/area/targetarea = get_area(target)

	if(isavatar(target))
		to_chat(usr, span_ghostalert("这个灵魂已连接两个世界，其星界投影正在[targetarea.name]游荡。"))
		playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)
		qdel(src)
		return

	if(isobserver(target))
		to_chat(usr, span_ghostalert("这个灵魂已离开生者世界，正在[targetarea.name]游荡。"))
		playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1off.ogg', 50, FALSE)
		qdel(src)
		return

	if(isliving(target))
		var/mob/living/livetarget = target
		if(livetarget.stat != DEAD)
			to_chat(usr, span_ghostalert("这个灵魂仍留在生者世界，位于[targetarea.name]。"))
			playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

			if(IS_UNCONSCIOUS(livetarget))
				to_chat(usr, span_ghostalert("其与这个世界的联系微弱，正逐渐消退。死亡正在等待。"))
			if(livetarget.get_discipline(/datum/discipline/necromancy)) //other necromancers catch onto it if targeted
				var/area/userarea = get_area(usr)
				to_chat(livetarget, span_notice("一阵寒意，一声低语。一位死灵术士同行找到了你的灵魂，其灵魂正在<b>[userarea.name]</b>发出呼唤。"))
			qdel(src)
			return

		if (livetarget.stat == DEAD) //for when they haven't ghosted yet
			to_chat(usr, span_ghostalert("这个灵魂仍被困在死去的躯壳中，位于[targetarea.name]。"))
			qdel(src)
			return

/obj/ritual_rune/necromancy/locate/proc/find_target(chosen_name)
	var/mob/target_found
	for(var/mob/target in GLOB.player_list)
		if(target.real_name == chosen_name)
			target_found = target
			break
	return target_found
