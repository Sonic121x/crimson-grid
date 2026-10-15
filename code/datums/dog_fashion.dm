/datum/dog_fashion
	///Name modifier for the dog that we're dressing up
	var/name = null
	///Description modifier for the dog that we're dressing up
	var/desc = null
	///Hearable emotes modifier for the dog that we're dressing up
	var/list/emote_hear
	///Visible emotes modifier for the dog that we're dressing up
	var/list/emote_see
	///Speech modifier for the dog that we're dressing up
	var/list/speak
	///Speech verb modifier for the dog that we're dressing up
	var/list/speak_emote

	// This isn't applied to the dog, but stores the icon_state of the
	// sprite that the associated item uses
	///Icon path for the fashion item
	var/icon_file = null
	///Icon state for the fashion item
	var/obj_icon_state = null
	///Alpha level (opacity) modifier of the fashion item
	var/obj_alpha
	///Color modifier of the fasion item
	var/obj_color

/datum/dog_fashion/New(mob/fashionable_mob)
	//replace the placeholder for the real unmodified name in the name of the dog
	name = replacetext(name, "%REAL_NAME%", fashionable_mob.real_name)
	//replace the placeholder for the capitalized real unmodified name in the name of the dog
	name = replacetext(name, "%CAPITAL_REAL_NAME%", capitalize(fashionable_mob.real_name))
	//replace the placeholder for the current full name, which includes our name modifiers
	desc = replacetext(desc, "%NAME%", name)
	//replace the placeholder for the real unmodified name in the description of the dog
	desc = replacetext(desc, "%REAL_NAME%", fashionable_mob.real_name)
	//replace the placeholder for the capitalized real unmodified name in the description of the dog
	desc = replacetext(desc, "%CAPITAL_REAL_NAME%", capitalize(fashionable_mob.real_name))

///Applies the name, description and speak emote modifiers to the dog
/datum/dog_fashion/proc/apply(mob/living/basic/pet/dog/dressup_doggy)
	if(name)
		dressup_doggy.name = name
	if(desc)
		dressup_doggy.desc = desc
	if(LAZYLEN(speak_emote))
		dressup_doggy.speak_emote = string_list(speak_emote)

///Applies random speech modifiers to the dog
/datum/dog_fashion/proc/apply_to_speech(list/speech_data)
	if(LAZYLEN(emote_see))
		speech_data[BB_EMOTE_SEE] = string_list(emote_see)
	if(LAZYLEN(emote_hear))
		speech_data[BB_EMOTE_HEAR] = string_list(emote_hear)
	if(LAZYLEN(speak))
		speech_data[BB_EMOTE_SAY] = string_list(speak)

/**
 * Generates the icon overlay for the equipped item
 * dir: passed direction for the sprite, e.g. to apply to a dead dog, we use the EAST dir and just flip it 180.
 */
/datum/dog_fashion/proc/get_overlay(dir)
	if(icon_file && obj_icon_state)
		var/image/corgI = image(icon_file, icon_state = obj_icon_state, dir = dir)
		corgI.alpha = obj_alpha
		corgI.color = obj_color
		return corgI


/datum/dog_fashion/head
	icon_file = 'icons/mob/simple/corgi_head.dmi'

/datum/dog_fashion/back
	icon_file = 'icons/mob/simple/corgi_back.dmi'

/datum/dog_fashion/back/armorvest
	obj_icon_state = "armor"

/datum/dog_fashion/back/deathsquad
	name = "士兵%REAL_NAME%"
	desc = "那可不是红漆，而是真正的柯基鲜血。"

/datum/dog_fashion/head/helmet
	name = "中士%REAL_NAME%"
	desc = "永远忠诚，永远警惕。"

/datum/dog_fashion/head/chef
	name = "副主厨%REAL_NAME%"
	desc = "你的食物会接受试吃检查。一口不剩。"

/datum/dog_fashion/head/captain
	name = "船长%REAL_NAME%"
	desc = "大概比上一任船长强。"

/datum/dog_fashion/head/dragoon
	name = "龙骑士%REAL_NAME%"
	desc = "世上最后一位活着的龙骑士。"

