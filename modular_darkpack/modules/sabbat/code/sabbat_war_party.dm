/obj/item/sabbat_war_party
	name = "魔宴战团出征图腾"
	desc = "用吸血鬼头骨制成的图腾，用于召集所有魔宴同盟战团前往战团首领的巢穴。"
	icon = 'modular_darkpack/modules/sabbat/icons/sabbat_war_party.dmi'
	icon_state = "sabbat_warparty"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL

/obj/item/sabbat_war_party/attack_self(mob/user)
	. = ..()

	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	if(!is_sabbat_ductus(H.mind.assigned_role) && !is_sabbat_priest(H.mind.assigned_role))
		to_chat(H, span_cult("只有战团首领或祭司才能用图腾召集战团出征！"))
		return

	var/choice = tgui_alert(H, "是否向城中所有魔宴同盟成员发出消息，命令他们返回魔宴巢穴？", "返回巢穴", list("是", "否"), 10 SECONDS)
	if(choice == "是")

		// Inform the user about the current status of the totem
		to_chat(H, span_notice("你唤起图腾的力量，头骨的眼眶中燃起猩红光芒。"))
		for(var/mob/living/carbon/human/sabbat_member in GLOB.player_list)
			if(sabbat_member.mind && is_sabbatist(sabbat_member.mind.assigned_role))
				to_chat(sabbat_member, span_cult("战团首领召集所有战团成员返回巢穴，立即归队！"))
				SEND_SOUND(sabbat_member, sound('modular_darkpack/master_files/sounds/announce.ogg'))
				sabbat_member.emote("twitch")
	else
		to_chat(user, span_warning("你决定不召集战团出征。"))
