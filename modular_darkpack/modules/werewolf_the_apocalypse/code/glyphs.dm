GLOBAL_LIST_INIT(localized_glyph_names, list("basic glyph" = "基础符文", "wyrm glyph" = "妖蛆符文", "vampire glyph" = "吸血鬼符文", "kinfolk glyph" = "眷属符文", "dancing glyph" = "舞蹈符文", "caern glyph" = "圣地符文", "danger glyph" = "危险符文", "garou glyph" = "狼人符文", "conceal glyph" = "隐匿符文", "hive glyph" = "巢穴符文", "howling glyph" = "长嚎符文", "remembrance glyph" = "追思符文", "watch glyph" = "监视符文", "toxic glyph" = "毒害符文", "\improper Black Spiral Dancer glyph" = "黑螺旋舞者符文", "\improper Glasswalkers glyph" = "玻璃行者符文", "\improper Younger Brother glyph" = "幼弟符文", "war against wyrm glyph" = "对抗妖蛆之战符文", "black furies glyph" = "黑怒之女符文", "bonegnawer glyph" = "啃骨者符文", "children of gaia glyph" = "盖亚之子符文", "fianna glyph" = "芬尼安符文", "get of fenris glyph" = "芬里斯之裔符文", "red talon glyph" = "赤爪符文", "shadow lord glyph" = "暗影领主符文", "silent striders glyph" = "寂静行者符文", "silver fang glyph" = "银牙符文", "stargazers glyph" = "观星者符文", "ghost council glyph" = "幽灵议会符文", "ronin glyph" = "浪人符文", "ratkin glyph" = "鼠人符文", "corax glyph" = "渡鸦变形者符文", "sept of western eye glyph" = "西境之眼社群符文", "bastet glyph" = "猫人符文", "gurahl glyph" = "熊人符文", "rokea glyph" = "鲨人符文", "corax safety glyph" = "鸦族安全符文", "corax danger glyph" = "鸦族危险符文", "corax wyrm spirit glyph" = "鸦族妖蛆灵体符文", "corax weaver spirit glyph" = "鸦族织者灵体符文", "corax food glyph" = "鸦族食物符文", "corax party glyph" = "鸦族聚会符文", "moon lodge glyph" = "月之会所符文", "sun lodge glyph" = "日之会所符文", "house austere glyph" = "肃穆家族符文", "house blood-red crest glyph" = "血红冠家族符文", "house crescent moon glyph" = "眉月家族符文", "house gleaming eye glyph" = "灿目家族符文", "house unbreakable hearth glyph" = "不灭炉火家族符文", "house wise heart glyph" = "慧心家族符文", "house wyrmfoe glyph" = "妖蛆之敌家族符文", "siberakh glyph" = "西伯拉克符文", "impergium glyph" = "猎杀人类时代符文", "litany glyph" = "律诫符文", "pack glyph" = "狼群符文", "moot glyph" = "大集会符文", "weaver glyph" = "织者符文", "defiler wyrm glyph" = "污秽之蛆符文", "beast of war glyph" = "战争巨兽符文", "eater of souls glyph" = "噬魂者符文", "wyld glyph" = "荒野符文", "umbra glyph" = "影界符文", "luna glyph" = "露娜符文", "helios glyph" = "赫利俄斯符文", "fish glyph" = "鱼符文", "forest glyph" = "森林符文", "ally glyph" = "盟友符文", "rite glyph" = "仪式符文", "moon bridge glyph" = "月桥符文", "chimera glyph" = "奇美拉符文", "cockroach glyph" = "蟑螂符文", "falcon glyph" = "猎隼符文", "fenris glyph" = "芬里斯符文", "griffin glyph" = "狮鹫符文", "owl glyph" = "猫头鹰符文", "grandfather thunder glyph" = "雷霆祖父符文", "pegasus glyph" = "飞马符文", "rat glyph" = "鼠符文", "stag glyph" = "雄鹿符文", "horned serpent glyph" = "有角之蛇符文", "unicorn glyph" = "独角兽符文", "north wind glyph" = "北风符文", "gun glyph" = "枪械符文", "path glyph" = "路径符文", "urge wyrm glyph" = "欲念妖蛆符文", "radiation glyph" = "辐射符文", "spirit glyph" = "灵体符文", "mend glyph" = "修复符文", "safety glyph" = "安全符文", "suffering glyph" = "苦难符文", "regeneration glyph" = "再生符文", "storm glyph" = "风暴符文", "story glyph" = "故事符文", "totem glyph" = "图腾符文", "cyberrealm glyph" = "网络灵域符文", "wolfhome glyph" = "狼乡符文", "malfeas glyph" = "秽恶界符文", "aetherial glyph" = "以太界符文", "arcadia gateway glyph" = "阿卡迪亚之门符文", "atrocity realm glyph" = "暴虐界符文", "battleground glyph" = "战场界符文", "erebus glyph" = "幽冥炼狱符文", "flux glyph" = "流变界符文", "legendary realm glyph" = "传奇界符文", "pangaea glyph" = "盘古大陆符文", "scar glyph" = "创痕界符文", "summer country glyph" = "长夏之国符文", "pollution glyph" = "污染符文", "ananasi glyph" = "蛛人符文", "nagah glyph" = "蛇人符文", "fire glyph" = "火焰符文", "bane glyph" = "灾灵符文", "fomori glyph" = "妖蛆附身者符文", "therapy glyph" = "疗愈符文"))
/proc/init_glyphs()
	var/glyph_list = list()
	for(var/path in valid_subtypesof(/obj/effect/decal/garou_glyph))
		var/obj/effect/decal/garou_glyph/S = path
		glyph_list[S.garou_name] = S
	sort_list(glyph_list, GLOBAL_PROC_REF(cmp_typepaths_asc))
	return glyph_list

