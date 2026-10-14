/obj/item/clothing/under/vampire
	abstract_type = /obj/item/clothing/under/vampire
	desc = "一些衣服。"
	name = "衣服"
	has_sensor = NO_SENSORS
	random_sensor = FALSE
	can_adjust = FALSE
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	female_sprite_flags = NO_FEMALE_UNIFORM

/obj/item/clothing/under/vampire/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "undersuit", FALSE)

/obj/item/clothing/under/vampire/brujah
	name = "朋克服装"
	desc = "一件粗犷的短袖衬衫，搭配脏兮兮的裤子。"
	icon_state = "brujah_m"

/obj/item/clothing/under/vampire/brujah/female
	desc = "运动内衣搭配黑色运动裤。真有格调。"
	icon_state = "brujah_f"

/obj/item/clothing/under/vampire/gangrel
	name = "粗犷服装"
	desc = "流浪汉的衣服。"
	icon_state = "gangrel_m"

/obj/item/clothing/under/vampire/gangrel/female
	icon_state = "gangrel_f"

/obj/item/clothing/under/vampire/malkavian
	name = "脏裤子"
	desc = "猛男穿的裤子。"
	icon_state = "malkavian_m"

/obj/item/clothing/under/vampire/malkavian/female
	name = "女学生服装"
	icon_state = "malkavian_f"

/obj/item/clothing/under/vampire/nosferatu
	name = "束缚服"
	desc = "把那个穿束缚服的家伙带出来。"
	icon_state = "nosferatu_m"

/obj/item/clothing/under/vampire/nosferatu/female
	name = "女式束缚服"
	icon_state = "nosferatu_f"

/obj/item/clothing/under/vampire/toreador
	name = "艳丽服装"
	desc = "性感的衣服。"
	icon_state = "toreador_m"

/obj/item/clothing/under/vampire/toreador/female
	name = "舞者便装"
	desc = "我看起来像你的女朋友吗？"
	icon_state = "toreador_f"

/obj/item/clothing/under/vampire/tremere
	name = "酒红色西装"
	desc = "整洁得有些古怪的衣服。"
	icon_state = "tremere_m"

/obj/item/clothing/under/vampire/tremere/female
	name = "酒红色西装裙"
	icon_state = "tremere_f"

/obj/item/clothing/under/vampire/ventrue
	name = "棕色奢华衬衫"
	desc = "富贵人家的衣服。"
	icon_state = "ventrue_m"

/obj/item/clothing/under/vampire/ventrue/female
	name = "棕色奢华西装裙"
	icon_state = "ventrue_f"

/obj/item/clothing/under/vampire/baali
	name = "叛逆服装"
	desc = "黑色T恤上印着红色五芒星。要是连这都保不住你的处子之身，那就没有什么能保住了。"
	icon_state = "baali_m"

/obj/item/clothing/under/vampire/baali/female
	icon_state = "baali_f"

/obj/item/clothing/under/vampire/salubri
	name = "灰色服装"
	desc = "配色十分中性，几乎没有鲜艳颜色的衣服。"
	icon_state = "salubri_m"

/obj/item/clothing/under/vampire/salubri/female
	icon_state = "salubri_f"

/obj/item/clothing/under/vampire/punk
	name = "朋克摇滚服装"
	desc = "一件汗渍斑斑的白色衬衫，胸前印着巨大的黑色骷髅，彰显着某种态度。也许是‘我不用除臭剂’，但好歹也是态度。"
	icon_state = "dirty"

/obj/item/clothing/under/vampire/sceneleopard
	name = "清凉服装"
	desc = "你从未想过自己会需要细肩带。"
	icon_state = "scenetop_leopard"

/obj/item/clothing/under/vampire/scenemoody
	name = "忧郁风格服装"
	desc = "一件经典的‘我的化学浪漫’乐队上衣。"
	icon_state = "scenetop_moody"

/obj/item/clothing/under/vampire/scenezim
	name = "入侵者吉姆服装"
	desc = "一件来自你最爱的节目《入侵者吉姆》的上衣。"
	icon_state = "scenetop_zim"

/obj/item/clothing/under/vampire/scenepink
	name = "时髦服装"
	desc = "穿上它，你几乎觉得自己成了刻薄的校园女王。"
	icon_state = "scenetop_pink"

/obj/item/clothing/under/vampire/turtleneck_white
	name = "白色高领衫"
	desc = "对我来说，一直都是这样。"
	icon_state = "turtleneck_white"

/obj/item/clothing/under/vampire/turtleneck_black
	name = "黑色高领衫"
	desc = "懂行的人称它为战术高领衫，秘密特工的首选服装。"
	icon_state = "turtleneck_black"