/datum/dog_fashion/head/kitty
	name = "运行时"
	desc = "真是只可爱的小猫咪！……等等……什么鬼？"
	emote_see = list("咳出一个毛球", "伸了个懒腰")
	emote_hear = list("发出呼噜声")
	speak = list("呼噜噜", "喵！", "喵——嗷！", "嘶——", "喵呜——")

/datum/dog_fashion/head/rabbit
	name = "蹦蹦"
	desc = "这是蹦蹦。它是只柯基……呃……小兔子。"
	emote_see = list("抽动着鼻子", "蹦跶了几下")

/datum/dog_fashion/head/beret
	name = "扬恩"
	desc = "我的天哪！这是一只狗！"
	speak = list("勒汪！", "勒汪汪！", "汪汪！！")
	emote_see = list("害怕地蜷缩起来。", "投降了。", "开始装死。","仿佛面前有一堵墙。")

/datum/dog_fashion/head/detective
	name = "侦探%REAL_NAME%"
	desc = "%NAME%看穿了你的谎言……"
	emote_see = list("调查着周围。","四处嗅闻，寻找线索。","寻找史酷比零食。","从帽子里拿出一颗玉米糖。")

/datum/dog_fashion/head/nurse
	name = "护士%REAL_NAME%"
	desc = "%NAME%需要100毫升牛肉干……立刻！"

/datum/dog_fashion/head/pirate
	name = "海盗头衔 海盗名字"
	desc = "呀嗬！！那里有只坏血病狗！"
	emote_see = list("寻找着宝藏。","冷冷地盯着……","咬得小小的柯基牙齿咯咯响！")
	emote_hear = list("凶猛地低吼！", "龇牙低吼。")
	speak = list("呀嗬！！","呜噜噜！")

/datum/dog_fashion/head/pirate/New(mob/M)
	. = ..()
	name = "[pick("老","坏血病","黑","朗姆","瘸","血腥","坏疽","死亡","长约翰")][pick("狗粮","腿","胡子","牙","艉楼甲板","斯里普伍德","勒查克","海盗","西尔弗","克鲁索")]"

/datum/dog_fashion/head/ushanka
	name = "共产主义头衔 本名"
	desc = "卡尔·汪克思的追随者。"
	emote_see = list("思索着资本主义经济模式的弊端。", "琢磨着先锋队主义的利弊。")

/datum/dog_fashion/head/ushanka/New(mob/M)
	name = "[pick("同志","政委","光荣领袖")]%REAL_NAME%"
	return ..()

/datum/dog_fashion/head/warden
	name = "警官%REAL_NAME%"
	desc = "站住，你这犯罪渣滓！"
	emote_see = list("流着口水。","寻找甜甜圈。")

/datum/dog_fashion/head/warden_red
	name = "警官%REAL_NAME%"
	desc = "站住，你这犯罪渣滓！"
	emote_see = list("流着口水。","寻找甜甜圈。")

/datum/dog_fashion/head/blue_wizard
	name = "大巫师%REAL_NAME%"
	speak = list("汪", "汪呜！", "汪汪！", "嗷呜——", "EI NATH!")

/datum/dog_fashion/head/red_wizard
	name = "烈焰法师%REAL_NAME%"
	speak = list("汪", "汪呜！", "汪汪！", "嗷呜——", "ONI SOMA!")

/datum/dog_fashion/head/cardborg
	name = "机柯基"
	desc = "机器人部门削减预算的成果。"
	speak = list("叮！","哔！","汪！")
	emote_see = list("失控了。", "嗅探着非人类。")

/datum/dog_fashion/head/ghost
	name = "\improper 幽灵"
	desc = "阴森森的！"
	obj_icon_state = "sheet"
	speak = list("呜——呜呜～","嗷呜——————")
	emote_see = list("踉踉跄跄地走着。", "打着寒战。")
	emote_hear = list("嚎叫起来！","低吟着。")

/datum/dog_fashion/head/santa
	name = "圣诞老人的柯基小助手"
	desc = "它非常喜欢牛奶和饼干。"
	emote_hear = list("用汪汪声唱着圣诞歌。", "欢快地叫着！")
	emote_see = list("寻找礼物。", "核对着清单。")

