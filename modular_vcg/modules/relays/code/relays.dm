GLOBAL_VAR(relay_config)

GAME_VERB_DESC(/client, go2relay, "网络中继", "连接至中继服务器，尝试改善连接稳定性。", "OOC")

	if(is_localhost())
		to_chat(src, span_notice("你正通过本机地址连接，无需使用网络中继。"))
		return

	if(!length(GLOB.relay_config))
		to_chat(src, span_notice("未找到中继配置，或配置为空。"))
		return

	var/list/names = list()
	var/list/name_to_relay = list()

	for(var/list/relay in GLOB.relay_config)
		var/name = relay["name"]
		names += name
		name_to_relay[name] = relay

	var/choice = tgui_input_list(src, "你想使用哪个中继？中继可能降低部分玩家的网络延迟。", "选择中继", names)
	if(!choice)
		to_chat(src, span_notice("你没有选择中继。"))
		return

	var/list/relay = name_to_relay[choice]
	if(!relay)
		to_chat(src, span_notice("所选中继无效。"))
		return

	var/address = replacetext(relay["address"], "{port}", "[world.port]")

	var/quickname = relay["quickname"]

	to_chat_immediate(
		target = src,
		html = boxed_message(span_info(span_big("正在连接[quickname]\n若没有响应，请尝试手动连接中继（[address]）；中继也可能暂时离线！"))),
		type = MESSAGE_TYPE_INFO,
	)
	DIRECT_OUTPUT(src, link(address))

/datum/controller/configuration/LoadMisc()
	. = ..()
	LoadRelays()

/datum/controller/configuration/proc/LoadRelays()
	var/config_path = "[directory]/relays.toml"
	if(!fexists(file(config_path)))
		log_config("relays.toml does not exist.")
		return

	var/list/result = rustg_raw_read_toml_file(config_path)
	if(!result["success"])
		log_config("Notify Server Operators: The relay config (relays.toml) is not configured correctly! [result["content"]]")
		return

	var/list/content = json_decode(result["content"])
	if(!length(content))
		return

	GLOB.relay_config = content["relay"]
