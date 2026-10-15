/datum/subsplat/vampire_clan/cappadocian
	name = "Cappadocian"
	id = VAMPIRE_CLAN_CAPPADOCIAN
	desc = "卡帕多西亚是被认为已经灭绝的死灵术士氏族，专门研究物质世界中的死亡。他们初拥乔凡尼家族成员，希望借此推进对冥界的研究，换来的却是血噬，以及氏族与始祖的毁灭。"
	icon = "cappadocian"
	curse = "面容苍白枯槁，即使消耗血液也无法显得更像人类。"
	sense_the_sin_text = "永远无法摆脱腐尸般的外貌。"
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/necromancy
	)
	alt_sprite = "rotten1"
	alt_sprite_greyscale = TRUE

	whitelisted = TRUE

/datum/subsplat/vampire_clan/cappadocian/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()

	apply_rot_curse(gaining_mob, gaining_mob.chronological_age)

/datum/subsplat/vampire_clan/cappadocian/proc/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 500)
			H.rot_body(1)
		if (500 to INFINITY)
			H.rot_body(2)

/datum/subsplat/vampire_clan/cappadocian/harbinger
	name = "Harbinger of Skulls"
	id = VAMPIRE_CLAN_HARBINGER
	desc = "死骸先驱是卡帕多西亚的血系，主要由乔凡尼清洗与愚行之宴的受害者组成。这些加入魔宴同盟的卡帕多西亚血族精通死灵术，曾将驾驭亡者的力量带入冥界，在那里化为强大的怨灵，蛰伏等待穿越冥幕的机会，为氏族复仇。"
	curse = "外貌极似尸体，且随年龄增长愈发骇人；最古老者宛如行走的骸骨或幽魂，仿佛仍带着冥幕另一侧的痕迹。"
	icon = "harbinger_of_skulls"

/datum/subsplat/vampire_clan/cappadocian/harbinger/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 100)
			H.rot_body(1)
		if (100 to 300)
			H.rot_body(2)
		if (300 to 500)
			H.rot_body(3)
		if (500 to INFINITY)
			H.rot_body(4)

/datum/subsplat/vampire_clan/cappadocian/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("你感到一股令人毛骨悚然的空洞存在，新生的绝望随之渗入你腐朽的血肉。"))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	new /obj/effect/client_image_holder/baali_demon/spectre(get_turf(target), list(target))
