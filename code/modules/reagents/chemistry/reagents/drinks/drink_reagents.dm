/datum/reagent/consumable/orangejuice
	name = "Orange Juice"; display_name = "橙汁"
	description = "美味又富含维生素C，你还想要什么？"
	color = "#E78108" // rgb: 231, 129, 8
	taste_description = "oranges"
	ph = 3.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/orangejuice

/datum/reagent/consumable/orangejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_oxy_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_oxy_loss(-0.5 * metabolization_ratio, FALSE, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/tomatojuice
	name = "Tomato Juice"; display_name = "番茄汁"
	description = "把番茄榨成了汁。这么大又多汁的番茄，真浪费啊？"
	color = "#731008" // rgb: 115, 16, 8
	taste_description = "tomatoes"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/tomatojuice

/datum/reagent/consumable/tomatojuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_fire_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0, burn = 0.5 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/limejuice
	name = "Lime Juice"; display_name = "青柠汁"
	description = "酸酸甜甜的青柠汁。"
	color = "#a6f19a" // rgb: 166, 241, 154
	taste_description = "unbearable sourness"
	ph = 2.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/limejuice

/datum/reagent/consumable/limejuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/carrotjuice
	name = "Carrot Juice"; display_name = "胡萝卜汁"
	description = "就像胡萝卜，只是不脆了。"
	color = "#973800" // rgb: 151, 56, 0
	taste_description = "carrots"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/carrotjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_eye_blur(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_temp_blindness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(current_cycle)
		if(21 to 110)
			if(SPT_PROB(100 * (1 - (sqrt(110 - current_cycle) / 10)), seconds_per_tick))
				need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio)
		if(110 to INFINITY)
			need_mob_update = affected_mob.adjust_organ_loss(ORGAN_SLOT_EYES, -1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/berryjuice
	name = "Berry Juice"; display_name = "浆果汁"
	description = "由多种浆果调成的美味果汁。"
	color = "#863333" // rgb: 134, 51, 51
	taste_description = "berries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/applejuice
	name = "Apple Juice"; display_name = "苹果汁"
	description = "甜美的苹果汁，老少皆宜。"
	color = "#fff06b" // rgb: 255, 240, 107
	taste_description = "apples"
	ph = 3.2 // ~ 2.7 -> 3.7

/datum/reagent/consumable/poisonberryjuice
	name = "Poison Berry Juice"; display_name = "毒浆果汁"
	description = "由多种致命毒浆果调成的美味果汁。"
	color = "#792b49" // rgb: 121, 43, 73
	taste_description = "berries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/poisonberryjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/watermelonjuice
	name = "Watermelon Juice"; display_name = "西瓜汁"
	description = "用西瓜榨成的美味果汁。"
	color = "#af5e5e" // rgb: 175, 94, 94
	taste_description = "juicy watermelon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemonjuice
	name = "Lemon Juice"; display_name = "柠檬汁"
	description = "这种果汁特别酸。"
	color = "#ebeb9e" // rgb: 235, 235, 158
	taste_description = "sourness"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/lemonjuice

/datum/reagent/consumable/banana
	name = "Banana Juice"; display_name = "香蕉汁"
	description = "香蕉的原汁原味。HONK"
	color = "#FFFCB9" // rgb: 255, 252, 185
	taste_description = "banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/banana/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || HAS_TRAIT(affected_mob, TRAIT_SIMIAN))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/nothing
	name = "Nothing"; display_name = "虚无"
	description = "彻底的虚无。"
	taste_description = "nothing"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/shot_glass/nothing
	required_drink_type = /datum/reagent/consumable/nothing
	icon_state = "shotglass"

/datum/reagent/consumable/nothing/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		if(drinker.heal_bodypart_damage(brute = 0.5 * metabolization_ratio * seconds_per_tick, burn = 0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/laughter
	name = "Laughter"; display_name = "欢笑"
	description = "有人说欢笑是最好的药，但最新研究证明并非如此。"
	metabolization_rate = INFINITY
	color = "#FF4DD2"
	taste_description = "laughter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/laughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tic, metabolization_ratio)
	. = ..()
	affected_mob.emote("laugh")
	affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_laughter)

/datum/reagent/consumable/superlaughter
	name = "Super Laughter"; display_name = "超级欢笑"
	description = "很好笑，直到笑的人变成你。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = "#FF4DD2"
	taste_description = "laughter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/superlaughter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(16, seconds_per_tick))
		affected_mob.visible_message(span_danger("[affected_mob]突然止不住地大笑起来！"), span_userdanger("你突然止不住地大笑起来！"))
		affected_mob.Stun(5)
		affected_mob.add_mood_event("chemical_laughter", /datum/mood_event/chemical_superlaughter)

/datum/reagent/consumable/potato_juice
	name = "Potato Juice"; display_name = "土豆汁"
	description = "土豆榨的汁。呸。"
	nutriment_factor = 2
	color = "#E8A856" // rgb: 234, 157, 58
	taste_description = "irish sadness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle
	name = "Pickle Juice"; display_name = "腌黄瓜汁"
	description = "准确地说，这是泡腌黄瓜的盐水"
	nutriment_factor = 2
	color = "#cde65e" // rgb: 205, 230, 94
	taste_description = "vinegar brine"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pickle/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM)))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/grapejuice
	name = "Grape Juice"; display_name = "葡萄汁"
	description = "一串葡萄榨出的汁，保证不含酒精。"
	color = "#290029" // dark purple
	taste_description = "grape soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/plumjuice
	name = "Plum Juice"; display_name = "李子汁"
	description = "清爽微酸的饮料。"
	color = "#b6062c"
	taste_description = "plums"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/milk
	name = "Milk"; display_name = "牛奶"
	description = "哺乳动物乳腺产生的不透明白色液体。"
	color = "#DFDFDF" // rgb: 223, 223, 223
	taste_description = "milk"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/milk

