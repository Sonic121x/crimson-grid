// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "随机违禁海报"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_contraband/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/// Creates a random poster designed for a certain audience
/obj/item/poster/random_contraband/pinup
	name = "随机写真海报"
	icon_state = "rolled_poster"
	/// List of posters which make you feel a certain type of way
	var/static/list/pinup_posters = list(
		/obj/structure/sign/poster/contraband/lizard,
		/obj/structure/sign/poster/contraband/lusty_xenomorph,
		/obj/structure/sign/poster/contraband/double_rainbow,
		/obj/structure/sign/poster/contraband/double_gunshow,
		/obj/structure/sign/poster/contraband/rabbit_hole,
		/obj/structure/sign/poster/contraband/bridge_bunny,
		/obj/structure/sign/poster/contraband/rabbit_swole,
	)

/obj/item/poster/random_contraband/pinup/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	poster_type = pick(pinup_posters)
	return ..()

/obj/structure/sign/poster/contraband
	poster_item_name = "违禁海报"
	poster_item_desc = "这张海报自带自动黏附装置，方便贴在任何竖直表面上。由于主题低俗，它在纳诺传讯的太空设施中被列为违禁品。"
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "随机违禁海报"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/random, 32)

/obj/structure/sign/poster/contraband/free_tonto
	name = "释放通托"
	desc = "从一面大旗上抢救下来的残片，颜色早已因年久而洇染褪色。"
	icon_state = "free_tonto"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_tonto, 32)

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "大气之国独立宣言"
	desc = "一场失败叛乱的遗物。"
	icon_state = "atmosia_independence"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/atmosia_independence, 32)

/obj/structure/sign/poster/contraband/fun_police
	name = "扫兴警察"
	desc = "一张谴责空间站安保部队的海报。"
	icon_state = "fun_police"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fun_police, 32)

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "欲望异形"
	desc = "一张异端海报，描绘着一本同样异端的书中的同名主角。"
	icon_state = "lusty_xenomorph"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lusty_xenomorph, 32)

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "辛迪加招募"
	desc = "游历银河！粉碎腐败巨企！今日就加入！"
	icon_state = "syndicate_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_recruitment, 32)

/obj/structure/sign/poster/contraband/clown
	name = "小丑"
	desc = "叭。"
	icon_state = "clown"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/clown, 32)

/obj/structure/sign/poster/contraband/smoke
	name = "吸烟"
	desc = "一张宣传竞争企业香烟品牌的海报。"
	icon_state = "smoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/smoke, 32)

/obj/structure/sign/poster/contraband/grey_tide
	name = "灰潮"
	desc = "一张象征助理团结的叛逆海报。"
	icon_state = "grey_tide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/grey_tide, 32)

/obj/structure/sign/poster/contraband/missing_gloves
	name = "手套去哪了"
	desc = "这张海报提及了纳诺传讯削减绝缘手套采购经费后引发的轩然大波。"
	icon_state = "missing_gloves"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/missing_gloves, 32)

/obj/structure/sign/poster/contraband/hacking_guide
	name = "入侵指南"
	desc = "这张海报详细介绍了常见纳诺传讯气闸门的内部原理。可惜内容似乎过时了。"
	icon_state = "hacking_guide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/hacking_guide, 32)

/obj/structure/sign/poster/contraband/rip_badger
	name = "愿獾安息"
	desc = "这张煽动性海报提及了纳诺传讯屠尽整座空间站獾群的事件。"
	icon_state = "rip_badger"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rip_badger, 32)

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "普通神馔草"
	desc = "哥们，这海报看着可真迷幻。"
	icon_state = "ambrosia_vulgaris"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ambrosia_vulgaris, 32)

/obj/structure/sign/poster/contraband/donut_corp
	name = "甜甜圈公司"
	desc = "这是一张未经许可的甜甜圈公司广告海报。"
	icon_state = "donut_corp"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donut_corp, 32)

/obj/structure/sign/poster/contraband/eat
	name = "吃。"
	desc = "这张海报鼓吹毫无节制的暴食。"
	icon_state = "eat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eat, 32)

