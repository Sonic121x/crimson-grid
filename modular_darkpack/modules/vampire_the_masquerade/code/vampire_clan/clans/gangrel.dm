/datum/subsplat/vampire_clan/gangrel
	name = "Gangrel"
	id = VAMPIRE_CLAN_GANGREL
	desc = "冈格罗比其他吸血鬼更接近野兽，自诩为顶级掠食者。他们穿行荒野与都市丛林都同样自如，在各种环境中忍耐、生存并壮大的能力无其他氏族可比。他们往往有极强的领地意识，变形能力连其他不死生物也为之忌惮。冈格罗是生存专家、流浪者和掠食者，与本能和心兽联系紧密。虽然氏族多年前已正式退出密党，仍有足够多的冈格罗长老留在其中，维系着影响力。他们通常回避僵化的政治，相比地位更看重独立与实用的力量。氏族诅咒会使他们在狂乱后显露兽类特征，逐渐失去人类的外貌。"
	icon = "gangrel"
	curse = "初始人性较低。"
	roleplay_level = "Beginner Friendly"
	sense_the_sin_text = "无法控制自身的冲动。"
	clan_disciplines = list(
		/datum/discipline/animalism,
		/datum/discipline/fortitude,
		/datum/discipline/protean,
	)
	male_clothes = /obj/item/clothing/under/vampire/gangrel
	female_clothes = /obj/item/clothing/under/vampire/gangrel/female
	clan_marks = list(
		/datum/bodypart_overlay/simple/clan_mark/beast_legs,
		/datum/bodypart_overlay/simple/clan_mark/beast_tail,
		/datum/bodypart_overlay/simple/clan_mark/beast_tail_and_legs,
	)

/datum/subsplat/vampire_clan/gangrel/city
	name = "City Gangrel"
	desc = "都市冈格罗是传统冈格罗分化出的魔宴血系，通常栖居城市。他们运用有别于本族的迅捷术与朦胧术，凭借超常速度和隐匿能力，与魔宴战团同伴一同潜行于巷道、屋顶和下水道，寻找下一顿鲜血盛宴。"
	id = VAMPIRE_CLAN_CITY_GANGREL
	icon = "city_gangrel"
	roleplay_level = "Beginner Friendly"
	clan_disciplines = list(
		/datum/discipline/celerity,
		/datum/discipline/obfuscate,
		/datum/discipline/protean,
	)
