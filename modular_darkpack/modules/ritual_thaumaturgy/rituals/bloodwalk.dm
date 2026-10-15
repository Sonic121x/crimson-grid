/obj/ritual_rune/thaumaturgy/bloodwalk
	name = "血脉追溯"
	desc = "通过注射器中的血液追溯受检者的血系。"
	icon_state = "rune7"
	word = "在我眼前显露你的血系。"
	level = 2

/obj/ritual_rune/thaumaturgy/bloodwalk/complete()
	. = ..()
	for(var/obj/item/reagent_containers/syringe/S in loc)
		for(var/datum/reagent/blood/B in S.reagents.reagent_list)
			var/blood_data = B.data
			if(blood_data)
				var/generation = blood_data["generation"]
				var/clan = LOWER_TEXT(blood_data["clan"])
				var/real_name = blood_data["real_name"]
				var/message = generate_message(generation, clan, real_name)
				to_chat(last_activator, "[message]")
				// Process blood collection for research points
				if(ishuman(last_activator))
					SSoccult_research.process_blood_collection(last_activator, B)
			else
				to_chat(last_activator, "鲜血沉默不语，其中毫无力量！")
		color = rgb(255,0,0)
		activated = TRUE
		qdel(src)

/obj/ritual_rune/thaumaturgy/bloodwalk/proc/generate_message(generation, clan, real_name)
	var/message = ""
	message += "这份血液主人的真名是[real_name]。\n"
	switch(generation)
		if(4)
			message += "这份血液无比古老而强大！它一定来自一位古老的玛士撒拉！\n"
		if(5)
			message += "这份血液无比古老而强大！它一定来自一位玛士撒拉！\n"
		if(6)
			message += "这份血液无比古老而强大！它一定来自一位长老！\n"
		if(7, 8, 9)
			message += "这份血液十分强大，一定来自一位资深者或长老！\n"
		if(10, 11)
			message += "这份血液的力量中等，一定来自某个年轻的血族。\n"
		if(12, 13)
			message += "这份血液的力量已经衰薄，一定来自一位新血。\n"
		else
			if(generation >= 14)
				message += "这是薄血者的血粹！\n"
	switch(clan)
		if(VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY)
			message += "这份血液甘甜浓郁，其主人想必也十分美丽。\n"
		if(VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_VENTRUE_ANTITRIBU)
			message += "这份血液蕴含王者之力，传承自密特拉斯或哈德斯塔特。\n"
		if(VAMPIRE_CLAN_LASOMBRA)
			message += "冰冷而黑暗，这份血液与深渊有着神秘的联系。\n"
		if(VAMPIRE_CLAN_TZIMISCE)
			message += "这份血粹变化无常、扭曲畸异。它所属的诅咒血系，还有什么可怀疑的吗？\n"
		if(VAMPIRE_CLAN_OLD_CLAN_TZIMISCE)
			message += "这份血粹极其古老，让你想起另一种更加扭曲、诅咒深重的血液……\n"
		if(VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_CITY_GANGREL)
			message += "这份血液散发着原始而野性的气息，其主人想必也是如此。\n"
		if(VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_DOMINATE_MALKAVIAN)
			message += "你能感受到这份血液中的混乱与疯狂，其主人一定也已陷入疯癫。\n"
		if(VAMPIRE_CLAN_BRUJAH)
			message += "这份血液充满激情与愤怒，其主人一定也是如此。\n"
		if(VAMPIRE_CLAN_NOSFERATU)
			message += "这份血液污秽恶心，其主人一定也是如此。\n"
		if(VAMPIRE_CLAN_TREMERE)
			message += "这份血液充满魔法力量，其主人一定是一位血魔法师。\n"
		if(VAMPIRE_CLAN_BAALI)
			message += "污秽而腐化，卑劣而肮脏。你在血中看见自己的倒影，却有别的东西正回望着你。\n"
		if(VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_BANU_HAQIM_VIZIER)
			message += "强劲……致命……且深受诅咒。你深知睿魔尔对刺客们施加的诅咒。\n"
		if(VAMPIRE_CLAN_TRUE_BRUJAH)
			message += "这份血液冰冷而凝滞……其中几乎感受不到任何情绪。\n"
		if(VAMPIRE_CLAN_HEALER_SALUBRI)
			message += "萨鲁布里那受诅咒的血！必须杀死这份血液的主人。\n"
		if(VAMPIRE_CLAN_WARRIOR_SALUBRI)
			message += "萨米尔复仇的化身就在你面前，你敢以同样刻骨的仇恨回敬吗？\n"
		if(VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_HARBINGER)
			message += "这份血液极其冰冷，充满死亡气息，其主人一定是一位死灵术士。\n"
		if(VAMPIRE_CLAN_KIASYD)
			message += "这份血液充满妖精魔法的痕迹。\n"
		if(VAMPIRE_CLAN_GARGOYLE)
			message += "这是我们岩石仆从的血液。\n"
		if(VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_WARRIOR_SETITE)
			message += "这份血液蕴含诱惑与魅力。啊，是蛇族的一员。\n"
		if(VAMPIRE_CLAN_NAGARAJA)
			message += "这份血液冰冷，沾染着死亡，透出令人不安的饥饿。\n"
		else
			message += "这份血液的源头难以追溯。也许来自一位无氏族者？\n"

	return message