// Milk is good for humans, but bad for plants.
// The sugars cannot be used by plants, and the milk fat harms growth. Except shrooms.
/datum/reagent/consumable/milk/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume * 0.3))
	var/obj/item/seeds/myseed = mytray.myseed
	if(isnull(myseed) || myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
		return
	myseed.adjust_potency(-round(volume * 0.5))

/datum/reagent/consumable/milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/milk/used_on_fish(obj/item/fish/fish)
	if(HAS_TRAIT(fish, TRAIT_FISH_MADE_OF_BONE))
		fish.repair_damage(fish.max_integrity * max(fish.get_hunger() * 0.5, 0.12))
		fish.sate_hunger()
		return TRUE

/datum/reagent/consumable/soymilk
	name = "Soy Milk"; display_name = "豆奶"
	description = "用大豆制成的不透明白色液体。"
	color = "#DFDFC7" // rgb: 223, 223, 199
	taste_description = "soy milk"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/condiment/soymilk

/datum/reagent/consumable/soymilk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(1, 0))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cream
	name = "Cream"; display_name = "奶油"
	description = "牛奶中富含脂肪、仍呈液态的部分。要不掺点苏格兰威士忌？"
	color = "#DFD7AF" // rgb: 223, 215, 175
	taste_description = "creamy milk"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/cream

