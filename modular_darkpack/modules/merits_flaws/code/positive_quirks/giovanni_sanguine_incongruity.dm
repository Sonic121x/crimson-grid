/datum/quirk/darkpack/giovanni_sanguine_incongruity
	name = "Sanguine Incongruity"
	desc = "你承受着卡帕多西亚氏族被篡夺之前，其血脉所带有的尸体般苍白外貌的诅咒。拥有此优势的乔凡尼在氏族中享有更多宽容：他们要么是血噬篡位之前的古血长老，要么被认为比其他族人更接近死亡，而这种迷信象征着强大的死灵术造诣。拥有此优势的乔凡尼也不受拉弥亚诅咒影响，不再因那种超自然的剧痛噬咬而难以进食。只有乔凡尼可以选择此优势。"
	ttrpg_sources = list(/datum/source_book/vtm20/lotc = 106)
	value = 5
	mob_trait = TRAIT_SANGUINE_INCONGRUITY
	gain_text = span_notice("拉弥亚诅咒离开了你的身体，让你能够正常进食，但你的皮肤变得苍白，更像一具尸体。")
	lose_text = span_notice("不知为何，乔凡尼的拉弥亚诅咒再次降临，你的噬咬变得格外痛苦。至少你的皮肤恢复了些许生气。")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_GIOVANNI)
	icon = FA_ICON_SKULL_CROSSBONES
	failure_message = "不知为何，乔凡尼的拉弥亚诅咒再次降临，你的噬咬变得格外痛苦。至少你的皮肤恢复了些许生气。"


/datum/quirk/darkpack/giovanni_sanguine_incongruity/add(client/client_source)
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return

	var/datum/splat/vampire/kindred/kindred = get_kindred_splat(human_holder)
	if(kindred)
		if(istype(kindred.clan, /datum/subsplat/vampire_clan/giovanni))
			REMOVE_TRAIT(human_holder, TRAIT_PAINFUL_VAMPIRE_KISS, SUBSPLAT_TRAIT)

			if(human_holder.chronological_age >= 300)
				human_holder.rot_body(2)
			else
				human_holder.rot_body(1)

