GLOBAL_LIST_INIT(localized_clan_names, list("Baali" = "巴力", "Banu Haqim Warrior" = "哈基姆之裔战士", "Banu Haqim Vizier" = "哈基姆之裔维齐尔", "Brujah" = "布鲁赫", "Caitiff" = "无氏族者", "Cappadocian" = "卡帕多西亚", "City Gangrel" = "都市冈格罗", "Daughters of Cacophony" = "喧嚣之女", "Dominate Malkavian" = "支配派魔卡维", "Gangrel" = "冈格罗", "Gargoyle" = "石像鬼", "Giovanni" = "乔凡尼", "Harbinger of Skulls" = "死骸先驱", "Kiasyd" = "奇亚希德", "Lasombra" = "勒森布拉", "Malkavian" = "魔卡维", "Nagaraja" = "纳迦拉贾", "Nosferatu" = "诺斯费拉图", "Old Clan Tzimisce" = "古派茨密希", "Salubri" = "萨鲁布里", "Warrior Salubri" = "萨鲁布里战士", "Samedi" = "萨麦迪", "Setite" = "瑟泰信徒", "Tlacique" = "特拉西克", "Toreador" = "托瑞多", "Tremere" = "睿魔尔", "True Brujah" = "真布鲁赫", "Tzimisce" = "茨密希", "Ventrue" = "梵卓", "Ventrue antitribu" = "梵卓逆族", "Warrior Setite" = "瑟泰战士"))
GLOBAL_LIST_INIT(vampire_clan_list, init_subsplat_list(/datum/subsplat/vampire_clan))

/// Associative list of Clan typepaths to singletons
GLOBAL_LIST_INIT_TYPED(vampire_clans, /datum/subsplat/vampire_clan, init_subtypes_w_path_keys(/datum/subsplat/vampire_clan, list()))

/// All frenzied players
GLOBAL_LIST_EMPTY(frenzy_list)


GLOBAL_ALIST_INIT(beast_marks_to_names, beast_marks_to_names())
GLOBAL_ALIST_INIT(beast_marks_to_names_reverse, beast_marks_to_names(TRUE))
GLOBAL_ALIST_INIT(beast_mark_names_by_clan, beast_mark_names_by_clan())
