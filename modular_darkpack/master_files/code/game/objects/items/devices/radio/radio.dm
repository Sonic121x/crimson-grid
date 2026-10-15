/obj/item/radio
	/// If the radio is connected to a network via a transceiver.
	var/radio_network
	/// The ID used to identify the radio on the network.
	var/radio_id

/obj/item/radio/examine(mob/user)
	. = ..()
	. += radio_network ? span_notice("已连接至[darkpack_radio_network_name(radio_network)]，使用的编号为：[radio_id]。") : span_warning("未连接至任何网络。")
