//These are static plaques, they are made of gold and start engraved with a title and description.

/obj/structure/plaque/static_plaque
	engraved = TRUE

/obj/structure/plaque/static_plaque/Initialize(mapload)
	. = ..()
	if(isopenturf(loc) && !isProbablyWallMounted(src))
		SET_PLANE_IMPLICIT(src, FLOOR_PLANE)
		layer = HIGH_TURF_LAYER

/obj/structure/plaque/static_plaque/get_mountable_objects()
	return list()

/obj/structure/plaque/static_plaque/find_and_mount_on_atom(mark_for_late_init, late_init)
	if(isProbablyWallMounted(src))
		return ..()

/obj/structure/plaque/static_plaque/atmos
	name = "\improper FEA大气部门纪念牌"
	desc = "这块铭牌纪念FEA大气部门的覆灭。谨以此纪念所有在其手中丧命、被烧焦、熏晕或冻脆的人。"

/obj/structure/plaque/static_plaque/thunderdome
	name = "\improper 雷霆竞技场纪念牌"
	desc = "这块铭牌纪念在光荣战斗中倒下的人。谨以此纪念所有在此丧命、被烧焦、打晕或揍倒的人。"

/obj/structure/plaque/static_plaque/golden
	name = "最强悍勇士奖"
	desc = "强悍并非一种行为或生活方式，而是一种精神境界。唯有意志足够坚定，能在危急时挺身而出，从敌人手中救下朋友的人，才算真正强悍。朋友们，保持强悍。"
	icon_state = "goldenplaque"

/obj/structure/plaque/static_plaque/golden/captain
	name = "最强悍船长奖"

// Commission plaques, to give a little backstory to the stations. Commission dates are date of merge (or best approximation, in the case of Meta) + 540 years to convert to SS13 dates.
// Where PRs are available, I've linked them. Where they are unavailable, a git hash is provided instead for the direct commit that added/removed the map.
// Please enjoy this trip through SS13's history.

// Runtimestation: added Nov 11, 2016 (946ec1fec869eb59d6a84e32c90613af734fcd0e)
/obj/structure/plaque/static_plaque/golden/commission
	name = "服役纪念牌"
	desc = "旋臂星区空间站SS-13\n‘运行时’级前哨站\n服役日期03/11/2556\n‘献给先驱者’"
	icon_state = "commission_nt"
	layer = BELOW_OPEN_DOOR_LAYER

//Current stations

// Catwalk: added Apr 10, 2025 (#90532)
/obj/structure/plaque/static_plaque/golden/commission/catwalk
	desc = "旋臂星区空间站SS-13\n‘格栅走道’级前哨站\n服役日期10/04/2565\n‘新的高度’"

// Deltastation: added Dec 17, 2016 (#22066)
/obj/structure/plaque/static_plaque/golden/commission/delta
	desc = "旋臂星区空间站SS-13\n‘德尔塔’级前哨站\n服役日期17/12/2556\n‘以冗余实现高效’"

// Icebox Station: added May 13, 2020 (#51090)
/obj/structure/plaque/static_plaque/golden/commission/icebox
	desc = "旋臂星区空间站SS-13\n‘方盒’级前哨站（修订版2.2：‘冰盒’）\n服役日期13/05/2560\n‘冰冷而可靠’"

// Metastation: added Mar 11, 2013 (best estimate, pre-git)
/obj/structure/plaque/static_plaque/golden/commission/meta
	desc = "旋臂星区空间站SS-13\n‘元’级前哨站\n服役日期11/03/2553\n‘忒修斯的空间站’"

// Nebulastation: added Nov 6, 2024 (#84826)
/obj/structure/plaque/static_plaque/golden/commission/nebula
	desc = "旋臂星区空间站SS-13\n‘星云’级前哨站\n服役日期06/11/2564\n‘崭新的未来’"

// Tramstation: added Mar 11, 2021 (#56509)
/obj/structure/plaque/static_plaque/golden/commission/tram
	desc = "旋臂星区空间站SS-13\n‘电车’级前哨站\n服役日期11/03/2561\n‘不断前行’"

// Kilostation: added Nov 13, 2019 (#46968), removed, readded Jul 7, 2026 (#96447)
/obj/structure/plaque/static_plaque/golden/commission/kilo
	desc = "旋臂星区空间站SS-13\n‘基洛’级前哨站\n服役日期13/11/2559\n已退役\n重新服役日期7/7/2566‘永远与众不同’"

