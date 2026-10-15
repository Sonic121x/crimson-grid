/datum/admin_help/ClosureLinks(ref_src)
	. = ..()
	. += " (<A HREF='byond://?_src_=holder;[HrefToken(TRUE)];ahelp=[ref_src];ahelp_action=mhelp'>MHELP</A>)"

/**
 * We're overwriting /datum/admin_help/proc/Action(action)
 * This is to add the "Mhelp" button to the admin_help's Action
 */

/datum/admin_help/Action(action)
	. = ..()
	switch(action)
		if("mhelp")
			MHelpThis()

/datum/admin_help/proc/MHelpThis(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return

	if(initiator)
		initiator.giveadminhelpverb()

		SEND_SOUND(initiator, sound('sound/effects/adminhelp.ogg'))

		to_chat(initiator, "<font color='red' size='4'><b>- 请向导师求助！ -</b></font>")
		to_chat(initiator, "<font color='red'>这个问题涉及<b>游戏机制</b>，应通过<b>导师求助</b>提出。请使用屏幕右上方<b>导师（Mentor）<b>选项卡中的<b>导师求助</b>命令。</font>")

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "mhelp this")
	var/msg = "Ticket [TicketHref("#[id]")] told to mentorhelp by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Told to mentorhelp by [key_name].")
	Close(silent = TRUE)
