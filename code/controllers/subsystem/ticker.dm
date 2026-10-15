#define ROUND_START_MUSIC_LIST "strings/round_start_sounds.txt"
#define SS_TICKER_TRAIT "SS_Ticker"

SUBSYSTEM_DEF(ticker)
	name = "Ticker"
	priority = FIRE_PRIORITY_TICKER
	ss_flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	/// state of current round (used by process()) Use the defines GAME_STATE_* !
	var/current_state = GAME_STATE_STARTUP
	/// Boolean to track if round should be forcibly ended next ticker tick.
	/// Set by admin intervention ([ADMIN_FORCE_END_ROUND])
	/// or a "round-ending" event, like summoning Nar'Sie, a blob victory, the nuke going off, etc. ([FORCE_END_ROUND])
	var/force_ending = END_ROUND_AS_NORMAL
	/// If TRUE, there is no lobby phase, the game starts immediately.
	#ifdef AUTOSTART_GAME
	var/start_immediately = TRUE
	#else
	var/start_immediately = FALSE
	#endif
	/// Boolean to track and check if our subsystem setup is done.
	var/setup_done = FALSE

	var/login_music //music played in pregame lobby
	var/round_end_sound //music/jingle played when the world reboots
	var/round_end_sound_sent = TRUE //If all clients have loaded it

	var/list/datum/mind/minds = list() //The characters in the game. Used for objective tracking.

	var/delay_end = FALSE //if set true, the round will not restart on its own
	var/admin_delay_notice = "" //a message to display to anyone who tries to restart the world after a delay
	var/ready_for_reboot = FALSE //all roundend preparation done with, all that's left is reboot

	var/tipped = FALSE //Did we broadcast the tip of the day yet?
	var/selected_tip // What will be the tip of the day?

	/// Time left until the round starts after all subsystems initialize
	var/timeLeft = 120 SECONDS
	/// value used to initialize `timeLeft` when the master subsystem finishes initializing.
	/// We do this to allow for the timer to be set manually before all subsystems initialize,
	/// while also making sure that when the timer does start, it does so at the value we have set.
	/// This is set to the config value when SSticker initializes, so setting this only makes sense after that point.
	var/start_at = 120 SECONDS

	var/gametime_offset = 21 HOURS //Deciseconds to add to world.time for station time. // DARKPACK EDIT ADD - CITY_TIME
	var/city_time_rate_multiplier = 2 //factor of station time progressal vs real time. // DARKPACK EDIT CHANGE - CITY_TIME

	/// Num of players, used for pregame stats on statpanel
	var/totalPlayers = 0
	/// Num of ready players, used for pregame stats on statpanel (only viewable by admins)
	var/totalPlayersReady = 0
	/// Num of ready admins, used for pregame stats on statpanel (only viewable by admins)
	var/total_admins_ready = 0

	var/queue_delay = 0
	var/list/queued_players = list() //used for join queues when the server exceeds the hard population cap

	/// What is going to be reported to other stations at end of round?
	var/news_report


	var/roundend_check_paused = FALSE

	var/round_start_time = 0
	var/round_start_timeofday = 0 // DARKPACK EDIT ADD
	var/list/round_start_events
	var/list/round_end_events
	var/mode_result = "undefined"
	var/end_state = "undefined"

	/// People who have been commended and will receive a heart
	var/list/hearts

	/// Why an emergency shuttle was called
	var/emergency_reason

	///The display of how much time is left before a reboot, given to all clients post-game.
	var/atom/movable/screen/reboot_timer/reboot_hud
	/// ID of round reboot timer, if it exists
	var/reboot_timer = null
	var/real_round_start_time = 0 // CRIMSON EDIT ADDITION

/datum/controller/subsystem/ticker/Initialize()
	var/list/provisional_title_music = flist("[global.config.directory]/title_music/sounds/")
	var/list/music = list()
	var/use_rare_music = prob(1)

	for(var/S in provisional_title_music)
		var/lower = LOWER_TEXT(S)
		var/list/L = splittext(lower,"+")
		switch(L.len)
			if(3) //rare+MAP+sound.ogg or MAP+rare.sound.ogg -- Rare Map-specific sounds
				if(use_rare_music)
					if(L[1] == "rare" && L[2] == SSmapping.current_map.map_name)
						music += S
					else if(L[2] == "rare" && L[1] == SSmapping.current_map.map_name)
						music += S
			if(2) //rare+sound.ogg or MAP+sound.ogg -- Rare sounds or Map-specific sounds
				if((use_rare_music && L[1] == "rare") || (L[1] == SSmapping.current_map.map_name))
					music += S
			if(1) //sound.ogg -- common sound
				if(L[1] == "exclude")
					continue
				music += S

	var/old_login_music = trim(file2text("data/last_round_lobby_music.txt"))
	if(length(music) > 1)
		music -= old_login_music

	for(var/S in music)
		if(IS_SOUND_FILE(S))
			continue
		music -= S

	if(!length(music))
		music = world.file2list(ROUND_START_MUSIC_LIST, "\n")
		if(length(music) > 1)
			music -= old_login_music
		set_lobby_music(pick(music))
	else
		set_lobby_music("[global.config.directory]/title_music/sounds/[pick(music)]")

	start_at = CONFIG_GET(number/lobby_countdown) * (1 SECONDS)
	// DARKPACK EDIT ADD START - CITY_TIME
	round_start_time = start_at // May be changed later, but prevents the time from jumping back when the round actually starts
	gametime_offset = (CONFIG_GET(number/shift_time_start_hour) * (1 HOURS))
	// DARKPACK EDIT ADD END
	return SS_INIT_SUCCESS

