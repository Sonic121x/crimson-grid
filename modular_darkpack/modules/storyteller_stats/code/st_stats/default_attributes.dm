/datum/st_stat/attribute/strength
	name = "力量"
	description = "影响徒手攻击的伤害倍率，提高徒手战斗中击倒对手的概率。"
	subcategory = "身体"


/datum/st_stat/attribute/dexterity
	name = "敏捷"
	description = "影响移动速度和近战武器命中率，提高徒手战斗中抵抗击倒的能力，并加快某些动作。"
	subcategory = "身体"

/datum/st_stat/attribute/dexterity/update_mob(mob/living/our_mob, initial)
	our_mob.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/dexterity, multiplicative_slowdown = -(get_score() / 20))


/datum/st_stat/attribute/stamina
	name = "耐力"
	description = "影响生命值上限。用于静谧术。"
	subcategory = "身体"

/datum/st_stat/attribute/stamina/update_mob(mob/living/our_mob, initial)
	our_mob.recalculate_max_health(initial)


/datum/st_stat/attribute/charisma
	name = "魅力"
	description = "角色凭借个性吸引他人、赢得好感的能力。用于惑狂术、支配术和威仪术。"
	subcategory = "社交"

/datum/st_stat/attribute/manipulation
	name = "操控"
	description = "角色通过言行让他人认同自己的观点或顺从自己意愿的能力。用于社交与心智类律能。"
	subcategory = "社交"

/datum/st_stat/attribute/appearance
	name = "外貌"
	description = "衡量角色给人留下的第一印象。用于社交类律能，也使角色更具吸引力。"
	subcategory = "社交"

/* For the bimbo in the audience
/datum/st_stat/attribute/appearance/update_mob(mob/living/our_mob, initial)
	update_bloodquality_from_appearance()
*/


/datum/st_stat/attribute/perception
	name = "感知"
	description = "角色观察周围环境的能力。加快查看速度。用于灵视术。"
	subcategory = "心智"

/datum/st_stat/attribute/intelligence
	name = "智力"
	description = "角色掌握事实与知识的程度，也决定推理、解决问题和判断形势的能力。用于法术类律能与仪式。"
	subcategory = "心智"

/datum/st_stat/attribute/wits
	name = "机敏"
	description = "角色临机应变、迅速作出反应的能力，也反映其整体机智程度。用于死灵术。"
	subcategory = "心智"
