/*
CONTAINS:
BEDSHEETS
LINEN BINS
*/

/obj/item/bedsheet
	name = "床单"
	desc = "柔软得令人惊讶的亚麻床单。"
	icon = 'icons/obj/bedsheets.dmi'
	lefthand_file = 'icons/mob/inhands/items/bedsheet_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/bedsheet_righthand.dmi'
	icon_state = "sheetwhite"
	inhand_icon_state = "sheetwhite"
	drop_sound = SFX_CLOTH_DROP
	pickup_sound = SFX_CLOTH_PICKUP
	slot_flags = ITEM_SLOT_NECK
	layer = BELOW_MOB_LAYER
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	dying_key = DYE_REGISTRY_BEDSHEET
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING

	dog_fashion = /datum/dog_fashion/head/ghost
	/// Custom nouns to act as the subject of dreams
	var/list/dream_messages = list("白色")
	/// Cutting it up will yield this.
	var/stack_type = /obj/item/stack/sheet/cloth
	/// The number of sheets dropped by this bedsheet when cut
	var/stack_amount = 3
	/// Denotes if the bedsheet is a single, double, or other kind of bedsheet
	var/bedsheet_type = BEDSHEET_SINGLE
	var/datum/weakref/signal_sleeper //this is our goldylocks

/obj/item/bedsheet/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/surgery_aid, "bedsheet")
	AddElement(/datum/element/bed_tuckable, mapload, 0, 0, 0)
	if(bedsheet_type == BEDSHEET_DOUBLE)
		stack_amount *= 2
		dying_key = DYE_REGISTRY_DOUBLE_BEDSHEET
	register_context()
	register_item_context()

/obj/item/bedsheet/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(istype(held_item) && (held_item.tool_behaviour == TOOL_WIRECUTTER || held_item.get_sharpness()))
		context[SCREENTIP_CONTEXT_LMB] = "撕成布料"

	context[SCREENTIP_CONTEXT_ALT_LMB] = "旋转"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/bedsheet/add_item_context(datum/source, list/context, mob/living/target)
	if(isliving(target) && target.body_position == LYING_DOWN)
		context[SCREENTIP_CONTEXT_RMB] = "盖上"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/item/bedsheet/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	var/mob/living/to_cover = interacting_with
	if(to_cover.body_position != LYING_DOWN)
		return ITEM_INTERACT_BLOCKING
	if(!user.transfer_item_to_turf(src, get_turf(to_cover)))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "已盖好")
	coverup(to_cover)
	add_fingerprint(user)

	return ITEM_INTERACT_SUCCESS