/obj/item/pen/charcoal/interact_with_atom(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isopenturf(target) || isgroundlessturf(target))
		return NONE

	if(!user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		return NONE

	if(!GLOB.glyph_list.len)
		to_chat(user, span_notice("没有可用的符文。"))
		return NONE

	var/list/glyph_names = list()

	for(var/glyph in GLOB.glyph_list)
		glyph_names[GLOB.localized_glyph_names[glyph] || glyph] = glyph

	var/choice = tgui_input_list(user, "选择要绘制的符文。", "选择符文", assoc_to_keys(glyph_names))
	if(!choice)
		return ITEM_INTERACT_BLOCKING

	var/obj/effect/decal/garou_glyph/drawn_glyph = GLOB.glyph_list[glyph_names[choice]]
	if(drawn_glyph)
		user.visible_message(span_notice("[user]开始在地面上刻画符文……"), \
		span_notice("你开始刻画所选符文的螺旋与线条……"))

		if(do_after(user, 5 SECONDS, target))
			new drawn_glyph.type(target)
			user.visible_message(span_notice("[user]画完了符文。"), \
			span_notice("你为符文添上最后几笔，将它留在面前的地面上。"))
			return ITEM_INTERACT_SUCCESS
		else
			user.visible_message(span_notice("[user]手一滑，把符文抹花了。"), \
			span_notice("你画砸了，符文变成了地上的一团污迹。"))
			return ITEM_INTERACT_FAILURE

/obj/effect/decal/garou_glyph
	abstract_type = /obj/effect/decal/garou_glyph
	name = "古怪符文"
	desc = "一组古怪的符号，似乎是用木炭画成的。"
	anchored = TRUE
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/glyphs.dmi'
	icon_state = "garou"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	// Very likely not needed
	// layer = SIGIL_LAYER
	var/garou_name = "basic glyph"
	var/garou_desc = "没有特殊含义的基础符文。" // This is shown to werewolves who examine the glyph in order to determine its true meaning.

/obj/effect/decal/garou_glyph/examine(mob/user)
	. = ..()
	if(user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		. += "<b>名称：</b>[GLOB.localized_glyph_names[garou_name] || garou_name]\n"
		. += "<b>说明：</b>[garou_desc]\n"

/obj/effect/decal/garou_glyph/wyrm
	name = "阴森符文"
	garou_name = "wyrm glyph"
	garou_desc = "代表妖蛆的符文，象征腐化与毁灭的力量。"
	icon_state = "wyrm"

/obj/effect/decal/garou_glyph/vampire
	name = "怪异符文"
	garou_name = "vampire glyph"
	garou_desc = "代表血族的符文，他们是织者与妖蛆的水蛭。"
	icon_state = "vampire"

/obj/effect/decal/garou_glyph/kinfolk
	name = "诡异符文"
	garou_name = "kinfolk glyph"
	garou_desc = "代表眷属的符文，他们是狼人的人类亲族。"
	icon_state = "kinfolk"

/obj/effect/decal/garou_glyph/dance
	name = "奇趣符文"
	garou_name = "dancing glyph"
	garou_desc = "代表狼人灵性舞蹈的符文。"
	icon_state = "dance"

/obj/effect/decal/garou_glyph/caern
	name = "幽异符文"
	garou_name = "caern glyph"
	garou_desc = "代表圣地的符文，这种神圣之地天然流淌着灵性能量。"
	icon_state = "caern"

/obj/effect/decal/garou_glyph/danger
	name = "奇特符文"
	garou_name = "danger glyph"
	garou_desc = "代表危险的符文！请谨慎前行。"
	icon_state = "danger"

/obj/effect/decal/garou_glyph/garou
	name = "离奇符文"
	garou_name = "garou glyph"
	garou_desc = "代表狼人的符文，他们是盖亚的战士。"
	icon_state = "garou"

/obj/effect/decal/garou_glyph/conceal
	name = "神秘符文"
	garou_name = "conceal glyph"
	garou_desc = "代表某种隐匿的符文。有什么东西瞒过了你的眼睛？"
	icon_state = "conceal"

/obj/effect/decal/garou_glyph/hive
	name = "诡谲符文"
	garou_name = "hive glyph"
	garou_desc = "代表巢穴的符文，那是黑螺旋舞者狼群的污秽居所。"
	icon_state = "hive"

/obj/effect/decal/garou_glyph/howl
	name = "异样符文"
	garou_name = "howling glyph"
	garou_desc = "代表长嚎的符文，这是狼人天生的歌声。"
	icon_state = "howl"

/obj/effect/decal/garou_glyph/remembrance
	name = "哀伤符文"
	garou_name = "remembrance glyph"
	garou_desc = "代表哀悼与追思逝者的符文。"
	icon_state = "remembrance"

/obj/effect/decal/garou_glyph/watch
	name = "古怪符文"
	garou_name = "watch glyph"
	garou_desc = "标记某事物需要监视的符文。"
	icon_state = "watch"

/obj/effect/decal/garou_glyph/toxic
	name = "污秽符文"
	garou_name = "toxic glyph"
	garou_desc = "代表毒害的符文，象征妖蛆对大地的物质污染。"
	icon_state = "toxic"

/obj/effect/decal/garou_glyph/dancers
	name = "异质符文"
	garou_name = "\improper Black Spiral Dancer glyph"
	garou_desc = "代表黑螺旋舞者部族的符文。"
	icon_state = "black_spiral_dancers"

/obj/effect/decal/garou_glyph/glasswalkers
	name = "别致符文"
	garou_name = "\improper Glasswalkers glyph"
	garou_desc = "代表玻璃行者部族的符文。"
	icon_state = "glasswalkers"

/obj/effect/decal/garou_glyph/galestalkers
	name = "异常符文"
	garou_name = "\improper Younger Brother glyph"
	garou_desc = "代表逐风者部族的符文。"
	icon_state = "younger_brother"

/obj/effect/decal/garou_glyph/war_against_wyrm
	name = "骇人符文"
	garou_name = "war against wyrm glyph"
	garou_desc = "代表狼人与妖蛆之间末日之战的符文。"
	icon_state = "war_against_wyrm"

/obj/effect/decal/garou_glyph/black_furies
	name = "根状符文"
	garou_name = "black furies glyph"
	garou_desc = "代表狼人部族之一黑怒之女的符文。"
	icon_state = "black_furies"

/obj/effect/decal/garou_glyph/bonegnawers
	name = "模糊符文"
	garou_name = "bonegnawer glyph"
	garou_desc = "代表狼人部族之一啃骨者的符文。"
	icon_state = "bonegnawers"

/obj/effect/decal/garou_glyph/children_of_gaia
	name = "舒心符文"
	garou_name = "children of gaia glyph"
	garou_desc = "代表狼人部族之一盖亚之子的符文。"
	icon_state = "children_of_gaia"

/obj/effect/decal/garou_glyph/fianna
	name = "韵律符文"
	garou_name = "fianna glyph"
	garou_desc = "代表狼人部族之一芬尼安的符文。"
	icon_state = "fianna"

/obj/effect/decal/garou_glyph/get_of_fenris
	name = "锯齿符文"
	garou_name = "get of fenris glyph"
	garou_desc = "代表狼人部族之一芬里斯之裔的符文。"
	icon_state = "get_of_fenris"

/obj/effect/decal/garou_glyph/red_talons
	name = "爪状符文"
	garou_name = "red talon glyph"
	garou_desc = "代表狼人部族之一赤爪的符文。"
	icon_state = "red_talons"

/obj/effect/decal/garou_glyph/shadow_lords
	name = "朦胧符文"
	garou_name = "shadow lord glyph"
	garou_desc = "代表狼人部族之一暗影领主的符文。"
	icon_state = "shadow_lords"

/obj/effect/decal/garou_glyph/silent_striders
	name = "波纹符文"
	garou_name = "silent striders glyph"
	garou_desc = "代表狼人部族之一寂静行者的符文。"
	icon_state = "silent_striders"

/obj/effect/decal/garou_glyph/silver_fangs
	name = "华贵符文"
	garou_name = "silver fang glyph"
	garou_desc = "代表狼人部族之一银牙的符文。"
	icon_state = "silver_fangs"

/obj/effect/decal/garou_glyph/stargazers
	name = "祥瑞符文"
	garou_name = "stargazers glyph"
	garou_desc = "代表观星者的符文，这个狼人部族如今已退出狼人国度。"
	icon_state = "stargazers"

/obj/effect/decal/garou_glyph/ghost_council
	name = "警觉符文"
	garou_name = "ghost council glyph"
	garou_desc = "代表狼人部族之一幽灵议会的符文。"
	icon_state = "ghost_council"

/obj/effect/decal/garou_glyph/ronin
	name = "凌乱符文"
	garou_name = "ronin glyph"
	garou_desc = "代表浪人的符文，他们游离于部族之外，独来独往，鲜少值得信任。"
	icon_state = "ronin"

/obj/effect/decal/garou_glyph/ratkin
	name = "不祥符文"
	garou_name = "ratkin glyph"
	garou_desc = "代表鼠人的符文，他们是能够在人与鼠之间变换形态的变形者。"
	icon_state = "ratkin"

/obj/effect/decal/garou_glyph/corax
	name = "醒目符文"
	garou_name = "corax glyph"
	garou_desc = "代表渡鸦变形者的符文，他们能够在人与渡鸦之间变换形态。"
	icon_state = "corax"

/obj/effect/decal/garou_glyph/sept_of_western_eye
	name = "繁复符文"
	garou_name = "sept of western eye glyph"
	garou_desc = "代表西境之眼社群的符文，他们守护着隐藏在旧金山市内及郊区的盖亚圣地。"
	icon_state = "sept_of_western_eye"

/obj/effect/decal/garou_glyph/bastet
	name = "獠牙符文"
	garou_name = "bastet glyph"
	garou_desc = "代表猫人的符文，他们是能够在人与猫科动物之间变换形态的变形者。"
	icon_state = "bastet"

/obj/effect/decal/garou_glyph/gurahl
	name = "硕大符文"
	garou_name = "gurahl glyph"
	garou_desc = "代表熊人的符文，他们是能够在人与熊之间变换形态的变形者。"
	icon_state = "gurahl"

/obj/effect/decal/garou_glyph/rokea
	name = "水波符文"
	garou_name = "rokea glyph"
	garou_desc = "代表鲨人的符文，他们是能够在人与鲨鱼之间变换形态的变形者。"
	icon_state = "rokea"

/obj/effect/decal/garou_glyph/corax_safe
	name = "粗糙标记"
	garou_name = "corax safety glyph"
	garou_desc = "标记安全区域的渡鸦变形者符文。"
	icon_state = "corax_safe"

/obj/effect/decal/garou_glyph/corax_danger
	name = "奇怪线条"
	garou_name = "corax danger glyph"
	garou_desc = "标记危险区域的渡鸦变形者符文。"
	icon_state = "corax_danger"

/obj/effect/decal/garou_glyph/corax_wyrm_spirits
	name = "粗糙符号"
	garou_name = "corax wyrm spirit glyph"
	garou_desc = "警告附近有妖蛆灵体的渡鸦变形者符文。"
	icon_state = "corax_wyrm_spirits"

/obj/effect/decal/garou_glyph/corax_weaver_spirits
	name = "抓痕"
	garou_name = "corax weaver spirit glyph"
	garou_desc = "警告附近有织者灵体的渡鸦变形者符文。"
	icon_state = "corax_weaver_spirits"

/obj/effect/decal/garou_glyph/corax_food
	name = "排列古怪的圆点"
	garou_name = "corax food glyph"
	garou_desc = "标示食物或屠杀现场的渡鸦变形者符文。"
	icon_state = "corax_food"

/obj/effect/decal/garou_glyph/corax_party
	name = "粗糙刻痕"
	garou_name = "corax party glyph"
	garou_desc = "标示聚会或庆典地点的渡鸦变形者符文。"
	icon_state = "corax_party"

/obj/effect/decal/garou_glyph/lodge_of_the_moon
	name = "屋顶符文"
	garou_name = "moon lodge glyph"
	garou_desc = "代表月之会所的符文，它是银牙部族两大会所之一，专注于灵性事务。"
	icon_state = "lodge_of_the_moon"

/obj/effect/decal/garou_glyph/lodge_of_the_sun
	name = "闪亮符文"
	garou_name = "sun lodge glyph"
	garou_desc = "代表日之会所的符文，它是银牙部族两大会所之一，专注于世俗事务。"
	icon_state = "lodge_of_the_sun"

/obj/effect/decal/garou_glyph/house_austere_howl
	name = "烟雾符文"
	garou_name = "house austere glyph"
	garou_desc = "代表肃穆家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_austere_howl"

/obj/effect/decal/garou_glyph/house_blood_red_crest
	name = "哭泣符文"
	garou_name = "house blood-red crest glyph"
	garou_desc = "代表血红冠家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_blood_red_crest"

/obj/effect/decal/garou_glyph/house_crescent_moon
	name = "弯曲符文"
	garou_name = "house crescent moon glyph"
	garou_desc = "代表眉月家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_crescent_moon"

/obj/effect/decal/garou_glyph/house_gleaming_eye
	name = "凝视符文"
	garou_name = "house gleaming eye glyph"
	garou_desc = "代表灿目家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_gleaming_eye"

/obj/effect/decal/garou_glyph/house_unbreakable_hearth
	name = "坚实符文"
	garou_name = "house unbreakable hearth glyph"
	garou_desc = "代表不灭炉火家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_unbreakable_hearth"

/obj/effect/decal/garou_glyph/house_wise_heart
	name = "睿智符文"
	garou_name = "house wise heart glyph"
	garou_desc = "代表慧心家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_wise_heart"

/obj/effect/decal/garou_glyph/house_wyrmfoe
	name = "破碎符文"
	garou_name = "house wyrmfoe glyph"
	garou_desc = "代表妖蛆之敌家族的符文，它是银牙部族七大家族之一。"
	icon_state = "house_wyrmfoe"

/obj/effect/decal/garou_glyph/siberakh
	name = "异样符文"
	garou_name = "siberakh glyph"
	garou_desc = "代表西伯拉克的符文，这个隐秘部族只有银牙和逐风者知晓。"
	icon_state = "siberakh"

/obj/effect/decal/garou_glyph/impergium
	name = "慑人符文"
	garou_name = "impergium glyph"
	garou_desc = "代表猎杀人类时代的符文，那是狼人猎杀人类的岁月，又称第一次战争。"
	icon_state = "impergium"

/obj/effect/decal/garou_glyph/litany
	name = "尖角符文"
	garou_name = "litany glyph"
	garou_desc = "代表律诫的符文，这是狼人国度全体成员都必须遵守的神圣律法。"
	icon_state = "litany"

/obj/effect/decal/garou_glyph/pack
	name = "方形符文"
	garou_name = "pack glyph"
	garou_desc = "代表狼群的符文，这是狼人最紧密的群体。"
	icon_state = "pack"

/obj/effect/decal/garou_glyph/moot
	name = "碗形符文"
	garou_name = "moot glyph"
	garou_desc = "代表大集会的符文，这是狼人的盛大聚会。"
	icon_state = "moot"

/obj/effect/decal/garou_glyph/weaver
	name = "网格符文"
	garou_name = "weaver glyph"
	garou_desc = "代表织者的符文，祂是静止与恒定的原初之灵。"
	icon_state = "weaver"

/obj/effect/decal/garou_glyph/defiler_wyrm
	name = "诱人符文"
	garou_name = "defiler wyrm glyph"
	garou_desc = "代表污秽之蛆的符文，祂是妖蛆三相中象征腐化的一面。"
	icon_state = "defiler_wyrm"

/obj/effect/decal/garou_glyph/beast_of_war
	name = "凶险符文"
	garou_name = "beast of war glyph"
	garou_desc = "代表战争巨兽的符文，祂是妖蛆三相中象征暴力的一面。"
	icon_state = "beast_of_war"

/obj/effect/decal/garou_glyph/eater_of_souls
	name = "空洞符文"
	garou_name = "eater of souls glyph"
	garou_desc = "代表噬魂者的符文，祂是妖蛆三相中渴望吞噬造物的一面。"
	icon_state = "eater_of_souls"

/obj/effect/decal/garou_glyph/wyld
	name = "混沌符文"
	garou_name = "wyld glyph"
	garou_desc = "代表荒野的符文，祂是生命与创造的原初之灵。"
	icon_state = "wyld"

/obj/effect/decal/garou_glyph/umbra
	name = "隐晦符文"
	garou_name = "umbra glyph"
	garou_desc = "代表影界的符文，这是与物质世界并存的灵性领域。"
	icon_state = "umbra"

/obj/effect/decal/garou_glyph/luna
	name = "圆形符文"
	garou_name = "luna glyph"
	garou_desc = "代表露娜的符文，这位月亮之灵将怒火赐予狼人。"
	icon_state = "luna"

/obj/effect/decal/garou_glyph/helios
	name = "罗盘符文"
	garou_name = "helios glyph"
	garou_desc = "代表赫利俄斯的符文，这位太阳之灵将光明赐予渡鸦变形者。"
	icon_state = "helios"

/obj/effect/decal/garou_glyph/fish
	name = "鱼形符文"
	garou_name = "fish glyph"
	garou_desc = "代表鱼的符文。"
	icon_state = "fish"

/obj/effect/decal/garou_glyph/forest
	name = "小巧符文"
	garou_name = "forest glyph"
	garou_desc = "代表森林的符文。"
	icon_state = "forest"

/obj/effect/decal/garou_glyph/ally
	name = "安心符文"
	garou_name = "ally glyph"
	garou_desc = "代表联盟的符文。"
	icon_state = "ally"

/obj/effect/decal/garou_glyph/rite
	name = "含蓄符文"
	garou_name = "rite glyph"
	garou_desc = "代表仪式的符文，这是变形者举行的神圣仪式。"
	icon_state = "rite"

/obj/effect/decal/garou_glyph/moon_bridge
	name = "交叉符文"
	garou_name = "moon bridge glyph"
	garou_desc = "代表月桥的符文，它让人能够往返于物质世界与影界之间。"
	icon_state = "moon_bridge"

/obj/effect/decal/garou_glyph/chimera
	name = "威严符文"
	garou_name = "chimera glyph"
	garou_desc = "代表奇美拉的符文，祂是观星者的图腾之灵。"
	icon_state = "chimera"

/obj/effect/decal/garou_glyph/cockroach
	name = "恶心符文"
	garou_name = "cockroach glyph"
	garou_desc = "代表蟑螂的符文，祂是玻璃行者的图腾之灵。"
	icon_state = "cockroach"

/obj/effect/decal/garou_glyph/falcon
	name = "凝视符文"
	garou_name = "falcon glyph"
	garou_desc = "代表猎隼的符文，祂是银牙的图腾之灵。"
	icon_state = "falcon"

/obj/effect/decal/garou_glyph/fenris
	name = "雕刻符文"
	garou_name = "fenris glyph"
	garou_desc = "代表芬里斯的符文，祂是芬里斯之裔的图腾之灵。"
	icon_state = "fenris"

/obj/effect/decal/garou_glyph/griffin
	name = "不安符文"
	garou_name = "griffin glyph"
	garou_desc = "代表狮鹫的符文，祂是赤爪的图腾之灵。"
	icon_state = "griffin"

/obj/effect/decal/garou_glyph/owl
	name = "栖鸟符文"
	garou_name = "owl glyph"
	garou_desc = "代表猫头鹰的符文，祂是寂静行者的图腾之灵。"
	icon_state = "owl"

/obj/effect/decal/garou_glyph/grandfather_thunder
	name = "风蚀符文"
	garou_name = "grandfather thunder glyph"
	garou_desc = "代表雷霆祖父的符文，祂是暗影领主的图腾之灵。"
	icon_state = "grandfather_thunder"

/obj/effect/decal/garou_glyph/pegasus
	name = "迅疾符文"
	garou_name = "pegasus glyph"
	garou_desc = "代表飞马的符文，祂是黑怒之女的图腾之灵。"
	icon_state = "pegasus"

/obj/effect/decal/garou_glyph/rat
	name = "讨厌符文"
	garou_name = "rat glyph"
	garou_desc = "代表鼠的符文，祂是啃骨者的图腾之灵。"
	icon_state = "rat"

/obj/effect/decal/garou_glyph/stag
	name = "角状符文"
	garou_name = "stag glyph"
	garou_desc = "代表雄鹿的符文，祂是芬尼安的图腾之灵。"
	icon_state = "stag"

/obj/effect/decal/garou_glyph/horned_serpent
	name = "蜿蜒符文"
	garou_name = "horned serpent glyph"
	garou_desc = "代表有角之蛇的符文，祂是逐风者的图腾之灵。"
	icon_state = "horned_serpent"

/obj/effect/decal/garou_glyph/unicorn
	name = "高贵符文"
	garou_name = "unicorn glyph"
	garou_desc = "代表独角兽的符文，祂是盖亚之子的图腾之灵。"
	icon_state = "unicorn"

/obj/effect/decal/garou_glyph/north_wind
	name = "简朴符文"
	garou_name = "north wind glyph"
	garou_desc = "代表北风的符文，祂是幽灵议会的图腾之灵。"
	icon_state = "north_wind"

/obj/effect/decal/garou_glyph/gun
	name = "冒烟符文"
	garou_name = "gun glyph"
	garou_desc = "代表枪械的符文。"
	icon_state = "gun"

/obj/effect/decal/garou_glyph/path
	name = "曲折符文"
	garou_name = "path glyph"
	garou_desc = "代表路径的符文。"
	icon_state = "path"

/obj/effect/decal/garou_glyph/urge_wyrm
	name = "惑人符文"
	garou_name = "urge wyrm glyph"
	garou_desc = "代表欲念妖蛆的符文，这些灵性实体能够腐蚀心灵。"
	icon_state = "urge_wyrm"

/obj/effect/decal/garou_glyph/radiation
	name = "发光符文"
	garou_name = "radiation glyph"
	garou_desc = "代表辐射的符文，鲜有事物能像辐射那样玷污生命。"
	icon_state = "radiation"

/obj/effect/decal/garou_glyph/spirit
	name = "抽象符文"
	garou_name = "spirit glyph"
	garou_desc = "标示灵体存在的符文。"
	icon_state = "spirit"

/obj/effect/decal/garou_glyph/mend
	name = "十字符文"
	garou_name = "mend glyph"
	garou_desc = "呼吁修复某处、某物或救治某人的符文。"
	icon_state = "mend"

/obj/effect/decal/garou_glyph/safety
	name = "安心符文"
	garou_name = "safety glyph"
	garou_desc = "代表安全之地的符文。"
	icon_state = "safety"

/obj/effect/decal/garou_glyph/suffering
	name = "揪心符文"
	garou_name = "suffering glyph"
	garou_desc = "代表苦难状态或受苦之地的符文。"
	icon_state = "suffering"

/obj/effect/decal/garou_glyph/regeneration
	name = "宁神符文"
	garou_name = "regeneration glyph"
	garou_desc = "代表再生与愈合的状态或场所的符文。"
	icon_state = "regeneration"

/obj/effect/decal/garou_glyph/storm
	name = "闪电符文"
	garou_name = "storm glyph"
	garou_desc = "代表风暴及其全部威力的符文。"
	icon_state = "storm"

/obj/effect/decal/garou_glyph/story
	name = "怪异符文"
	garou_name = "story glyph"
	garou_desc = "标记讲述故事之地的符文，也可用于以符文叙事。"
	icon_state = "story"

/obj/effect/decal/garou_glyph/totem
	name = "复杂符文"
	garou_name = "totem glyph"
	garou_desc = "代表图腾的符文，图腾是守护狼人部族的灵体。"
	icon_state = "totem"

/obj/effect/decal/garou_glyph/cyberrealm
	name = "凌乱符文"
	garou_name = "cyberrealm glyph"
	garou_desc = "代表网络灵域的符文，这是互联网的灵性领域。"
	icon_state = "cyberspace"

/obj/effect/decal/garou_glyph/wolfhome
	name = "野性符文"
	garou_name = "wolfhome glyph"
	garou_desc = "代表狼乡的符文，这是遍布无尽森林的原始灵性领域，狼群及其猎物的灵魂栖居于此。"
	icon_state = "wolfhome"

/obj/effect/decal/garou_glyph/malfeas
	name = "寒彻骨髓的符文"
	garou_name = "malfeas glyph"
	garou_desc = "代表秽恶界的符文，这是位于妖蛆之口内的黑暗影界领域。"
	icon_state = "malfeas"

/obj/effect/decal/garou_glyph/aetherial
	name = "耀眼符文"
	garou_name = "aetherial glyph"
	garou_desc = "代表以太界的符文，这是容纳着灵性荒野的影界领域。"
	icon_state = "aetherial"

/obj/effect/decal/garou_glyph/arcadia_gateway
	name = "环绕符文"
	garou_name = "arcadia gateway glyph"
	garou_desc = "代表阿卡迪亚之门的符文，这片土地位于中层影界深处，宛如传说中的妖精故乡。"
	icon_state = "arcadia_gateway"

/obj/effect/decal/garou_glyph/atrocity_realm
	name = "腐臭符文"
	garou_name = "atrocity realm glyph"
	garou_desc = "代表暴虐界的符文，这是灾灵滋生之地。"
	icon_state = "atrocity_realm"

/obj/effect/decal/garou_glyph/battleground
	name = "残破符文"
	garou_name = "battleground glyph"
	garou_desc = "代表战场界的符文，这片近域包含了有史以来发生过的一切战斗与冲突。"
	icon_state = "battleground"

/obj/effect/decal/garou_glyph/erebus
	name = "尖角符文"
	garou_name = "erebus glyph"
	garou_desc = "代表幽冥炼狱的符文，这是净化灵性的领域，常被比作地狱。"
	icon_state = "erebus"

/obj/effect/decal/garou_glyph/flux
	name = "狂野符文"
	garou_name = "flux glyph"
	garou_desc = "代表流变界的符文，这片近域充满纯粹的荒野能量，未曾受到织者的染指。"
	icon_state = "flux"

/obj/effect/decal/garou_glyph/legendary_realm
	name = "强劲符文"
	garou_name = "legendary realm glyph"
	garou_desc = "代表传奇界的符文，狼人可以进入这里，亲历祖先的人生。"
	icon_state = "legendary_realm"

/obj/effect/decal/garou_glyph/pangaea
	name = "原始符文"
	garou_name = "pangaea glyph"
	garou_desc = "代表盘古大陆的符文，这片中层领域映照着文明与历史诞生之前、猎杀人类时代结束之前的大地。"
	icon_state = "pangaea"

/obj/effect/decal/garou_glyph/the_scar
	name = "丑陋符文"
	garou_name = "scar glyph"
	garou_desc = "代表创痕界的符文，这片近域映照着工业革命及其带来的压迫与污染。"
	icon_state = "the_scar"

/obj/effect/decal/garou_glyph/summer_country
	name = "壮丽符文"
	garou_name = "summer country glyph"
	garou_desc = "代表长夏之国的符文，这片中层领域正在迅速消逝，据说它体现了盖亚对子女纯粹的爱。"
	icon_state = "summer_country"

/obj/effect/decal/garou_glyph/pollution
	name = "拱形符文"
	garou_name = "pollution glyph"
	garou_desc = "代表污染的符文，象征妖蛆污秽借助工业蔓延。"
	icon_state = "pollution"

/obj/effect/decal/garou_glyph/ananasi
	name = "纤长符文"
	garou_name = "ananasi glyph"
	garou_desc = "代表蛛人的符文，他们是获赐在人与蜘蛛之间变换形态之力的变形者。"
	icon_state = "ananasi"

/obj/effect/decal/garou_glyph/nagah
	name = "獠牙符文"
	garou_name = "nagah glyph"
	garou_desc = "代表蛇人的符文，他们是获赐在人与蛇之间变换形态之力的变形者。"
	icon_state = "nagah"

/obj/effect/decal/garou_glyph/fire
	name = "烟霭符文"
	garou_name = "fire glyph"
	garou_desc = "代表火焰的符文，象征原始的毁灭之力。"
	icon_state = "fire"

/obj/effect/decal/garou_glyph/bane
	name = "令人担忧的符文"
	garou_name = "bane glyph"
	garou_desc = "标示灾灵存在的符文，灾灵是被妖蛆腐化的灵体。"
	icon_state = "bane"

/obj/effect/decal/garou_glyph/fomori
	name = "方框符文"
	garou_name = "fomori glyph"
	garou_desc = "代表妖蛆附身者的符文，他们是被灾灵附身的凡人，在妖蛆仆从的影响下变异成各种模样。"
	icon_state = "fomori"

/obj/effect/decal/garou_glyph/therapy
	name = "舒心符文"
	garou_name = "therapy glyph"
	garou_desc = "代表疗愈状态或场所的符文。"
	icon_state = "therapy"
