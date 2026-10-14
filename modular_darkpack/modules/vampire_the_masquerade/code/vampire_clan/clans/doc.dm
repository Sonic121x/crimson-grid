/datum/subsplat/vampire_clan/daughters_of_cacophony
	name = "Daughters of Cacophony"
	id = VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY
	desc = "喧嚣之女目前大多为女性，因为多数男性的音域使相关训练更为困难。她们修习悲歌术，这种律能可通过歌唱引发奇异效果。她们是不死者中出类拔萃的歌者；对托瑞多而言，能主持一场她们的聚会，是莫大的荣誉。"
	icon = "daughters_of_cacophony"
	curse = "听见过多不应听见的声音。"
	sense_the_sin_text = "心智被永不停歇的乐声笼罩。"
	clan_disciplines = list(
		/datum/discipline/fortitude,
		/datum/discipline/melpominee,
		/datum/discipline/presence
	)
	male_clothes = /obj/item/clothing/under/vampire/sexy
	female_clothes = /obj/item/clothing/under/vampire/toreador/female
	enlightenment = FALSE
	whitelisted = TRUE
	subsplat_keys = /obj/item/vamp/keys/daughters
