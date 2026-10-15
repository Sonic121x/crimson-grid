/datum/ert/darkpack
	abstract_type = /datum/ert/darkpack

/datum/ert/darkpack/swat
	leader_role = /datum/antagonist/ert/darkpack/swat/leader
	roles = list(/datum/antagonist/ert/darkpack/swat/medic, /datum/antagonist/ert/darkpack/swat/rifleman, /datum/antagonist/ert/darkpack/swat/negotiations)
	rename_team = "特警队"
	mission = "评估局势并协助警察局，确保城市恢复法治与秩序。"
	polldesc = "市特警队"

/datum/ert/darkpack/national_guard
	leader_role = /datum/antagonist/ert/darkpack/national_guard/leader
	roles = list(/datum/antagonist/ert/darkpack/national_guard/medic, /datum/antagonist/ert/darkpack/national_guard/rifleman, /datum/antagonist/ert/darkpack/national_guard/explosives)
	rename_team = "国民警卫队排"
	mission = "稳定该地区局势，实施宵禁，驱散暴乱。不惜一切手段，立即确保安全并恢复秩序。"
	polldesc = "国民警卫队应急响应部队"

/datum/ert/darkpack/pentex
	leader_role = /datum/antagonist/ert/darkpack/pentex/leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/medic, /datum/antagonist/ert/darkpack/pentex/exterminator, /datum/antagonist/ert/darkpack/pentex/specialist)
	rename_team = "第一小队"
	mission = "肃清所有敌对异常实体。"
	polldesc = "精锐的第一小队"

/datum/ert/darkpack/pentex/budget
	leader_role = /datum/antagonist/ert/darkpack/pentex/budget_leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/budget_intern, /datum/antagonist/ert/darkpack/pentex/budget_medic)
	rename_team = "第一小队" //For when you need a death-squad on a budget
	mission = "清除所有敌对异常实体。"
	polldesc = "“精锐”的第一小队"

/datum/ert/darkpack/fbi
	leader_role = /datum/antagonist/ert/darkpack/fbi/leader
	roles = list(/datum/antagonist/ert/darkpack/fbi/medic, /datum/antagonist/ert/darkpack/fbi/rifleman, /datum/antagonist/ert/darkpack/fbi/marksman)
	rename_team = "联邦调查局特警队"
	mission = "评估局势并协助已部署的联邦调查局特别探员。"
	polldesc = "联邦调查局特警队"
