/datum/subsplat/vampire_clan/setite
	name = "Setite"
	id = VAMPIRE_CLAN_SETITE
	desc = "瑟泰信徒又称瑟泰圣职会或圣职会，是相信始祖为埃及神瑟泰的吸血鬼氏族。他们以诱惑与恶行为途径追求自由，是引人堕落者。在许多城市，他们作为独立势力活动，深涉黑市贸易，并与萨麦迪、死骸先驱等死亡氏族结盟；纳迦拉贾则是其宿敌。瑟泰信徒擅长隐秘行事、操纵他人与腐化心灵，凭借近乎邪教般的始祖崇拜，常将自己包装成解救人们摆脱道德束缚的解放者。氏族诅咒使他们在强光、火焰或阳光下变得虚弱。"
	icon = "setite"
	curse = "在有光照的区域移动速度降低。"
	roleplay_level = "Advanced"
	sense_the_sin_text = "将每一处罪孽都视为美德。"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)
	subsplat_traits = list(
		TRAIT_LIGHT_WEAKNESS
	)
	male_clothes = /obj/item/clothing/under/vampire/slickback
	female_clothes = /obj/item/clothing/under/vampire/burlesque
	subsplat_keys = /obj/item/vamp/keys/setite

/datum/subsplat/vampire_clan/setite/tlacique
	name = "Tlacique"
	id = VAMPIRE_CLAN_TLACIQUE
	desc = "特拉西克是起源于墨西哥的血系，远在其他瑟泰信徒到来之前便已扎根于此。现代的他们日渐凋零，几乎被该隐之剑灭绝，与母氏族往往仅有些许相似之处。"
	icon = "tlacique"
	clan_disciplines = list(
		/datum/discipline/obfuscate,
		/datum/discipline/presence,
		/datum/discipline/protean
	)
	whitelisted = TRUE

/datum/subsplat/vampire_clan/setite/warrior
	name = "Warrior Setite"
	id = VAMPIRE_CLAN_WARRIOR_SETITE
	icon = "warrior_setite"
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/presence,
		/datum/discipline/serpentis
	)

/datum/subsplat/vampire_clan/setite/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/arabic)
//We don't have Mesoamerican languages.
