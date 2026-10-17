/obj/item/poster/random_official
	name = "随机官方海报"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

/obj/structure/sign/poster/official
	poster_item_name = "励志海报"
	poster_item_desc = "纳诺传讯官方发行的海报，旨在培养顺从听话的员工。采用尖端背胶，方便贴在任何竖直表面上。"
	poster_item_icon_state = "rolled_legit"
	printable = TRUE

/obj/structure/sign/poster/official/random
	name = "随机官方海报（ROP）"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/random, 32)
//This is being hardcoded here to ensure we don't print directionals from the library management computer because they act wierd as a poster item
/obj/structure/sign/poster/official/random/directional
	printable = FALSE

/obj/structure/sign/poster/official/here_for_your_safety
	name = "守护你的安全"
	desc = "一张颂扬空间站安保部队的海报。"
	icon_state = "here_for_your_safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/here_for_your_safety, 32)

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "\improper 纳诺传讯标志"
	desc = "一张印着纳诺传讯标志的海报。"
	icon_state = "nanotrasen_logo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanotrasen_logo, 32)

/obj/structure/sign/poster/official/cleanliness
	name = "清洁卫生"
	desc = "一张警示不良卫生习惯危害的海报。"
	icon_state = "cleanliness"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cleanliness, 32)

/obj/structure/sign/poster/official/help_others
	name = "帮助他人"
	desc = "一张鼓励你帮助同事的海报。"
	icon_state = "help_others"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/help_others, 32)

/obj/structure/sign/poster/official/build
	name = "建设"
	desc = "一张颂扬工程团队的海报。"
	icon_state = "build"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/build, 32)

/obj/structure/sign/poster/official/bless_this_spess
	name = "愿这片太空蒙福"
	desc = "一张为此地祈福的海报。"
	icon_state = "bless_this_spess"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/bless_this_spess, 32)

/obj/structure/sign/poster/official/science
	name = "科学"
	desc = "一张描绘原子的海报。"
	icon_state = "science"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/science, 32)

/obj/structure/sign/poster/official/ian
	name = "伊恩"
	desc = "汪汪。汪。"
	icon_state = "ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ian, 32)

/obj/structure/sign/poster/official/obey
	name = "服从"
	desc = "一张要求观者服从权威的海报。"
	icon_state = "obey"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/obey, 32)

/obj/structure/sign/poster/official/walk
	name = "慢行"
	desc = "一张要求观者走路、不要奔跑的海报。"
	icon_state = "walk"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/walk, 32)

/obj/structure/sign/poster/official/state_laws
	name = "宣读法则"
	desc = "一张要求半机械人宣读法则的海报。"
	icon_state = "state_laws"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/state_laws, 32)

/obj/structure/sign/poster/official/love_ian
	name = "关爱伊恩"
	desc = "伊恩就是爱，伊恩就是生命。"
	icon_state = "love_ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/love_ian, 32)

/obj/structure/sign/poster/official/space_cops
	name = "太空警察。"
	desc = "一张宣传电视节目《太空警察》的海报。"
	icon_state = "space_cops"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/space_cops, 32)

/obj/structure/sign/poster/official/ue_no
	name = "上野。"
	desc = "上面全是日文。"
	icon_state = "ue_no"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ue_no, 32)

/obj/structure/sign/poster/official/get_your_legs
	name = "站稳你的LEGS"
	desc = "LEGS：领导力、经验、才智、服从。"
	icon_state = "get_your_legs"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/get_your_legs, 32)

/obj/structure/sign/poster/official/do_not_question
	name = "不要质疑"
	desc = "一张要求观者不要打听不该知道的事情的海报。"
	icon_state = "do_not_question"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/do_not_question, 32)

/obj/structure/sign/poster/official/work_for_a_future
	name = "为未来工作"
	desc = " 一张鼓励你为自己的未来工作的海报。"
	icon_state = "work_for_a_future"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/work_for_a_future, 32)

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "软帽波普艺术"
	desc = "一幅廉价波普艺术作品的海报翻印。"
	icon_state = "soft_cap_pop_art"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/soft_cap_pop_art, 32)

