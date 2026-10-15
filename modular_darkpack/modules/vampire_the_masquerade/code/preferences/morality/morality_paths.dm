GLOBAL_LIST_INIT(morality_paths, init_morality_paths())

/proc/init_morality_paths()
	var/list/paths = list()
	for(var/morality_type in subtypesof(/datum/morality))
		var/datum/morality/M = new morality_type()
		paths[initial(M.name)] = M
	return paths

/datum/morality
	var/name = ""
	var/desc = ""
	/// Humanity or Enlightenment
	var/alignment
	/// The bearing of the path's ethos
	var/bearing

/datum/morality/proc/show_lore(mob/user)
	to_chat(user, span_notice("[GLOB.preference_entries[/datum/preference/choiced/vtm_morality]:compile_constant_data()["display_names"][name] || name]<br><br>[alignment == MORALITY_HUMANITY ? "使用自制与良知" : "使用本能与信念"] <br> <br>所有血族都遵循某种道途，借此调和体内超自然的心兽与生前残存的意识。心兽只渴求野兽般的杀戮与鲜血盛宴。大多数不属于魔宴同盟的血族都遵循人性之道。血族若背离自身道途，就可能沦为失心兽，彻底屈从于内在的心兽，成为漫无目的游荡、毫无理智的野兽。 <br> <br>[desc]<br>")) // KUKU：沿用道途中文名称映射，翻译聊天介绍中的美德及共用说明，保留换行标签与正文插值

/datum/morality/humanity
	name = "Path of Humanity"
	desc = "人性之道是血族中最普遍的道途，也是密党唯一认可的道途。它主张，抵抗心兽的唯一方式就是坚守凡人生活的价值观与本性。正如避世戒律致力于向凡人社会隐瞒血族的存在，人性之道通过否定吸血本性及其最黑暗的欲望来压制心兽，因此避世戒律与人性相辅相成。与大多数道途不同，人性具有诸多益处，其中之一就是影响血族在他人眼中有多像人类。选择启迪道途或远离人性的角色可能从不呼吸或眨眼，也可能发出野兽般的低吼，或显露深陷的眼窝。不要误会：遵循人性之道的血族并非圣人。血族天生就是捕食者，遵循这条道途并不会改变这一点。大多数凡人也遵循这条道途，但讽刺的是，人性极高的血族可能比大多数凡人更像人类。偏离人性之道极其危险，需要极低的人性和一位导师；你的角色也将永远舍弃那些曾使自己成为人类的残存行为、信仰、外貌与道德。" // KUKU：翻译人性之道的理念、外在表现及改换道途的背景说明
	alignment = MORALITY_HUMANITY
	bearing = BEARING_MUNDANE

/datum/morality/power
	name = "Path of Power and the Inner Voice"
	desc = "权力与心声之道是一条启迪道途，修习者凭借坚定的决心与世俗权力的积累来控制心兽。他们被称为统一者。" // KUKU：翻译权力与心声之道的理念及追随者称谓
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_COMMAND

/datum/morality/heaven
	name = "Path of Heaven"
	desc = "天堂之道的追随者试图通过虔诚的宗教信仰控制心兽。他们常被称为虔信者。" // KUKU：翻译天堂之道的信仰方式及追随者称谓
	alignment = MORALITY_HUMANITY
	bearing = BEARING_HOLINESS

/datum/morality/metamorphosis
	name = "Path of Metamorphosis"
	desc = "蜕变之道是一条启迪道途，通过研究心兽的极限以及血族存在本身的极限来控制心兽。它由更古老的蜕变之路演变而来，主要由茨密希氏族修习。" // KUKU：翻译蜕变之道的理念与传承，沿用茨密希氏族译名
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_INHUMANITY

/datum/morality/assamite
	name = "Path of Blood"
	desc = "鲜血之道是一条几乎仅在哈基姆之裔中流传的启迪道途。其追随者以对始祖事业严苛而坚定的奉献来对抗心兽，被称为苦修者。" // KUKU：翻译鲜血之道的理念与称谓，沿用哈基姆之裔译名
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_RESOLVE