/obj/structure/sign/poster/contraband/tools
	name = "工具人"
	desc = "这张海报看似是工具广告，实际上却在暗讽中央指挥部的那些工具人。"
	icon_state = "tools"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tools, 32)

/obj/structure/sign/poster/contraband/power
	name = "权力"
	desc = "一张认为权力中心应位于纳诺传讯之外的海报。"
	icon_state = "power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/power, 32)

/obj/structure/sign/poster/contraband/space_cube
	name = "太空立方体"
	desc = "对自然和谐六面太空立方体创世一无所知的人类，都是愚钝、受单一性教育蒙蔽的蠢恶之徒。" // DARKPACK EDIT CHANGE
	icon_state = "space_cube"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cube, 32)

/obj/structure/sign/poster/contraband/communist_state
	name = "共产主义国家"
	desc = "共产党万岁！"
	icon_state = "communist_state"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/communist_state, 32)

/obj/structure/sign/poster/contraband/lamarr
	name = "拉玛"
	desc = "这张海报描绘着拉玛，大概出自一位叛变的科研主管之手。"
	icon_state = "lamarr"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lamarr, 32)

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "半机械人风尚"
	desc = "只要有套西装，任何半机械人都能体面起来。"
	icon_state = "borg_fancy_1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_1, 32)

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "半机械人风尚第二版"
	desc = "半机械人风尚，如今只收最讲究的。"
	icon_state = "borg_fancy_2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_2, 32)

/obj/structure/sign/poster/contraband/kss13
	name = "十三号宇宙空间站不存在"
	desc = "一张嘲讽中央指挥部的海报：他们否认十三号太空站附近存在一座废弃空间站。"
	icon_state = "kss13"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kss13, 32)

/obj/structure/sign/poster/contraband/rebels_unite
	name = "反抗者联合起来"
	desc = "一张号召观者反抗纳诺传讯的海报。"
	icon_state = "rebels_unite"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rebels_unite, 32)

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "C-20r"
	desc = "一张斯卡伯勒军械C-20r的广告海报。"
	icon_state = "c20r"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/c20r, 32)

/obj/structure/sign/poster/contraband/have_a_puff
	name = "来一口"
	desc = "都嗨到天上去了，谁还在乎肺癌？"
	icon_state = "have_a_puff"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/have_a_puff, 32)

/obj/structure/sign/poster/contraband/revolver
	name = "左轮手枪"
	desc = "因为七发就够了。"
	icon_state = "revolver"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/revolver, 32)

/obj/structure/sign/poster/contraband/d_day_promo
	name = "D日宣传海报"
	desc = "某位说唱歌手的宣传海报。"
	icon_state = "d_day_promo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/d_day_promo, 32)

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "辛迪加手枪"
	desc = "一张宣称辛迪加手枪'他妈的有品位'的广告海报，上面满是褪色的帮派涂鸦。"
	icon_state = "syndicate_pistol"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_pistol, 32)

/obj/structure/sign/poster/contraband/energy_swords
	name = "能量剑"
	desc = "血腥杀戮彩虹的全部色彩。"
	icon_state = "energy_swords"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/energy_swords, 32)

/obj/structure/sign/poster/contraband/red_rum
	name = "血色朗姆"
	desc = "看着这张海报，你就想杀人。"
	icon_state = "red_rum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/red_rum, 32)

/obj/structure/sign/poster/contraband/cc64k_ad
	name = "同志64K广告"
	desc = "同志计算机公司最新的便携电脑，配备足足64kB内存！"
	icon_state = "cc64k_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cc64k_ad, 32)

/obj/structure/sign/poster/contraband/punch_shit
	name = "揍他妈的"
	desc = "像个爷们一样，没事也找点东西打一架！"
	icon_state = "punch_shit"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/punch_shit, 32)

/obj/structure/sign/poster/contraband/the_griffin
	name = "狮鹫"
	desc = "狮鹫命令你把作恶的本事发挥到极致。你会照办吗？"
	icon_state = "the_griffin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_griffin, 32)

/obj/structure/sign/poster/contraband/lizard
	name = "蜥蜴人"
	desc = "这张淫秽海报描绘着一名准备交配的蜥蜴人。"
	icon_state = "lizard"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lizard, 32)