/datum/controller/subsystem/ticker/fire()
	switch(current_state)
		if(GAME_STATE_STARTUP)
			for(var/client/C in GLOB.clients)
				window_flash(C, ignorepref = TRUE) //let them know lobby has opened up.
			to_chat(world, span_notice("<b>欢迎来到[station_name()]！</b>"))
			for(var/channel_tag in CONFIG_GET(str_list/channel_announce_new_game))
				send2chat(new /datum/tgs_message_content("New round starting on [SSmapping.current_map.map_name]!"), channel_tag)

			// CRIMSON EDIT ADDITION START
			for(var/client/C in GLOB.clients)
				C.playtitlemusic()
			// CRIMSON EDIT ADDITION END

			current_state = GAME_STATE_PREGAME
			SEND_SIGNAL(src, COMSIG_TICKER_ENTER_PREGAME)
			fire()
			// CRIMSON EDIT ADD START - lobby_notices
			if (length(config.lobby_notices))
				config.ShowLobbyNotices(world)
			// CRIMSON END ADD
		if(GAME_STATE_PREGAME)
			//lobby stats for statpanels
			totalPlayers = LAZYLEN(GLOB.new_player_list)
			totalPlayersReady = 0
			total_admins_ready = 0
			for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
				if(player.ready == PLAYER_READY_TO_PLAY)
					++totalPlayersReady
					if(player.client?.holder)
						++total_admins_ready

			if(start_immediately)
				timeLeft = 0

			//countdown
			if(timeLeft < 0)
				return
			timeLeft -= wait

			if(timeLeft <= 300 && !tipped)
				send_tip_of_the_round(world, selected_tip)
				tipped = TRUE

			if(timeLeft <= 0)
				SEND_SIGNAL(src, COMSIG_TICKER_ENTER_SETTING_UP)
				current_state = GAME_STATE_SETTING_UP
				Master.SetRunLevel(RUNLEVEL_SETUP)
				if(start_immediately)
					fire()

		if(GAME_STATE_SETTING_UP)
			if(!setup())
				//setup failed
				current_state = GAME_STATE_STARTUP
				timeLeft = null
				Master.SetRunLevel(RUNLEVEL_LOBBY)
				SEND_SIGNAL(src, COMSIG_TICKER_ERROR_SETTING_UP)

		if(GAME_STATE_PLAYING)
			check_queue()

			if(!roundend_check_paused && (check_finished() || force_ending))
				current_state = GAME_STATE_FINISHED
				GLOB.canon_event = FALSE // We generally consider all events in postgame to be non-canon due to most servers having EORG // DARKPACK EDIT ADD
				toggle_ooc(TRUE) // Turn it on
				toggle_dooc(TRUE)
				declare_completion(force_ending)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)
				SEND_SIGNAL(src, COMSIG_TICKER_ROUND_ENDED) // CRIMSON EDIT ADDITION

		if(GAME_STATE_FINISHED)
			if(ready_for_reboot)
				if(isnull(reboot_timer))
					reboot_hud.maptext = MAPTEXT_PIXELLARI("<center>服务器重启\n\ 已推迟</center>")
				else
					reboot_hud.maptext = MAPTEXT_PIXELLARI("<center>服务器重启倒计时：\n\ [DisplayTimeText(timeleft(SSticker.reboot_timer), 1)]</center>")

/datum/controller/subsystem/ticker/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, login_music))
		set_lobby_music(var_value, override = TRUE)
	return ..()

/// Checks if the round should be ending, called every ticker tick
/datum/controller/subsystem/ticker/proc/check_finished()
	if(!setup_done)
		return FALSE
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(GLOB.station_was_nuked)
		return TRUE
	if(GLOB.revolution_handler?.result == REVOLUTION_VICTORY)
		return TRUE
	// DARKPACK EDIT ADD START - CITY_TIME
	if(SScity_time.roundend_started)
		return TRUE
	// DARKPACK EDIT ADD END
	// DARKPACK EDIT ADD START - MASQUERADE
	if(SSmasquerade.roundend_started)
		return TRUE
	// DARKPACK EDIT ADD END
	return FALSE

/// Gets a list of players with their readied state so we can post it as a log
/datum/controller/subsystem/ticker/proc/get_player_ready_states()
	var/list/player_states = list()
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		player_states[player.ckey] = player.ready
	return player_states

