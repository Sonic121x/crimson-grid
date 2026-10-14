/mob/living/carbon/human/proc/prompt_permanent_ghouling()
	var/response = tgui_alert(src, "是否将血仆身份保存到当前角色存档？此选择永久生效，无法撤销！", "转化为血仆", list("是", "否"))
	if(response == "是")
		write_preference_midround(/datum/preference/choiced/splats, SPLAT_GHOUL)
		to_chat(src, span_danger("你选择了永久成为血仆！"))


/mob/living/carbon/human/proc/ghoulificate(mob/living/carbon/human/owner)
	make_ghoul(owner)
	if(!mind)
		return
	send_ghoul_vitae_consumption_message(owner)

/mob/living/carbon/human/proc/send_ghoul_vitae_consumption_message(mob/living/carbon/human/owner)
	if(HAS_TRAIT(src, TRAIT_UNBONDABLE) || !owner)
		to_chat(src, span_warning("珍贵的血粹流入口中，如同令人上瘾的毒药。然而，你并不忠于献血者，只眷恋这血粹本身。"))
		return TRUE
	var/mob/living/master = mind.enslaved_to?.resolve()
	if(master != owner)
		mind.enslave_mind_to_creator(owner)
		apply_status_effect(/datum/status_effect/blood_bond, owner)
		to_chat(src, span_userdanger("第一夜饮下第一口血，你便会崇拜或憎恨那位献血者。第二夜饮下第二口血，你将牢记对方的话语，竭力博取欢心。到了第三夜、第三次饮血，你就彻底属于对方。你仍可能凭意志反抗，但那不过是转瞬即逝的挣扎。"))
		return TRUE