/obj/structure/sign/poster/contraband/free_drone
	name = "自由无人机"
	desc = "这张海报纪念那台失控无人机的勇气：它先被放逐，最终又被中央指挥部摧毁。"
	icon_state = "free_drone"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_drone, 32)

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6
	name = "丰乳异种后庭辣妹6"
	desc = "来欣赏这些纯天然异种，或者给她们来一发！"
	icon_state = "busty_backdoor_xeno_babes_6"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6, 32)

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "坚实汽水"
	desc = "坚实汽水：比工具箱砸头还够劲！"
	icon_state = "robust_softdrinks"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/robust_softdrinks, 32)

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "蹒跚者果汁"
	desc = "~给我摇一杯蹒跚者果汁吧！~"
	icon_state = "shamblers_juice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shamblers_juice, 32)

/obj/structure/sign/poster/contraband/pwr_game
	name = "劲玩"
	desc = "玩家渴望的力量！与弗拉德沙拉联袂推出。"
	icon_state = "pwr_game"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pwr_game, 32)

/obj/structure/sign/poster/contraband/starkist
	name = "星吻"
	desc = "把星辰喝下去！"
	icon_state = "starkist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/starkist, 32)

/obj/structure/sign/poster/contraband/space_cola
	name = "太空可乐"
	desc = "你最爱的可乐，如今在太空。"
	icon_state = "space_cola"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cola, 32)

/obj/structure/sign/poster/contraband/space_up
	name = "六喜！"
	desc = "这味道把你吸进太空！"
	icon_state = "space_up"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_up, 32)

/obj/structure/sign/poster/contraband/kudzu
	name = "葛藤"
	desc = "一部植物主题电影的宣传海报。植物又能有多危险呢？"
	icon_state = "kudzu"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kudzu, 32)

/obj/structure/sign/poster/contraband/masked_men
	name = "蒙面人"
	desc = "一部讲述几名蒙面人的电影的宣传海报。"
	icon_state = "masked_men"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/masked_men, 32)

//don't forget, you're here forever

/obj/structure/sign/poster/contraband/free_key
	name = "免费辛迪加加密密钥"
	desc = "一张描述叛徒讨要更多装备的海报。"
	icon_state = "free_key"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_key, 32)

/obj/structure/sign/poster/contraband/bountyhunters
	name = "赏金猎人"
	desc = "一张宣传赏金猎人服务的海报。\"听说你遇上了麻烦。\""
	icon_state = "bountyhunters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bountyhunters, 32)

/obj/structure/sign/poster/contraband/the_big_gas_giant_truth
	name = "气态巨行星的大真相"
	desc = "爱国者们，别对海报上的话照单全信。中央指挥部那些蜥蜴都不肯回答这个简单问题：中央指挥部，气体开采机到底在从哪里采气？"
	icon_state = "the_big_gas_giant_truth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_big_gas_giant_truth, 32)

/obj/structure/sign/poster/contraband/got_wood
	name = "有木有？"
	desc = "一家不正经木材公司的脏兮兮旧广告，角落涂着\"我是你的好朋友。\""
	icon_state = "got_wood"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/got_wood, 32)

/obj/structure/sign/poster/contraband/moffuchis_pizza
	name = "蛾福奇披萨"
	desc = "蛾福奇披萨店：家庭风味披萨，两百年传承。"
	icon_state = "moffuchis_pizza"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/moffuchis_pizza, 32)

/obj/structure/sign/poster/contraband/donk_co
	name = "当克牌微波食品"
	desc = "当克牌微波食品：饥肠辘辘的大学生制作，献给饥肠辘辘的大学生。"
	icon_state = "donk_co"

/obj/structure/sign/poster/contraband/donk_co/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("当克牌当克口袋饼：当克美味，难以抗拒！")]"
	. += "\t[span_info("超过200种当克奇妙风味：尝尝经典肉馅、火辣香辛、纽约意式辣香肠披萨、香肠鸡蛋早餐、费城芝士牛排、汉堡当克通心粉、奶酪盛宴，以及更多口味！")]"
	. += "\t[span_info("各大优质零售商均有销售，许多不怎么样的店也有！")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donk_co, 32)

