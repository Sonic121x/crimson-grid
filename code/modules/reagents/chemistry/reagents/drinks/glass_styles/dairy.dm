// Dairy

/datum/glass_style/has_foodtype/drinking_glass/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "杯装牛奶"
	desc = "洁白营养的好东西！"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/milk
	required_drink_type = /datum/reagent/consumable/milk
	name = "盒装牛奶"
	desc = "为成长中的太空探险家提供优质钙质。"
	icon_state = "milkbox"
	drink_type = DAIRY | BREAKFAST

/datum/glass_style/has_foodtype/juicebox/chocolate_milk
	required_drink_type = /datum/reagent/consumable/milk/chocolate_milk
	name = "盒装巧克力奶"
	desc = "酷孩子喝的牛奶！"
	icon_state = "chocolatebox"
	drink_type = SUGAR | DAIRY

/datum/glass_style/drinking_glass/soymilk
	required_drink_type = /datum/reagent/consumable/soymilk
	name = "杯装豆奶"
	desc = "洁白营养的大豆精华！"

/datum/glass_style/drinking_glass/cream
	required_drink_type = /datum/reagent/consumable/cream
	name = "杯装奶油"
	desc = "呕……"

/datum/glass_style/drinking_glass/coconut_milk
	required_drink_type = /datum/reagent/consumable/coconut_milk
	name = "杯装椰奶"
	desc = "热带的精华，安稳地盛在杯中。"
	icon = 'icons/obj/drinks/drinks.dmi'