/datum/controller/subsystem/ticker/proc/setup()
	to_chat(world, span_boldannounce("正在开始游戏……"))
	var/init_start = world.timeofday

	var/list/players_and_readiness = get_player_ready_states()
	log_game("Players and Readiness: [json_encode(players_and_readiness)]", players_and_readiness)

	CHECK_TICK
	//Configure mode and assign player to antagonists
	var/can_continue = FALSE
	can_continue = SSdynamic.select_roundstart_antagonists() //Choose antagonists
	CHECK_TICK
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_PRE_JOBS_ASSIGNED, src)
	can_continue = can_continue && SSjob.divide_occupations() //Distribute jobs
	CHECK_TICK

	if(!GLOB.debugging_enabled)
		if(!can_continue)
			log_game("Game failed pre_setup")
			to_chat(world, "<B>游戏初始化失败。</B>正在返回准备大厅。")
			SSjob.reset_occupations()
			return FALSE
	else
		message_admins(span_notice("DEBUG: Bypassing prestart checks..."))

	CHECK_TICK

	// There may be various config settings that have been set or modified by this point.
	// This is the point of no return before spawning in new players, let's run over the
	// job trim singletons and update them based on any config settings.
	SSid_access.refresh_job_trim_singletons()

	CHECK_TICK

	if(!CONFIG_GET(flag/ooc_during_round))
		toggle_ooc(FALSE) // Turn it off

	CHECK_TICK
	GLOB.start_landmarks_list = shuffle(GLOB.start_landmarks_list) //Shuffle the order of spawn points so they dont always predictably spawn bottom-up and right-to-left
	create_characters() //Create player characters
	collect_minds()
	equip_characters()

	GLOB.manifest.build()

	transfer_characters() //transfer keys to the new mobs

	for(var/I in round_start_events)
		var/datum/callback/cb = I
		cb.InvokeAsync()
	LAZYCLEARLIST(round_start_events)

	round_start_time = world.time //otherwise round_start_time would be 0 for the signals
	round_start_timeofday = world.timeofday // DARKPACK EDIT ADD
	real_round_start_time = REALTIMEOFDAY // CRIMSON EDIT ADDITION
	SEND_SIGNAL(src, COMSIG_TICKER_ROUND_STARTING, world.time)

	log_world("Game start took [(world.timeofday - init_start)/10]s")
	INVOKE_ASYNC(SSdbcore, TYPE_PROC_REF(/datum/controller/subsystem/dbcore,SetRoundStart))

	to_chat(world, span_notice(span_bold("在[station_name()]又熬过一夜，又挣一份钱。"))) // DARKPACK EDIT CHANGE
	SEND_SOUND(world, sound(SSstation.announcer.get_rand_welcome_sound()))

	current_state = GAME_STATE_PLAYING
	Master.SetRunLevel(RUNLEVEL_GAME)

	if(length(GLOB.holidays))
		to_chat(world, span_notice("还有……"))
		for(var/holidayname in GLOB.holidays)
			var/datum/holiday/holiday = GLOB.holidays[holidayname]
			to_chat(world, span_info(holiday.greet()))

	PostSetup()

	return TRUE