/datum/morality/hive
	name = "Path of the Hive"
	desc = "蜂巢之道又称蜂巢之路，是一条几乎仅由巴力氏族遵循的小众道途。其追随者被称为阿贝林信徒。" // KUKU：翻译蜂巢之道的别称与追随者，沿用巴力氏族译名
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_JUSTICE

/datum/morality/kings
	name = "Road of Kings"
	desc = "诸王之路的追随者通过统治他人来控制心兽。他们认为凡人低人一等，承诺必须兑现，权力就是一切。遵循诸王之路的人被称为王裔。" // KUKU：翻译诸王之路的统治理念及追随者称谓
	alignment = MORALITY_HUMANITY
	bearing = BEARING_COMMAND

/datum/morality/heart
	name = "Path of the Scorched Heart"
	desc = "焦心之道原名拉斯莫尼库斯之道，是一条源自真布鲁赫的古老启迪道途。它以拉斯莫尼库斯所著的《空心之书》为基础，最初流传于天主教会中的少数血族之间，后来由真黑手重新搜集并编纂其经文。焦心之道通过有系统地根除血族心中的一切情感来控制心兽，尤其受到本就淡泊情感的真布鲁赫青睐。其追随者被称为不赦者。" // KUKU：翻译焦心之道的起源、典籍与修行方式，沿用真布鲁赫译名
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_INTELLECT

/datum/morality/typhon
	name = "Path of Typhon"
	desc = "堤丰之道是一条大量借鉴瑟泰信徒教义及其上古者崇拜的启迪道途。其追随者被称为神蛇信徒或堤丰信徒，外人则称他们为腐化者。" // KUKU：翻译堤丰之道的宗教背景与称谓，沿用瑟泰和上古者术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_DEVOTION

/datum/morality/typhon/ecstasy
	name = "Path of Ecstasy"
	desc = "极乐之道与瑟泰教义的一个分支密切相关，认为沉醉于狂喜本身就是神圣之举。极乐信徒用享乐喂饱心兽，使其肥胖而懒惰。他们与堤丰信徒的区别在于，他们着重追求的是享乐，而非腐化本身。" // KUKU：翻译极乐之道的修行方式及其与堤丰之道的区别
	bearing = BEARING_RAPTURE

/datum/morality/typhon/warrior
	name = "Path of the Warrior"
	desc = "遵循战士之道的瑟泰信徒不在暗中散播腐化，而是以战士的身份践行他们心目中的瑟泰理想。他们将自身的狂热与受虐视为神圣之举，在战斗中展现武勇，力求连心兽本身也为之震慑。" // KUKU：翻译战士之道对瑟泰信仰和战斗修行的说明
	bearing = BEARING_FURY

/datum/morality/bones
	name = "Path of the Bones"
	desc = "骸骨之道是一条通过研究死亡的真实本质及其与其他存在状态之间的关系来压制心兽的启迪道途，其追随者被戏称为掘墓人。他们是研究死亡及迈入死亡这一过程的学者，以自身带来的知识推动死灵术与死亡学研究，而非追求与死者交往所能获得的政治或实际利益。这条道途有时被讥讽为赞颂肆意杀戮，但掘墓人的好奇心只是凌驾于他们对生命的关切之上。他们接触的各种凡俗生命都可能沦为这种阴森好奇心的牺牲品，因此他们很少与凡人来往，性情也往往十分内向、寡言。" // KUKU：翻译骸骨之道的研究理念与行为倾向，沿用死灵术术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_SILENCE

/datum/morality/bones/death
	name = "Path of Death and the Soul"
	desc = "死亡与灵魂之道常被认为源于骸骨之道：说得好听是受到启发，说得难听就是照搬。两者有许多相同的信条，但这条道途更常见于魔宴同盟。其追随者声称两者本质不同，外人却始终看不出这些差别。" // KUKU：翻译死亡与灵魂之道与骸骨之道的关系及派系背景