/obj/item/bedsheet/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// Handle wirecutters here so we still tear it up in combat mode
	if(tool.tool_behaviour != TOOL_WIRECUTTER && !tool.get_sharpness())
		return NONE

	// We cannot get free cloth from holograms
	if(flags_1 & HOLOGRAM_1)
		return ITEM_INTERACT_BLOCKING

	var/obj/item/stack/shreds = new stack_type(get_turf(src), stack_amount)
	if(!QDELETED(shreds)) // Stacks merged
		transfer_fingerprints_to(shreds)
		shreds.add_fingerprint(user)
	to_chat(user, span_notice("你撕开了[src]。"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/bedsheet/attack_self(mob/living/user)
	if(!IsReachableBy(user)) //No telekinetic grabbing.
		return
	if(user.body_position != LYING_DOWN)
		return
	if(!user.transfer_item_to_turf(src, get_turf(src)))
		return

	coverup(user)
	add_fingerprint(user)

/obj/item/bedsheet/click_alt(mob/living/user)
	setDir(REVERSE_DIR(dir))
	return CLICK_ACTION_SUCCESS

/obj/item/bedsheet/proc/coverup(mob/living/sleeper)
	layer = ABOVE_MOB_LAYER
	pixel_x = 0
	pixel_y = 0
	pixel_z = sleeper.pixel_z // Account for possible mob elevation
	balloon_alert(sleeper, "已盖好")
	var/angle = sleeper.lying_prev
	dir = angle2dir(angle + 180) // 180 flips it to be the same direction as the mob

	signal_sleeper = WEAKREF(sleeper)
	RegisterSignal(src, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))
	RegisterSignal(sleeper, COMSIG_MOVABLE_MOVED, PROC_REF(smooth_sheets))
	RegisterSignal(sleeper, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(smooth_sheets))
	RegisterSignal(sleeper, COMSIG_QDELETING, PROC_REF(smooth_sheets))

/obj/item/bedsheet/proc/smooth_sheets(mob/living/sleeper)
	SIGNAL_HANDLER

	UnregisterSignal(src, COMSIG_ITEM_PICKUP)
	UnregisterSignal(sleeper, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(sleeper, COMSIG_LIVING_SET_BODY_POSITION)
	UnregisterSignal(sleeper, COMSIG_QDELETING)
	balloon_alert(sleeper, "已铺平床单")
	layer = initial(layer)
	SET_PLANE_IMPLICIT(src, initial(plane))
	pixel_z = 0
	signal_sleeper = null

// We need to do this in case someone picks up a bedsheet while a mob is covered up
// otherwise the bedsheet will disappear while in our hands if the sleeper signals get activated by moving
/obj/item/bedsheet/proc/on_pickup(datum/source, mob/grabber)
	SIGNAL_HANDLER

	var/mob/living/sleeper = signal_sleeper?.resolve()

	UnregisterSignal(src, COMSIG_ITEM_PICKUP)
	UnregisterSignal(sleeper, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(sleeper, COMSIG_LIVING_SET_BODY_POSITION)
	UnregisterSignal(sleeper, COMSIG_QDELETING)
	pixel_z = 0
	signal_sleeper = null

/obj/item/bedsheet/blue
	icon_state = "sheetblue"
	inhand_icon_state = "sheetblue"
	dream_messages = list("蓝色")

/obj/item/bedsheet/green
	icon_state = "sheetgreen"
	inhand_icon_state = "sheetgreen"
	dream_messages = list("绿色")

/obj/item/bedsheet/grey
	icon_state = "sheetgrey"
	inhand_icon_state = "sheetgrey"
	dream_messages = list("灰色")

/obj/item/bedsheet/orange
	icon_state = "sheetorange"
	inhand_icon_state = "sheetorange"
	dream_messages = list("橙色")

/obj/item/bedsheet/purple
	icon_state = "sheetpurple"
	inhand_icon_state = "sheetpurple"
	dream_messages = list("紫色")

/obj/item/bedsheet/patriot
	name = "爱国床单"
	desc = "睡在这上面，你从未感觉如此自由。"
	icon_state = "sheetUSA"
	inhand_icon_state = "sheetUSA"
	dream_messages = list("美国", "自由", "烟花", "白头海雕")

/obj/item/bedsheet/rainbow
	name = "彩虹床单"
	desc = "一条多彩的毯子，其实是把几条不同的床单剪开后缝在一起做成的。"
	icon_state = "sheetrainbow"
	inhand_icon_state = "sheetrainbow"
	dream_messages = list("红色", "橙色", "黄色", "绿色", "蓝色", "紫色", "一道彩虹")

/obj/item/bedsheet/red
	icon_state = "sheetred"
	inhand_icon_state = "sheetred"
	dream_messages = list("红色")

/obj/item/bedsheet/yellow
	icon_state = "sheetyellow"
	inhand_icon_state = "sheetyellow"
	dream_messages = list("黄色")

/obj/item/bedsheet/mime
	name = "默剧演员的毯子"
	desc = "一条让人十分安心的条纹毯子。盖上它，周围的喧闹仿佛都渐渐消失了。"
	icon_state = "sheetmime"
	inhand_icon_state = "sheetmime"
	dream_messages = list("寂静", "手势", "一张苍白的脸", "一张大张的嘴", "默剧演员")

/obj/item/bedsheet/clown
	name = "小丑的毯子"
	desc = "织有小丑面具图案的彩虹毯，散发着淡淡的香蕉味。"
	icon_state = "sheetclown"
	inhand_icon_state = "sheetrainbow"
	dream_messages = list("叭叭声", "笑声", "一场恶作剧", "一个笑话", "一张笑脸", "小丑")

/obj/item/bedsheet/captain
	name = "船长床单"
	desc = "印有纳诺传讯标志，用革命性的新型纤维织成，保证对大多数非化学物质的渗透率仅为0.01%，深受当代船长欢迎。"
	icon_state = "sheetcaptain"
	inhand_icon_state = "sheetcaptain"
	dream_messages = list("权威", "一张金色身份证", "太阳镜", "一张绿色磁盘", "一把古董枪", "船长")

/obj/item/bedsheet/rd
	name = "科研主管床单"
	desc = "上面似乎有个烧杯徽记，由耐火材料制成，不过大概挡不住你每天都见惯了的那些火灾。"
	icon_state = "sheetrd"
	inhand_icon_state = "sheetrd"
	dream_messages = list("权威", "一张银色身份证", "一枚炸弹", "一台机甲", "一只抱脸虫", "狂笑声", "科研主管")

// for Free Golems.
/obj/item/bedsheet/rd/royal_cape
	name = "解放者的皇家披风"
	desc = "威风凛凛。"
	dream_messages = list("采矿", "石头", "一个魔像", "自由", "随心所欲")

/obj/item/bedsheet/medical
	name = "医用毯"
	desc = "医务室常用的“无菌”毯子。"
	icon_state = "sheetmedical"
	inhand_icon_state = "sheetmedical"
	dream_messages = list("治愈", "生命", "手术", "一位医生")

/obj/item/bedsheet/cmo
	name = "首席医疗官床单"
	desc = "带有十字徽记的无菌毯。上面有些猫毛，大概是运行时留下的。"
	icon_state = "sheetcmo"
	inhand_icon_state = "sheetcmo"
	dream_messages = list("权威", "一张银色身份证", "治愈", "生命", "手术", "一只猫", "首席医疗官")

/obj/item/bedsheet/hos
	name = "安保主管床单"
	desc = "饰有盾牌徽记。犯罪从不睡觉，你却得睡；不过，你依然代表法律！"
	icon_state = "sheethos"
	inhand_icon_state = "sheethos"
	dream_messages = list("权威", "一张银色身份证", "手铐", "一根警棍", "一枚闪光弹", "太阳镜", "安保主管")

/obj/item/bedsheet/hop
	name = "人事主管床单"
	desc = "饰有钥匙徽记。难得没人通过无线电嚷着找你时，正适合躺下来抱着伊恩歇一会儿。"
	icon_state = "sheethop"
	inhand_icon_state = "sheethop"
	dream_messages = list("权威", "一张银色身份证", "职责", "一台电脑", "一张身份证", "一只柯基", "人事主管")

/obj/item/bedsheet/ce
	name = "总工程师床单"
	desc = "饰有扳手徽记。反光性强且耐污，不必担心油渍弄坏它。"
	icon_state = "sheetce"
	inhand_icon_state = "sheetce"
	dream_messages = list("权威", "一张银色身份证", "引擎", "电动工具", "一台区域电力控制器", "一只鹦鹉", "总工程师")

/obj/item/bedsheet/qm
	name = "军需官床单"
	desc = "饰有银边货箱徽记。质地相当结实，忙了一整天文书工作后躺上去再合适不过。"
	icon_state = "sheetqm"
	inhand_icon_state = "sheetqm"
	dream_messages = list("权威", "一张银色身份证", "一艘穿梭机", "一个货箱", "一只树懒", "军需官")

/obj/item/bedsheet/chaplain
	name = "牧师的毯子"
	desc = "用诸神之心编织而成的毯子……等等，只是亚麻而已。"
	icon_state = "sheetchap"
	inhand_icon_state = "sheetchap"
	dream_messages = list("一张灰色身份证", "诸神", "应验的祈祷", "一个邪教", "牧师")

/obj/item/bedsheet/brown
	icon_state = "sheetbrown"
	inhand_icon_state = "sheetbrown"
	dream_messages = list("棕色")

/obj/item/bedsheet/black
	icon_state = "sheetblack"
	inhand_icon_state = "sheetblack"
	dream_messages = list("黑色")

/obj/item/bedsheet/centcom
	name = "\improper 中央指挥部床单"
	desc = "采用先进纳米纤维织成，既保暖又装饰华丽，是官员的必备之物。"
	icon_state = "sheetcentcom"
	inhand_icon_state = "sheetcentcom"
	dream_messages = list("一张独特的身份证", "权威", "火炮", "一个结局")

/obj/item/bedsheet/syndie
	name = "辛迪加床单"
	desc = "带有辛迪加徽记，散发着邪恶的气息。"
	icon_state = "sheetsyndie"
	inhand_icon_state = "sheetsyndie"
	dream_messages = list("一张绿色磁盘", "一块红色水晶", "一把发光的刀刃", "一张缠满电线的身份证")

/obj/item/bedsheet/cult
	name = "邪教徒床单"
	desc = "盖着它睡觉，说不定会梦见纳尔西。它看起来相当破旧，泛着诡异的光芒。"
	icon_state = "sheetcult"
	inhand_icon_state = "sheetcult"
	dream_messages = list("一本古籍", "一块悬浮的红色水晶", "一把发光的剑", "一个血色符号", "一个庞大的人形身影")

/obj/item/bedsheet/wiz
	name = "巫师床单"
	desc = "附有魔法的特殊织物，让你度过一个奇幻之夜。它甚至会发光！"
	icon_state = "sheetwiz"
	inhand_icon_state = "sheetwiz"
	dream_messages = list("一本书", "一场爆炸", "闪电", "一根法杖", "一具骷髅", "一件长袍", "魔法")

/obj/item/bedsheet/rev
	name = "革命者床单"
	desc = "从中央指挥部官员卧室里偷来的床单，象征着反抗纳诺传讯暴政的胜利。正面的金色徽记已经被涂掉了。"
	icon_state = "sheetrev"
	inhand_icon_state = "sheetrev"
	dream_messages = list(
		"人民",
		"解放",
		"协作",
		"人头落地",
		"多得数不清的棒球棍",
		"刺眼的光芒",
		"你的战友"
	)

/obj/item/bedsheet/nanotrasen
	name = "\improper 纳诺传讯床单"
	desc = "印有纳诺传讯标志，散发着使命感。"
	icon_state = "sheetNT"
	inhand_icon_state = "sheetNT"
	dream_messages = list("权威", "一个结局")

/obj/item/bedsheet/ian
	icon_state = "sheetian"
	inhand_icon_state = "sheetian"
	dream_messages = list("一条狗", "一只柯基", "汪汪声", "犬吠声", "汪呜声")

/obj/item/bedsheet/runtime
	icon_state = "sheetruntime"
	inhand_icon_state = "sheetruntime"
	dream_messages = list("一只小猫", "一只猫", "喵喵声", "呼噜声", "喵～")

/obj/item/bedsheet/pirate
	name = "海盗床单"
	desc = "印有骷髅海盗旗图案，带着淡淡的格罗格酒味。"
	icon_state = "sheetpirate"
	inhand_icon_state = "sheetpirate"
	dream_messages = list(
		"埋藏的宝藏",
		"一座岛屿",
		"一只猴子",
		"一只鹦鹉",
		"一位冒险剑客",
		"一颗会说话的骷髅头",
		"停船！",
		"当一名海盗",
		"因为海盗自由自在",
		"随心所欲",
		"黄金",
		"旱鸭子",
		"偷窃",
		"纵横七海",
		"呀吼！",
	)

/obj/item/bedsheet/gondola
	name = "冈多拉床单"
	desc = "由一种奇特的濒危动物的皮制成的珍贵床单。"
	icon_state = "sheetgondola"
	inhand_icon_state = "sheetgondola"
	dream_messages = list("宁静", "舒适", "一种稀有小动物", "一种无害生物")
	stack_type = /obj/item/stack/sheet/animalhide/gondola
	stack_amount = 1
	///one of four icon states that represent its mouth
	var/gondola_mouth
	///one of four icon states that represent its eyes
	var/gondola_eyes

/obj/item/bedsheet/gondola/Initialize(mapload)
	. = ..()
	gondola_mouth = "sheetgondola_mouth[rand(1, 4)]"
	gondola_eyes = "sheetgondola_eyes[rand(1, 4)]"
	add_overlay(gondola_mouth)
	add_overlay(gondola_eyes)

/obj/item/bedsheet/gondola/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands)
		. += mutable_appearance(icon_file, gondola_mouth)
		. += mutable_appearance(icon_file, gondola_eyes)

/obj/item/bedsheet/cosmos
	name = "浩瀚星空床单"
	desc = "由仰望星空之人的梦想织成。"
	icon_state = "sheetcosmos"
	inhand_icon_state = "sheetcosmos"
	dream_messages = list("无垠宇宙", "汉斯·季默的音乐", "一次太空飞行", "银河", "光彩夺目", "流星")
	light_power = 2
	light_range = 1.4

/obj/item/bedsheet/double
	icon_state = "double_sheetwhite"
	worn_icon_state = "sheetwhite"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/blue/double
	icon_state = "double_sheetblue"
	worn_icon_state = "sheetblue"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/green/double
	icon_state = "double_sheetgreen"
	worn_icon_state = "sheetgreen"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/grey/double
	icon_state = "double_sheetgrey"
	worn_icon_state = "sheetgrey"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/orange/double
	icon_state = "double_sheetorange"
	worn_icon_state = "sheetorange"
	dying_key = DYE_REGISTRY_DOUBLE_BEDSHEET
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/purple/double
	icon_state = "double_sheetpurple"
	worn_icon_state = "sheetpurple"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/patriot/double
	icon_state = "double_sheetUSA"
	worn_icon_state = "sheetUSA"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/rainbow/double
	icon_state = "double_sheetrainbow"
	worn_icon_state = "sheetrainbow"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/red/double
	icon_state = "double_sheetred"
	worn_icon_state = "sheetred"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/yellow/double
	icon_state = "double_sheetyellow"
	worn_icon_state = "sheetyellow"
	dying_key = DYE_REGISTRY_DOUBLE_BEDSHEET
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/mime/double
	icon_state = "double_sheetmime"
	worn_icon_state = "sheetmime"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/clown/double
	icon_state = "double_sheetclown"
	worn_icon_state = "sheetclown"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/captain/double
	icon_state = "double_sheetcaptain"
	worn_icon_state = "sheetcaptain"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/rd/double
	icon_state = "double_sheetrd"
	worn_icon_state = "sheetrd"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/medical/double
	icon_state = "double_sheetmedical"
	worn_icon_state = "sheetmedical"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/cmo/double
	icon_state = "double_sheetcmo"
	worn_icon_state = "sheetcmo"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/hos/double
	icon_state = "double_sheethos"
	worn_icon_state = "sheethos"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/hop/double
	icon_state = "double_sheethop"
	worn_icon_state = "sheethop"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/ce/double
	icon_state = "double_sheetce"
	worn_icon_state = "sheetce"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/qm/double
	icon_state = "double_sheetqm"
	worn_icon_state = "sheetqm"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/chaplain/double
	icon_state = "double_sheetchap"
	worn_icon_state = "sheetchap"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/brown/double
	icon_state = "double_sheetbrown"
	worn_icon_state = "sheetbrown"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/black/double
	icon_state = "double_sheetblack"
	worn_icon_state = "sheetblack"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/centcom/double
	icon_state = "double_sheetcentcom"
	worn_icon_state = "sheetcentcom"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/syndie/double
	icon_state = "double_sheetsyndie"
	worn_icon_state = "sheetsyndie"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/cult/double
	icon_state = "double_sheetcult"
	worn_icon_state = "sheetcult"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/wiz/double
	icon_state = "double_sheetwiz"
	worn_icon_state = "sheetwiz"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/rev/double
	icon_state = "double_sheetrev"
	worn_icon_state = "sheetrev"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/nanotrasen/double
	icon_state = "double_sheetNT"
	worn_icon_state = "sheetNT"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/ian/double
	icon_state = "double_sheetian"
	worn_icon_state = "sheetian"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/runtime/double
	icon_state = "double_sheetruntime"
	worn_icon_state = "sheetruntime"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/item/bedsheet/cosmos/double
	icon_state = "double_sheetcosmos"
	worn_icon_state = "sheetcosmos"
	bedsheet_type = BEDSHEET_DOUBLE

/obj/structure/bedsheetbin
	name = "床单箱"
	desc = "看起来挺舒适的。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "linenbin-full"
	base_icon_state = "linenbin"
	anchored = TRUE
	pass_flags = PASSTABLE
	resistance_flags = FLAMMABLE
	max_integrity = 70
	anchored_tabletop_offset = 6
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
	/// The number of bedsheets in the bin
	var/amount = 10
	/// A list of actual sheets within the bin
	var/list/sheets = list()
	/// The object hiddin within the bedsheet bin
	var/obj/item/hidden = null

/obj/structure/bedsheetbin/empty
	amount = 0
	icon_state = "linenbin-empty"
	anchored = FALSE


/obj/structure/bedsheetbin/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/bedsheetbin/examine(mob/user)
	. = ..()
	if(amount < 1)
		. += "箱子里没有床单。"
	else if(amount == 1)
		. += "箱子里有一条床单。"
	else
		. += "箱子里有[amount]条床单。"

/obj/structure/bedsheetbin/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	if(isnull(held_item))
		if(amount)
			context[SCREENTIP_CONTEXT_LMB] = "取出床单"
			return CONTEXTUAL_SCREENTIP_SET
		return

	if(istype(held_item, /obj/item/bedsheet))
		context[SCREENTIP_CONTEXT_LMB] = "放入"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_RMB] = "拆解"
		. = CONTEXTUAL_SCREENTIP_SET
	else if(held_item.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_RMB] = "[anchored ? "解除固定" : "固定"]"
		. = CONTEXTUAL_SCREENTIP_SET

	if(amount && held_item.w_class < WEIGHT_CLASS_BULKY)
		context[SCREENTIP_CONTEXT_LMB] = "藏入物品"
		. = CONTEXTUAL_SCREENTIP_SET
	return .

/obj/structure/bedsheetbin/update_icon_state()
	switch(amount)
		if(0)
			icon_state = "[base_icon_state]-empty"
		if(1 to 5)
			icon_state = "[base_icon_state]-half"
		else
			icon_state = "[base_icon_state]-full"
	return ..()

/obj/structure/bedsheetbin/fire_act(exposed_temperature, exposed_volume)
	if(amount)
		amount = 0
		update_appearance()
	..()

/obj/structure/bedsheetbin/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if(amount)
		to_chat(user, span_warning("需要先清空[src]！"))
		return ITEM_INTERACT_SUCCESS
	if(tool.use_tool(src, user, 0.5 SECONDS, volume=50))
		to_chat(user, span_notice("你拆解了[src]。"))
		new /obj/item/stack/rods(loc, 2)
		qdel(src)
		return ITEM_INTERACT_SUCCESS

/obj/structure/bedsheetbin/wrench_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 0.5 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/structure/bedsheetbin/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/bedsheet))
		return bedsheet_act(user, tool)

	// Everything else we try to hide
	return hide_item_act(user, tool)

