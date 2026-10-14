// Talents
/datum/st_stat/ability/alertness
	subcategory = "天赋"
	name = "警觉"
	description = "影响角色的直觉。"

/datum/st_stat/ability/athletics
	subcategory = "天赋"
	name = "运动"
	description = "影响角色的体能与持久力，以及攀墙和跳跃的能力。"

/datum/st_stat/ability/awareness
	subcategory = "天赋"
	name = "灵觉"
	description = "影响角色察觉细微之处的能力。用于灵视术。"

/datum/st_stat/ability/brawl
	subcategory = "天赋"
	name = "斗殴"
	description = "影响角色的徒手格斗能力和徒手伤害下限。"

/datum/st_stat/ability/empathy
	subcategory = "天赋"
	name = "共情"
	description = "影响角色理解他人情绪与心理状态的能力。"

/datum/st_stat/ability/expression
	subcategory = "天赋"
	name = "表达"
	description = "影响角色传达情绪和表达自我的能力。"

/datum/st_stat/ability/intimidation
	subcategory = "天赋"
	name = "威吓"
	description = "影响角色借助胁迫和暴力说服他人的能力。用于支配术、威仪术及其他心智与社交类律能。"

/datum/st_stat/ability/leadership
	subcategory = "天赋"
	name = "领导"
	description = "影响角色领导、指挥、承担责任和制定策略的天赋，提高随从数量上限。"

/datum/st_stat/ability/streetwise
	subcategory = "天赋"
	name = "街头智慧"
	description = "影响角色对犯罪地下世界的熟悉程度，以及在低收入群体中的人脉。"

/datum/st_stat/ability/subterfuge
	subcategory = "天赋"
	name = "诡诈"
	description = "影响角色以隐秘和欺骗手段实施破坏与打击的能力。用于支配术、威仪术和朦胧术。"

// Skills
/datum/st_stat/ability/animal_ken
	subcategory = "技能"
	name = "驯兽"
	description = "影响角色与动物及其他生物相处的能力。"

/datum/st_stat/ability/crafts
	subcategory = "技能"
	name = "工艺"
	description = "影响角色制作某些物品的能力。"

/datum/st_stat/ability/drive
	subcategory = "技能"
	name = "驾驶"
	description = "决定角色的驾驶水平。为 0 点时，完全无法驾驶。"

/datum/st_stat/ability/etiquette
	subcategory = "技能"
	name = "礼仪"
	description = "影响角色以得体举止赢得他人好感的能力。"

/datum/st_stat/ability/firearms
	subcategory = "技能"
	name = "枪械"
	description = "影响角色使用枪械的技巧，降低某些武器的后坐力。每点增加 10% 的概率，使每发子弹造成额外 40% 的伤害；该触发概率最高为 50%。"

/datum/st_stat/ability/larceny
	subcategory = "技能"
	name = "盗窃"
	description = "影响角色偷窃与撬锁的能力。为 0 点时，完全无法使用开锁工具。"

/datum/st_stat/ability/melee
	subcategory = "技能"
	name = "近战"
	description = "影响角色使用各类近战武器造成的伤害。"

/datum/st_stat/ability/performance
	subcategory = "技能"
	name = "表演"
	description = "影响角色展现表演才华的能力。用于威仪术和朦胧术。"

/datum/st_stat/ability/stealth
	subcategory = "技能"
	name = "潜行"
	description = "影响角色潜行和避免被发现的能力。用于朦胧术。"

/datum/st_stat/ability/survival
	subcategory = "技能"
	name = "生存"
	description = "影响角色独立求生的能力，无论是在荒野，还是冰冷无情的城市街头。"

// Knowledges
/datum/st_stat/ability/academics
	subcategory = "学识"
	name = "学术"
	description = "影响角色对学术与文学的熟悉程度，以及掌握的语言数量。为 0 点时，角色只懂一种语言。"

