/datum/ert
	///Antag datum team for this type of ERT.
	var/team = /datum/team/ert
	///Do we open the doors to the "high-impact" weapon/explosive cabinets? Used for combat-focused ERTs.
	var/opendoors = TRUE
	///Alternate antag datum given to the leader of the squad.
	var/leader_role = /datum/antagonist/ert/commander
	///Do we humanize all spawned players or keep them the species in their current character prefs?
	var/enforce_human = TRUE
	///A list of roles distributed to the selected candidates that are not the leader.
	var/roles = list(/datum/antagonist/ert/security, /datum/antagonist/ert/medic, /datum/antagonist/ert/engineer)
	///The custom name assigned to this team, for their antag datum/roundend reporting.
	var/rename_team
	///Defines the color/alert code of the response team. Unused if a polldesc is defined.
	var/code
	///The mission given to this ERT type in their flavor text.
	var/mission = "支援空间站。"
	///The number of players for consideration.
	var/teamsize = 5
	///The "would you like to play as XXX" message used when polling for players.
	var/polldesc
	/// If TRUE, gives the team members "[role] [random last name]" style names
	var/random_names = TRUE
	/// If TRUE, the admin who created the response team will be spawned in the briefing room in their preferred briefing outfit (assuming they're a ghost)
	var/spawn_admin = FALSE
	/// If TRUE, we try and pick one of the most experienced players who volunteered to fill the leader slot
	var/leader_experience = TRUE
	/// A custom map template to spawn the ERT at. If this is null or use_custom_shuttle is FALSE, the ERT will spawn at Centcom.
	var/datum/map_template/ert_template
	/// If we should actually _use_ the ert_template custom shuttle
	var/use_custom_shuttle = TRUE
	/// Used for spawning bodies for your ERT. Unless customized in the Summon-ERT verb settings, will be overridden and should not be defined at the datum level.
	var/mob/living/carbon/human/mob_type

/datum/ert/New()
	if (!polldesc)
		polldesc = "纳诺传讯[list("Blue" = "蓝色", "Amber" = "琥珀色", "Red" = "红色", "Delta" = "德尔塔", "Green" = "绿色", "Rainbow" = "彩虹", "Violet" = "紫色")[code] || code]代码紧急响应小队"

/datum/ert/blue
	opendoors = FALSE
	code = "Blue"

/datum/ert/amber
	code = "Amber"

/datum/ert/red
	leader_role = /datum/antagonist/ert/commander/red
	roles = list(/datum/antagonist/ert/security/red, /datum/antagonist/ert/medic/red, /datum/antagonist/ert/engineer/red)
	code = "Red"

/datum/ert/deathsquad
	roles = list(/datum/antagonist/ert/deathsquad)
	leader_role = /datum/antagonist/ert/deathsquad/leader
	rename_team = "死亡小队"
	code = "Delta"
	mission = "不留目击者。"
	polldesc = "纳诺传讯精锐突击队"

/datum/ert/marine
	leader_role = /datum/antagonist/ert/marine
	roles = list(/datum/antagonist/ert/marine/security, /datum/antagonist/ert/marine/engineer, /datum/antagonist/ert/marine/medic)
	rename_team = "陆战小队"
	polldesc = "纳诺传讯“精锐”突击队"
	opendoors = FALSE

/datum/ert/centcom_official
	code = "Green"
	teamsize = 1
	opendoors = FALSE
	leader_role = /datum/antagonist/ert/official
	roles = list(/datum/antagonist/ert/official)
	rename_team = "中央指挥部官员"
	polldesc = "中央指挥部官员"
	random_names = FALSE
	leader_experience = FALSE

/datum/ert/centcom_official/New()
	mission = "对[station_name()]及其船长进行例行绩效评估。"

/datum/ert/inquisition
	roles = list(/datum/antagonist/ert/chaplain/inquisitor, /datum/antagonist/ert/security/inquisitor, /datum/antagonist/ert/medic/inquisitor)
	leader_role = /datum/antagonist/ert/commander/inquisitor
	rename_team = "审判庭"
	mission = "消除空间站内一切超自然活动的痕迹。"
	polldesc = "纳诺传讯超自然事件响应小队"

/datum/ert/janitor
	roles = list(/datum/antagonist/ert/janitor, /datum/antagonist/ert/janitor/heavy)
	leader_role = /datum/antagonist/ert/janitor/heavy
	teamsize = 4
	opendoors = FALSE
	rename_team = "清洁队"
	mission = "把一切都清理干净。"
	polldesc = "纳诺传讯清洁响应小队"

/datum/ert/intern
	roles = list(/datum/antagonist/ert/intern)
	leader_role = /datum/antagonist/ert/intern/leader
	teamsize = 7
	opendoors = FALSE
	rename_team = "实习生大军"
	mission = "协助解决冲突。"
	polldesc = "纳诺传讯无薪实习岗位"
	random_names = FALSE

/datum/ert/intern/unarmed
	roles = list(/datum/antagonist/ert/intern/unarmed)
	leader_role = /datum/antagonist/ert/intern/leader/unarmed
	rename_team = "徒手实习生大军"

/datum/ert/erp
	roles = list(/datum/antagonist/ert/security/party, /datum/antagonist/ert/clown/party, /datum/antagonist/ert/engineer/party, /datum/antagonist/ert/janitor/party)
	leader_role = /datum/antagonist/ert/commander/party
	opendoors = FALSE
	rename_team = "紧急响应派对"
	mission = "为船员提供娱乐。"
	polldesc = "纳诺传讯彩虹代码紧急响应派对"
	code = "Rainbow"

/datum/ert/bounty_hunters
	roles = list(/datum/antagonist/ert/bounty_armor, /datum/antagonist/ert/bounty_hook, /datum/antagonist/ert/bounty_synth)
	leader_role = /datum/antagonist/ert/bounty_armor
	teamsize = 3
	opendoors = FALSE
	rename_team = "赏金猎人"
	mission = "协助空间站抓捕罪犯，生死不论。"
	polldesc = "中央指挥部雇佣的赏金猎人团伙"
	random_names = FALSE
	ert_template = /datum/map_template/shuttle/ert/bounty

/datum/ert/militia
	roles = list(/datum/antagonist/ert/militia)
	leader_role = /datum/antagonist/ert/militia/general
	teamsize = 4
	opendoors = FALSE
	rename_team = "边疆民兵"
	mission = "收到空间站的求援后，协助船员自卫。"
	polldesc = "独立空间站防卫民兵"
	random_names = TRUE

/datum/ert/medical
	opendoors = FALSE
	teamsize = 4
	leader_role = /datum/antagonist/ert/medical_commander
	enforce_human = FALSE //All the best doctors I know are moths and cats
	roles = list(/datum/antagonist/ert/medical_technician)
	rename_team = "急救小队"
	code = "Violet"
	mission = "为船员提供紧急医疗服务。"
	polldesc = "紧急医疗响应小队"