/obj/structure/bedsheetbin/proc/bedsheet_act(mob/living/user, obj/item/tool)
	if(!user.transferItemToLoc(tool, src, silent = FALSE))
		return ITEM_INTERACT_BLOCKING
	sheets.Add(tool)
	amount++
	to_chat(user, span_notice("你把[tool]放进了[src]。"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/structure/bedsheetbin/proc/hide_item_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return NONE
	if(tool.w_class >= WEIGHT_CLASS_BULKY)
		balloon_alert(user, "太大了！")
		return ITEM_INTERACT_BLOCKING
	if(!amount)
		balloon_alert(user, "没有可供藏东西的床单！")
		return ITEM_INTERACT_BLOCKING
	if(hidden)
		balloon_alert(user, "里面已经藏着东西了！")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src, silent = FALSE))
		to_chat(user, span_warning("[tool]黏在你的手上，无法藏进床单里！"))
		return ITEM_INTERACT_BLOCKING
	hidden = tool
	to_chat(user, span_notice("你把[tool]藏进了床单里。"))
	return ITEM_INTERACT_SUCCESS

/obj/structure/bedsheetbin/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/bedsheetbin/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(isliving(user))
		var/mob/living/L = user
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return
	if(amount >= 1)
		amount--

		var/obj/item/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/bedsheet(loc)

		B.forceMove(drop_location())
		user.put_in_hands(B)
		to_chat(user, span_notice("你从[src]里取出了[B]。"))
		update_appearance()

		if(hidden)
			hidden.forceMove(drop_location())
			to_chat(user, span_notice("[hidden]从[B]里掉了出来！"))
			hidden = null

	add_fingerprint(user)


/obj/structure/bedsheetbin/attack_tk(mob/user)
	if(amount >= 1)
		amount--

		var/obj/item/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/bedsheet(loc)

		B.forceMove(drop_location())
		to_chat(user, span_notice("你用念力从[src]里取出了[B]。"))
		update_appearance()

		if(hidden)
			hidden.forceMove(drop_location())
			hidden = null

	add_fingerprint(user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/structure/bedsheetbin/basket
	name = "床单篮"
	icon_state = "linenbasket-full"
	base_icon_state = "linenbasket"

/obj/structure/bedsheetbin/empty/basket
	name = "床单篮"
	icon_state = "linenbasket-empty"
	base_icon_state = "linenbasket"