/datum/st_stat/ability/academics/update_mob(mob/living/our_mob, initial)
	our_mob.remove_all_partial_languages(LANGUAGE_ACADEMICS)
	
	var/current_score = get_score()
	// level 1 - english, spanish, french, german
	if(current_score >= 1)
		our_mob.grant_partial_language(/datum/language/common, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/spanish, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/french, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/german, 25, LANGUAGE_ACADEMICS)

	// level 2 - italian, polish, adds addtl 25 to common spanish french german (-> 50)
	if(current_score >= 2)
		our_mob.grant_partial_language(/datum/language/italian, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/polish, 25, LANGUAGE_ACADEMICS)

		our_mob.grant_partial_language(/datum/language/common, 50, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/spanish, 50, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/french, 50, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/german, 50, LANGUAGE_ACADEMICS)

	// level 3 - czech, tagalog, ukrainian, welsh, armenian, adds addtl 10 to common spanish french german (-> 60)
	if(current_score >= 3)
		our_mob.grant_partial_language(/datum/language/czech, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/tagalog, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/ukrainian, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/welsh, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/armenian, 25, LANGUAGE_ACADEMICS)

		our_mob.grant_partial_language(/datum/language/common, 60, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/spanish, 60, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/french, 60, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/german, 60, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/italian, 40, LANGUAGE_ACADEMICS)

	// level 4 - hebrew, russian, greek
	if(current_score >= 4)
		our_mob.grant_partial_language(/datum/language/hebrew, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/russian, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/greek, 25, LANGUAGE_ACADEMICS)

	// level 5 - japanese, mandarin, latin, farsi, arabic, cantonese, scottish, irish, korean
	if(current_score >= 5)
		our_mob.grant_partial_language(/datum/language/japanese, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/mandarin, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/latin, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/farsi, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/arabic, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/cantonese, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/scottish, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/irish, 25, LANGUAGE_ACADEMICS)
		our_mob.grant_partial_language(/datum/language/korean, 25, LANGUAGE_ACADEMICS)
		
/datum/st_stat/ability/academics/unlink_mob(mob/living/our_mob)
	if(QDELING(our_mob))
		return
	our_mob.remove_all_partial_languages(LANGUAGE_ACADEMICS)


/datum/st_stat/ability/computer
	subcategory = "学识"
	name = "计算机"
	/* V20 p. 108
	This Knowledge represents the ability to operate and program computers, including mobile devices.
	Most Computer use also imparts a degree of Internet awareness (if not savvy).
	*/
	description = "影响使用和操作计算机化设备的能力。"

// This kinda sucks dick to do for every stat.
/datum/st_stat/ability/computer/New()
	. = ..()
	if(CONFIG_GET(flag/punishing_zero_dots))
		description += " 为 0 点时，你将无法使用计算机。"

/datum/st_stat/ability/finance
	subcategory = "学识"
	name = "金融"
	description = "影响角色的财富与商业头脑，决定银行账户的初始余额以及出售物品的收入。"

/datum/st_stat/ability/investigation
	subcategory = "学识"
	name = "调查"
	description = "影响角色整合观察所得、推导结论的能力。"

/datum/st_stat/ability/law
	subcategory = "学识"
	name = "法律"
	description = "影响角色对法律、政策及其适用情境的熟悉程度。"

/datum/st_stat/ability/medicine
	subcategory = "学识"
	name = "医学"
	description = "影响角色对解剖学、医学及紧急急救流程的了解。用于塑形术。"

/datum/st_stat/ability/medicine/link_mob(mob/living/our_mob)
	RegisterSignal(our_mob, COMSIG_LIVING_OPERATING_ON, PROC_REF(check_medicine_wound_tending))

/datum/st_stat/ability/medicine/unlink_mob(mob/living/our_mob)
	UnregisterSignal(our_mob, COMSIG_LIVING_OPERATING_ON)

/datum/st_stat/ability/occult
	subcategory = "学识"
	name = "神秘学"
	description = "影响角色对秘传学问与神秘概念的了解。用于法术类律能，并影响法术仪式。神秘学达到 3 点或以上时，可鉴定魔法奇物。"

/datum/st_stat/ability/politics
	subcategory = "学识"
	name = "政治"
	description = "影响角色运用政治手腕的能力。"

/datum/st_stat/ability/science
	subcategory = "学识"
	name = "科学"
	description = "影响角色的科学素养与化学品合成能力。"

/datum/st_stat/ability/technology
	subcategory = "学识"
	name = "技术"
	/* V20 p. 110
	The Technology Knowledge represents a broad acumen with electronics, computer hardware, and devices more elaborate than “machines,” which fall under the Crafts Skill.
	If it has a processor, a transistor, or an integrated circuit — if it’s electronic rather than electrical manipulating it uses the Technology Knowledge.
	This is the wide-ranging Ability used to build one’s own computer, install (or subvert) a security system, repair a mobile phone, or kitbash a shortwave radio.
	You must always choose a specialization in Technology, even though you possess some skill in multiple fields.
	*/
	description = "影响角色对机械、设备和电气系统的熟悉程度。"
