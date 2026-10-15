/datum/subsplat/vampire_clan/true_brujah
	name = "True Brujah"
	id = VAMPIRE_CLAN_TRUE_BRUJAH
	desc = "真布鲁赫是布鲁赫氏族的一支血系，自称传承自最初的上古者始祖，而非对始祖施行血噬的子嗣特洛伊尔。他们以冷静疏离的举止著称，与暴躁易怒、敌视既有体制的主流布鲁赫形成鲜明对照。"
	icon = "true_brujah"
	curse = "缺乏激情。"
	sense_the_sin_text = "无法表达情感。"
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/presence,
		/datum/discipline/temporis
	)
	enlightenment = TRUE
	male_clothes = /obj/item/clothing/under/vampire/rich
	female_clothes = /obj/item/clothing/under/vampire/business
	restricted_disciplines = list(/datum/discipline/celerity)
	whitelisted = TRUE