/datum/controller/subsystem/ticker/proc/PostSetup()
	set waitfor = FALSE

	// Spawn traitors and stuff
	for(var/datum/dynamic_ruleset/roundstart/ruleset in SSdynamic.queued_rulesets)
		ruleset.execute()
		SSdynamic.unqueue_ruleset(ruleset)
		SSdynamic.executed_rulesets += ruleset
	// Queue roundstart intercept report
	if(!CONFIG_GET(flag/no_intercept_report))
		GLOB.communications_controller.queue_roundstart_report()
	// Queue admin logout report
	var/roundstart_logout_timer = CONFIG_GET(number/roundstart_logout_report_time_average)
	var/roundstart_report_variance = CONFIG_GET(number/roundstart_logout_report_time_variance)
	var/randomized_callback_timer = rand((roundstart_logout_timer - roundstart_report_variance), (roundstart_logout_timer + roundstart_report_variance))
	addtimer(CALLBACK(src, PROC_REF(display_roundstart_logout_report)), randomized_callback_timer)
	GLOB.logout_timer_set = randomized_callback_timer
	// Queue suicide slot handling
	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles))
		var/delay = (CONFIG_GET(number/reopen_roundstart_suicide_roles_delay) * 1 SECONDS) || 4 MINUTES
		addtimer(CALLBACK(src, PROC_REF(reopen_roundstart_suicide_roles)), delay)
	// Handle database
	if(SSdbcore.Connect())
		var/list/to_set = list()
		var/arguments = list()
		if(GLOB.revdata.originmastercommit)
			to_set += "commit_hash = :commit_hash"
			arguments["commit_hash"] = GLOB.revdata.GetDatabaseCommitSha()
		if(to_set.len)
			arguments["round_id"] = GLOB.round_id
			var/datum/db_query/query_round_game_mode = SSdbcore.NewQuery(
				"UPDATE [format_table_name("round")] SET [to_set.Join(", ")] WHERE id = :round_id",
				arguments
			)
			query_round_game_mode.Execute()
			qdel(query_round_game_mode)

	GLOB.start_state = new /datum/station_state()
	GLOB.start_state.count()

	var/list/adm = get_admin_counts()
	var/list/allmins = adm["present"]
	send2adminchat("Server", "Round [GLOB.round_id ? "#[GLOB.round_id]" : ""] has started[allmins.len ? ".":" with no active admins online!"]")
	setup_done = TRUE

	for(var/i in GLOB.start_landmarks_list)
		var/obj/effect/landmark/start/S = i
		if(istype(S)) //we can not runtime here. not in this important of a proc.
			S.after_round_start()
		else
			stack_trace("[S] [S.type] found in start landmarks list, which isn't a start landmark!")

	// handle persistence stuff that requires ckeys, in this case hardcore mode and temporal scarring
	for(var/i in GLOB.player_list)
		if(!ishuman(i))
			continue
		var/mob/living/carbon/human/iter_human = i

		iter_human.increment_scar_slot()
		iter_human.load_persistent_scars()
		iter_human.load_guestbook() // DARKPACK EDIT ADD

		if(!iter_human.hardcore_survival_score)
			continue
		if(iter_human.is_antag())
			to_chat(iter_human, span_notice("如果你在本回合完成全部目标，将获得 [round(iter_human.hardcore_survival_score) * 2] 点硬核随机积分！"))
		else
			to_chat(iter_human, span_notice("如果你在本回合存活，将获得 [round(iter_human.hardcore_survival_score)] 点硬核随机积分！"))

/datum/controller/subsystem/ticker/proc/display_roundstart_logout_report()
	var/list/msg = list("[span_boldnotice("Roundstart logout report")]\n\n")

	for(var/i in GLOB.mob_living_list)
		var/mob/living/L = i
		var/mob/living/carbon/C = L
		if (istype(C) && !C.last_mind)
			continue  // never had a client

		if(L.ckey && !GLOB.directory[L.ckey])
			msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Disconnected</b></font>)\n"


		if(L.ckey && L.client)
			var/failed = FALSE
			if(L.client.inactivity >= GLOB.logout_timer_set) //Connected, but inactive (alt+tabbed or something)
				msg += "<b>[L.name]</b> ([L.key]), the [L.job] (<font color='#ffcc00'><b>Connected, Inactive</b></font>)\n"
				failed = TRUE //AFK client
			if(!failed && IS_UNCONSCIOUS_OR_CRIT(L))
				if(HAS_TRAIT(L, TRAIT_SUICIDED)) //Suicider
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] ([span_bolddanger("Suicide")])\n"
					failed = TRUE //Disconnected client
				if(!failed && (L.stat == HARD_CRIT))
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dying)\n"
					failed = TRUE //Unconscious
				if(!failed && L.stat == DEAD)
					msg += "<b>[L.name]</b> ([L.key]), the [L.job] (Dead)\n"
					failed = TRUE //Dead

			continue //Happy connected client
		for(var/mob/dead/observer/D in GLOB.dead_mob_list)
			if(D.mind && D.mind.current == L)
				if(L.stat == DEAD)
					if(HAS_TRAIT(L, TRAIT_SUICIDED)) //Suicider
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_bolddanger("Suicide")])\n"
						continue //Disconnected client
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] (Dead)\n"
						continue //Dead mob, ghost abandoned
				else
					if(D.can_reenter_corpse)
						continue //Adminghost, or cult/wizard ghost
					else
						msg += "<b>[L.name]</b> ([ckey(D.mind.key)]), the [L.job] ([span_bolddanger("Ghosted")])\n"
						continue //Ghosted while alive

	msg += "[span_boldnotice("Roundstart logout reported at: [DisplayTimeText(GLOB.logout_timer_set)]")]\n"

	var/concatenated_message = msg.Join()
	log_admin(concatenated_message)
	to_chat(GLOB.admins, concatenated_message)