/obj/structure/sign/poster/official/safety_internals
	name = "安全须知：内置供气"
	desc = "一张要求观者在罕见的缺氧或有毒空气环境下佩戴内置供气设备的海报。"
	icon_state = "safety_internals"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_internals, 32)

/obj/structure/sign/poster/official/safety_eye_protection
	name = "安全须知：眼部防护"
	desc = "一张要求观者在接触化学品、烟雾或强光时佩戴眼部防护用品的海报。"
	icon_state = "safety_eye_protection"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_eye_protection, 32)

/obj/structure/sign/poster/official/safety_report
	name = "安全须知：报告"
	desc = "一张要求观者向安保部队报告可疑活动的海报。"
	icon_state = "safety_report"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_report, 32)

/obj/structure/sign/poster/official/report_crimes
	name = "举报犯罪"
	desc = "一张鼓励及时向空间站安保部门举报犯罪或煽动行为的海报。"
	icon_state = "report_crimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/report_crimes, 32)

/obj/structure/sign/poster/official/ion_rifle
	name = "离子步枪"
	desc = "一张展示离子步枪的海报。"
	icon_state = "ion_rifle"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ion_rifle, 32)

/obj/structure/sign/poster/official/foam_force_ad
	name = "泡沫特攻广告"
	desc = "泡沫特攻，要么泡沫出击，要么被泡沫击倒！"
	icon_state = "foam_force_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/foam_force_ad, 32)

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "高希霸罗布图广告"
	desc = "高希霸罗布图，有品位的雪茄。"
	icon_state = "cohiba_robusto_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cohiba_robusto_ad, 32)

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "五十周年复古翻印海报"
	desc = "一张2505年海报的翻印本，纪念纳诺传讯子公司纳诺海报制造成立五十周年。"
	icon_state = "anniversary_vintage_reprint"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/anniversary_vintage_reprint, 32)

/obj/structure/sign/poster/official/fruit_bowl
	name = "果盘"
	desc = " 简单，却令人赞叹。"
	icon_state = "fruit_bowl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/fruit_bowl, 32)

/obj/structure/sign/poster/official/pda_ad
	name = "PDA广告"
	desc = "一张宣传纳诺传讯供应商最新PDA的海报。"
	icon_state = "pda_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/pda_ad, 32)

/obj/structure/sign/poster/official/enlist
	name = "参军" // but I thought deathsquad was never acknowledged
	desc = "今天就加入纳诺传讯死亡小队预备役！"
	icon_state = "enlist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/enlist, 32)

/obj/structure/sign/poster/official/nanomichi_ad
	name = "纳诺道广告"
	desc = " 一张宣传纳诺道录音磁带的海报。"
	icon_state = "nanomichi_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanomichi_ad, 32)

/obj/structure/sign/poster/official/twelve_gauge
	name = "12号口径"
	desc = "一张吹嘘12号霰弹优越性的海报。"
	icon_state = "twelve_gauge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twelve_gauge, 32)

/obj/structure/sign/poster/official/high_class_martini
	name = "高级马天尼"
	desc = "我说了，要摇匀，别搅拌。"
	icon_state = "high_class_martini"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/high_class_martini, 32)

/obj/structure/sign/poster/official/the_owl
	name = "猫头鹰"
	desc = "猫头鹰会竭尽全力保护空间站。你会吗？"
	icon_state = "the_owl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/the_owl, 32)

/obj/structure/sign/poster/official/no_erp
	name = "禁止ERP"
	desc = "这张海报提醒船员：根据旋臂政府对巨型企业的监管规定，公司政策禁止企业资源规划。"
	icon_state = "no_erp"
	/// Tracks poster state for the hidden interaction
	VAR_PRIVATE/corrupted = FALSE

/obj/structure/sign/poster/official/no_erp/tear_poster(mob/user)
	if(prob(99) && !check_holidays(APRIL_FOOLS))
		return ..()

	visible_message(span_notice("[user]干脆利落地撕开[src]……露出了另一张海报？"))
	playsound(src, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
	if(corrupted)
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
		corrupted = FALSE
	else
		name = "支持ERP"
		desc = "这张海报提醒船员：企业资源规划既高效，又对空间站运作至关重要。"
		icon_state = "yes_erp"
		corrupted = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/no_erp, 32)