/datum/morality/night
	name = "Path of Night"
	desc = "黑夜之道的追随者承认，初拥已使他们遭受永罚，而他们绝不会独自沉沦。这条道途主要流传于年轻的勒森布拉之间，其目的很简单：成为邪恶的使者，践行自身罪恶的本性。" // KUKU：翻译黑夜之道的理念，沿用初拥与勒森布拉术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_DARKNESS

/datum/morality/night/road
	name = "Road of Night"
	desc = "黑夜之路的追随者被称为救赎者。他们比天堂之道的追随者更深切地感受到该隐诅咒与自身永罚的沉重。与虔信者一样，救赎者寻求救赎与宽恕，并认为必须通过苦难与净化才能获得它们。然而，他们不采用虔信者相对温和的方式，而是主动行走于凡人世界，惩罚并杀死有罪的凡人。一些黑夜之路的追随者允许犯下轻罪的人通过苦修赎罪，另一些则会初拥无可救药的凡人，借此帮助他们承受惩罚。他们也会猎杀引诱凡人堕落的该隐后裔，尤其是瑟泰信徒与巴力。" // KUKU：翻译黑夜之路的救赎理念、惩戒方式及敌对目标
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_GUILT

/datum/morality/honor
	name = "Path of Honorable Accord"
	desc = "荣誉盟约之道是一条通过严格践行荣誉与骑士精神来驾驭心兽的启迪道途。这些血族以忠于所属团体、领袖及盟友，以及坚定恪守自己的言辞与承诺而闻名，将责任置于一切之上。其追随者被称为骑士、爱国者或教规信徒。不要误会：遵循这条道途的血族绝不意味着仁慈或有人性。他们仍将人类视为财产或食物，认为人类不配享有他们给予其他血族的荣誉礼遇。" // KUKU：翻译荣誉盟约之道的责任观与行为准则，不改变原有阵营参数
	alignment = MORALITY_HUMANITY
	bearing = BEARING_DEVOTION

/datum/morality/beast
	name = "Path of the Feral Heart"
	desc = "野性之心之道有时也被称为心兽之道，是一条尤其受到冈格罗氏族成员推崇的启迪道途。其修习者将心兽的冲动视为自然的一部分，并接受自己作为众多猎手之一的身份，借此控制心兽。他们被称为兽性者或野兽。" // KUKU：翻译野性之心之道的理念与别称，沿用心兽和冈格罗术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_MENACE

/datum/morality/beast/harmony
	name = "Path of Harmony"
	desc = "和谐之道与野性之心之道相似，常被视为后者更古老的变体。和谐信徒同样认同自己作为捕食者的身份，但也更重视自身在自然世界中的位置，往往保有更多良知。" // KUKU：翻译和谐之道与野性之心之道的关系，沿用良知术语

/datum/morality/samiel
	name = "Code of Samiel"
	desc = "萨米尔法典将萨鲁布里战士与惩戒之道的信条整理为正式教义，由索洛特最杰出的战士子嗣萨米尔亲自制定。其追随者誓言惩戒一切邪恶，尤其是炼狱信徒、恶魔和瑟泰信徒。复仇、警觉与正义是他们的核心美德。" // KUKU：翻译萨米尔法典的起源与美德，沿用索洛特及氏族宗教术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_JUSTICE //I have no idea what this actually does