/datum/controller/subsystem/ticker/proc/reopen_roundstart_suicide_roles()
	var/include_command = CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_positions)
	var/list/reopened_jobs = list()

	for(var/mob/living/quitter in GLOB.suicided_mob_list)
		var/datum/job/job = SSjob.get_job(quitter.job)
		if(!job || !(job.job_flags & JOB_REOPEN_ON_ROUNDSTART_LOSS))
			continue
		if(!include_command && job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
			continue
		job.current_positions = max(job.current_positions - 1, 0)
		reopened_jobs += quitter.job

	if(CONFIG_GET(flag/reopen_roundstart_suicide_roles_command_report))
		if(reopened_jobs.len)
			var/reopened_job_report_positions
			for(var/dead_dudes_job in reopened_jobs)
				reopened_job_report_positions = "[reopened_job_report_positions ? "[reopened_job_report_positions]\n":""][JOB_DISPLAY_NAME(dead_dudes_job)]"

			var/suicide_command_report = {"
				<font size = 3><b>[command_name()]人力资源委员会</b><br>
				人事变动通知</font><hr>
				致[station_name()]的人事管理人员：<br><br>
				我们的医护人员从贵站部分员工的生命体征传感器中
				检测到了一系列异常。<br><br>
				经进一步调查，我们发现上述员工做出了
				一系列相当……令人遗憾的决定。<br><br>
				因此，我们已自行决定，重新开放这些
				不愿参与研究的船员原先占据的职位。相关案例将提交至雇佣审核委员会，
				以评估他们是否有资格继续为公司服务（当然，也包括
				是否继续在中央医疗备份服务器中保留其克隆记录）。<br><br>
				<i>我们已重新开放以下职位：<br><br>
				[reopened_job_report_positions]</i>
			"}

			print_command_report(suicide_command_report, "中央指挥部人事通告")

//These callbacks will fire after roundstart key transfer
/datum/controller/subsystem/ticker/proc/OnRoundstart(datum/callback/cb)
	if(!HasRoundStarted())
		LAZYADD(round_start_events, cb)
	else
		cb.InvokeAsync()

//These callbacks will fire before roundend report
/datum/controller/subsystem/ticker/proc/OnRoundend(datum/callback/cb)
	if(current_state >= GAME_STATE_FINISHED)
		cb.InvokeAsync()
	else
		LAZYADD(round_end_events, cb)

/datum/controller/subsystem/ticker/proc/create_characters()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/player = i
		if(player.ready == PLAYER_READY_TO_PLAY && player.mind)
			GLOB.joined_player_list += player.ckey
			var/atom/destination = player.mind.assigned_role.get_roundstart_spawn_point()
			if(!destination) // Failed to fetch a proper roundstart location, won't be going anywhere.
				continue
			player.create_character(destination)
		CHECK_TICK

/datum/controller/subsystem/ticker/proc/collect_minds()
	for(var/i in GLOB.new_player_list)
		var/mob/dead/new_player/P = i
		if(P.new_character && P.new_character.mind)
			SSticker.minds += P.new_character.mind
		CHECK_TICK


/datum/controller/subsystem/ticker/proc/equip_characters()
	GLOB.security_officer_distribution = decide_security_officer_departments(
		shuffle(GLOB.new_player_list),
		shuffle(GLOB.available_depts),
	)

	// var/captainless = TRUE // CRIMSON EDIT REMOVAL

	var/highest_rank = length(SSjob.chain_of_command) + 1
	var/list/spare_id_candidates = list()
	var/mob/dead/new_player/picked_spare_id_candidate

	// Find a suitable player to hold captaincy.
	for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
		if(is_banned_from(new_player_mob.ckey, list(JOB_CAPTAIN)))
			CHECK_TICK
			continue
		if(!ishuman(new_player_mob.new_character))
			continue
		var/mob/living/carbon/human/new_player_human = new_player_mob.new_character
		if(!new_player_human.mind || is_unassigned_job(new_player_human.mind.assigned_role))
			continue
		// Keep a rolling tally of who'll get the cap's spare ID vault code.
		// Check assigned_role's priority and curate the candidate list appropriately.
		var/player_assigned_role = new_player_human.mind.assigned_role.title
		var/spare_id_priority = SSjob.chain_of_command[player_assigned_role]
		if(spare_id_priority)
			if(spare_id_priority < highest_rank)
				spare_id_candidates.Cut()
				spare_id_candidates += new_player_mob
				highest_rank = spare_id_priority
			else if(spare_id_priority == highest_rank)
				spare_id_candidates += new_player_mob
		CHECK_TICK

	if(length(spare_id_candidates))
		picked_spare_id_candidate = pick(spare_id_candidates)

	for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
		if(QDELETED(new_player_mob) || !isliving(new_player_mob.new_character))
			CHECK_TICK
			continue
		var/mob/living/new_player_living = new_player_mob.new_character
		if(!new_player_living.mind)
			CHECK_TICK
			continue
		var/datum/job/player_assigned_role = new_player_living.mind.assigned_role
		if(player_assigned_role.job_flags & JOB_EQUIP_RANK)
			SSjob.equip_rank(new_player_living, player_assigned_role, new_player_mob.client)
		player_assigned_role.after_roundstart_spawn(new_player_living, new_player_mob.client)
		if(picked_spare_id_candidate == new_player_mob)
			// captainless = FALSE // CRIMSON EDIT REMOVAL
			var/acting_captain = !is_captain_job(player_assigned_role)
			SSjob.promote_to_captain(new_player_living, acting_captain)
			OnRoundstart(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce), player_assigned_role.get_captaincy_announcement(new_player_living)))
		if(ishuman(new_player_living))
			if(player_assigned_role.job_flags & JOB_ASSIGN_QUIRKS)
				if(CONFIG_GET(flag/roundstart_traits))
					if(new_player_mob.client?.prefs?.should_be_random_hardcore(player_assigned_role, new_player_living.mind))
						new_player_mob.client.prefs.hardcore_random_setup(new_player_living)
					SSquirks.AssignQuirks(new_player_living, new_player_mob.client)
			else // clear any personalities the prefs added since our job clearly does not want them
				new_player_living.clear_personalities()

		if(ishuman(new_player_living))
			SEND_SIGNAL(new_player_living, COMSIG_HUMAN_CHARACTER_SETUP_FINISHED)
		CHECK_TICK

	/* // CRIMSON EDIT REMOVAL START
	if(captainless)
		for(var/mob/dead/new_player/new_player_mob as anything in GLOB.new_player_list)
			var/mob/living/carbon/human/new_player_human = new_player_mob.new_character
			if(new_player_human)
				to_chat(new_player_mob, span_notice("Captainship not forced on anyone."))
			CHECK_TICK
	*/