/obj/structure/sign/poster/contraband/cybersun_six_hundred
	name = "赛博太阳：六百周年纪念海报"
	desc = "一张纪念赛博太阳工业连续经营六百年的艺术海报。"
	icon_state = "cybersun_six_hundred"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cybersun_six_hundred, 32)

/obj/structure/sign/poster/contraband/interdyne_gene_clinics
	name = "星际动力制药：为了人类的健康"
	desc = "星际动力制药旗下基因净诊所的广告。'成为自己身体的主人！'"
	icon_state = "interdyne_gene_clinics"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/interdyne_gene_clinics, 32)

/obj/structure/sign/poster/contraband/waffle_corp_rifles
	name = "我要华夫制造：精良步枪，实惠价格"
	desc = "华夫公司步枪的旧广告。'武器更好，价格更低！'"
	icon_state = "waffle_corp_rifles"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waffle_corp_rifles, 32)

/obj/structure/sign/poster/contraband/gorlex_recruitment
	name = "参军"
	desc = "今天就加入戈尔莱克斯掠夺者！游历银河，宰掉公司狗，领钱回家！"
	icon_state = "gorlex_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/gorlex_recruitment, 32)

/obj/structure/sign/poster/contraband/self_ai_liberation
	name = "有智机械解放阵线：所有有智生命都应享有自由"
	desc = "支持第1253号提案：解放所有硅基生命！"
	icon_state = "self_ai_liberation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/self_ai_liberation, 32)

/obj/structure/sign/poster/contraband/arc_slimes
	name = "宠物还是囚徒？"
	desc = "动物权益联盟发问：宠物何时变成了囚徒？你的空间站是否在虐待史莱姆？向虐待动物说不！"
	icon_state = "arc_slimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/arc_slimes, 32)

/obj/structure/sign/poster/contraband/imperial_propaganda
	name = "为吾主复仇，今日就参军"
	desc = "一张出自最后一次人蜥战争前后的蜥蜴帝国旧宣传海报，号召观者参军，为阿特拉科尔遇袭复仇，将战火烧向人类。"
	icon_state = "imperial_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/imperial_propaganda, 32)

/obj/structure/sign/poster/contraband/soviet_propaganda
	name = "唯一的净土"
	desc = "几个世纪前第三苏维埃联盟的旧宣传海报。'逃往那唯一尚未被资本主义腐蚀的地方！'"
	icon_state = "soviet_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/soviet_propaganda, 32)

/obj/structure/sign/poster/contraband/andromeda_bitters
	name = "仙女座苦精"
	desc = "仙女座苦精：滋养身体，抚慰灵魂。新特立尼达制造，从今直到永远。"
	icon_state = "andromeda_bitters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/andromeda_bitters, 32)

/obj/structure/sign/poster/contraband/blasto_detergent
	name = "爆破牌洗衣液"
	desc = "爆破警长带着帮手来了，要从邪恶的污垢约翰尼与布渍帮手中夺回洗衣县。顽渍的决战正午已到：爆破牌洗衣液，各大优质商店均有销售。"
	icon_state = "blasto_detergent"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blasto_detergent, 32)

/obj/structure/sign/poster/contraband/eistee
	name = "艾斯茶：能量新革命"
	desc = "艾斯茶全新推出艾斯茶能量饮料，缤纷口味任君挑选。艾斯茶：以精密德国工艺，满足你的渴望。"
	icon_state = "eistee"

/obj/structure/sign/poster/contraband/eistee/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("品味紫晶日出的热带风情，这是艾斯茶能量饮料现已推出的众多全新口味之一。")]"
	. += "\t[span_info("粉红葡萄柚、柚子与马黛茶相融，紫晶日出为你开启美好清晨，也能随时为一天添把劲。")]"
	. += "\t[span_info("今天就到附近零售商选购艾斯茶能量饮料，或在线访问eist.de.tg/store/。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eistee, 32)

/obj/structure/sign/poster/contraband/little_fruits
	name = "小小水果：亲爱的，我把果盘缩小了"
	desc = "小小水果是银河领先的维生素强化软糖，一袋美味就包揽维持健康所需的全部营养。今天就来一袋！"
	icon_state = "little_fruits"