/datum/dog_fashion/head/cargo_tech
	name = "柯基货运员%REAL_NAME%"
	desc = "你那黄色手套上的牙印就是它干的。"

/datum/dog_fashion/head/reindeer
	name = "红鼻子柯基%REAL_NAME%"
	desc = "它的鼻子闪闪发亮。"
	emote_hear = list("照亮了前路！", "发出亮光。", "汪汪叫着！")

/datum/dog_fashion/head/sombrero
	name = "%REAL_NAME%先生"
	desc = "你必须尊重%REAL_NAME%长者。"

/datum/dog_fashion/head/hop
	name = "中尉%REAL_NAME%"
	desc = "这位真的靠得住，不会擅自跑掉。"

/datum/dog_fashion/head/deathsquad
	name = "士兵%REAL_NAME%"
	desc = "那可不是红漆，而是真正的柯基鲜血。"

/datum/dog_fashion/head/clown
	name = "小丑%REAL_NAME%"
	desc = "滑稽人的好朋友。"
	speak = list("HONK！", "Honk！")
	emote_see = list("耍起了小把戏。", "滑倒了。")

/datum/dog_fashion/head/festive
	name = "欢庆%REAL_NAME%"
	desc = "准备好开派对了！"
	obj_icon_state = "festive"

/datum/dog_fashion/head/pumpkin/unlit
	name = "无头又无主的%REAL_NAME%"
	desc = "这只备受宠爱的狗失去了人事主管主人，化作了阴森的狗魂。"
	obj_icon_state = "pumpkin0"
	speak = list("吓！", "嗷呜——", "嗷吼！")
	emote_see = list("蹒跚地游荡着。", "发出不祥的吠声。", "打着寒战。")
	emote_hear = list("对着月亮嚎叫。", "冲乌鸦汪汪叫！")

/datum/dog_fashion/head/pumpkin/lit
	obj_icon_state = "pumpkin1"

/datum/dog_fashion/head/blumpkin/unlit
	name = "失色无头又无主的%REAL_NAME%"
	desc = "这只备受宠爱的狗化作了邪恶的狗魂，盘踞在你的零食柜里！"
	obj_icon_state = "blumpkin0"
	speak = list("吓！", "嗷呜——", "嗷吼！")
	emote_see = list("蹒跚地游荡着。", "发出不祥的吠声。", "打着寒战。")
	emote_hear = list("对着月亮嚎叫。", "冲乌鸦汪汪叫！", "发出诡异的低吼！")

/datum/dog_fashion/head/blumpkin/lit
	obj_icon_state = "blumpkin1"

/datum/dog_fashion/head/butter
	name = "黄油%REAL_NAME%"
	desc = "%NAME%。顶着黄油的%CAPITAL_REAL_NAME%。%NAME%。头上有块黄油的%CAPITAL_REAL_NAME%。"
	obj_icon_state = "butter"
	speak = null //they're very patient and focused on holding the butter on 'em
	emote_see = list("微微抖动。", "环顾四周。")
	emote_hear = list("舔掉一小滴淌下来的黄油。", "露出微笑。")

/datum/dog_fashion/head/eyepatch
	name = "饱受磨难的%REAL_NAME%"
	desc = "%REAL_NAME%今天实在是饱经磨难。"
	obj_icon_state = "eyepatch"
	emote_hear = list("粗声叹了口气。", "低吟着。")
	emote_see = list("思索着自己终将死去的命运。", "目光黯淡地望着不远处。", "思索着战争的恐怖。")

/datum/dog_fashion/head/watermelon
	name = "西瓜勇士%REAL_NAME%"
	desc = "比平时安全了5%，已经准备好把握优势！"
	obj_icon_state = "watermelon"

/datum/dog_fashion/head/holymelon
	name = "圣瓜圣骑士%REAL_NAME%"
	desc = "天外势力小心了，%NAME%要来惩戒你们了！"
	obj_icon_state = "holymelon"

/datum/dog_fashion/head/barrelmelon
	name = "桶瓜狂战士%REAL_NAME%"
	desc = "要么是头盔的结实程度让%REAL_NAME%信心大增，要么就是它把脑袋箍得有点紧……"
	obj_icon_state = "barrelmelon"
