GLOBAL_LIST_INIT(localized_food_tastes, list("chicken" = "鸡肉", "italy" = "意大利风味", "meat" = "肉", "cheese" = "奶酪", "lettuce" = "生菜", "extra italy" = "浓郁的意大利风味", "a wish that the sandwich had anything in it" = "盼着三明治里能有点馅料的心愿", "vanilla" = "香草", "ice cream" = "冰淇淋", "chocolate" = "巧克力", "berry" = "浆果", "broth" = "高汤", "noodles" = "面条", "carrots" = "胡萝卜", "pork" = "猪肉", "onions" = "洋葱", "dough" = "面团", "blood sweet" = "血的甘甜", "tortilla" = "墨西哥薄饼", "torilla" = "墨西哥薄饼", "beans" = "豆子", "hot peppers" = "辣椒", "nachos" = "玉米脆片", "hot pepper" = "辣椒", "taco" = "塔可", "fish" = "鱼肉", "cabbage" = "卷心菜", "sour cream" = "酸奶油", "death" = "死亡", "rock" = "岩石", "peppers" = "辣椒", "salsa" = "莎莎酱", "tortilla chips" = "玉米片", "onion" = "洋葱", "deep-fried tortilla" = "油炸薄饼", "hard corn tortilla" = "硬玉米饼", "crunchy taco shell" = "酥脆的塔可饼壳", "tomatoes" = "番茄", "ground meat" = "肉糜", "mashed beans" = "豆泥", "zesty rice" = "风味米饭", "tomato sauce" = "番茄酱汁", "pineapple" = "菠萝", "tomato" = "番茄", "chili" = "辣椒"))
#define TEXT_NO_TASTE "难以形容的滋味"
GLOBAL_LIST_INIT(localized_fast_food_tastes, list("donut" = "甜甜圈", "chaos" = "混沌", "violets" = "紫罗兰", "green apples" = "青苹果", "buttery sweetness" = "黄油甜香", "bitterness" = "苦味", "blumpkin" = "蓝南瓜", "tropical sweetness" = "热带果香", "matcha" = "抹茶", "fizzy tutti frutti" = "汽泡什锦水果", "jelly" = "果酱", "bun" = "面包", "beef patty" = "牛肉饼", "long pig" = "人肉", "corgi meat" = "柯基肉", "grass" = "青草", "tofu" = "豆腐", "sludge" = "污泥", "acid" = "酸液", "salmon" = "三文鱼", "a bad joke" = "烂笑话", "brains" = "脑髓", "ectoplasm" = "灵质", "red" = "红色", "orange" = "橙子", "yellow" = "黄色", "green" = "绿色", "blue" = "蓝色", "purple" = "紫色", "black" = "黑色", "white" = "白色", "magic" = "魔法", "type two diabetes" = "二型糖尿病", "extreme heat" = "极度辛辣", "dead rat" = "死老鼠", "a home run" = "本垒打", "bacon" = "培根", "pure electricity" = "纯粹电流", "cat" = "猫", "crab meat" = "蟹肉", "assistant" = "助手", "pork patty" = "猪肉饼", "muffin" = "玛芬", "God's covenant" = "上帝之约", "beef soaked in chili" = "浸满辣椒的牛肉", "a smoking flare" = "冒烟的照明弹", "juicy meat" = "多汁肉馅", "BBQ sauce" = "烧烤酱", "fries" = "薯条", "salt" = "盐", "spookiness" = "阴森气息", "dust" = "灰尘", "lint" = "布絮", "fried batter" = "油炸面糊", "\"chicken\"" = "“鸡肉”", "fried fish" = "炸鱼"))
//=============================== TASTE GRAPH ====================================
//                                                                              //
// Flavor Intensity Thresholds (Relative to Detection Threshold % 'DT'):        //
// 0%             1x DT              2x DT              4x DT             100%  //
// |----------------|------------------|------------------|-----------------|   //
// |   Undetected   |       Weak       |       Mild       |      Strong     |   //
// |----------------|------------------|------------------|-----------------|   //
//                                                                              //
//==============================================================================//
GLOBAL_LIST_INIT(localized_salad_pastry_tastes, list("apple" = "苹果", "berries" = "浆果", "biscuit" = "饼干", "blue cherry" = "蓝樱桃", "bread" = "面包", "brownie" = "布朗尼", "building heat" = "逐渐增强的辣味", "cake" = "蛋糕", "caramel" = "焦糖", "cherry" = "樱桃", "cherry jelly" = "樱桃果酱", "chocolatey goodness" = "巧克力美味", "cookie" = "曲奇", "cracker" = "咸脆饼干", "cream" = "奶油", "creamy meringue" = "绵密蛋白霜", "creamy potatoes" = "奶香土豆", "crisp greens" = "爽脆绿叶菜", "dressing" = "沙拉调味汁", "egg" = "鸡蛋", "eggs" = "鸡蛋", "extreme bitterness" = "极度苦涩", "feta cheese" = "菲达奶酪", "fruit" = "水果", "glaze" = "糖衣", "healthy greens" = "健康绿叶菜", "hope" = "希望", "leaves" = "叶片", "mayonnaise" = "蛋黄酱", "mozzarella cheese" = "马苏里拉奶酪", "mushroom" = "蘑菇", "mushrooms" = "蘑菇", "oat" = "燕麦", "olive dressing" = "橄榄调味汁", "pastry" = "糕点", "peanut butter" = "花生酱", "peanuts" = "花生", "people" = "人", "pita bread" = "皮塔饼", "potato" = "土豆", "pretzel" = "椒盐卷饼", "raisins" = "葡萄干", "raw brownie batter" = "生布朗尼面糊", "rice" = "米饭", "salami" = "萨拉米香肠", "savory meat and vegtables" = "鲜香肉菜", "soft cookie" = "软曲奇", "sourness" = "酸味", "spinach" = "菠菜", "sweetness" = "甜味", "the colour green" = "绿色", "the jungle" = "丛林", "valids" = "正当击杀目标", "wafer" = "威化饼", "waffle" = "华夫饼", "waffles" = "华夫饼", "zap" = "电击", "cream cheese" = "奶油奶酪", "crab" = "蟹肉", "crispiness" = "酥脆口感", "dried seaweed" = "干海苔", "rice wrappers" = "米皮", "spice" = "香料", "crunchy veggies" = "爽脆蔬菜"))
/**
 * Returns what the reagents in our given list taste like
 *
 * Arguments:
 * * list/reagent_list - List of reagents to taste.
 * * mob/living/taster - Who is doing the tasting. Some mobs can pick up specific flavours.
 * * detection_threshold_percent - The minimum relative percentage a flavor must reach to be tasted.
 */
