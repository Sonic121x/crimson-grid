///Shows guestbook tgui window
GAME_VERB_DESC(/mob, guestbook, "人际名册", "查看角色的人际名册。", "IC")
	if(!mind)
		var/fail_message = "你没有角色意识！"
		if(isobserver(src))
			fail_message += " 你必须在本局中扮演过角色才能拥有角色意识。"
		to_chat(src, span_warning(fail_message))
		return
	mind.guestbook.ui_interact(usr)