/obj/structure/sign/poster/official/wtf_is_co2
	name = "二氧化碳"
	desc = "这张知识海报向观者介绍什么是二氧化碳。"
	icon_state = "wtf_is_co2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/wtf_is_co2, 32)

/obj/structure/sign/poster/official/dick_gum
	name = "迪克·冈舒"
	desc = "一张宣传老鼠侦探迪克·冈舒冒险故事的海报，鼓励船员用正义的力量制裁电线破坏者。"
	icon_state = "dick_gum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/dick_gum, 32)

/obj/structure/sign/poster/official/there_is_no_gas_giant
	name = "气态巨行星并不存在"
	desc = "纳诺传讯向所有空间站分发了这样的海报，提醒大家关于气态巨行星的传闻并不属实。"
	// And yet people still believe...
	icon_state = "there_is_no_gas_giant"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/there_is_no_gas_giant, 32)

/obj/structure/sign/poster/official/periodic_table
	name = "元素周期表"
	desc = "一张元素周期表，列出了从氢到鿫及其间的所有元素。"
	icon_state = "periodic_table"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/periodic_table, 32)

/obj/structure/sign/poster/official/plasma_effects
	name = "等离子与身体"
	desc = "这张知识海报介绍长期接触等离子对大脑的影响。"
	icon_state = "plasma_effects"

/obj/structure/sign/poster/official/plasma_effects/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("等离子（学名阿门铥）被地球政府列为一级健康危害物，长期接触会对健康造成重大风险。")]"
	. += "\t[span_info("已知等离子能够穿过血脑屏障，并在脑组织中累积，进而导致脑功能退化。其侵害机制尚未完全查明，因此除正确使用个人防护装备（手套、防护连身服及呼吸器）外，暂无确切的预防建议。")]"
	. += "\t[span_info("少量等离子会引起意识混乱、短期失忆及攻击性增强。持续接触时，这些影响也会持续存在。")]"
	. += "\t[span_info("长期接触者已出现严重症状，包括攻击性进一步增强、长期失忆、阿尔茨海默病症状、精神分裂症、黄斑变性、动脉瘤、中风风险升高及帕金森病症状。")]"
	. += "\t[span_info("建议所有未采取防护措施接触原始等离子的人员定期接受公司医务人员检查。")]"
	. += "\t[span_info("更多信息请查阅地球政府有关阿门铥的外联网网站：www.terra.gov/health_and_safety/amenthium/，或公司内部风险评估文档（文档编号#47582-b《等离子安全数据表》及#64210至#64225《等离子作业个人防护装备规定》，全体员工均可通过纳诺文档查阅）。")]"
	. += "\t[span_info("纳诺传讯：始终关爱你的健康。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/plasma_effects, 32)

/obj/structure/sign/poster/official/terragov
	name = "地球政府：为人类团结一心"
	desc = "一张印有地球政府标志与格言的海报，提醒观者是谁在守护人类。"
	icon_state = "terragov"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/terragov, 32)

/obj/structure/sign/poster/official/corporate_perks_vacation
	name = "纳诺传讯员工福利：度假"
	desc = "这张知识海报介绍纳诺传讯员工福利计划的部分奖品，包括在度假星球田园星享受两周双人假期。"
	icon_state = "corporate_perks_vacation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/corporate_perks_vacation, 32)

/obj/structure/sign/poster/official/jim_nortons
	name = "吉姆·诺顿魁北克咖啡"
	desc = "吉姆·诺顿的广告，这家魁北克咖啡馆已经风靡银河。"
	icon_state = "jim_nortons"

/obj/structure/sign/poster/official/jim_nortons/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("自1965年扎根三河城以来，我们一直努力为你奉上金钱所能买到的最好咖啡。")]"
	. += "\t[span_info("今天就来吉姆的店，享用一杯热咖啡和一个甜甜圈，体验魁北克人的生活。")]"
	. += "\t[span_info("吉姆·诺顿魁北克咖啡：永远欢迎你。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/jim_nortons, 32)