/datum/morality/caine
	name = "Path of Caine"
	desc = "该隐之道的追随者通常被称为挪得信徒。他们是致力于研究血族存在本质的该隐后裔，尤其注重效仿该隐并研习《挪得之书》的教诲。追随者誓言通过学习与反思，发掘身为血族的真正含义，并接纳、实现这种存在的终极形态。他们往往是博学或善于自省的血族，以自律和严谨见长。挪得信徒誓言抛弃已经失落的人性，接纳自身的新存在，在一切事情上效仿该隐，并通过血噬夺取不配者的血粹，以求更接近黑暗之父。这条道途视以下行为为罪：与凡人交好或共存；屈从于狂乱或恐惧狂乱；未对保有人性的血族实施血噬；不学习或研究血族的本质；以及拒绝进食或心生怜悯，从而否认血族的天性需求。" // KUKU：翻译该隐之道的完整介绍及罪行列表，沿用挪得、血噬、血粹和恐惧狂乱术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_FAITH

/datum/morality/cathari
	name = "Path of Cathari"
	desc = "清洁派之道的追随者通常被称为阿尔比派信徒，其血族伦理源自黑暗时代被天主教会视为异端的清洁派。清洁派主张，世界由两位地位相等的造物主共同创造：善的光明造物主掌管美德与精神，恶的黑暗造物主掌管物质世界及其一切罪恶。遵循这条道途的血族认为，受吸血诅咒者因不死之身而无法在来世获得永恒的灵魂安宁，因此他们存在的本质就是以物质世界的种种诱惑引诱他人，取悦黑暗造物主。从某种意义上说，他们是在堕落中寻求灵性。这条道途视以下行为为罪：表现克制、信任他人、谋杀、为了方便他人而牺牲自己的满足、拒绝放纵，或劝他人克制。" // KUKU：翻译清洁派之道的教义背景与罪行列表，保留原文价值观
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_SEDUCTION // add this

/datum/morality/lilith
	name = "Path of Lilith"
	desc = "莉莉丝之道的追随者常被称为巴哈里或莉琳，是研习莉莉丝教诲的血族。大多数魔宴同盟的该隐后裔视他们为异端。巴哈里践行莉莉丝亲自传下的古老教法，相信痛楚、磨难与苦难是通往学习和真正成长的唯一道路。他们认为，唯有经历苦难，体验造物及其感受的极限，才能获得领悟；对于缺乏见识或意志、不愿踏上这段旅程的人，他们鲜有怜悯。这条道途视以下行为为罪：饥饿时立即进食；追逐财富或权力；不纠正他人对该隐与莉莉丝故事的误解；因他人受苦而懊悔；畏惧死亡；谋杀；不施予痛楚与折磨；以及逃避痛苦。" // KUKU：翻译莉莉丝之道的传承、苦难观与罪行列表
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_TRIBULATION // add this

/datum/morality/lilith/seed
	name = "Path of the Serpent's Seed"
	desc = "蛇种之道是巴哈里信仰的一个分支，其追随者倾向于采用温和得多的手段。他们虽意图击败该隐，却不打算诉诸毁灭，而更愿意从内部瓦解挪得信徒，埋葬该隐的传承。" // KUKU：翻译蛇种之道的信仰分支与行动方式

/datum/morality/lilith/midwives
	name = "Path of the Red Midwives"
	desc = "赤红助产士之道是巴哈里信仰的一个分支，将诞生与创造视为自身的艺术。在他们眼中，身边那些非人而可怖的生物，以及刚刚接受初拥的新生者，都值得赞叹，并应得到帮助，去寻觅这世间的力量。" // KUKU：翻译赤红助产士之道对诞生、创造和新生血族的看法

/datum/morality/lilith/thorn
	name = "Path of the Thorn Garden"
	desc = "荆棘花园之道是巴哈里信仰的一个分支，其追随者怀有更强烈的正义感。他们将复仇置于一旁，转而追求准则与律法的贯彻，对违背者施以格外严厉的惩罚。" // KUKU：翻译荆棘花园之道的正义观与惩戒原则

/datum/morality/lilith/witches
	name = "Path of the Lilin Witches"
	desc = "莉琳女巫之道是巴哈里信仰的一个分支。女巫们追寻黑暗之母的诡秘知识，保护同道信徒，甚至致力于在凡人中培植崇敬她的女神教派。" // KUKU：翻译莉琳女巫之道的求知与传教理念，沿用黑暗之母译名