/datum/controller/subsystem/ticker/proc/decide_security_officer_departments(
	list/new_players,
	list/departments,
)
	var/list/officer_mobs = list()
	var/list/officer_preferences = list()

	for (var/mob/dead/new_player/new_player_mob as anything in new_players)
		var/mob/living/carbon/human/character = new_player_mob.new_character
		if (istype(character) && is_security_officer_job(character.mind?.assigned_role))
			officer_mobs += character

			var/datum/client_interface/client = GET_CLIENT(new_player_mob)
			var/preference = client?.prefs?.read_preference(/datum/preference/choiced/security_department)
			officer_preferences += preference

	var/distribution = get_officer_departments(officer_preferences, departments)

	var/list/output = list()

	for (var/index in 1 to officer_mobs.len)
		output[REF(officer_mobs[index])] = distribution[index]

	return output

/datum/controller/subsystem/ticker/proc/transfer_characters()
	var/list/livings = list()
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		var/mob/living = player.transfer_character()
		if(living)
			qdel(player)
			ADD_TRAIT(living, TRAIT_NO_TRANSFORM, SS_TICKER_TRAIT)
			if(living.client)
				var/atom/movable/screen/splash/fade_out = new(null, null, living.client, TRUE)
				fade_out.fade(TRUE)
				living.client.init_verbs()
				living.client.show_spawn_text_overlay()

			livings += living
	if(livings.len)
		addtimer(CALLBACK(src, PROC_REF(release_characters), livings), 3 SECONDS, TIMER_CLIENT_TIME)

/datum/controller/subsystem/ticker/proc/release_characters(list/livings)
	for(var/mob/living/living_mob as anything in livings)
		REMOVE_TRAIT(living_mob, TRAIT_NO_TRANSFORM, SS_TICKER_TRAIT)

/datum/controller/subsystem/ticker/proc/check_queue()
	if(!queued_players.len)
		return
	var/hard_popcap = CONFIG_GET(number/hard_popcap)
	if(!hard_popcap)
		list_clear_nulls(queued_players)
		for (var/mob/dead/new_player/new_player in queued_players)
			to_chat(new_player, span_userdanger("存活玩家人数限制已解除！<br><a href='byond://?src=[REF(new_player)];late_join=override'>[html_encode(">>加入游戏<<")]</a>"))
			SEND_SOUND(new_player, sound('sound/announcer/notice/notice1.ogg'))
			GLOB.latejoin_menu.ui_interact(new_player)
		queued_players.len = 0
		queue_delay = 0
		return

	queue_delay++
	var/mob/dead/new_player/next_in_line = queued_players[1]

	switch(queue_delay)
		if(5) //every 5 ticks check if there is a slot available
			list_clear_nulls(queued_players)
			if(living_player_count() < hard_popcap)
				if(next_in_line?.client)
					to_chat(next_in_line, span_userdanger("有空位了！你有大约 20 秒的时间加入。<a href='byond://?src=[REF(next_in_line)];late_join=override'>\>\>加入游戏\<\<</a>"))
					SEND_SOUND(next_in_line, sound('sound/announcer/notice/notice1.ogg'))
					next_in_line.ui_interact(next_in_line)
					return
				queued_players -= next_in_line //Client disconnected, remove he
			queue_delay = 0 //No vacancy: restart timer
		if(25 to INFINITY)  //No response from the next in line when a vacancy exists, remove he
			to_chat(next_in_line, span_danger("未收到回应，你已被移出队列。"))
			queued_players -= next_in_line
			queue_delay = 0

///Whether the game has started, including roundend.
/datum/controller/subsystem/ticker/proc/HasRoundStarted()
	return current_state >= GAME_STATE_PLAYING

///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsRoundInProgress()
	return current_state == GAME_STATE_PLAYING

///Whether the game is currently in progress, excluding roundend
/datum/controller/subsystem/ticker/proc/IsPostgame()
	return current_state == GAME_STATE_FINISHED

/datum/controller/subsystem/ticker/Recover()
	current_state = SSticker.current_state
	force_ending = SSticker.force_ending

	login_music = SSticker.login_music
	round_end_sound = SSticker.round_end_sound

	minds = SSticker.minds

	delay_end = SSticker.delay_end

	tipped = SSticker.tipped
	selected_tip = SSticker.selected_tip

	timeLeft = SSticker.timeLeft

	totalPlayers = SSticker.totalPlayers
	totalPlayersReady = SSticker.totalPlayersReady
	total_admins_ready = SSticker.total_admins_ready

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players
	round_start_time = SSticker.round_start_time

	queue_delay = SSticker.queue_delay
	queued_players = SSticker.queued_players

	if (Master) //Set Masters run level if it exists
		switch (current_state)
			if(GAME_STATE_SETTING_UP)
				Master.SetRunLevel(RUNLEVEL_SETUP)
			if(GAME_STATE_PLAYING)
				Master.SetRunLevel(RUNLEVEL_GAME)
			if(GAME_STATE_FINISHED)
				Master.SetRunLevel(RUNLEVEL_POSTGAME)
				SEND_SIGNAL(src, COMSIG_TICKER_ROUND_ENDED) // CRIMSON EDIT ADDITION