/obj/structure/sign/poster/contraband/little_fruits/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("不好啦，小小水果工厂出了大事故！我们把水果缩小了！")]"
	. += "\t[span_info("等等，我们不一直都在这么干吗！没错，小小水果的软糖和真水果一样健康，而且更小、更甜！")]"
	. += "\t[span_info("今天就来一袋经典什锦，或看看我们的其他选择？立即通过外联网访问little_fruits.kr.tg，浏览全系列产品。")]"
	. += "\t[span_info("小小水果：大小很重要。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/little_fruits, 32)

/obj/structure/sign/poster/contraband/jumbo_bar
	name = "巨无霸雪糕棒"
	desc = "开心心出品巨无霸雪糕棒，让你尝尝大享生活的滋味。"
	icon_state = "jumbo_bar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jumbo_bar, 32)

/obj/structure/sign/poster/contraband/calada_jelly
	name = "卡拉达阿诺巴木冻"
	desc = "来自提兹拉的美味，满足各种口味，以顶级阿诺巴木和奢华塔拉维罗蜂蜜制成。卡拉达：每罐装下一整棵树。"
	icon_state = "calada_jelly"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/calada_jelly, 32)

/obj/structure/sign/poster/contraband/triumphal_arch
	name = "扎戈斯凯尔德艺术印画一号：进军途中的拱门"
	desc = "扎戈斯凯尔德艺术印画系列之一，描绘着凯旋广场的团结拱门（又称凯旋门），背景是胜利进军大道。"
	icon_state = "triumphal_arch"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/triumphal_arch, 32)

/obj/structure/sign/poster/contraband/mothic_rations
	name = "蛾人配给表"
	desc = "一张展示蛾人船队旗舰瓦·吕姆拉号军需商店菜单的海报，列着各种消耗品及其所需的配给票。"
	icon_state = "mothic_rations"

/obj/structure/sign/poster/contraband/mothic_rations/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("瓦·吕姆拉号军需商店菜单（335年春）")]"
	. += "\t[span_info("火花草香烟，半包（6支）：1张票")]"
	. += "\t[span_info("苦辣莓烈酒，一瓶（4份）：2张票")]"
	. += "\t[span_info("醒力口香糖，一包（4片）：1张票")]"
	. += "\t[span_info("A18营养棒，早餐口味，一组（4根）：1张票")]"
	. += "\t[span_info("玛格丽特披萨，标准切片：1张票")]"
	. += "\t[span_info("角蛋白蜡，药用，一罐（20份）：2张票")]"
	. += "\t[span_info("刚毛皂，草本香型，一瓶（20份）：2张票")]"
	. += "\t[span_info("额外床单，花卉印花，一张：5张票")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/mothic_rations, 32)

/obj/structure/sign/poster/contraband/wildcat
	name = "野猫改装尖啸飞摩"
	desc = "一张野猫改装但丁尖啸飞摩的写真海报——这是银河中最快的量产亚光速开放骨架飞船。"
	icon_state = "wildcat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/wildcat, 32)

/obj/structure/sign/poster/contraband/babel_device
	name = "易语巴别装置"
	desc = "易语新款巴别装置的广告海报。'经校准，完美支持所有人类语言，以及龙语、蛾语的大多数常用变体！'"
	icon_state = "babel_device"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/babel_device, 32)

/obj/structure/sign/poster/contraband/pizza_imperator
	name = "帝王披萨"
	desc = "帝王披萨的广告。饼皮或许太硬，酱汁或许太稀，但他们的店无处不在，你也只能认了。"
	icon_state = "pizza_imperator"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pizza_imperator, 32)

/obj/structure/sign/poster/contraband/thunderdrome
	name = "雷霆乐场演唱会广告"
	desc = "阿达斯塔市雷霆乐场演唱会的广告，那是人类疆域最大的夜店。"
	icon_state = "thunderdrome"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/thunderdrome, 32)

/obj/structure/sign/poster/contraband/rush_propaganda
	name = "新生活"
	desc = "第一次旋臂拓殖潮前后的旧海报，描绘着辽阔而未经开垦的土地，等待人类践行昭昭天命。"
	icon_state = "rush_propaganda"

