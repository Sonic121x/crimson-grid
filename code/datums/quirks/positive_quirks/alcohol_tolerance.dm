/datum/quirk/alcohol_tolerance
	name = "Alcohol Tolerance"
	desc = "你更不容易喝醉，受到酒精的负面影响也更少。"
	icon = FA_ICON_BEER
	value = 4
	mob_trait = TRAIT_ALCOHOL_TOLERANCE
	gain_text = span_notice("你觉得自己能喝下一整桶酒！")
	lose_text = span_danger("不知为何，你感觉自己的酒量没那么好了。")
	medical_record_text = "患者对酒精的耐受程度较高。"
	mail_goodies = list(/obj/item/skillchip/wine_taster)