/datum/morality/redemption
	name = "Path of Redemption"
	desc = "神有成千上万种称呼：耶稣、雅威、安拉、阿胡拉·马兹达。但有一点是确定的：血族身负不死之躯与神的诅咒，曾见证大洪水、生活在第一城，因此知道神确实存在。救赎之道的追随者因而极度虔诚地坚守信仰与教义，将诅咒视为证据，相信自己在接受仁慈造物主审判之日仍有获得救赎的机会。血族确实被天堂放逐，但这一切会不会只是考验？这些通常被称为殉道者的追随者，试图通过为他人牺牲自己来获得救赎，摆脱心兽自私而兽性的牵引，再次使自己配得上所信奉之神的宽恕。然而，神并不要求完美。他们接纳神圣潮汐，也就是罪、宽恕与重生的自然循环。追随者通常还应聆听同道的忏悔，并向同道忏悔。遵循这条道途的血族并非圣人；事实上，他们承认罪是神圣潮汐中一种不幸而循环往复的命运，只盼有朝一日能以伟大而最终的殉道之举超越它，获得救赎。这条道途视以下行为为罪：不遵守自身宗教的准则；将肉体需求置于精神需求之上；拒绝给予他人救赎的机会；拒绝聆听或作出忏悔；放任色欲、暴食、愤怒、傲慢等重罪不受惩罚；以及杀害无辜。此道途鄙弃血魔法。" // KUKU：翻译救赎之道的完整宗教背景、修行要求及罪行列表
	alignment = MORALITY_HUMANITY
	bearing = BEARING_FAITH

/datum/morality/revelation
	name = "Path of Evil Revelations"
	desc = "恶魔，即堕落天使，是神最早的子嗣，早在人类被泥土塑成、该隐诞生之前就已存在。最初的反叛者路西法要求神解释其在阴影中创造的禁忌造物——邪壳。神不仅拒绝回答，还将他及其盟友永远逐出天堂，因为一旦向路西法解释这些造物的本质，就会暴露神其实是个愚者：一位偏爱某些子嗣、不公而暴虐的父亲。这桩凡人无法理解的巨大不公，将在路西法完成叛乱时得到纠正。他的恶魔大军数量超过天使，待僭位者被驱逐，造物便会重归正轨。因此，遵循邪恶启示之道的血族被称为炼狱信徒，他们服从恶魔，并自称恶魔的盟友，认为双方都被天堂放逐、游离于自然秩序之外，生来就该结盟；毕竟，血族猎食的是神的子嗣——人类。这条道途不只是接纳内心的邪恶，许多其他道途也能做到这一点。遵循它意味着投身一场比人类、比血族、甚至比造物本身更古老的战争，侍奉一种深不可测的邪恶。这条道途视以下行为为罪：遵守任何法律；不履行炼狱仪式；利他行为；有机会时不攫取权力；表现私心；拒绝支持炼狱暴行；不侍奉自己的庇护恶魔；以及让自己被神的仆从击败或算计。" // KUKU：翻译邪恶启示之道的神话叙述与罪行列表，沿用炼狱信徒术语
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_CORRUPTION