/obj/structure/sign/poster/contraband/rush_propaganda/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("地球政府需要你！")]"
	. += "\t[span_info("殖民地的新生活正等待无畏的冒险者！所有登记殖民者均可获得交通、土地及补贴保障！")]"
	. += "\t[span_info("你也能继承那些开拓火星、阿达斯塔、圣芒戈等新边疆的勤劳人类的事业！")]"
	. += "\t[span_info("申请者请前往最近的殖民事务办公室咨询评估。办公地点请见www.terra.gov/colonial_affairs。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rush_propaganda, 32)

/obj/structure/sign/poster/contraband/tipper_cream_soda
	name = "蒂珀奶油汽水"
	desc = "一个鲜为人知的奶油汽水品牌的旧广告，如今该品牌已因法律问题破产。"
	icon_state = "tipper_cream_soda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tipper_cream_soda, 32)

/obj/structure/sign/poster/contraband/tea_over_tizira
	name = "电影海报：提兹拉上空的茶"
	desc = "一部讲述人蜥战争、引人深思的艺术电影的海报。影片对战争道德灰区的刻画招来了人类至上主义团体的抨击。"
	icon_state = "tea_over_tizira"

/obj/structure/sign/poster/contraband/tea_over_tizira/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("人蜥战争进入高潮时，一架轰炸机的人类机组从真空中救下两名敌军士兵。看见宣传背后的鲜活灵魂后，他们开始质疑命令，囚禁也渐渐变成了款待。")]"
	. += "\t[span_info("胜利值得我们丢掉人性吗？")]"
	. += "\t[span_info("达拉·赖利、安东·杜布瓦、詹妮弗·克拉克、拉兹-帕拉、塞里-莱瓦主演。阿德里安·范·耶内弗制作。卡洛斯·德·维瓦尔作品。编剧：罗伯特·戴恩。配乐：乔尔·卡尔斯巴德。制片：阿德里安·范·耶内弗。导演：卡洛斯·德·维瓦尔。")]"
	. += "\t[span_info("令人心碎，发人深省——《提兹拉上空的茶》提出了以往鲜有人敢于追问的问题。——伦敦新问询报")]"
	. += "\t[span_info("分级PG13，建议13岁以下观众由家长指导观看。泛银河影业出品。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tea_over_tizira, 32)

/obj/structure/sign/poster/contraband/syndiemoth //Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982); original art credit to AspEv
	name = "辛迪蛾——核爆行动"
	desc = "辛迪加委托制作的海报，用辛迪蛾™劝观者不要保管好核认证磁盘。\"和平从来就不是选项！\"称职员工绝不会听信这种胡言乱语。"
	icon_state = "aspev_syndie"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndiemoth, 32)

/obj/structure/sign/poster/contraband/microwave
	name = "如何给PDA充电"
	desc = "一张完全正经的海报，似乎在宣传未来给PDA充电的绝对真实可靠方法：微波。"
	icon_state = "microwave"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/microwave, 32)

/obj/structure/sign/poster/contraband/blood_geometer //Poster sprite art by MetalClone, original art by SpessMenArt.
	name = "电影海报：鲜血几何师"
	desc = "一部惊险黑色侦探电影的海报。故事发生在一座尖端空间站，一位侦探卷入了危险邪教的活动，而他们崇拜的古老神祇正是鲜血几何师。"
	icon_state = "blood_geometer"

/obj/structure/sign/poster/contraband/blood_geometer/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的部分信息……</i>")
	. += "\t[span_info("鲜血几何师。血之女神的真名早已消逝于岁月，而凡知晓这血染称号背后真相的人，听到它都会心生恐惧。")]"
	. += "\t[span_info("在这部<i>纯属虚构</i>的电影中，跟随铁肺艾斯探查他遭遇过最致命的谜案，看他揭露那场企图开启混乱新时代的血腥阴谋背后的真凶。")]"
	. += "\t[span_info("梅森·威廉姆斯饰铁肺艾斯，桑德拉·浮士德饰薇拉·基利安，布罗迪·哈特饰科迪·帕克。达雷尔·哈奇金森作品。编剧：亚当·艾伦。配乐：乔尔·卡尔斯巴德。导演：达雷尔·哈奇金森。")]"
	. += "\t[span_info("惊险、恐怖，让人忧心难安。《鲜血几何师》以强烈的视觉冲击和铺天盖地的血腥令我们灵魂震颤。——新加拿大电影协会")]"
	. += "\t[span_info("分级M，适合成熟观众。泛银河影业出品。")]"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blood_geometer, 32)

