GAME_VERB_DESC(/mob/living/carbon/human, set_custom_examine_text, "设置自定义查看描述", "设置一段查看时显示的文字，描述角色此刻正在做什么。", "IC")
	var/new_text = tgui_input_text(src, "输入新的自定义查看描述。", "查看描述", custom_examine_message, MAX_MESSAGE_LEN, TRUE)

	custom_examine_message = new_text