/obj/item/clothing/under/vampire/turtleneck_red
	name = "红色高领衫"
	desc = "一件红色高领衫。"
	icon_state = "turtleneck_red"

/obj/item/clothing/under/vampire/turtleneck_navy
	name = "海军蓝高领衫"
	desc = "一件海军蓝高领衫。"
	icon_state = "turtleneck_navy"

/obj/item/clothing/under/vampire/napoleon
	name = "法国皇帝服装"
	desc = "古老得有些奇怪的衣服。"
	icon_state = "napoleon"

/obj/item/clothing/under/vampire/military_fatigues
	name = "军用作训服"
	desc = "军用服装。"
	icon_state = "milfatigues"

//FOR NPC

//GANGSTERS AND BANDITS

/obj/item/clothing/under/vampire/larry
	name = "黄色背心"
	desc = "我知道自己胖，可我他妈就是不在乎！"
	icon_state = "larry"

/obj/item/clothing/under/vampire/bandit
	name = "白色背心"
	desc = "一件磨损得出奇严重的背心。"
	icon_state = "bandit"

/obj/item/clothing/under/vampire/biker
	name = "摩托骑手服装"
	desc = "脏兮兮的衣服。"
	icon_state = "biker"

//USUAL

/obj/item/clothing/under/vampire/mechanic
	name = "蓝色工装背带裤"
	desc = "一套蓝色工装背带裤，简直就差一张柯克舰长面具了。"
	icon_state = "mechanic"

/obj/item/clothing/under/vampire/sport
	name = "红色运动服"
	desc = "切基布里基！"
	icon_state = "sport"

/obj/item/clothing/under/vampire/office
	name = "白色衬衫"
	desc = "滚开，穿干净衬衫的！"
	icon_state = "office"

/obj/item/clothing/under/vampire/sexy
	name = "紫色服装"
	desc = "普通的衣服。"
	icon_state = "sexy"

/obj/item/clothing/under/vampire/slickback
	name = "潇洒西装"
	desc = "看起来很潇洒的衣服。"
	icon_state = "slickback"

/obj/item/clothing/under/vampire/burlesque
	name = "艳舞演出服"
	desc = "艳舞表演用的服装。"
	icon_state = "burlesque"

/obj/item/clothing/under/vampire/burlesque/daisyd
	name = "超短牛仔裤"
	desc = "短得不能再短的短裤。"
	icon_state = "daisyd"

/obj/item/clothing/under/vampire/emo
	name = "素色服装"
	desc = "普通的衣服。"
	icon_state = "emo"

//WOMEN

/obj/item/clothing/under/vampire/black
	name = "黑色露脐上衣"
	desc = "普通的衣服。"
	icon_state = "black"

/obj/item/clothing/under/vampire/red
	name = "红色露脐上衣"
	desc = "普通的衣服。"
	icon_state = "red"

/obj/item/clothing/under/vampire/gothic
	name = "哥特风格服装"
	desc = "破洞牛仔裤配黑色卫衣。据说这就叫哥特。"
	icon_state = "gothic"

//PATRICK BATEMAN (High Society)

/obj/item/clothing/under/vampire/rich
	desc = "富贵人家的衣服。"
	name = "华贵西装"
	icon_state = "rich"

/obj/item/clothing/under/vampire/business
	name = "黑色连衣裙"
	desc = "第一课，学会拼写‘生意’这个词。"
	icon_state = "business"

//Homeless

/obj/item/clothing/under/vampire/homeless
	name = "脏衣服"
	desc = "流浪汉的衣服。"
	icon_state = "homeless_m"

/obj/item/clothing/under/vampire/homeless/female
	icon_state = "homeless_f"

//Police and Guards

/obj/item/clothing/under/vampire/police
	name = "警服"
	/*
	 * I did like a fair bit of research tracking down the statistic, 44% was the original value here but I cant find anything supporting that,
	 * The commonly thrown around number of 40% is from
	 * Johnson, L.B. (1991). On the front lines: Police stress and family well-being. Hearing before the Select Committee on Children, Youth, and Families House of Representatives: 102 Congress First Session May 20 (p. 32-48). Washington DC: US Government Printing Office.
	 * Most other stuides get lower numbers e.g
	 * Neidig, P.H., Russell, H.E. & Seng, A.F. (1992). Interspousal aggression in law enforcement families: A preliminary investigation. Police Studies, Vol. 15 (1), p. 30-38.
	 * Anyway im done doing research for this joke. - Fallcon
	 */
	desc = "蓝衣警员的制服。你知道有40%的警察听说过" + EVIL_COMPANY_DISPLAY_NAME + "吗？用谷歌搜索‘40% of Cops’了解更多。"
	icon_state = "police"
	custom_price = 20

/obj/item/clothing/under/vampire/police/long
	name = "警服"
	icon_state = "policelong"

