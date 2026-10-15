/obj/ritual_rune/necromancy/insight
	name = "洞悉死因"
	desc = "询问尸体的灵魂，查明其死亡经过。"
	icon_state = "rune6"
	word = "IH'DET ULYSS RES'SAR"
	level = 2

/obj/ritual_rune/necromancy/insight/complete()

	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/targetbody in loc)
		if(targetbody == usr)
			to_chat(usr, span_warning("你不能对自己施行此仪式。"))
			return
		else if(targetbody.stat == DEAD)
			valid_bodies += targetbody
		else
			to_chat(usr, span_warning("目标还活着！直接去问吧！"))
			return

	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("没有可供施行此仪式的尸体。"))
		return

	playsound(loc, 'modular_darkpack/modules/ritual_necromancy/sounds/necromancy1on.ogg', 50, FALSE)

	var/mob/living/carbon/victim = pick(valid_bodies)

	var/mob/dead/observer/victim_ghost = victim.last_mind

	var/permission = null

	if(isnpc(victim))
		to_chat(last_activator, span_notice("[victim.name]只是一个日渐衰弱的低等无心怨灵，无法从中获取更多见闻。"))
		to_chat(last_activator, span_notice("<b>所受伤害：<b><br>物理伤害：[victim.get_brute_loss()]<br>缺氧伤害：[victim.get_oxy_loss()]<br>毒素伤害：[victim.get_tox_loss()]<br>烧伤：[victim.get_fire_loss()]<br>恶性伤害：[victim.get_agg_loss()]"))
		to_chat(last_activator, span_notice("最后一次近战攻击的施袭者：[victim.lastattacker]"))
		qdel(src)
		return

	if(victim_ghost)
		permission = tgui_input_list(victim_ghost, "[last_activator.real_name]想了解你的死亡经过。你愿意回答吗？", "选择", list("是","否","我不记得了"), "否", 1 MINUTES)

	if(permission == "是" && victim_ghost)
		to_chat(last_activator, span_ghostalert("[victim.name]阴魂不散的低语涌入你的脑海……"))
		var/deathdesc = tgui_input_text(victim_ghost, "", "你是怎么死的？", "", 300, TRUE, TRUE, 5 MINUTES)
		if(deathdesc == "")
			to_chat(last_activator, span_warning("冥幕太厚，低语又太过疯癫，无法从中获取有用的信息。"))
		else
			to_chat(last_activator, span_ghostalert("<i>[deathdesc]</i>"))
			//discount scanner
			to_chat(last_activator, span_notice("<b>所受伤害：<b><br>物理伤害：[victim.get_brute_loss()]<br>缺氧伤害：[victim.get_oxy_loss()]<br>毒素伤害：[victim.get_tox_loss()]<br>烧伤：[victim.get_fire_loss()]<br>恶性伤害：[victim.get_agg_loss()]"))
			to_chat(last_activator, span_notice("最后一次近战攻击的施袭者：[victim.lastattacker]")) //guns behave weirdly
			qdel(src)

	else if(permission == "否")
		to_chat(last_activator, span_danger("怨灵转身离去，不愿交出自己的秘密。"))