/datum/morality/entelechy
	name = "Path of Entelechy"
	desc = "圆成之道由欧洲的布鲁赫发展而来，强调理性。它认为，人性之道着重否认并压制心兽，这种被动做法永远不够；必须以严谨、自律的理性修养主动对抗心兽。这些品质曾是布鲁赫氏族的根本，他们希望借助这条道途及其追随者，重夺自己在血族中应有的战士亲王地位。此道途有三项核心原则：内在力量、勇气与自我控制。它要求严格、勤勉不懈，是一场与心兽永无止境的战斗，而人性只是拒斥心兽。这条道途视以下行为为罪：思虑含混或懒于思考；冲动行事；偷窃、抢劫、破坏公物等轻罪；故意伤害任何凡人；强行吸食无辜者的鲜血；屈从于心兽；放任罪行不受惩罚；杀害无辜；或帮助遵循其他道途的人。绝不怯懦，绝不轻视凡人。进食只为生存，不可贪多。投身严谨的学习与反思，你终将驾驭心兽。这条道途极为罕见，绝大多数追随者都是布鲁赫长老。在自由邦与新约官府对抗之际，他们因不满氏族的堕落，再次传播此道途。" // KUKU：翻译圆成之道的理性原则、禁忌与背景，沿用布鲁赫和心兽术语
	alignment = MORALITY_HUMANITY
	bearing = BEARING_RESOLVE

/datum/morality/ashirra
	name = "Sharia El-Sama"
	desc = "公元623年，一名叫苏莱曼·伊本·阿卜杜拉的该隐后裔来到麦地那，企图猎食先知穆罕默德。苏莱曼请求觐见先知，获准后却被这位神使的神圣所震撼，不由得俯身拜伏。苏莱曼·伊本·阿卜杜拉由此成为阿希拉兄弟会的第一位成员；这些血族誓言遵守神最后、最伟大的先知所阐明的神圣律法。通过这种方式，内在的恶魔——心兽——便能沉寂，血族也能借祈祷与不可动摇的信仰寻求神的宽恕。天国律法视以下行为为罪：不在每夜遵行伊斯兰五功；不传播伊斯兰信仰；有需要时不行善施舍；初拥不信者；奴役他人；背弃誓言；以及谋杀。不要吸食不信者的鲜血，最好以动物为食。不要初拥不信者，也不要在未经同意的情况下初拥信徒。血缚即奴役，只可用于不信者；若他们表现出对神真正的虔诚，便可予以释放。凡事遵从神，内在的心兽终将被净除。此道途的追随者鄙弃血魔法，并完全禁止蛇形术、恶魔术和塑形术。" // KUKU：翻译天国律法的传说、戒律与律能限制，保留原文规则和年代
	alignment = MORALITY_HUMANITY
	bearing = BEARING_FAITH

/datum/morality/paradox
	name = "Path of Paradox"
	desc = "悖论之道以血族所负的因果责任为核心。其追随者认为，血族逃脱了生死轮回，因此负有必须履行的本分：推动宇宙的循环。这主要意味着找出其他血族在循环中应扮演的角色，或将其消灭，使其重返轮回。" // KUKU：翻译悖论之道的因果责任与轮回观
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_CONFIDENCE

/datum/morality/self_focus
	name = "Path of Self-Focus"
	desc = "自省之道的内省者将无为与接纳视为准则。他们不纠结于事物的本来面目，也不忧虑未来，只关注当下。他们在需要时进食、杀戮，却被大多数人认为迟缓而被动。较为善意的旁观者则会称他们敏锐而善于自省。" // KUKU：翻译自省之道的行为准则及外界评价
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_BALANCE

/datum/morality/asakku
	name = "Path of Asakku"
	desc = "阿萨库之道的追随者常被称为腐化者。与其说这是一套思想体系，不如说它是一种存在状态，源于对塑形术的痴迷研究，以及与其背后黑暗意识的交流。作为一条依靠直觉的道途，腐化者通常要共事一段时间后才会使用共同的术语，不过修为高深的追随者有时会展现出诡异的同步性。他们可能将召唤出的存在称为内在之影或观察者，也可能认同某个与塑形术相关的邪壳恶魔。塑形术是腐化者痴迷的核心，他们通过血液与传授，尽可能广泛地传播这种力量。他们憎恨那些未经污染、却通过氏族或血系继承塑形术的血族，尤其热衷于转化或毁灭他们。" // KUKU：翻译阿萨库之道的完整背景与传播方式，沿用塑形术译名
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_OTHERWORLDLY