/obj/item/clothing/under/vampire/police/turtleneck
	name = "警用高领衫"
	icon_state = "policeturtleneck"

/obj/item/clothing/under/vampire/police/pants
	name = "警用作训裤"
	icon_state = "policepants"

/obj/item/clothing/under/vampire/police/utility
	name = "警用作训服"
	icon_state = "policeutil"

/obj/item/clothing/under/vampire/police/fbi
	name = "\improper 联邦调查局高领衫"
	desc = "调查局精英的制服，搭配耐穿又有弹性的裤子，方便踹门。"
	icon_state = "fbiturtleneck"

/obj/item/clothing/under/vampire/police/fbi/utility
	name = "\improper 联邦调查局作训服"
	icon_state = "fbiutil"

/obj/item/clothing/under/vampire/police/fbi/pants
	name = "\improper 联邦调查局作训裤"
	icon_state = "fbipants"

/obj/item/clothing/under/vampire/guard
	name = "保安制服"
	desc = "别让生活这块陈腐松软的蛋糕，挡住你品尝成功那美味奶油夹心的路。"
	icon_state = "guard"

//JOBS

/obj/item/clothing/under/vampire/janitor
	name = "清洁工制服"
	desc = "你的工作？厕所和锅炉，锅炉和厕所，还有那个沸腾的马桶。"
	icon_state = "janitor"

/obj/item/clothing/under/vampire/nurse
	name = "护士洗手服"
	desc = "无菌服装。"
	icon_state = "nurse"

/obj/item/clothing/under/vampire/nurse/nurseb
	name = "黑色护士洗手服"
	desc = "无菌服装。"
	icon_state = "nurseb"

/obj/item/clothing/under/vampire/nurse/nurseg
	name = "绿色护士洗手服"
	desc = "无菌服装。"
	icon_state = "nurseg"

/obj/item/clothing/under/vampire/nurse/nursep
	name = "粉色护士洗手服"
	desc = "无菌服装。"
	icon_state = "nursep"

/obj/item/clothing/under/vampire/nurse/nursec
	name = "青色护士洗手服"
	desc = "无菌服装。"
	icon_state = "nursec"

/obj/item/clothing/under/vampire/graveyard
	desc = "脱掉它，后果严重得能让你进坟墓！"
	icon_state = "graveyard"

/obj/item/clothing/under/vampire/suit
	name = "西装"
	desc = "商务服装。"
	icon_state = "suit"

/obj/item/clothing/under/vampire/suit/female
	name = "西装裙"
	icon_state = "suit_f"

/obj/item/clothing/under/vampire/sheriff
	name = "红色西装"
	desc = "商务服装。"
	icon_state = "sheriff"

/obj/item/clothing/under/vampire/sheriff/female
	name = "红色西装裙"
	icon_state = "sheriff_f"

/obj/item/clothing/under/vampire/clerk
	name = "蓝色西装"
	desc = "商务服装。"
	icon_state = "clerk"

/obj/item/clothing/under/vampire/clerk/female
	name = "蓝色西装裙"
	icon_state = "clerk_f"

/obj/item/clothing/under/vampire/prince
	name = "奢华黑色西装"
	desc = "获得权力还不够，还必须守住权力。"
	icon_state = "prince"

/obj/item/clothing/under/vampire/prince/female
	name = "奢华黑色西装裙"
	icon_state = "prince_f"

/obj/item/clothing/under/vampire/hound
	name = "邋遢的黑色西装"
	desc = "抱歉，这下面只有联邦调查局最不受待见的人。"
	icon_state = "agent"

/obj/item/clothing/under/vampire/archivist
	name = "棕红色西装"
	desc = "真希望金字塔不会因为一连串愚蠢又写得稀烂的事件而炸掉！"
	icon_state = "archivist"

/obj/item/clothing/under/vampire/archivist/female
	name = "棕红色西装裙"
	icon_state = "archivist_f"

/obj/item/clothing/under/vampire/bar
	name = "红色衬衫"
	desc = "女仆的衣服。"
	icon_state = "bar"

/obj/item/clothing/under/vampire/bar/female
	name = "红色裙子"
	icon_state = "bar_f"

/obj/item/clothing/under/vampire/bouncer
	name = "宽松衬衫"
	desc = "今晚不好过吧？"
	icon_state = "bouncer"

/obj/item/clothing/under/vampire/supply
	name = "货运连体服"
	desc = "该隐还活着？不不不，货运国万岁。"
	icon_state = "supply"

//PRIMOGEN

/obj/item/clothing/under/vampire/primogen_malkavian
	name = "雪白长裤"
	desc = "真正的疯子才会穿的行头。谁会穿白裤子？尤其是在这种烂地方。"
	icon_state = "malkav_pants"

