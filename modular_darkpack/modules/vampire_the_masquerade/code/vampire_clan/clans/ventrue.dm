/datum/subsplat/vampire_clan/ventrue
	name = "Ventrue"
	id = VAMPIRE_CLAN_VENTRUE
	desc = "梵卓被称为王者氏族，绝非浪得虚名。他们从熟悉权力、财富与影响力的凡人中精挑子嗣，自视为吸血鬼世界的贵族。成员应尽可能掌握领导权，也愿为身先士卒而承受风浪。梵卓中的贵族、高管与统治者，在许多城市居于密党权力中心。梵卓长老常以亲王身份执掌统治权，氏族因此在当地政坛享有威望与影响。梵卓相信领导既是权利，也是责任，尽管旁人常视他们为傲慢、迷恋控制的精英主义者。多数梵卓满怀骄傲，能将自己的初拥传承追溯至氏族始祖。诅咒使他们只能从极为特定的猎物身上取食。"
	icon = "ventrue"
	curse = "低阶者与动物的血液令人作呕。"
	roleplay_level = "Intermediate"
	sense_the_sin_text = "无法从穷人的鲜血中获得愉悦。"
	clan_disciplines = list(
		/datum/discipline/dominate,
		/datum/discipline/fortitude,
		/datum/discipline/presence
	)
	subsplat_traits = list(
		TRAIT_FEEDING_RESTRICTION
	)
	male_clothes = /obj/item/clothing/under/vampire/ventrue
	female_clothes = /obj/item/clothing/under/vampire/ventrue/female
	subsplat_keys = /obj/item/vamp/keys/ventrue

/datum/subsplat/vampire_clan/ventrue/antitribu
	name = "Ventrue antitribu"
	id = VAMPIRE_CLAN_VENTRUE_ANTITRIBU
	desc = "传统梵卓血脉以密党那些“宽宏大量”的贵族著称，他们借助避世戒律、复杂的血仆与代理人网络维持对人类的统治，效忠上古者及自身血祖。梵卓逆族则是魔宴同盟的黑暗骑士与十字军，誓与软弱的密党为敌。在他们看来，密党只会凭借软性影响力统治，为第三世代效劳，而这些血族早已背叛了全体吸血鬼的黑暗之父该隐。"
	icon = "ventrue_antitribu"
	roleplay_level = "Advanced"
	clan_disciplines = list(
		/datum/discipline/dominate,
		/datum/discipline/fortitude,
		/datum/discipline/auspex
	)
