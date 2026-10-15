/obj/item/blood_hunt
	name = "不祥的骷髅"
	desc = "一颗用大理石雕成的骷髅。"
	icon = 'modular_darkpack/modules/masquerade/icons/blood_hunt_skull.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/masquerade/icons/onfloor.dmi')
	icon_state = "skull"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/blood_hunt_skull
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/blood_hunt_skull
	fire = 100
	acid = 100

/obj/item/blood_hunt/Initialize(mapload)
	. = ..()
	REGISTER_REQUIRED_MAP_ITEM(1, 1)
	GLOB.blood_hunt_announcers += src

/obj/item/blood_hunt/Destroy(force)
	GLOB.blood_hunt_announcers -= src
	return ..()

/obj/item/blood_hunt/examine(mob/user)
	. = ..()
	if(get_kindred_splat(user))
		. += span_notice("这件以血魔法创造的器物能让你向全城宣布血猎。")
		. += span_notice("手持这颗骷髅与血族<b>互动</b>，还可以赦免其违反避世戒律的罪行。")

/obj/item/blood_hunt/attack_self(mob/user)
	. = ..()
	var/chosen_name = tgui_input_text(user, "输入要追猎或赦免的角色姓名：", "血猎")
	if(!chosen_name)
		return
	chosen_name = sanitize_name(chosen_name)
	var/reason = tgui_input_text(user, "输入宣布血猎的理由：", "血猎理由")
	if(!reason)
		return
	reason = sanitize(reason)

	for(var/mob/player_mob in GLOB.kindred_list)
		if(player_mob.real_name == chosen_name)
			if(HAS_TRAIT(player_mob, TRAIT_HUNTED))
				end_hunt(user, player_mob)
				return
			else
				start_hunt(user, player_mob, reason)
				return
	to_chat(user, span_danger("城里没有这个人！"))

/obj/item/blood_hunt/proc/start_hunt(mob/user, mob/target, reason)
	to_chat(user, span_warning("你将[target.real_name]列入了血猎名单。"))
	RegisterSignals(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_LIVING_GIBBED), PROC_REF(complete_hunt))
	log_game("[user.real_name] started a bloodhunt on [target.real_name] for: [reason]")
	message_admins("[ADMIN_LOOKUPFLW(user)]] started a bloodhunt on [target.real_name] for: [reason]")
	target.start_blood_hunt(reason)

/obj/item/blood_hunt/proc/end_hunt(mob/user, mob/target)
	to_chat(user, span_warning("你将[target.real_name]移出了血猎名单。"))
	UnregisterSignal(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_LIVING_GIBBED))
	log_game("[user.real_name] ended a bloodhunt on [target.real_name].")
	message_admins("[ADMIN_LOOKUPFLW(user)]] ended a bloodhunt on [target.real_name].")
	target.clear_blood_hunt()

/obj/item/blood_hunt/proc/complete_hunt(mob/target)
	SIGNAL_HANDLER

	UnregisterSignal(target, list(COMSIG_LIVING_DEATH, COMSIG_QDELETING, COMSIG_LIVING_GIBBED))
	target.clear_blood_hunt()

// This code is for reinforcing a player's masquerade.
/obj/item/blood_hunt/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return NONE
	if(!get_kindred_splat(interacting_with))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你朝[interacting_with]举起[src]……"))
	if(!do_after(user, 10 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING
	if(SSmasquerade.masquerade_reinforce(src, interacting_with, MASQUERADE_REASON_PREFERENCES))
		to_chat(user, span_notice("你赦免了[interacting_with]违反避世戒律的罪行！"))
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_notice("[interacting_with]违反避世戒律的罪行尚不符合赦免条件！"))
	return ITEM_INTERACT_BLOCKING
