/* Morbid Mood Events -
Any mood events related to TRAIT_MORBID.
Ususally this is an inverse of a typically good, alturistic action (such as saving someones life), punishing it with a negative mood event,
and rewards typically antisocial/unsavory actions (such as graverobbing) with a positive mood event.
Intended to push a creepy, mad scientist/doctor vibe, or someone who is downright monstrous in nature.
*/

// Positive Events - We did something unsavory in the name of mad science

/datum/mood_event/morbid_dismemberment
	description = "没什么比干净利落地肢解更让人满足了！"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/morbid_dissection_success
	description = "我为自己的手艺感到骄傲。论解剖尸体，没人能比得上我。"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/morbid_abominable_surgery_success
	description = "就算毕加索亲自执笔，也难以画出能媲美我刀下作品的杰作。"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/morbid_revival_success
	description = "它活了！啊哈哈哈哈！！"
	mood_change = 6
	timeout = 8 MINUTES

/datum/mood_event/morbid_graverobbing
	description = "死人用不着财物。可我还活得好好的，而且非常需要这些东西。"
	mood_change = 2
	timeout = 2 MINUTES

/datum/mood_event/morbid_hauntium
	description = "我觉得自己与灵魂的联系更紧密了，真棒！"
	mood_change = 3
	timeout = 6 MINUTES

/datum/mood_event/morbid_aquarium_good
	description = "嘿嘿，鱼儿们全都睡着了……"
	mood_change = 3
	timeout = 90 SECONDS

// Negative Events - We helped someone stay alive.

/datum/mood_event/morbid_tend_wounds
	description = "我为什么要把才华浪费在这种无聊小事上？照料那些喘气的家伙纯属白费力气。"
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/morbid_saved_life
	description = "比起救下这条毫无用处的性命，我本可以用那具尸体做更多的事。真糟糕。"
	mood_change = -6
	timeout = 2 MINUTES

/datum/mood_event/morbid_aquarium_bad
	description = "看着鱼缸里的鱼真没劲。"
	mood_change = -3
	timeout = 90 SECONDS