//Removed stations

// Asteroidstation: added Oct 17, 2015 (169ab09f7b52254ee505e54cdea681fab287647b), removed Jun 19, 2016 (#18661)- 8 months, 2 days
/obj/structure/plaque/static_plaque/golden/commission/asteroid
	desc = "旋臂星区空间站SS-12\n‘小行星’级前哨站\n服役日期13/10/2555\n退役日期19/06/2556\n‘流星般的成功’"

// Birdboat Station: added Sep 17, 2015 (#11829), removed Feb 09, 2017 (#23754)- 1 year, 4 months, 23 days
/obj/structure/plaque/static_plaque/golden/commission/birdboat
	desc = "旋臂星区空间站SS-03\n‘飞鸟舟’级前哨站\n服役日期17/09/2555\n退役日期09/02/2557\n‘掀起波澜’"

// Boxstation: added Nov 15, 2010 (pre-git), removed Jul 06, 2020 (#52017)- 9 years, 7 months, 21 days
/obj/structure/plaque/static_plaque/golden/commission/box
	desc = "旋臂星区空间站SS-02\n‘方盒’级前哨站\n服役日期15/11/2550\n退役日期06/07/2560\n‘忠实的老伙计’"

// Pubbystation: added Oct 19, 2016 (#20925), removed Dec 10, 2020 (#54588)- 4 years, 1 month, 21 days
/obj/structure/plaque/static_plaque/golden/commission/pubby
	desc = "旋臂星区空间站SS-06\n‘帕比’级前哨站\n服役日期19/10/2556\n退役日期10/12/2560\n‘唯我之法’"

// Cerestation: added Mar 29, 2017 (#24665), removed Aug 26th, 2017 (#30196)- 4 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/cere
	desc = "旋臂星区空间站SS-10\n‘瑟尔’级前哨站\n服役日期29/03/2557\n退役日期26/08/2557\n‘去远足吧’"

// Discstation: added Sep 21, 2015 (#11923), removed Jan 31, 2016 (#15069)- 4 months, 10 days
/obj/structure/plaque/static_plaque/golden/commission/disc
	desc = "旋臂星区空间站SS-05\n‘圆盘’级前哨站\n服役日期21/09/2555\n退役日期31/01/2556\n‘睡个好觉’"

// Donutstation: added Dec 16, 2018 (#41099), removed Apr 28, 2020 (#50730)- 1 year, 4 months, 12 days
/obj/structure/plaque/static_plaque/golden/commission/donut
	desc = "旋臂星区空间站SS-11\n‘甜甜圈’级前哨站\n服役日期16/12/2558\n退役日期28/04/2560\n‘赞美主’"

// Dreamstation: added Oct 06, 2015 (#12154), removed Dec 22, 2016 (#22305)- 1 year, 2 months, 16 days
/obj/structure/plaque/static_plaque/golden/commission/dream
	desc = "旋臂星区空间站SS-04\n‘梦想’级前哨站\n服役日期06/10/2555\n退役日期22/12/2556\n‘志存高远’"

// Efficiencystation: added Jan 28, 2016 (46f64266cfb8b40e35faa8a4d9a2d3aeec689943), removed Dec 20, 2016 (#22306)- 10 months, 22 days
/obj/structure/plaque/static_plaque/golden/commission/efficiency
	desc = "旋臂星区空间站SS-07\n‘高效’级前哨站\n服役日期28/01/2556\n退役日期20/12/2556\n‘巧干胜过苦干’"

// Ministation: added Jan 29, 2014 (7a76e9456b782e6626bf81e27a912d8232c76b18), removed Dec 27, 2016 (#22453)- 2 years, 10 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/mini
	desc = "旋臂星区空间站SS-08\n‘迷你’级前哨站\n服役日期29/01/2554\n退役日期27/12/2556\n‘最小的空间站’"

// North Star: added Apr 13, 2023 (#74371), removed Nov 25, 2024 (#87937)- 1 year, 7 months, 12 days
/obj/structure/plaque/static_plaque/golden/commission/northstar
	desc = "旋臂星区舰船SS-13\n‘北极星’级舰船\n服役日期13/04/2563\n退役日期25/11/2564\n‘新的机遇’"

