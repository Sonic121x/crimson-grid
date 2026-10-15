/datum/mood_event/high
	mood_change = 6
	description = "哇——兄弟——我嗨得天旋地转了……"

/datum/mood_event/stoned
	mood_change = 6
	description = "我嗨——翻——天——了……"

/datum/mood_event/maintenance_high
	mood_change = 6
	description = "宝贝，老子天下无敌！灰潮席卷世界！"
	timeout = 2 MINUTES

/datum/mood_event/maintenance_high/add_effects(param)
	var/value = rand(-1, 6) // chance for it to suck
	mood_change = value
	if(value < 0)
		description = "不！别这样！我的手套！啊——！"
	else
		description = initial(description)

/datum/mood_event/hang_over
	mood_change = -4
	description = "宿醉简直要了我的命！"
	timeout = 1 MINUTES

/datum/mood_event/smoked
	description = "我刚抽过烟。"
	mood_change = 2
	timeout = 6 MINUTES

/datum/mood_event/wrong_brand
	description = "我讨厌那个牌子的香烟。"
	mood_change = -2
	timeout = 6 MINUTES

/datum/mood_event/overdose
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/overdose/add_effects(drug_name)
	description = "我好像摄入了太多[drug_name]！"

/datum/mood_event/withdrawal_light
	mood_change = -2

/datum/mood_event/withdrawal_light/add_effects(drug_name)
	description = "我想来点[drug_name]……"

/datum/mood_event/withdrawal_medium
	mood_change = -5

/datum/mood_event/withdrawal_medium/add_effects(drug_name)
	description = "我真的很需要[drug_name]。"

/datum/mood_event/withdrawal_severe
	mood_change = -8

/datum/mood_event/withdrawal_severe/add_effects(drug_name)
	description = "神明啊，我需要[drug_name]！"

/datum/mood_event/happiness_drug
	description = "什么都感觉不到了……"
	mood_change = 50

/datum/mood_event/happiness_drug_good_od
	description = "好！好！！好！！！"
	mood_change = 100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_good"

/datum/mood_event/happiness_drug_bad_od
	description = "不！不！！不！！！"
	mood_change = -100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_bad"

/datum/mood_event/narcotic_medium
	description = "这麻木的感觉真舒服。"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/narcotic_heavy
	description = "我感觉自己像被裹在棉花里！"
	mood_change = 9
	timeout = 3 MINUTES

/datum/mood_event/antinarcotic_medium
	description = "真希望我能再次麻木起来！"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/antinarcotic_heavy
	description = "不！！把棉花还给我！"
	mood_change = -9
	timeout = 3 MINUTES

/datum/mood_event/stimulant_medium
	description = "我精力充沛！感觉什么都能做到！"
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/stimulant_heavy
	description = "呃，啊，啊——！哈哈哈哈哈！呃……"
	mood_change = 6
	timeout = 3 MINUTES

#define EIGENTRIP_MOOD_RANGE 10

/datum/mood_event/eigentrip
	description = "我和另一个现实中的自己交换了位置！"
	mood_change = 0
	timeout = 10 MINUTES

/datum/mood_event/eigentrip/add_effects(param)
	var/value = rand(-EIGENTRIP_MOOD_RANGE,EIGENTRIP_MOOD_RANGE)
	mood_change = value
	if(value < 0)
		description = "我和另一个现实中的自己交换了位置！我想回家！"
	else
		description = "我和另一个现实中的自己交换了位置！不过，这里比我原来的生活好多了。"

#undef EIGENTRIP_MOOD_RANGE

/datum/mood_event/nicotine_withdrawal_moderate
	description = "有一阵子没抽烟了，感觉有点焦躁……"
	mood_change = -5

/datum/mood_event/nicotine_withdrawal_severe
	description = "头痛欲裂，冷汗直冒，焦躁不安。得抽根烟冷静一下！"
	mood_change = -8

/datum/mood_event/hauntium_spirits
	description = "我感觉自己的灵魂正在衰败！"
	mood_change = -8
	timeout = 8 MINUTES

/datum/mood_event/sadness_inverse
	description = "我好难过啊……"
	mood_change = -150
	special_screen_obj = "mood_happiness_bad"
