//nutrition
/datum/mood_event/fat
	description = "<B>我好胖……</B>" //muh fatshaming
	mood_change = -6

/datum/mood_event/too_wellfed
	description = "我好像吃得太多了。"
	mood_change = 0

/datum/mood_event/wellfed
	description = "我吃得饱饱的！"
	mood_change = 8

/datum/mood_event/fed
	description = "我刚吃过些东西。"
	mood_change = 5

/datum/mood_event/hungry
	description = "我有点饿了。"
	mood_change = -3

/datum/mood_event/hungry_very
	description = "我饿了！"
	mood_change = -6

/datum/mood_event/starving
	description = "我快饿死了！"
	mood_change = -10

//charge
/datum/mood_event/supercharged
	description = "我体内容不下这么多电能了，得赶快释放一些！"
	mood_change = -10

/datum/mood_event/overcharged
	description = "我的电量高得很危险，也许该释放一些电能了。"
	mood_change = -4

/datum/mood_event/charged
	description = "我能感到电能在血管里流淌！"
	mood_change = 6

/datum/mood_event/lowpower
	description = "我的电量不足了，应该找个地方充电。"
	mood_change = -6

/datum/mood_event/decharged
	description = "我急需补充电能！"
	mood_change = -10

//Disgust
/datum/mood_event/gross
	description = "我看到了恶心的东西。"
	mood_change = -4

/datum/mood_event/verygross
	description = "我好像要吐了……"
	mood_change = -6

/datum/mood_event/disgusted
	description = "神明啊，真恶心……"
	mood_change = -8

/datum/mood_event/disgust/bad_smell
	description = "我闻到这房间里有东西腐烂得臭不可闻。"
	mood_change = -6

/datum/mood_event/disgust/nauseating_stench
	description = "腐尸的恶臭简直让人无法忍受！"
	mood_change = -12

/datum/mood_event/disgust/dirty_food
	description = "那东西脏得根本不能吃……"
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/disgust/dirty_food/add_effects(...)
	if(HAS_PERSONALITY(owner, /datum/personality/ascetic))
		mood_change *= 0.25
		description = "那食物虽然脏，但还能吃。"
	if(HAS_PERSONALITY(owner, /datum/personality/gourmand))
		mood_change *= 1.5
		description = "那食物脏透了，难道是在垃圾箱里做的吗？！"

//Generic needs events
/datum/mood_event/shower
	description = "我刚舒舒服服地冲了个澡。"
	mood_change = 4
	timeout = 5 MINUTES

/datum/mood_event/shower/add_effects(shower_reagent)
	if(istype(shower_reagent, /datum/reagent/blood))
		if(HAS_TRAIT(owner, TRAIT_MORBID) || HAS_TRAIT(owner, TRAIT_EVIL) || (owner.mob_biotypes & MOB_UNDEAD))
			description = "美妙的鲜血淋浴让我感觉真好。"
			mood_change = 6 // you sicko
		else
			description = "我刚冲了个可怕的澡，淋下来的全是血！"
			mood_change = -4
			timeout = 3 MINUTES
	else if(istype(shower_reagent, /datum/reagent/water))
		if(HAS_TRAIT(owner, TRAIT_WATER_HATER) && !HAS_TRAIT(owner, TRAIT_WATER_ADAPTATION))
			description = "我讨厌浑身湿漉漉的！"
			mood_change = -2
			timeout = 3 MINUTES
		else
			return // just normal clean shower
	else // it's dirty ass water
		description = "我刚用脏水冲了个澡！"
		mood_change = -3
		timeout = 3 MINUTES

/datum/mood_event/hot_spring
	description = "泡在热气腾腾的水里真让人放松……"
	mood_change = 5

/datum/mood_event/hot_spring_hater
	description = "不不不不，我不想泡澡！"
	mood_change = -2

/datum/mood_event/hot_spring_left
	description = "刚才那个澡泡得真舒服。"
	mood_change = 4
	timeout = 4 MINUTES

/datum/mood_event/hot_spring_hater_left
	description = "我讨厌泡澡！更讨厌一出来就冷得要命！"
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/fresh_laundry
	description = "没什么比穿上刚洗好的连体服更舒服了。"
	mood_change = 2
	timeout = 10 MINUTES

/datum/mood_event/surrounded_by_silicon
	description = "我身边全是完美的生命体！！"
	mood_change = 8

/datum/mood_event/around_many_silicon
	description = "我身边有好多硅基生命！"
	mood_change = 4

/datum/mood_event/around_silicon
	description = "我身边的硅基生命简直完美无缺。"
	mood_change = 2

/datum/mood_event/around_organic
	description = "身边的有机生命让我再次意识到血肉之躯的低劣。"
	mood_change = -2

/datum/mood_event/around_many_organic
	description = "好多恶心的有机生命！"
	mood_change = -4

/datum/mood_event/surrounded_by_organic
	description = "我身边全是恶心的有机生命！！"
	mood_change = -8

/datum/mood_event/completely_robotic
	description = "我抛弃了孱弱的血肉之躯，如今的躯体完美无缺！！"
	mood_change = 8

/datum/mood_event/very_robotic
	description = "我的机械部分已经比血肉更多了！"
	mood_change = 4

/datum/mood_event/balanced_robotic
	description = "我的身体一部分是机械，一部分是血肉。"
	mood_change = 0

/datum/mood_event/very_organic
	description = "我讨厌这孱弱无力的血肉之躯！"
	mood_change = -4

/datum/mood_event/completely_organic
	description = "我浑身上下都是血肉，真是悲惨！！"
	mood_change = -8