/obj/structure/sign/poster/official/twenty_four_seven
	name = "全天候便利店"
	desc = "全天候便利店的广告，宣传其与纳诺传讯合作推出的新款全天候补给站。"
	icon_state = "twenty_four_seven"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twenty_four_seven, 32)

/obj/structure/sign/poster/official/tactical_game_cards
	name = "纳诺传讯战术游戏卡"
	desc = "纳诺传讯集换式卡牌的广告：多买点卡。"
	icon_state = "tactical_game_cards"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/tactical_game_cards, 32)

/obj/structure/sign/poster/official/midtown_slice
	name = "中城切片披萨"
	desc = "纳诺传讯官方披萨合作伙伴中城切片披萨的广告。中城切片：无论身在何处，都能尝到一片家的味道。"
	icon_state = "midtown_slice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/midtown_slice, 32)

//SafetyMoth Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982)
//SafetyMoth art credit goes to AspEv
/obj/structure/sign/poster/official/moth_hardhat
	name = "安全蛾——安全帽"
	desc = "这张知识海报借安全蛾™提醒观者在危险区域佩戴安全帽。\"就像给脑袋戴上一盏灯！\""
	icon_state = "aspev_hardhat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_hardhat, 32)

/obj/structure/sign/poster/official/moth_piping
	name = "安全蛾——管道"
	desc = "这张知识海报借安全蛾™告诉大气技师应选用的正确管道类型。\"要管道，别用泵！管道布得好，性能才可靠！\""
	icon_state = "aspev_piping"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_piping, 32)

/obj/structure/sign/poster/official/moth_meth
	name = "安全蛾——甲基苯丙胺"
	desc = "这张知识海报借安全蛾™提醒观者在制备甲基苯丙胺前先征得首席医疗官批准。\"紧贴目标温度，绝不能超过！\"……你根本就不该做这种东西。"
	icon_state = "aspev_meth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_meth, 32)

/obj/structure/sign/poster/official/moth_epi
	name = "安全蛾——肾上腺素"
	desc = "这张知识海报借安全蛾™提醒观者使用肾上腺素注射器救助受伤或死亡的船员。\"一个简单小妙招，防止器官腐烂！\""
	icon_state = "aspev_epi"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_epi, 32)

/obj/structure/sign/poster/official/moth_delam
	name = "安全蛾——超物质失稳安全须知"
	desc = "这张知识海报借安全蛾™提醒观者在超物质晶体失稳时躲进柜子，以免产生幻觉。撤离也许才是更好的办法。"
	icon_state = "aspev_delam"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_delam, 32)

//End of AspEv posters

/obj/structure/sign/poster/fluff/lizards_gas_payment
	name = "请付款"
	desc = "一张制作粗糙的海报，请求读者为打算带离空间站的物品付款。"
	icon_state = "gas_payment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_payment, 32)

/obj/structure/sign/poster/fluff/lizards_gas_power
	name = "节约用电"
	desc = "一张制作粗糙的海报，请求读者离开前关闭电源。希望下次开张时还能记得打开。"
	icon_state = "gas_power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_power, 32)

/obj/structure/sign/poster/official/festive
	name = "节日公告海报"
	desc = "一张告知当前节日的海报。今天没有节日，回去工作吧。"
	icon_state = "holiday_none"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/festive, 32)

/obj/structure/sign/poster/official/boombox
	name = "爆音箱"
	desc = "一张过时的海报，列着一些所谓的'致命词'和暗语，声称竞争企业会用它们远程停用旗下特工。"
	icon_state = "boombox"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/boombox, 32)

/obj/structure/sign/poster/official/download
	name = "你总不会下载一把枪吧"
	desc = "一张提醒船员公司机密应留在工作场所的海报。"
	icon_state = "download_gun"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/download, 32)

/obj/structure/sign/poster/official/mining
	name = "未发现的物种"
	desc = "一张展示灰烬行者的海报。我们对他们仍知之甚少，成为开拓者吧！\
	读到这张海报的人都会感觉更好！"
	icon_state = "ashwalkers"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/mining, 32)