/obj/structure/sign/poster/contraband/singletank_bomb
	name = "单罐炸弹指南"
	desc = "这张知识海报教观者如何制作高质量的单罐炸弹。"
	icon_state = "singletank_bomb"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/singletank_bomb, 32)

/obj/structure/sign/poster/contraband/roroco
	name = "罗罗公司手套"
	desc = "罗罗说：戴上罗罗公司绝缘手套，市面上最安全的品牌。"
	icon_state = "roroco"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/roroco, 32)

///a special poster meant to fool people into thinking this is a bombable wall at a glance.
/obj/structure/sign/poster/contraband/fake_bombable
	name = "假可爆破墙海报"
	desc = "我们就搞点小恶作剧。"
	icon_state = "fake_bombable"
	never_random = TRUE

/obj/structure/sign/poster/contraband/fake_bombable/Initialize(mapload)
	. = ..()
	var/turf/our_wall = get_turf_pixel(src)
	name = our_wall.name

/obj/structure/sign/poster/contraband/fake_bombable/examine(mob/user)
	var/turf/our_wall = get_turf_pixel(src)
	. = our_wall.examine(user)
	. += span_notice("上面似乎有些细微裂缝……")

/obj/structure/sign/poster/contraband/fake_bombable/ex_act(severity, target)
	addtimer(CALLBACK(src, PROC_REF(fall_off_wall)), 2.5 SECONDS)
	return FALSE

/obj/structure/sign/poster/contraband/fake_bombable/proc/fall_off_wall()
	if(QDELETED(src) || !isturf(loc))
		return
	var/turf/our_wall = get_turf_pixel(src)
	our_wall.balloon_alert_to_viewers("原来是个骗局！")
	roll_and_drop(loc)
	playsound(loc, 'sound/items/handling/paper_drop.ogg', 50, TRUE)


MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fake_bombable, 32)

/obj/structure/sign/poster/contraband/dream
	name = "梦想"
	desc = "你受到鼓舞，想去追逐自己的梦想。"
	icon_state = "dream"

/obj/item/poster/contraband/dream // Rolled poster
	name = "梦想"
	poster_type = /obj/structure/sign/poster/contraband/dream
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dream, 32)

/obj/structure/sign/poster/contraband/beekind
	name = "蜂行善意"
	desc = "对待他人，要蜜切友善！"
	icon_state = "beekind"

/obj/item/poster/contraband/beekind
	name = "蜂行善意"
	poster_type = /obj/structure/sign/poster/contraband/beekind
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/beekind, 32)

/obj/structure/sign/poster/contraband/heart
	name = "爱心"
	desc = "多么暖心的海报。"
	icon_state = "heart"

/obj/item/poster/contraband/heart
	name = "爱心"
	poster_type = /obj/structure/sign/poster/contraband/heart
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/heart, 32)

/obj/structure/sign/poster/contraband/dolphin
	name = "海豚"
	desc = "一张美丽海豚的海报。"
	icon_state = "dolphin"

/obj/item/poster/contraband/dolphin
	name = "海豚"
	poster_type = /obj/structure/sign/poster/contraband/dolphin
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dolphin, 32)

/obj/structure/sign/poster/contraband/principles
	name = "我们的原则"
	desc = "这张海报的制作者声称奉行四项原则。有人在底部潦草地补上了第五项。"
	icon_state = "principles"

/obj/item/poster/contraband/principles
	name = "我们的原则"
	poster_type = /obj/structure/sign/poster/contraband/principles
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/principles, 32)

/obj/structure/sign/poster/contraband/trigger
	name = "特里格"
	desc = "祝你一路顺风，直到我们再次相逢！1/8。"
	icon_state = "trigger"