/datum/controller/subsystem/ticker/proc/send_news_report()
	var/news_message
	var/news_source = "[CITY_NAME == "San Francisco" ? "旧金山" : CITY_NAME]新闻网"
	var/decoded_station_name = html_decode(station_name()) //decode station_name to avoid minor_announce double encode
	var/decoded_emergency_reason = html_decode(emergency_reason)

	switch(news_report)
		// The nuke was detonated on the syndicate recon outpost
		if(NUKE_SYNDICATE_BASE)
			news_message = "在一次大胆的突袭中，[decoded_station_name]的英勇船员\
				在恐怖分子基地的核心引爆了一枚核装置。"
		// The station was destroyed by nuke ops
		if(STATION_DESTROYED_NUKE)
			news_message = "请全体员工放心，所谓辛迪加\
				支持的针对[decoded_station_name]的核袭击报道，实际上是一场骗局。祝各位平安！"
		// The station was evacuated (normal result)
		if(STATION_EVACUATED)
			// Had an emergency reason supplied to pass along
			if(emergency_reason)
				news_message = "[decoded_station_name]在发送以下\
					求救信号后已完成撤离：\n\n[decoded_emergency_reason]"
			else
				news_message = "在有关敌方活动的未经证实报道出现后，\
					[decoded_station_name]的船员已撤离。"
		// A blob won
		if(BLOB_WIN)
			news_message = "[decoded_station_name]被一场未知生物灾害吞没，\
				全体船员遇难。别让悲剧在你身上重演！请记住，整洁的工作环境才是安全的工作环境。"
		// A blob was destroyed
		if(BLOB_DESTROYED)
			news_message = "在消灭生物危害后，[decoded_station_name]\
				正在进行去污处理。提醒各位：任何出现\
				痉挛或腹胀的船员，应立即向安保部门报到，接受焚烧处理。"
		// A certain percentage of all cultists managed to escape at the end of round
		if(CULT_ESCAPE)
			news_message = "安全警报：一群宗教狂热分子已从[decoded_station_name]逃离。"
		// Cult was completely or almost completely wiped out
		if(CULT_FAILURE)
			news_message = "在取缔[decoded_station_name]上的非法邪教后，\
				我们提醒全体员工：严禁在礼拜堂以外进行宗教活动，\
				违者将被解雇。"
		// Cult summoned Nar'sie
		if(CULT_SUMMON)
			news_message = "公司发言人澄清，[decoded_station_name]早在今年初遭受陨石破坏后，\
				就已被列入退役计划。此前关于某种\
				不可名状的恐怖存在的报道有误。"
		// Nuke detonated, but missed the station entirely
		if(NUKE_MISS)
			news_message = "辛迪加针对[decoded_station_name]的恐怖袭击出了岔子，\
				将核武器引爆在了附近的空旷太空中。"
		// All nuke ops got killed
		if(OPERATIVES_KILLED)
			news_message = "船员全歼了一支辛迪加精锐死亡小队后，\
				[decoded_station_name]的修复工作正在进行。"
		// Nuke ops results inconclusive - Crew escaped without the disk, or nukies were left alive, or something
		if(OPERATIVE_SKIRMISH)
			news_message = "[decoded_station_name]上的安保部队与辛迪加特工发生了一场小规模交火，\
				双方均有伤亡，但都未被消灭。"
		// Revolution victory
		if(REVS_WIN)
			news_message = "公司发言人向投资者保证，尽管[decoded_station_name]\
				发生了工会领导的叛乱，工人的工资也不会上涨。"
		// Revolution defeat
		if(REVS_LOSE)
			news_message = "[decoded_station_name]迅速平息了一场误入歧途的哗变。\
				请记住，组织工会是违法的！"
		// All wizards (plus apprentices) have been killed
		if(WIZARD_KILLED)
			news_message = "太空巫师联合会的一名成员在[decoded_station_name]身亡后，\
				双方关系骤然紧张。"
		// The station was nuked generically
		if(STATION_NUKED)
			// There was a blob on board, guess it was nuked to stop it
			if(length(GLOB.overminds))
				for(var/mob/eye/blob/overmind as anything in GLOB.overminds)
					if(overmind.max_count < overmind.announcement_size)
						continue

					news_message = "[decoded_station_name]在利用受控辐射爆发\
						清除一种生物黏液后，正在进行去污处理。全体员工事先均已安全撤离，\
						目前正在享受轻松的假期。"
					break
			// A self destruct or something else
			else
				news_message = "[decoded_station_name]出于不明原因启动了自毁装置。\
					目前正尝试克隆船长，以便将其逮捕并处决。"
		// The emergency escape shuttle was hijacked
		if(SHUTTLE_HIJACK)
			news_message = "在例行撤离过程中，[decoded_station_name]的紧急穿梭机\
				因导航协议损坏而偏离航线，但随后很快被找回。\
				撤离前曾发送以下求救信号：\n\n[Gibberish(decoded_emergency_reason, FALSE, 8)]"
		// A supermatter cascade triggered
		if(SUPERMATTER_CASCADE)
			news_message = "官方正通知附近殖民地，\
				[decoded_station_name]周边星区已被划为禁区。"

	if(news_message)
		send2otherserver(news_source, news_message, "News_Report")