/datum/reagent/consumable/cream/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && affected_mob.heal_bodypart_damage(1, 0))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/coffee
	name = "Coffee"; display_name = "咖啡"
	description = "用咖啡树烘焙过的种子冲泡而成的饮品，这些种子通常称为咖啡豆。"
	color = "#482000" // rgb: 72, 32, 0
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	//310.15 is the normal bodytemp.
	affected_mob.adjust_bodytemperature(12.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(holder.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/tea
	name = "Tea"; display_name = "茶"
	description = "美味的红茶，富含抗氧化物，对身体好！"
	color = "#101000" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "tart black tea"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/mug/tea
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_jitter(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(10 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

	var/to_chatted = FALSE
	for(var/datum/wound/iter_wound as anything in affected_mob.all_wounds)
		if(SPT_PROB(10, seconds_per_tick))
			var/helped = iter_wound.tea_life_process()
			if(!to_chatted && helped)
				to_chat(affected_mob, span_notice("平静而放松的感觉遍布全身，你的伤口似乎好了一些。"))
			to_chatted = TRUE

// Different handling, different name.
// Returns FALSE by default so broken bones and 'loss' wounds don't give a false message
/datum/wound/proc/tea_life_process()
	return FALSE

// Slowly increase (gauzed) clot rate
/datum/wound/pierce/bleed/tea_life_process()
	gauzed_clot_rate += 0.1
	return TRUE

// Slowly increase clot rate
/datum/wound/slash/flesh/tea_life_process()
	clot_rate += 0.2
	return TRUE

// There's a designated burn process, but I felt this would be better for consistency with the rest of the reagent's procs
/datum/wound/burn/flesh/tea_life_process()
	// Sanitizes and heals, but with a limit
	flesh_healing = (flesh_healing > 0.1) ? flesh_healing : flesh_healing + 0.02
	infection_rate = max(infection_rate - 0.005, 0)
	return TRUE

/datum/reagent/consumable/lemonade
	name = "Lemonade"; display_name = "柠檬汽水"
	description = "酸甜的柠檬汽水，滋润心灵。"
	color = "#FFE978"
	quality = DRINK_NICE
	taste_description = "sunshine and summertime"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/tea/arnold_palmer
	name = "Arnold Palmer"; display_name = "阿诺·帕尔默"
	description = "让饮用者想去打高尔夫。"
	color = "#FFB766"
	quality = DRINK_NICE
	nutriment_factor = 10
	taste_description = "bitter tea"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tea/arnold_palmer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(affected_mob, span_notice("[pick("你想起要摆正肩膀。","你想起要低头。","你拿不准该摆正肩膀还是低头。","你想起要放松。","你想着总有一天能把高尔夫成绩再减少两杆。")]"))

/datum/reagent/consumable/icecoffee
	name = "Iced Coffee"; display_name = "冰咖啡"
	description = "咖啡加冰，清凉提神。"
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitter coldness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icecoffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/icecoffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/hot_ice_coffee
	name = "Hot Ice Coffee"; display_name = "热冰咖啡"
	description = "加了脉动冰晶的咖啡"
	color = "#462b15" // rgb: 70, 43, 21
	nutriment_factor = 0
	overdose_threshold = 80
	taste_description = "bitter coldness and a hint of smoke"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/hot_ice_coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/hot_ice_coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-3.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/icetea
	name = "Iced Tea"; display_name = "冰茶"
	description = "与某位名字相似的说唱歌手兼演员无关。"
	color = "#104038" // rgb: 16, 64, 56
	nutriment_factor = 0
	taste_description = "sweet tea"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/icetea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_cola
	name = "Cola"; display_name = "可乐"
	description = "一种清爽的饮料。"
	color = "#100800" // rgb: 16, 8, 0
	taste_description = "cola"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/roy_rogers
	name = "Roy Rogers"; display_name = "罗伊·罗杰斯"
	description = "一种甜甜的气泡饮料。"
	color = "#53090B"
	quality = DRINK_GOOD
	taste_description = "fruity overlysweet cola"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/roy_rogers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.set_jitter_if_lower(6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	return ..()

/datum/reagent/consumable/nuka_cola
	name = "Nuka Cola"; display_name = "核子可乐"
	description = "可乐，可乐从未改变。"
	color = "#100800" // rgb: 16, 8, 0
	quality = DRINK_VERYGOOD
	taste_description = "the future"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/nuka_cola/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/nuka_cola)

/datum/reagent/consumable/nuka_cola/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.set_drugginess(30 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())
	if (SSradiation.can_irradiate_basic(affected_mob))
		affected_mob.AddComponent(/datum/component/irradiated)

/datum/reagent/consumable/rootbeer
	name = "Root Beer"; display_name = "沙士"
	description = "气泡丰富的美味沙士，含糖量高到能让饮用者扣扳机的手指更快。"
	color = "#181008" // rgb: 24, 16, 8
	quality = DRINK_VERYGOOD
	nutriment_factor = 10
	metabolization_rate = 2 * REAGENTS_METABOLISM
	taste_description = "a monstrous sugar rush"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	/// If we activated the effect
	var/effect_enabled = FALSE

/datum/reagent/consumable/rootbeer/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
	if(current_cycle > 10)
		to_chat(affected_mob, span_warning("糖分带来的兴奋逐渐消退，你有些疲倦……"))
		affected_mob.adjust_stamina_loss(min(80, current_cycle * 3), required_biotype = affected_biotype)
		affected_mob.adjust_drowsiness((current_cycle-1) * 2 SECONDS)

/datum/reagent/consumable/rootbeer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 3 && !effect_enabled) // takes a few seconds for the bonus to kick in to prevent microdosing
		to_chat(affected_mob, span_notice("你觉得扣扳机的手指痒痒的……"))
		ADD_TRAIT(affected_mob, TRAIT_DOUBLE_TAP, type)
		effect_enabled = TRUE

	affected_mob.set_jitter_if_lower(1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(prob(50))
		affected_mob.adjust_dizzy(0.5 SECONDS * metabolization_ratio * seconds_per_tick)
	if(current_cycle > 10)
		affected_mob.adjust_dizzy(0.75 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/grey_bull
	name = "Grey Bull"; display_name = "灰牛"
	description = "灰牛，给你一双手套！"
	color = "#EEFF00" // rgb: 238, 255, 0
	quality = DRINK_VERYGOOD
	taste_description = "carbonated oil"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/grey_bull/on_mob_metabolize(mob/living/carbon/affected_atom)
	. = ..()
	var/obj/item/organ/liver/liver = affected_atom.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_MAINTENANCE_METABOLISM))
		affected_atom.add_mood_event("maintenance_fun", /datum/mood_event/maintenance_high)
		metabolization_rate *= 0.8

/datum/reagent/consumable/grey_bull/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/spacemountainwind
	name = "SM Wind"; display_name = "太空山风"
	description = "像太空中的风一样穿透你的身体。"
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "sweet citrus soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/spacemountainwind/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-7 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/dr_gibb
	name = "Dr. Gibb"; display_name = "吉布博士"
	description = "融合42种不同风味的美味饮料。"
	color = "#102000" // rgb: 16, 32, 0
	taste_description = "cherry soda" // FALSE ADVERTISING
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/dr_gibb/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/space_up
	name = "Space-Up"; display_name = "六喜"
	description = "尝起来就像嘴里发生了船体破损。"
	color = COLOR_VIBRANT_LIME // rgb: 0, 255, 0
	taste_description = "cherry soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/space_up/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/lemon_lime
	name = "Lemon Lime"; display_name = "柠檬青柠汽水"
	description = "酸爽的饮料，含0.5%天然柑橘成分！"
	color = "#8CFF00" // rgb: 135, 255, 0
	taste_description = "tangy lime and lemon soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/lemon_lime/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/pwr_game
	name = "Pwr Game"; display_name = "劲玩"
	description = "唯一蕴含真正玩家渴求力量的饮料。"
	color = "#9385bf" // rgb: 58, 52, 75
	taste_description = "sweet and salty tang"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pwr_game/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(exposed_mob?.mind?.get_skill_level(/datum/skill/gaming) >= SKILL_LEVEL_LEGENDARY && (methods & INGEST) && !HAS_TRAIT(exposed_mob, TRAIT_GAMERGOD))
		ADD_TRAIT(exposed_mob, TRAIT_GAMERGOD, "pwr_game")
		to_chat(exposed_mob, span_nicegreen("随着劲玩下肚，你的玩家第三眼睁开了…… \
		你仿佛得知了宇宙中的一个重大秘密……"))

/datum/reagent/consumable/pwr_game/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.mind?.adjust_experience(/datum/skill/gaming, 5)

/datum/reagent/consumable/shamblers
	name = "Shambler's Juice"; display_name = "蹒跚者果汁"
	description = "～给我摇一杯蹒跚者果汁！～"
	color = "#f00060" // rgb: 94, 0, 38
	taste_description = "carbonated metallic soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shamblers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sodawater
	name = "Soda Water"; display_name = "苏打水"
	description = "一罐苏打水。何不调杯苏打威士忌？"
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "carbonated water"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// A variety of nutrients are dissolved in club soda, without sugar.
// These nutrients include carbon, oxygen, hydrogen, phosphorous, potassium, sulfur and sodium, all of which are needed for healthy plant growth.
/datum/reagent/consumable/sodawater/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	mytray.adjust_plant_health(round(volume * 0.1))

/datum/reagent/consumable/sodawater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/tonic
	name = "Tonic Water"; display_name = "汤力水"
	description = "味道奇怪，但至少里面的奎宁能预防太空疟疾。"
	color = "#0064C8" // rgb: 0, 100, 200
	taste_description = "tart and fresh"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/tonic/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/wellcheers
	name = "Wellcheers"; display_name = "畅饮牌果汁"
	description = "一种带着海水气味的古怪紫色饮料。你听见远处传来海鸥的叫声。"
	color = "#762399" // rgb: 118, 35, 153
	taste_description = "grapes and the fresh open sea"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/wellcheers/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(1.5 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	switch(affected_mob.mob_mood.sanity_level)
		if (SANITY_LEVEL_GREAT to SANITY_LEVEL_NEUTRAL)
			need_mob_update = affected_mob.adjust_brute_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		if (SANITY_LEVEL_DISTURBED to SANITY_LEVEL_UNSTABLE)
			affected_mob.add_mood_event("wellcheers", /datum/mood_event/wellcheers)
		if (SANITY_LEVEL_CRAZY to SANITY_LEVEL_INSANE)
			need_mob_update = affected_mob.adjust_stamina_loss(1.5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/monkey_energy
	name = "Monkey Energy"; display_name = "猴力能量饮料"
	description = "唯一能让你释放猿性的饮料。"
	color = "#f39b03" // rgb: 243, 155, 3
	overdose_threshold = 60
	taste_description = "barbecue and nostalgia"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/monkey_energy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(40 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_dizzy(1 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/monkey_energy/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_SIMIAN))
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/monkey_energy)

/datum/reagent/consumable/monkey_energy/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(7.5, seconds_per_tick))
		affected_mob.say(pick_list_replacements(BOOMER_FILE, "boomer"), forced = /datum/reagent/consumable/monkey_energy)

/datum/reagent/consumable/ice
	name = "Ice"; display_name = "冰"
	description = "冻住的水，你的牙医可不希望你嚼这个。"
	color = "#619494" // rgb: 97, 148, 148
	taste_description = "ice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/ice

/datum/reagent/consumable/ice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_bodytemperature(-2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, FALSE, affected_mob.get_body_temp_normal()))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/soy_latte
	name = "Soy Latte"; display_name = "豆奶拿铁"
	description = "读嬉皮士书籍时享用的美味饮品。"
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "creamy coffee"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/soy_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/soy_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cafe_latte
	name = "Cafe Latte"; display_name = "拿铁咖啡"
	description = "阅读时享用的浓郁美味饮品。"
	color = "#cc6404" // rgb: 204,100,4
	overdose_threshold = 80
	quality = DRINK_NICE
	taste_description = "bitter cream"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/cafe_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cafe_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/doctor_delight
	name = "The Doctor's Delight"; display_name = "医生之乐"
	description = "每天一口，医护机器人远离我！混合果汁，能较快治疗大多数伤害，代价是让人饥饿。"
	color = "#FF8CFF" // rgb: 255, 140, 255
	quality = DRINK_VERYGOOD
	taste_description = "homely fruit"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/doctor_delight/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(affected_mob.nutrition && (affected_mob.nutrition - 2 > 0))
		var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
		if(!(HAS_TRAIT(liver, TRAIT_MEDICAL_METABOLISM)))
			// Drains the nutrition of the holder. Not medical doctors though, since it's the Doctor's Delight!
			affected_mob.adjust_nutrition(-1 * metabolization_ratio * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/cinderella
	name = "Cinderella"; display_name = "灰姑娘"
	description = "和朋友聚会时喝的果味鸡尾酒，绝对含酒精，真的。"
	color = "#FF6A50"
	quality = DRINK_VERYGOOD
	taste_description = "sweet tangy fruit"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cinderella/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/cherryshake
	name = "Cherry Shake"; display_name = "樱桃奶昔"
	description = "樱桃味的奶昔。"
	color = "#FFB6C1"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "creamy tart cherry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bluecherryshake
	name = "Blue Cherry Shake"; display_name = "蓝樱桃奶昔"
	description = "充满异域风味的奶昔。"
	color = "#00F1FF"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "creamy blue cherry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanillashake
	name = "Vanilla Shake"; display_name = "香草奶昔"
	description = "香草味奶昔，经典口味依旧美味。"
	color = "#E9D2B2"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "sweet creamy vanilla"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/caramelshake
	name = "Caramel Shake"; display_name = "焦糖奶昔"
	description = "焦糖味奶昔，光看着就觉得牙疼。"
	color = "#E17C00"
	quality = DRINK_GOOD
	nutriment_factor = 10
	taste_description = "sweet rich creamy caramel"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/choccyshake
	name = "Chocolate Shake"; display_name = "巧克力奶昔"
	description = "冰凉的巧克力奶昔。"
	color = "#541B00"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "sweet creamy chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/strawberryshake
	name = "Strawberry Shake"; display_name = "草莓奶昔"
	description = "草莓味奶昔。"
	color = "#ff7b7b"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "sweet strawberries and milk"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/bananashake
	name = "Banana Shake"; display_name = "香蕉奶昔"
	description = "香蕉奶昔，小丑在HONK日派对上喝的东西。"
	color = "#f2d554"
	quality = DRINK_VERYGOOD
	nutriment_factor = 8
	taste_description = "thick banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/pumpkin_latte
	name = "Pumpkin Latte"; display_name = "南瓜拿铁"
	description = "南瓜汁与咖啡的混合饮品。"
	color = "#F4A460"
	overdose_threshold = 80
	quality = DRINK_VERYGOOD
	nutriment_factor = 3
	taste_description = "creamy pumpkin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/pumpkin_latte/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_jitter_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/pumpkin_latte/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_dizzy(-5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = affected_mob.SetSleeping(0)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		need_mob_update += affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/gibbfloats
	name = "Gibb Floats"; display_name = "吉布冰淇淋汽水"
	description = "在一杯吉布博士汽水上放上冰淇淋。"
	color = "#B22222"
	quality = DRINK_NICE
	nutriment_factor = 3
	taste_description = "creamy cherry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pumpkinjuice
	name = "Pumpkin Juice"; display_name = "南瓜汁"
	description = "用真正的南瓜榨成的汁。"
	color = "#FFA500"
	taste_description = "pumpkin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/blumpkinjuice
	name = "Blumpkin Juice"; display_name = "蓝南瓜汁"
	description = "用真正的蓝南瓜榨成的汁。"
	color = "#00BFFF"
	taste_description = "a mouthful of pool water"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/triple_citrus
	name = "Triple Citrus"; display_name = "三重柑橘"
	description = "一种解决口渴的混合溶液。"
	color = "#EEFF00"
	quality = DRINK_NICE
	taste_description = "extreme bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda
	name = "Grape Soda"; display_name = "葡萄汽水"
	description = "深受儿童和戒酒人士喜爱。"
	color = "#E6CDFF"
	taste_description = "grape soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grape_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/milk/chocolate_milk
	name = "Chocolate Milk"; display_name = "巧克力奶"
	description = "酷孩子喝的牛奶。"
	color = "#7D4E29"
	quality = DRINK_NICE
	taste_description = "chocolate milk"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco
	name = "Hot Coco"; display_name = "热可可"
	description = "用爱制作！还有可可豆。"
	nutriment_factor = 4
	color = "#3b240e" // rgb: 59, 36, 14
	taste_description = "creamy chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/hot_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_bodytemperature(2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.heal_bodypart_damage(brute = 0.5 * metabolization_ratio, burn = 0, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 1 * metabolization_ratio * seconds_per_tick)
	return ..() || .

/datum/reagent/consumable/italian_coco
	name = "Italian Hot Chocolate"; display_name = "意式热巧克力"
	description = "用爱制作！光闻香味就能想象出一位快乐的意大利奶奶。"
	nutriment_factor = 8
	color = "#57372A"
	quality = DRINK_VERYGOOD
	taste_description = "thick creamy chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/italian_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(2.5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/menthol
	name = "Menthol"; display_name = "薄荷醇"
	description = "能够缓解咳嗽症状。"
	color = "#80AF9C"
	taste_description = "mint"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/menthol

/datum/reagent/consumable/menthol/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/grenadine
	name = "Grenadine"; display_name = "红石榴糖浆"
	description = "不是樱桃味的！"
	color = "#EA1D26"
	taste_description = "sweet pomegranates"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/grenadine/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		to_chat(drinker, span_warning("抗氧化物正在削弱你的激进精神！"))

/datum/reagent/consumable/grenadine/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		drinker.set_dizzy_if_lower(5 SECONDS * metabolization_ratio * seconds_per_tick)
		if(drinker.get_stamina_loss() < 80)
			drinker.adjust_stamina_loss(12, required_biotype = affected_biotype) //The pomegranate stops free radicals! Har har.

/datum/reagent/consumable/parsnipjuice
	name = "Parsnip Juice"; display_name = "欧防风汁"
	description = "何必呢……"
	color = "#FFA500"
	taste_description = "parsnip"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/pineapplejuice
	name = "Pineapple Juice"; display_name = "菠萝汁"
	description = "酸爽、热带风味，而且备受争议。"
	color = "#F7D435"
	taste_description = "pineapple"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/juice/pineapplejuice

/datum/reagent/consumable/peachjuice //Intended to be extremely rare due to being the limiting ingredients in the blazaam drink
	name = "Peach Juice"; display_name = "桃汁"
	description = "桃气十足。"
	color = "#E78108"
	taste_description = "peaches"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda
	name = "Cream Soda"; display_name = "奶油汽水"
	description = "经典的太空美式香草味汽水。"
	color = "#dcb137"
	quality = DRINK_VERYGOOD
	taste_description = "fizzy vanilla"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cream_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-2.5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/sol_dry
	name = "Sol Dry"; display_name = "太阳干姜汽水"
	description = "用姜制成的温和舒缓饮料。"
	color = "#f7d26a"
	quality = DRINK_NICE
	taste_description = "sweet ginger spice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/sol_dry/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/shirley_temple
	name = "Shirley Temple"; display_name = "秀兰·邓波儿"
	description = "给你，小姑娘，现在你也能像大人一样喝一杯了。"
	color = "#F43724"
	quality = DRINK_GOOD
	taste_description = "sweet cherry syrup and ginger spice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/shirley_temple/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	affected_mob.adjust_disgust(-1.5 * metabolization_ratio * seconds_per_tick)
	return ..()

/datum/reagent/consumable/red_queen
	name = "Red Queen"; display_name = "红皇后"
	description = "喝我。"
	color = "#e6ddc3"
	quality = DRINK_GOOD
	taste_description = "wonder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/red_queen/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(50, seconds_per_tick))
		return

	var/newsize = pick(0.5, 0.75, 1, 1.50, 2)
	newsize *= RESIZE_DEFAULT_SIZE
	affected_mob.update_transform(newsize/current_size)
	current_size = newsize
	if(SPT_PROB(23, seconds_per_tick))
		affected_mob.emote("sneeze")

/datum/reagent/consumable/red_queen/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.update_transform(RESIZE_DEFAULT_SIZE/current_size)
	current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/consumable/bungojuice
	name = "Bungo Juice"; display_name = "邦果汁"
	color = "#F9E43D"
	description = "异域风味！让你仿佛已经开始度假。"
	taste_description = "succulent bungo"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/prunomix
	name = "Pruno Mixture"; display_name = "狱酿果酒原浆"
	color = "#E78108"
	description = "水果、糖、酵母和水捣成的刺鼻浆液。"
	taste_description = "garbage"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice
	name = "Aloe Juice"; display_name = "芦荟汁"
	color = "#b3c5a7" // rgb: 179, 197, 167
	description = "健康清爽的果汁。"
	taste_description = "vegetable"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/aloejuice/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.get_tox_loss() && SPT_PROB(16, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/agua_fresca
	name = "Agua Fresca"; display_name = "西瓜清凉饮"
	description = "清爽的西瓜清凉饮，适合在全息甲板玩耍时享用。"
	color = "#D25B66"
	quality = DRINK_VERYGOOD
	taste_description = "cool refreshing watermelon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/agua_fresca/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())
	if(affected_mob.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mushroom_tea
	name = "Mushroom Tea"; display_name = "蘑菇茶"
	description = "用原产提兹拉的多孔菌薄片泡成的一杯咸鲜茶饮。"
	color = "#674945" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "mushrooms"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mushroom_tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(affected_mob, TRAIT_LIZARD_METABOLISM))
		if(affected_mob.adjust_oxy_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

//Moth Stuff
/datum/reagent/consumable/toechtauese_juice
	name = "Töchtaüse Juice"; display_name = "苦辣莓汁"
	description = "用苦辣莓榨成的难喝果汁。除非你喜欢受罪，否则最好熬成糖浆。"
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "fiery itchy pain"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/toechtauese_syrup
	name = "Töchtaüse Syrup"; display_name = "苦辣莓糖浆"
	description = "用苦辣莓熬成的辛辣苦涩糖浆，可用于制作食物和鸡尾酒。"
	color = "#554862" // rgb: 85, 72, 98
	nutriment_factor = 0
	taste_description = "sugar, spice, and nothing nice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/strawberry_banana
	name = "Strawberry Banana Smoothie"; display_name = "草莓香蕉果昔"
	description = "用草莓和香蕉制成的经典果昔。"
	color = "#FF9999"
	nutriment_factor = 0
	taste_description = "strawberry and banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/berry_blast
	name = "Berry Blast Smoothie"; display_name = "浆果爆发果昔"
	description = "用混合浆果制成的经典果昔。"
	color = "#A76DC5"
	nutriment_factor = 0
	taste_description = "mixed berry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/funky_monkey
	name = "Funky Monkey Smoothie"; display_name = "放克猴果昔"
	description = "用巧克力和香蕉制成的经典果昔。"
	color = COLOR_BROWNER_BROWN
	nutriment_factor = 0
	taste_description = "chocolate and banana"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/green_giant
	name = "Green Giant Smoothie"; display_name = "绿巨人果昔"
	description = "不含蔬菜的绿色蔬菜果昔。"
	color = COLOR_VERY_DARK_LIME_GREEN
	nutriment_factor = 0
	taste_description = "green, just green"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_baller
	name = "Melon Baller Smoothie"; display_name = "蜜瓜球果昔"
	description = "用蜜瓜制成的经典果昔。"
	color = "#D22F55"
	nutriment_factor = 0
	taste_description = "fresh melon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/vanilla_dream
	name = "Vanilla Dream Smoothie"; display_name = "香草之梦果昔"
	description = "用香草和鲜奶油制成的经典果昔。"
	color = "#FFF3DD"
	nutriment_factor = 0
	taste_description = "creamy vanilla"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberjuice
	name = "Cucumber Juice"; display_name = "黄瓜汁"
	description = "普通的黄瓜汁，没有任何奇幻成分。"
	color = "#B1D861" // rgb: 177, 216, 97
	taste_description = "light cucumber"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/cucumberlemonade
	name = "Cucumber Lemonade"; display_name = "黄瓜柠檬汽水"
	description = "黄瓜汁、糖和汽水，还需要什么呢？"
	color = "#cbe248" // rgb: 203, 226, 72
	quality = DRINK_GOOD
	taste_description = "citrus soda with cucumber"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/cucumberlemonade/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-4 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, doll.get_body_temp_normal())
	if(doll.get_tox_loss() && SPT_PROB(10, seconds_per_tick))
		if(doll.adjust_tox_loss(-0.25 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/mississippi_queen
	name = "Mississippi Queen"; display_name = "密西西比皇后"
	description = "觉得自己很厉害？来杯庆功酒如何？"
	color = "#d4422f" // rgb: 212,66,47
	taste_description = "sludge seeping down your throat"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/mississippi_queen/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	switch(current_cycle)
		if(11 to 21)
			drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
		if(21 to 31)
			if(SPT_PROB(15, seconds_per_tick))
				drinker.adjust_confusion(2 SECONDS * metabolization_ratio)
		if(31 to 201)
			drinker.adjust_hallucinations(30 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/t_letter
	name = "T"; display_name = "字母T"
	description = "本以为会在字母汤里找到它，不过这样也不错。"
	color = "#583d09" // rgb: 88, 61, 9
	taste_description = "one of your 26 favorite letters"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/t_letter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_MIND_TRAIT(affected_mob, TRAIT_MIMING))
		return
	affected_mob.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
	affected_mob.adjust_drowsiness(-3 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.AdjustSleeping(-2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(affected_mob.get_tox_loss() && SPT_PROB(25, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(-1 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/hakka_mate
	name = "Hakka-Mate"; display_name = "黑客马黛"
	description = "火星制造的马黛茶汽水，直接从黑客大会的深处搬来。"
	color = "#c4b000"
	taste_description = "bubbly yerba mate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/coconut_milk
	name = "Coconut Milk"; display_name = "椰奶"
	description = "用途广泛的牛奶替代品，从烹饪到调酒都很合适。"
	color = "#DFDFDF"
	taste_description = "milky coconut"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/melon_soda
	name = "Melon Soda"; display_name = "蜜瓜汽水"
	description = "一抹霓虹绿，满满怀旧味。"
	color = "#6FEB48"
	taste_description = "fizzy melon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/volt_energy
	name = "24-Volt Energy"; display_name = "24伏能量饮料"
	description = "添加人工色素与香料的灯笼果味电能饮料，由以太人为以太人制作。"
	color = "#99E550"
	taste_description = "sour pear"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/volt_energy/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/fruit_punch
	name = "fruit punch"; display_name = "水果宾治"
	description = "甜得难以置信的水果宾治，连制作者都不知道用了哪些水果…… \
		独特配方能治疗伤势、恢复活力，但附近没有饮水机辅助时饮用并不安全。"
	color = "#f7b2e3"
	taste_description = "dangerously sweet fruit"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/fruit_punch/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	var/found_valid_cooler = FALSE
	for(var/obj/structure/reagent_dispensers/water_cooler/found_cooler in range(4, affected_mob))
		if(found_cooler.anchored)
			found_valid_cooler = TRUE
			var/obj/effect/temp_visual/heal/heal_effect = new /obj/effect/temp_visual/heal(get_turf(found_cooler))
			heal_effect.color = "#f7b2e3"
			break

	if(found_valid_cooler)
		affected_mob.clear_alert("punch_bad")
		affected_mob.throw_alert("punch_good", /atom/movable/screen/alert/fruit_punch_good)
		need_mob_update += affected_mob.adjust_tox_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_brute_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_fire_loss(-0.3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
	else
		affected_mob.clear_alert("punch_good")
		affected_mob.throw_alert("punch_bad", /atom/movable/screen/alert/fruit_punch_bad)
		need_mob_update += affected_mob.apply_damage(0.75 * metabolization_ratio * seconds_per_tick, TOX)
		affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)
		if(SPT_PROB(10, seconds_per_tick))
			affected_mob.Knockdown(3 SECONDS, 6 SECONDS) //Gives daze effect. Using the cooler is a commitment and if you get jumped during it or have to run away to fight something, you should be vulnerable.
			to_chat(affected_mob, span_warning("水果宾治甜得让你头晕目眩，不知所措！"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/movespeed_modifier/punch_punishment
	multiplicative_slowdown = 0.30

/datum/reagent/consumable/fruit_punch/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.clear_alert("punch_bad")
	affected_mob.clear_alert("punch_good")
	affected_mob.remove_movespeed_modifier(/datum/movespeed_modifier/punch_punishment)

/atom/movable/screen/alert/fruit_punch_good
	name = "水果宾治祝福"
	desc = "水果宾治的甜蜜与饮料冷却机的温馨陪伴正让你慢慢恢复健康……"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_blessing"

/atom/movable/screen/alert/fruit_punch_bad
	name = "水果惩罚"
	desc = "没有饮料冷却机的舒缓气场，水果宾治甜得令人难以承受！你的身体正陷入休克！"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "punch_punishment"

/datum/reagent/consumable/ethanol/bitters_soda
	name = "Bitters and Soda"; display_name = "苦精苏打"
	description = "以芳香苦精调味的简单苏打饮料，能舒缓胃部不适。"
	boozepwr = 0
	color = "#f1c1b3"
	quality = DRINK_NICE
	taste_description = "mild aromatics"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters_soda/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_disgust(-2.5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/lean
	name = "Lean"; display_name = "紫饮"
	description = "喝下去让你呼哧带喘的饮料。"
	color = "#DE55ED"
	quality = DRINK_GOOD
	taste_description = "purple and a hint of opioid."
	addiction_types = list(/datum/addiction/opioids = 200)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/lean/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_jitter(2.5 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_stutter(2.25 SECONDS * metabolization_ratio * seconds_per_tick)
	affected_mob.adjust_drugginess(2 SECONDS * metabolization_ratio * seconds_per_tick)
	if(SPT_PROB(15, seconds_per_tick))
		affected_mob.emote(pick("taunt","twitch","shiver","laugh","moan","blush","stare"))
	if(current_cycle > 16 && SPT_PROB(3.5, seconds_per_tick))
		affected_mob.adjust_dizzy(15 SECONDS * metabolization_ratio)
		affected_mob.adjust_drowsiness(6.5 SECONDS * metabolization_ratio)
		affected_mob.emote("drool")
