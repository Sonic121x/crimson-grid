/datum/quirk/darkpack/horrific_appearance
	name = "Horrific Appearance"
	desc = "卡帕多西亚氏族的诅咒加剧现象越来越常见。许多本就形似行尸的卡帕多西亚开始加速腐败，皮肤紧绷在骨头上并成片剥落，躯体严重腐烂，甚至失去鼻子和耳朵。具有此缺陷的卡帕多西亚外貌属性始终为 0，其面容会暴露超自然身份、违反避世戒律，必须借助律能或面具掩饰。"
	value = -3
	mob_trait = TRAIT_HORRIFIC_APPEARANCE
	gain_text = span_notice("你尸体般的躯体开始加速腐败！")
	lose_text = span_notice("你尸体般躯体上的皮肤恢复了原状。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_CAPPADOCIAN)
	icon = FA_ICON_SKULL
	failure_message = "你尸体般躯体上的皮肤恢复了原状。"
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	quirk_flags = QUIRK_HIDE_FROM_SCAN //CRIMSON GRID EDIT ADD | PR: MAKE MEDICAL RECORDS NOT MASQ BREACHY | CHANGE: ADDED THIS TO PREVENT IT FROM BEING SEEN IN COMS

/datum/quirk/darkpack/horrific_appearance/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	var/years_undead = human_holder.chronological_age - human_holder.age
	switch(years_undead)
		if (-INFINITY to 500)
			human_holder.rot_body(3)
		if (500 to INFINITY)
			human_holder.rot_body(4)
	human_holder.st_add_stat_clamp(STAT_APPEARANCE, 0, type)

/datum/quirk/darkpack/horrific_appearance/remove()
	. = ..()
	quirk_holder.st_remove_stat_clamp(STAT_APPEARANCE, type)