// Omegastation: added Dec 27, 2016 (#22453), removed Sep 20, 2018 (#40352)- 1 year, 8 months, 24 days
/obj/structure/plaque/static_plaque/golden/commission/omega
	desc = "旋臂星区空间站SS-09\n‘欧米伽’级前哨站\n服役日期27/12/2556\n退役日期20/09/2558\n‘微型站再来一次’"

// Uterusstation: added Sep 03, 2011 (bbd6db9ce2d6341892b89a620593fc8877f5a817), removed Jun 21, 2012 (72d72f7ce522c2d2ad4863f44ee9f5054413c489)- 9 months, 18 days
/obj/structure/plaque/static_plaque/golden/commission/uterus
	desc = "旋臂星区空间站SS-01\n‘子宫’级前哨站\n服役日期03/09/2551\n退役日期21/06/2552\n‘人类的先锋’"

// Birdshot: added Apr 29, 2023 (#74371), removed Jul 9, 2025 (#92022) — 2 years, 2 months, 10 days
/obj/structure/plaque/static_plaque/golden/commission/birdshot
	desc = "旋臂星区空间站SS-13\n‘鸟弹’级前哨站\n服役日期29/04/2563\n退役日期09/07/2565\n‘向群星进发’"

// Wawastation: added Jun 4, 2024 (#82298), removed Jul 7, 2026 (#96447) - 2 years, 1 month, 3 days
/obj/structure/plaque/static_plaque/golden/commission/wawa
	desc = "旋臂星区空间站SS-13\n‘瓦瓦’级前哨站\n服役日期04/06/2564\n退役日期9/07/2565\n‘永远纵向’"

// Other Stations

// Space Station 13, Developer Class Outpost, Station Commissioned 30.12.2322, For the Glory of the Workers of the Third Soviet Union
// The date for this station is exactly 4 centuries after the initial foundation of the (1st) Soviet Union. I have very little interest in tracking down the actual date of addition of Originalstation.
/obj/structure/plaque/static_plaque/golden/commission/ks13
	desc = "13号空间站\n开发者级前哨站\n服役日期30.12.2322\n荣耀归于第三苏联的劳动者"
	icon_state = "commission_commie"

//These are plaques that aren't made of metal, so we'll just consider them signs. Those are made of plastic (default) or wood, not gold.
//See: code>game>objects>structures>signs>_signs.dm

/obj/structure/sign/plaques/kiddie
	name = "\improper 人工智能开发者纪念牌"
	desc = "一长串姓名和职位旁画着一个小孩。这个孩子似乎身有残疾。有人在画像下方刻下了\"数据包\"几个字。"
	icon_state = "kiddieplaque"

/obj/structure/sign/plaques/kiddie/devils_tooth
	name = "\improper 恶魔之牙纪念牌"
	desc = "这块铭牌纪念在周围这颗冰封星球上开凿此段隧道时牺牲的亡魂。这里被称为\"恶魔之牙\"，因为在此献出生命的人必定觉得自己身处地狱。"

/obj/structure/sign/plaques/kiddie/badger
	name = "\improper 追思纪念牌"
	desc = "一块纪念逝者的铭牌，愿他们安息，永远长眠于群星之间。有人在底部画了一只哭泣的獾。"

/obj/structure/sign/plaques/kiddie/library
	name = "\improper 图书馆规则牌"
	desc = "一长串在图书馆内必须遵守的规则，颂扬时刻保持安静的美德，并警告那些胆敢在馆内吃热食的人。"

/obj/structure/sign/plaques/kiddie/perfect_man
	name = "\improper ‘完美之人’展品说明牌"
	desc = "这份展品说明介绍了纳诺传讯公司近期在心智护盾植入物和克隆技术上的进展，如何造就‘完美之人’——忠诚的纳诺传讯员工，并使其近乎永生。"

/obj/structure/sign/plaques/kiddie/perfect_drone
	name = "\improper ‘完美无人机’展品说明牌"
	desc = "这份无人机机壳分配器说明详述了现代维修无人机在建设与破坏方面的用途，以及绝不会腐化的未来机器人仆从的发展历程。明日科技，今日即可拥有。"

/obj/structure/sign/plaques/kiddie/gameoflife
	name = "\improper 康威生命游戏说明牌"
	desc = "这块铭牌详述了生命游戏在计算机科学领域的历史意义，并说明脚下的地面画展示的正是该游戏的运行过程。"