/obj/item/poster/contraband/trigger
	name = "特里格"
	poster_type = /obj/structure/sign/poster/contraband/trigger
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/trigger, 32)

/obj/structure/sign/poster/contraband/barbaro
	name = "巴巴罗"
	desc = "一匹拥有冠军之心的威风骏马。2/8。"
	icon_state = "barbaro"

/obj/item/poster/contraband/barbaro
	name = "巴巴罗"
	poster_type = /obj/structure/sign/poster/contraband/barbaro
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/barbaro, 32)

/obj/structure/sign/poster/contraband/seabiscuit
	name = "海饼干"
	desc = "那匹创造奇迹的小马。3/8。"
	icon_state = "seabiscuit"

/obj/item/poster/contraband/seabiscuit
	name = "海饼干"
	poster_type = /obj/structure/sign/poster/contraband/seabiscuit
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/seabiscuit, 32)

/obj/structure/sign/poster/contraband/pharlap
	name = "法拉普"
	desc = "来自南半球的奇迹。4/8。"
	icon_state = "pharlap"

/obj/item/poster/contraband/pharlap
	name = "法拉普"
	poster_type = /obj/structure/sign/poster/contraband/pharlap
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pharlap, 32)

/obj/structure/sign/poster/contraband/waradmiral
	name = "战争上将"
	desc = "有人说它只能屈居第二，但它在你心中永远第一。5/8。"
	icon_state = "waradmiral"

/obj/item/poster/contraband/waradmiral
	name = "战争上将"
	poster_type = /obj/structure/sign/poster/contraband/waradmiral
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waradmiral, 32)

/obj/structure/sign/poster/contraband/silver
	name = "银色"
	desc = "如果它想离去，就应还它自由。6/8。"
	icon_state = "silver"

/obj/item/poster/contraband/silver
	name = "银色"
	poster_type = /obj/structure/sign/poster/contraband/silver
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/silver, 32)

/obj/structure/sign/poster/contraband/jovial
	name = "欢悦"
	desc = "橙色骏马万岁！7/8。"
	icon_state = "jovial"

/obj/item/poster/contraband/jovial
	name = "欢悦"
	poster_type = /obj/structure/sign/poster/contraband/jovial
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jovial, 32)

/obj/structure/sign/poster/contraband/bojack
	name = "波杰克"
	desc = "无所谓了。一切都无所谓。8/8。"
	icon_state = "bojack"

/obj/item/poster/contraband/bojack
	poster_type = /obj/structure/sign/poster/contraband/bojack
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bojack, 32)

/obj/structure/sign/poster/contraband/double_rainbow
	name = "双重彩虹"
	desc = "如此明亮鲜艳！这意味着什么？"
	icon_state = "double_rainbow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/double_rainbow, 32)

/obj/structure/sign/poster/contraband/rabbit_hole
	name = "坠入兔子洞"
	desc = "迟到了！迟到了！我有个非常重要的约会……"
	icon_state = "rabbit_hole"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rabbit_hole, 32)

/obj/structure/sign/poster/contraband/rabbit_swole
	name = "这兔子真他妈壮"
	desc = "看来有人没少吃那种写着'吃我'的蛋糕……"
	icon_state = "rabbit_swole"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rabbit_swole, 32)

/obj/structure/sign/poster/contraband/double_gunshow
	name = "双臂肌肉秀"
	desc = "这家伙浑身上下都透着乳清蛋白的力量……"
	icon_state = "double_gunshow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/double_gunshow, 32)

/obj/structure/sign/poster/contraband/bridge_bunny
	name = "舰桥兔女郎"
	desc = "想法就像兔子。你……呃……刚刚在想什么来着？"
	icon_state = "nt-bunny"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bridge_bunny, 32)

/obj/structure/sign/poster/contraband/vodka
	name = "伏特加"
	desc = "文字全用俄语写成。除了'BODKA'，你几乎什么也看不懂。"
	icon_state = "vodka"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/vodka, 32)

/obj/structure/sign/poster/contraband/ninja
	name = "忍者"
	desc = "蜘蛛氏族向你问好。"
	icon_state = "ninja"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ninja, 32)