/datum/controller/subsystem/ticker/proc/GetTimeLeft()
	return timeLeft

/datum/controller/subsystem/ticker/proc/SetTimeLeft(newtime)
	start_at = newtime
	timeLeft = newtime

/datum/controller/subsystem/ticker/proc/SetRoundEndSound(the_sound)
	set waitfor = FALSE
	round_end_sound_sent = FALSE
	round_end_sound = fcopy_rsc(the_sound)
	for(var/thing in GLOB.clients)
		var/client/C = thing
		if (!C)
			continue
		C.Export("##action=load_rsc", round_end_sound)
	round_end_sound_sent = TRUE

/datum/controller/subsystem/ticker/proc/Reboot(reason, end_string, delay)
	set waitfor = FALSE
	if(usr && !check_rights(R_SERVER, TRUE))
		return

	if(!delay)
		delay = CONFIG_GET(number/round_end_countdown) * 10

	var/skip_delay = check_rights()
	if(delay_end && !skip_delay)
		to_chat(world, span_boldannounce("管理员已推迟回合结束。"))
		return

	to_chat(world, span_boldannounce("服务器将在 [DisplayTimeText(delay)] 后重启。[list("Station destroyed by Nuclear Device." = "空间站已被核装置摧毁。", "Round ended." = "回合已结束。")[reason] || reason]"))

	var/statspage = CONFIG_GET(string/roundstatsurl)
	var/gamelogloc = CONFIG_GET(string/gamelogurl)
	if(statspage)
		to_chat(world, span_info("可在<a href=\"[statspage][GLOB.round_id]\">此网站</a>查看回合统计和日志！"))
	else if(gamelogloc)
		to_chat(world, span_info("可在<a href=\"[gamelogloc]\">此网站</a>查看回合日志！"))

	var/start_wait = world.time
	UNTIL(round_end_sound_sent || (world.time - start_wait) > (delay * 2)) //don't wait forever
	if(!isnull(reboot_timer)) //Override existing reboot timers.
		deltimer(reboot_timer)
	reboot_timer = addtimer(CALLBACK(src, PROC_REF(reboot_callback), reason, end_string), delay - (world.time - start_wait), TIMER_STOPPABLE)


/datum/controller/subsystem/ticker/proc/reboot_callback(reason, end_string)
	if(end_string)
		end_state = end_string

	log_game(span_boldannounce("Rebooting World. [reason]"))

	world.Reboot()

/**
 * Deletes the current reboot timer and nulls the var
 *
 * Arguments:
 * * user - the user that cancelled the reboot, may be null
 */
/datum/controller/subsystem/ticker/proc/cancel_reboot(mob/user)
	if(!reboot_timer)
		to_chat(user, span_warning("当前没有等待执行的重启！"))
		return FALSE
	to_chat(world, span_boldannounce("管理员已推迟回合结束。"))
	deltimer(reboot_timer)
	reboot_timer = null
	return TRUE

/datum/controller/subsystem/ticker/Shutdown()
	gather_newscaster() //called here so we ensure the log is created even upon admin reboot
	if(!round_end_sound)
		round_end_sound = choose_round_end_song()
	for(var/mob/M in GLOB.player_list)
		var/pref_volume = M.client.prefs.read_preference(/datum/preference/numeric/volume/sound_midi)
		if(pref_volume > 0)
			SEND_SOUND(M.client, sound(round_end_sound, volume = pref_volume))

	text2file(login_music, "data/last_round_lobby_music.txt")

/datum/controller/subsystem/ticker/proc/choose_round_end_song()
	var/list/reboot_sounds = flist("[global.config.directory]/reboot_themes/")
	var/list/possible_themes = list()

	for(var/themes in reboot_sounds)
		possible_themes += themes
	if(possible_themes.len)
		return "[global.config.directory]/reboot_themes/[pick(possible_themes)]"

/// Updates the lobby music
/// Does not update if override is FALSE and login_music is already set
/datum/controller/subsystem/ticker/proc/set_lobby_music(new_music, override = FALSE)
	if(!override && login_music)
		return

	login_music = new_music
	//we just overrode the song, let's update everyone.
	if(override)
		for(var/mob/dead/new_player/new_player as anything in GLOB.new_player_list)
			new_player?.client.playtitlemusic()

#undef ROUND_START_MUSIC_LIST
#undef SS_TICKER_TRAIT
