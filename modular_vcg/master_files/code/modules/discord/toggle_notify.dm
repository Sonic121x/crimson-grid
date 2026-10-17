/client
	COOLDOWN_DECLARE(notify_toggle_cooldown)

/// action must be one of PLEXORA_NOTIFYSIGNUP
/datum/controller/subsystem/plexora/proc/notify_signup(ckey, action)
	var/list/response = http_basicasync("notify_enroll", list(
		"ckey" = ckey(ckey),
		"action" = action
	), TRUE, TRUE)

	if (isnum(response))
		return response

	return response["result"]

// Verb to toggle restart notifications
GAME_VERB_DESC(/client, notify_restart, "重启通知", "服务器重启时通过Discord通知你。", "OOC")

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("此功能需要SQL数据库服务正常运行。"))
		return

	if(!SSplexora) // SS is still starting
		to_chat(src, span_notice("服务器仍在启动，请稍后再尝试绑定账号。"))
		return

	if(!CONFIG_GET(flag/plexora_enabled) || !SSplexora.enabled)
		to_chat(src, span_warning("此功能需要启用Plexora服务。"))
		return

	var/stored_id = SSplexora.lookup_id(ckey)
	if(!stored_id) // Account is not linked
		to_chat(src, span_warning("请先使用“验证Discord账号”功能绑定你的Discord账号。"))
		return

	if (!COOLDOWN_FINISHED(src, notify_toggle_cooldown))
		to_chat(src, span_warning("通知开关仍在冷却中！（[COOLDOWN_TIMELEFT(src, notify_toggle_cooldown) * 0.1]秒）"))
		return

	COOLDOWN_START(src, notify_toggle_cooldown, 5 SECONDS)

	var/result = SSplexora.notify_signup(ckey)

	if (!result)
		to_chat(src, span_warning("未能切换你的通知状态！"))
		return

	if (isnum(result))
		if (result == 404)
			to_chat(src, "Plexora未找到你的Discord账号。这通常不应该发生。")
		else if (result == 400)
			to_chat(src, "Plexora未能正确响应请求，请在Discord提交求助工单。")
		else
			to_chat(src, "Plexora返回了意外响应（[result]），请在Discord提交求助工单。")
		return

	if (result == PLEXORA_NOTIFYSIGNUP_ENROLL)
		to_chat(src, span_notice("服务器重启时，你将收到通知。"))
	else if (result == PLEXORA_NOTIFYSIGNUP_UNENROLL)
		to_chat(src, span_notice("服务器重启时，你将不再收到通知。"))
	else
		to_chat(src, span_warning("Plexora返回了意外响应，未能切换你的通知状态。"))
		stack_trace("Unexpected response for notify_signup, [result]")