/proc/generate_reagents_taste_message(list/reagent_list, mob/living/taster, detection_threshold_percent)
	// We can't taste anything
	if(detection_threshold_percent > 100)
		return TEXT_NO_TASTE

	// Associative list of our tastes - list("taste description" = strength)
	var/list/tastes = list()
	var/total_taste_strength = 0

	for(var/datum/reagent/reagent as anything in reagent_list)
		if(!reagent.taste_mult)
			continue

		var/list/taste_data = reagent.get_taste_description(taster)
		for(var/taste_desc in taste_data)
			var/taste_strength = taste_data[taste_desc] * reagent.volume * reagent.taste_mult
			tastes[taste_desc] += taste_strength
			total_taste_strength += taste_strength

	// None of our reagents had any flavour
	if(total_taste_strength <= 0)
		return TEXT_NO_TASTE

	// If we have exactly one taste, don't bother with relative strengths
	if(length(tastes) == 1)
		return GLOB.localized_food_tastes[tastes[1]] || GLOB.localized_fast_food_tastes[tastes[1]] || GLOB.localized_salad_pastry_tastes[tastes[1]] || tastes[1]

	// Sort tastes descending by strength, so strong flavours come first
	sortTim(tastes, cmp = GLOBAL_PROC_REF(cmp_numeric_dsc), associative = TRUE)

	// Lazylists for different taste strength categories, no need to initialize if we don't have such flavors
	var/list/strong_tastes
	var/list/mild_tastes
	var/list/weak_tastes

	for(var/taste_desc in tastes)
		var/relative_taste_percent = (tastes[taste_desc] / total_taste_strength) * 100

		// From weakest to strongest
		if(relative_taste_percent < detection_threshold_percent)
			continue // too weak to detect
		else if(relative_taste_percent <= detection_threshold_percent * 2)
			LAZYADD(weak_tastes, GLOB.localized_food_tastes[taste_desc] || GLOB.localized_fast_food_tastes[taste_desc] || GLOB.localized_salad_pastry_tastes[taste_desc] || taste_desc)
		else if(relative_taste_percent <= detection_threshold_percent * 4)
			LAZYADD(mild_tastes, GLOB.localized_food_tastes[taste_desc] || GLOB.localized_fast_food_tastes[taste_desc] || GLOB.localized_salad_pastry_tastes[taste_desc] || taste_desc)
		else
			LAZYADD(strong_tastes, GLOB.localized_food_tastes[taste_desc] || GLOB.localized_fast_food_tastes[taste_desc] || GLOB.localized_salad_pastry_tastes[taste_desc] || taste_desc)

	var/list/taste_messages = list()

	if(LAZYLEN(strong_tastes))
		taste_messages += "浓浓的[english_list(strong_tastes, TEXT_NO_TASTE, "和", "、")]"
	if(LAZYLEN(mild_tastes))
		// Prefix "some " if there are strong flavors to avoid seeming like a strong flavor
		taste_messages += "[LAZYLEN(strong_tastes) ? "些许" : ""][english_list(mild_tastes, TEXT_NO_TASTE, "和", "、")]"
	if(LAZYLEN(weak_tastes))
		taste_messages += "一丝[english_list(weak_tastes, TEXT_NO_TASTE, "和", "、")]"

	return english_list(taste_messages, TEXT_NO_TASTE, "和", "、")

#undef TEXT_NO_TASTE
