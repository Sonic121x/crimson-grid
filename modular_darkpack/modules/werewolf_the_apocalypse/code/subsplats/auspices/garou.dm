/datum/subsplat/werewolf/auspice/garou
	abstract_type = /datum/subsplat/werewolf/auspice/garou
	fera_restriction = SPLAT_GAROU


/datum/subsplat/werewolf/auspice/garou/ahroun
	name = AUSPICE_AHROUN
	desc = "满月战士体现了狼人作为杀戮猛兽的典型形象，其中既有毫不悔恨的狂战士，也有以纪律驾驭怒火的百战老兵。旺盛的怒火使他们时刻处于爆发边缘，满月的祝福也意味着一触即发的脾气。出生时接近盈月者往往沉醉于战争的荣耀，接近亏月者则更加凶狠务实，嗜血而无情。与任何满月战士相处都很危险，但当妖蛆势力来袭时，同伴们总会庆幸冲锋在前的是一位满月战士。"
	start_rage = 5
	gifts_provided= list(
		/datum/action/cooldown/power/gift/falling_touch,
		/datum/action/cooldown/power/gift/inspiration,
		/datum/action/cooldown/power/gift/razor_claws,
	)
	moons_born_under = list(MOON_FULL)

/datum/subsplat/werewolf/auspice/garou/ahroun/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 10 && honor >= 9 && wisdom >= 4)
		return RANK_ELDER
	if(glory >= 9 && honor >= 4 && wisdom >= 2)
		return RANK_ATHRO
	if(glory >= 6 && honor >= 3 && wisdom >= 1)
		return RANK_ADREN
	if(glory >= 4 && honor >= 1 && wisdom >= 1)
		return RANK_FOSTERN
	if(glory >= 2 && honor >= 1)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/galliard
	name = AUSPICE_GALLIARD
	desc = "半月仲裁者克制隐忍，盈月诗人却满怀奔放的激情。凸月如炽烈的缪斯，激起其子女情感上的大起大落。所有盈月诗人都容易大喜大悲，而亏月下出生者更易陷入黑暗、吞噬心灵的激情。他们是狼人的悲剧诗人，擅长讲述厄运、毁灭、牺牲与失落。盈月下出生者则歌颂胜利与征服、激荡的心跳和对生命的热爱。他们通常是维系狼群士气的灵魂：只要盈月诗人愿意继续前行，其他成员便也会跟上。"
	start_rage = 4
	gifts_provided = list(
		/datum/action/cooldown/power/gift/beast_speech,
		/datum/action/cooldown/power/gift/call_of_the_wyld,
		/datum/action/cooldown/power/gift/mindspeak
	)
	moons_born_under = list(MOON_WAXING_GIBBOUS, MOON_WANING_GIBBOUS)

/datum/subsplat/werewolf/auspice/garou/galliard/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 9 && honor >= 5 && wisdom >= 9)
		return RANK_ELDER
	if(glory >= 7 && honor >= 2 && wisdom >= 6)
		return RANK_ATHRO
	if(glory >= 4 && honor >= 2 && wisdom >= 4)
		return RANK_ADREN
	if(glory >= 4 && wisdom >= 2)
		return RANK_FOSTERN
	if(glory >= 2 && wisdom >= 1)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/philodox
	name = AUSPICE_PHILODOX
	desc = "半月仲裁者全心投入公正审判与裁决的职责，因而显得疏离，甚至冷酷得不像狼人。上弦月下出生者往往异常平静、淡漠，唯有怒火沸腾时才流露情绪。下弦月下出生者则更为敏锐、严苛，时刻细察狼群同伴与同僚是否偏离应有的行止。半月仲裁者的意见令人敬畏，也备受尊重：这些天生能够看清冲突双方的人，所给予的一句赞许或谴责都分量十足。"
	start_rage = 3
	gifts_provided= list(
		/datum/action/cooldown/power/gift/resist_pain,
		/datum/action/cooldown/power/gift/scent_of_the_true_form,
		/datum/action/cooldown/power/gift/truth_of_gaia,
	)
	moons_born_under = list(MOON_FIRST_QUARTER, MOON_LAST_QUARTER)