/obj/item/clothing/under/vampire/voivode
	name = "蓝色防风衣"
	desc = "华丽的衣服。"
	icon_state = "voivode"

/obj/item/clothing/under/vampire/bogatyr
	name = "蓝色衬衫"
	desc = "漂亮的衣服。"
	icon_state = "bogatyr"

/obj/item/clothing/under/vampire/bogatyr/female
	name = "蓝色裙子"
	desc = "漂亮的衣服。"
	icon_state = "bogatyr"

/obj/item/clothing/under/vampire/primogen_malkavian/female
	name = "紧身连体衣"
	desc = "灵感大致来自2004年那部‘热门’电影。"
	icon_state = "malkav_suit"

/obj/item/clothing/under/vampire/primogen_toreador
	name = "白色西装"
	desc = "跟坏家伙说晚安吧！"
	icon_state = "toreador_male"

/obj/item/clothing/under/vampire/primogen_toreador/female
	name = "猩红连衣裙"
	desc = "富家女士的性感衣装。"
	icon_state = "toreador_female"

/obj/item/clothing/under/vampire/fancy_gray
	name = "奢华红色西装"
	desc = "做正经生意穿的西装。"
	icon_state = "fancy_gray"

/obj/item/clothing/under/vampire/fancy_red
	name = "奢华灰色西装"
	desc = "做正经生意穿的西装。"
	icon_state = "fancy_red"

/obj/item/clothing/under/vampire/leatherpants
	name = "皮裤"
	desc = "做真正、绝对正经的生意时穿的衣服。"
	icon_state = "leather_pants"


/obj/item/clothing/under/vampire/bacotell
	name = "巴可特尔制服"
	desc = "巴可特尔的服装。"
	icon_state = "bacotell"

/obj/item/clothing/under/vampire/bubway
	name = "巴布威制服"
	desc = "巴布威的服装。"
	icon_state = "bubway"

/obj/item/clothing/under/vampire/gummaguts
	name = "咕玛肚制服"
	desc = "咕玛肚的服装。"
	icon_state = "gummaguts"


//PENTEX
/obj/item/clothing/under/vampire/pentex_janitor
	name = "阿杜斯企业保洁连体服"
	desc = "阿杜斯企业保洁员的制服。"
	icon_state = "pentex_janitor"
	brand = "ardus"

/obj/item/clothing/under/vampire/pentex_shortsleeve
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "翻领短袖衫"
	desc = MAIN_EVIL_COMPANY_DISPLAY_NAME + "员工制服。这是一件漂亮的翻领短袖衫！"
	icon_state = "pentex_shortsleeve"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_longleeve
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "衬衫"
	desc = MAIN_EVIL_COMPANY_DISPLAY_NAME + "员工制服。这件有长袖！"
	icon_state = "pentex_longsleeve"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_turtleneck
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "高领衫"
	desc = MAIN_EVIL_COMPANY_DISPLAY_NAME + "员工制服。这是一件漂亮的高领衫！"
	icon_state = "pentex_turtleneck"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_suit
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "西装"
	desc = "漂亮的西装搭配绿色正装衬衫，上面缝有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标签！"
	icon_state = "pentex_suit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_suitskirt
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "西装裙"
	desc = "漂亮的西装裙搭配绿色正装衬衫，上面缝有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标签！"
	icon_state = "pentex_suitskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executive_suit
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "高管西装"
	desc = "白色名牌西装搭配绿色正装衬衫，上面缝有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标签！"
	icon_state = "pentex_executivesuit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executiveskirt
	name = "\improper " + MAIN_EVIL_COMPANY_DISPLAY_NAME + "高管西装裙"
	desc = "白色名牌西装裙搭配绿色正装衬衫，上面缝有" + MAIN_EVIL_COMPANY_DISPLAY_NAME + "的标签！"
	icon_state = "pentex_executiveskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executive_suit
	name = "安德隆高管西装"
	desc = "白色名牌西装搭配绿色正装衬衫，上面缝有安德隆国际的标签！"
	icon_state = "pentex_executivesuit"
	brand = "endron"

/obj/item/clothing/under/vampire/pentex_executiveskirt
	name = "安德隆高管西装裙"
	desc = "白色名牌西装裙搭配绿色正装衬衫，上面缝有安德隆国际的标签！"
	icon_state = "pentex_executiveskirt"
	brand = "endron"

/obj/item/clothing/under/vampire/gown_black
	name = "黑色礼服"
	desc = "一件昂贵的黑色礼服。"
	icon_state = "gown_black"

/obj/item/clothing/under/vampire/gown_white
	name = "白色礼服"
	desc = "一件昂贵的白色礼服。"
	icon_state = "gown_white"
