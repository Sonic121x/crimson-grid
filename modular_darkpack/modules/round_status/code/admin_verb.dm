ADMIN_VERB(toggle_canon, R_ADMIN, "Toggle Canon", "Toggle the canon of the round.", ADMIN_CATEGORY_SECOND_CITY)
	GLOB.canon_event = !GLOB.canon_event
	SEND_SOUND(world, sound('modular_darkpack/modules/round_status/sounds/canon.ogg', volume = 25))
	if(GLOB.canon_event)
		to_chat(world, "<b>本回合现已计入正史。数据将会保存。</b>")
	else
		to_chat(world, "<b>本回合不再计入正史。数据将不再保存。仍须遵守角色扮演和冲突升级规则。</b>")
	message_admins("[key_name_admin(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")
	log_admin("[key_name(usr)] toggled the round's canonicity. The round is [GLOB.canon_event ? "now canon." : "no longer canon."]")

	BLACKBOX_LOG_ADMIN_VERB("Toggle Canon")