/datum/subsplat/werewolf/auspice/garou/philodox/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 4 && honor >= 10 && wisdom >= 9)
		return RANK_ELDER
	if(glory >= 3 && honor >= 8 && wisdom >= 4)
		return RANK_ATHRO
	if(glory >= 2 && honor >= 6 && wisdom >= 2)
		return RANK_ADREN
	if(glory >= 1 && honor >= 4 && wisdom >= 1)
		return RANK_FOSTERN
	if(honor >= 3)
		return RANK_CLIATH
	return RANK_CUB


/datum/subsplat/werewolf/auspice/garou/theurge
	name = AUSPICE_THEURGE
	desc = "弦月祭司可能古怪而神秘，常常沉浸于所交往灵体那曲折的象征逻辑，而非人类熟悉的思维方式。亏月下出生的祭司与灵界关系往往更为严酷、对立：他们擅长束缚灵体、迫使其服从自身意志，与灵体交战时也更为凶狠。盈月下出生的祭司则更为宽厚坦诚，倾向于以魅力与劝诱打动灵体，而非恐吓与威胁。"
	subsplat_traits = list(TRAIT_OPENS_MOONGATES)
	start_rage = 2
	gifts_provided = list(
		/datum/action/cooldown/power/gift/mothers_touch,
		/datum/action/cooldown/power/gift/sense_wyrm,
		/datum/action/cooldown/power/gift/spirit_speech
	)
	moons_born_under = list(MOON_WANING_CRESCENT, MOON_WAXING_CRESENT)

/datum/subsplat/werewolf/auspice/garou/theurge/rank_requirments(list/renown)
	var/glory = renown[RENOWN_GLORY]
	var/honor = renown[RENOWN_HONOR]
	var/wisdom = renown[RENOWN_WISDOM]

	if(glory >= 4 && honor >= 9 && wisdom >= 10)
		return RANK_ELDER
	if(glory >= 4 && honor >= 2 && wisdom >= 9)
		return RANK_ATHRO
	if(glory >= 2 && honor >= 1 && wisdom >= 7)
		return RANK_ADREN
	if(glory >= 1 && wisdom >= 5)
		return RANK_FOSTERN
	if(wisdom >= 3)
		return RANK_CLIATH
	return RANK_CUB


/datum/subsplat/werewolf/auspice/garou/ragabash
	name = AUSPICE_RAGABASH
	desc = "新月将盈时出生的诡术者通常轻松愉快、变幻无常，新月将亏时出生者则多几分邪气与无情。几乎每位新月诡术者都机敏过人，无论境况多么黯淡，总能从中找到笑料。然而，其他狼人往往难以认真对待他们，因为很难分清一番嘲弄究竟是在指出计划中的致命缺陷，还是仅仅为了取乐。有时，他们道破皇帝没穿衣服的真相；有时，他们却又是最先谎喊“狼来了”的人。"
	start_rage = 1
	gifts_provided= list(
		/datum/action/cooldown/power/gift/blur_of_the_milky_eye,
		/datum/action/cooldown/power/gift/infectious_laughter,
		/datum/action/cooldown/power/gift/open_seal,
	)
	moons_born_under = list(MOON_NEW)

/datum/subsplat/werewolf/auspice/garou/ragabash/rank_requirments(list/renown)
	var/total_score = renown[RENOWN_GLORY] + renown[RENOWN_HONOR] + renown[RENOWN_WISDOM]

	if(total_score >= 25)
		return RANK_ELDER
	if(total_score >= 19)
		return RANK_ATHRO
	if(total_score >= 13)
		return RANK_ADREN
	if(total_score >= 7)
		return RANK_FOSTERN
	if(total_score >= 3)
		return RANK_CLIATH
	return RANK_CUB

/datum/subsplat/werewolf/auspice/garou/stolen_moon
	name = AUSPICE_NONE
	// DARKPACK TODO - WEREWOLF - (len lore)
	desc = "你又不是狗，对吧？"
	// Stolen moon get no gifts
