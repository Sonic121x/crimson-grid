#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

/datum/reagent/consumable/ethanol
	name = "Ethanol"; display_name = "乙醇"
	description = "用途广泛的常见酒精。"
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	creation_purity = 1 // impure base reagents are a big no-no
	ph = 7.33
	burning_temperature = 2193//ethanol burns at 1970C (at its peak)
	burning_volume = 0.1
	default_container = /obj/item/reagent_containers/cup/glass/bottle/beer
	fallback_icon = 'icons/obj/drinks/bottles.dmi'
	fallback_icon_state = "beer"
	/**
	 * Boozepwr Chart
	 *
	 * Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	 *
	 * Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts
	 * (i.e. light poisoning inherts from slight poisoning)
	 * In addition, severe effects won't always trigger unless the drink is poisonously strong
	 * All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance
	 * (see [/datum/status_effect/inebriated])
	 *
	 * * 0: Non-alcoholic
	 * * 1-10: Barely classifiable as alcohol - occassional slurring
	 * * 11-20: Slight alcohol content - slurring
	 * * 21-30: Below average - imbiber begins to look slightly drunk
	 * * 31-40: Just below average - no unique effects
	 * * 41-50: Average - mild disorientation, imbiber begins to look drunk
	 * * 51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
	 * * 61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
	 * * 71-80: High alcohol content - blurry vision, imbiber completely shitfaced
	 * * 81-90: Extremely high alcohol content - heavy toxin damage, passing out
	 * * 91-100: Dangerously toxic - swift death
	 */
	var/boozepwr = 65

/datum/reagent/consumable/ethanol/New(list/data)
	if(LAZYLEN(data))
		if(!isnull(data["quality"]))
			quality = data["quality"]
			name = "Natural " + name; display_name = "天然" + display_name
		if(data["boozepwr"])
			boozepwr = data["boozepwr"]
	if(boozepwr > 0)
		// the stronger the drink, the less total of the drink is needed to reach addiction
		LAZYSET(addiction_types, /datum/addiction/alcohol, max(50, round(150 - boozepwr, 5)))
	return ..()

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE)) // we're an accomplished drinker
			booze_power *= 0.7
		if(HAS_TRAIT(drinker, TRAIT_LIGHT_DRINKER))
			booze_power *= 2

		// water will dilute alcohol effects
		var/total_water_volume = 0
		var/total_alcohol_volume = 0
		for(var/datum/reagent/water/sobriety in drinker.reagents.reagent_list)
			total_water_volume += sobriety.volume

		for(var/datum/reagent/consumable/ethanol/alcohol in drinker.reagents.reagent_list)
			total_alcohol_volume += alcohol.volume

		var/combined_dilute_volume = total_alcohol_volume + total_water_volume
		if(combined_dilute_volume) // safety check to prevent division by zero
			booze_power *= (total_alcohol_volume / combined_dilute_volume)

		for(var/mob/living/enemy as anything in drinker.ai_controller?.blackboard[BB_MONKEY_ENEMIES])
			drinker.ai_controller.add_blackboard_key_assoc(BB_MONKEY_ENEMIES, enemy, MONKEY_ANGERED_HATRED_AMOUNT * (boozepwr / 100) * metabolization_ratio * seconds_per_tick)

		// Volume, power, and server alcohol rate effect how quickly one gets drunk
		drinker.adjust_drunk_effect(1 * sqrt(volume) * booze_power * ALCOHOL_RATE * metabolization_ratio * seconds_per_tick)
		if(boozepwr > 0)
			var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
			var/heavy_drinker_multiplier = (HAS_TRAIT(drinker, TRAIT_HEAVY_DRINKER) ? 0.5 : 1)
			if (istype(liver))
				if(liver.apply_organ_damage(((max(sqrt(volume) * (boozepwr ** ALCOHOL_EXPONENT) * liver.alcohol_tolerance * heavy_drinker_multiplier * seconds_per_tick, 0))/150)))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	if(istype(exposed_obj, /obj/item/paper))
		var/obj/item/paper/paperaffected = exposed_obj
		paperaffected.clear_paper()
		to_chat(usr, span_notice("[paperaffected]上的墨迹被洗掉了。"))
	if(istype(exposed_obj, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = exposed_obj
			affectedbook.book_data.set_content("")
			exposed_obj.visible_message(span_notice("[exposed_obj]上的字迹被[display_name || name]洗掉了！"))
		else
			exposed_obj.visible_message(span_warning("[exposed_obj]上的墨迹被[display_name || name]弄花了，但没有洗掉！"))
	return ..()

/datum/reagent/consumable/ethanol/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	. = ..()
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(ALCOHOL, chance = reac_volume * 5, histamine_add = min(10, reac_volume))

	if(methods & (TOUCH|VAPOR|PATCH))
		exposed_mob.adjust_fire_stacks(reac_volume / 15)
		exposed_mob.add_surgery_speed_mod("alcohol", round(1 - (boozepwr / 650), 0.05), min(reac_volume * 1 MINUTES, 5 MINUTES)) // Weak alcohol has less sterilizing power

/datum/reagent/consumable/ethanol/beer
	name = "Beer"; display_name = "啤酒"
	description = "旧地球自古就有酿造的酒精饮料，至今仍很受欢迎。"
	color = "#D7BC31" // rgb: 215, 188, 49
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "mild carbonated malt"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

// Beer is a chemical composition of alcohol and various other things. It's a garbage nutrient but hey, it's still one. Also alcohol is bad, mmmkay?
/datum/reagent/consumable/ethanol/beer/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 0.05))
	mytray.adjust_waterlevel(round(volume * 0.7))

/datum/reagent/consumable/ethanol/beer/light
	name = "Light Beer"; display_name = "淡啤酒"
	description = "旧地球自古就有酿造的酒精饮料，这一款热量与酒精含量较低。"
	boozepwr = 5 //Space Europeans hate it
	taste_description = "dish water"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/maltliquor
	name = "Malt Liquor"; display_name = "麦芽烈酒"
	description = "旧地球自古就有酿造的酒精饮料，这一款度数更高，极其便宜，也极其难喝。"
	boozepwr = 35
	taste_description = "sweet corn beer and the hood life"
	ph = 4.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green
	name = "Green Beer"; display_name = "绿啤酒"
	description = "旧地球自古就有酿造的酒精饮料，这一款染上了喜庆的绿色。"
	color = COLOR_CRAYON_GREEN
	overdose_threshold = 55 //More than a glass
	taste_description = "green piss water"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/beer/green/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.color != color)
		drinker.add_atom_colour(color, TEMPORARY_COLOUR_PRIORITY)

/datum/reagent/consumable/ethanol/beer/green/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, color)

/datum/reagent/consumable/ethanol/beer/green/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = REAGENTS_METABOLISM

	if(!ishuman(affected_mob))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	if(HAS_TRAIT(affected_human, TRAIT_USES_SKINTONES))
		affected_human.skin_tone = "green"
	else if(HAS_TRAIT(affected_human, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(affected_human, TRAIT_FIXED_MUTANT_COLORS)) //Code stolen from spraytan overdose
		affected_human.dna.features[FEATURE_MUTANT_COLOR] = "#a8e61d"
	affected_human.update_body(is_creating = TRUE)

/datum/reagent/consumable/ethanol/kahlua
	name = "Kahlua"; display_name = "甘露咖啡利口酒"
	description = "广为人知的墨西哥咖啡味利口酒，自1936年起生产！"
	color = "#8e8368" // rgb: 142,131,104
	boozepwr = 45
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/kahlua/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_drowsiness(-6 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/whiskey
	name = "Whiskey"; display_name = "威士忌"
	description = "上好的陈年单一麦芽威士忌。真带劲。"
	color = "#b4a287" // rgb: 180,162,135
	boozepwr = 75
	taste_description = "molasses"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/whiskey/kong
	name = "Kong"; display_name = "金刚酒"
	description = "让你猿形毕露！&#174;"
	color = "#332100" // rgb: 51, 33, 0
	taste_description = "the grip of a giant ape"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn
	name = "Candy Corn Liquor"; display_name = "玉米糖酒"
	description = "就像二维地下酒馆里喝的那种酒。"
	color = "#ccb800" // rgb: 204, 184, 0
	taste_description = "pancake syrup"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey/candycorn/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations(4 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/thirteenloko
	name = "Thirteen Loko"; display_name = "十三疯"
	description = "咖啡因与酒精的强劲混合物。"
	color = "#102000" // rgb: 16, 32, 0
	nutriment_factor = 1
	boozepwr = 80
	quality = DRINK_GOOD
	overdose_threshold = 60
	taste_description = "jitters and death"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/thirteenloko/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_drowsiness(-14 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.AdjustSleeping(-4 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_bodytemperature(-5 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, drinker.get_body_temp_normal())
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.set_jitter_if_lower(10 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_start(mob/living/drinker, metabolization_ratio)
	. = ..()
	to_chat(drinker, span_userdanger("你浑身剧烈颤抖，开始感到恶心。真不该喝下那么多[display_name || name]！"))
	drinker.set_jitter_if_lower(40 SECONDS)
	drinker.Stun(1.5 SECONDS)

/datum/reagent/consumable/ethanol/thirteenloko/overdose_process(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(3.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/held_item = drinker.get_active_held_item()
		if(held_item)
			drinker.dropItemToGround(held_item)
			to_chat(drinker, span_notice("你的手一抖，手里的东西掉了下来！"))
			drinker.set_jitter_if_lower(20 SECONDS)

	if(SPT_PROB(3.5, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("你头痛欲裂。", "你的眼睛很痛。", "你很难保持不动。", "你觉得心脏快要跳出胸膛了。")]"))

	if(SPT_PROB(2.5, seconds_per_tick) && iscarbon(drinker))
		var/obj/item/organ/eyes/eyes = drinker.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes && IS_ORGANIC_ORGAN(eyes)) // doesn't affect robotic eyes
			if(drinker.is_blind())
				eyes.Remove(drinker)
				eyes.forceMove(get_turf(drinker))
				to_chat(drinker, span_userdanger("你感觉眼球在脑袋里化成了液体，疼得弯下腰！"))
				drinker.emote("scream")
				if(drinker.adjust_brute_loss(15 * metabolization_ratio, updating_health = FALSE, required_bodytype = affected_bodytype))
					. = UPDATE_MOB_HEALTH
			else
				to_chat(drinker, span_userdanger("你失去了视力，惊恐地尖叫起来！"))
				if(eyes.apply_organ_damage(eyes.maxHealth))
					. = UPDATE_MOB_HEALTH
				drinker.emote("scream")

	if(SPT_PROB(1.5, seconds_per_tick) && iscarbon(drinker))
		drinker.visible_message(span_danger("[drinker]开始癫痫发作！"), span_userdanger("你癫痫发作了！"))
		if(drinker.Unconscious(10 SECONDS))
			. = UPDATE_MOB_HEALTH
		drinker.set_jitter_if_lower(700 SECONDS)

	if(SPT_PROB(0.5, seconds_per_tick) && iscarbon(drinker))
		drinker.apply_status_effect(/datum/status_effect/heart_attack)
		to_chat(drinker, span_userdanger("你很确定，刚才心脏停跳了一瞬间……"))
		drinker.playsound_local(drinker, 'sound/effects/singlebeat.ogg', 100, 0)

/datum/reagent/consumable/ethanol/vodka
	name = "Vodka"; display_name = "伏特加"
	description = "全世界俄罗斯人的首选饮料兼燃料。"
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 65
	taste_description = "grain alcohol"
	ph = 8.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS //Very high proof
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/vodka

/datum/reagent/consumable/ethanol/bilk
	name = "Bilk"; display_name = "啤奶"
	description = "似乎是啤酒兑牛奶。真恶心。"
	color = "#895C4C" // rgb: 137, 92, 76
	nutriment_factor = 2
	boozepwr = 15
	taste_description = "desperation and lactate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bilk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(5, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/threemileisland
	name = "Three Mile Island Iced Tea"; display_name = "三里岛冰茶"
	description = "为女士调制，烈到男士也招架得住。"
	color = "#666340" // rgb: 102, 99, 64
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "dryness"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/threemileisland/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/gin
	name = "Gin"; display_name = "金酒"
	description = "是金酒，在太空里。我说，先生，真不错。"
	color = "#d8e8f0" // rgb: 216,232,240
	boozepwr = 45
	taste_description = "an alcoholic christmas tree"
	ph = 6.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/rum
	name = "Rum"; display_name = "朗姆酒"
	description = "哟嚯嚯，海盗的那一套。"
	color = "#c9c07e" // rgb: 201,192,126
	boozepwr = 60
	taste_description = "spiked butterscotch"
	ph = 6.5
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/rum/aged
	name = "Aged Rum"; display_name = "陈年朗姆酒"
	description = "见鬼！这可是该和船伙计们分享的好朗姆。"
	color = "#c0b675" // rgb: 192,183,117
	boozepwr = 70
	taste_description = "extra-spiked butterscotch"
	default_container = /obj/item/reagent_containers/cup/glass/bottle/rum/aged
	quality = DRINK_FANTASTIC
	metabolized_traits = list(TRAIT_STRONG_STOMACH)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.add_blocked_language(subtypesof(/datum/language) - /datum/language/piratespeak, source = LANGUAGE_DRINK)
	drinker.grant_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)

/datum/reagent/consumable/ethanol/rum/aged/on_mob_end_metabolize(mob/living/drinker)
	if(!QDELING(drinker))
		drinker.remove_blocked_language(subtypesof(/datum/language), source = LANGUAGE_DRINK)
		drinker.remove_language(/datum/language/piratespeak, source = LANGUAGE_DRINK)
	return ..()

/datum/reagent/consumable/ethanol/tequila
	name = "Tequila"; display_name = "龙舌兰酒"
	description = "墨西哥出产的烈酒，风味温和。口渴了吗，老兄？"
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 70
	taste_description = "paint stripper"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/vermouth
	name = "Vermouth"; display_name = "味美思"
	description = "你突然很想喝一杯马天尼……"
	color = "#91FF91" // rgb: 145, 255, 145
	boozepwr = 45
	taste_description = "dry alcohol"
	ph = 3.25
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine
	name = "Wine"; display_name = "葡萄酒"
	description = "用蒸馏葡萄汁制成的优质酒精饮料。"
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 35
	taste_description = "bitter sweetness"
	ph = 3.45
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK
	default_container = /obj/item/reagent_containers/cup/glass/bottle/wine

/datum/reagent/consumable/ethanol/wine/on_merge(list/mix_data, amount)
	. = ..()
	if(data && mix_data && data["vintage"] != mix_data["vintage"])
		data["vintage"] = "mixed wine"

/datum/reagent/consumable/ethanol/wine/get_taste_description(mob/living/taster)
	if(HAS_TRAIT(taster,TRAIT_WINE_TASTER))
		if(data && data["vintage"])
			return list("[data["vintage"]]" = 1)
		else
			return list("synthetic wine"=1)
	return ..()

/datum/reagent/consumable/ethanol/lizardwine
	name = "Lizard Wine"; display_name = "蜥蜴酒"
	description = "来自太空中国的酒精饮料，将蜥蜴尾巴浸入乙醇制成。"
	color = "#7E4043" // rgb: 126, 64, 67
	boozepwr = 45
	quality = DRINK_FANTASTIC
	taste_description = "scaley sweetness"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/grappa
	name = "Grappa"; display_name = "格拉帕白兰地"
	description = "上好的意大利白兰地，适合嫌普通葡萄酒度数不够的人。"
	color = "#F8EBF1"
	boozepwr = 60
	taste_description = "classy bitter sweetness"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/amaretto
	name = "Amaretto"; display_name = "杏仁利口酒"
	description = "带有甜美香气的温和酒饮。"
	color = "#E17600"
	boozepwr = 25
	taste_description = "fruity and nutty sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/cognac
	name = "Cognac"; display_name = "干邑白兰地"
	description = "历经多次蒸馏和多年陈酿的香甜烈酒，优雅得要命。"
	color = "#AB3C05" // rgb: 171, 60, 5
	boozepwr = 75
	taste_description = "smooth and french"
	ph = 3.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/absinthe
	name = "Absinthe"; display_name = "苦艾酒"
	description = "一种烈酒，传闻会致幻，实际并不会。"
	color = rgb(10, 206, 0)
	boozepwr = 80 //Very strong even by default
	taste_description = "death and licorice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/absinthe/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/hooch
	name = "Hooch"; display_name = "劣酿酒"
	description = "要么是调酒失败的产物，要么是某人的酿酒尝试。不管怎样，你真想喝这个？"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 100
	taste_description = "pure resignation"
	addiction_types = list(/datum/addiction/maintenance_drugs = 600)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ale
	name = "Ale"; display_name = "艾尔啤酒"
	description = "用大麦芽和酵母酿造的深色酒精饮料。"
	color = "#976063" // rgb: 151,96,99
	boozepwr = 65
	taste_description = "hearty barley ale"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/goldschlager
	name = "Goldschlager"; display_name = "金箔肉桂酒"
	description = "酒精度50%的肉桂甜酒，专为春假里酗酒的少女准备。"
	color = "#FFFF91" // rgb: 255, 255, 145
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "burning cinnamon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

	// This drink is really popular with a certain demographic.
	var/teenage_girl_quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	// Reset quality each time, since the bottle can be shared
	quality = initial(quality)

	if(ishuman(exposed_mob))
		var/mob/living/carbon/human/human = exposed_mob
		// tgstation13 does not endorse underage drinking. laws may vary by your jurisdiction.
		if(human.age >= 13 && human.age <= 19 && human.gender == FEMALE)
			quality = teenage_girl_quality

	return ..()

/datum/reagent/consumable/ethanol/goldschlager/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return

	var/convert_amount = reac_volume * min(GOLDSCHLAGER_GOLD_RATIO, 1)
	var/datum/reagents/mob_reagents = exposed_mob.reagents

	mob_reagents.remove_reagent(/datum/reagent/consumable/ethanol/goldschlager, convert_amount)
	mob_reagents.add_reagent(/datum/reagent/gold, convert_amount)

/datum/reagent/consumable/ethanol/patron
	name = "Patron"; display_name = "培恩龙舌兰酒"
	description = "掺有银的龙舌兰酒，夜店酗酒女性的最爱。"
	color = "#585840" // rgb: 88, 88, 64
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "metallic and expensive"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/gintonic
	name = "Gin and Tonic"; display_name = "金汤力"
	description = "经久不衰的温和经典鸡尾酒。"
	color = "#cae7ec" // rgb: 202,231,236
	boozepwr = 20
	quality = DRINK_NICE
	taste_description = "mild and tart"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/rum_coke
	name = "Rum and Coke"; display_name = "朗姆可乐"
	description = "朗姆酒兑可乐。"
	taste_description = "cola"
	boozepwr = 30
	quality = DRINK_NICE
	color = "#3E1B00"
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre
	name = "Cuba Libre"; display_name = "自由古巴"
	description = "革命万岁！自由古巴万岁！"
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "a refreshing marriage of citrus and rum"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/cuba_libre/on_mob_life(mob/living/carbon/cubano, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(cubano.mind && cubano.mind.has_antag_datum(/datum/antagonist/rev)) //Cuba Libre, the traditional drink of revolutions! Heals revolutionaries.
		need_mob_update = cubano.adjust_brute_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_fire_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += cubano.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += cubano.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/whiskey_cola
	name = "Whiskey Cola"; display_name = "威士忌可乐"
	description = "威士忌兑可乐，意外地清爽。"
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "cola"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/martini
	name = "Classic Martini"; display_name = "经典马天尼"
	description = "味美思兑金酒，和007喝的有点不同，但依然美味。"
	color = "#cddbac" // rgb: 205,219,172
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "dry class"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/vodkamartini
	name = "Vodka Martini"; display_name = "伏特加马天尼"
	description = "伏特加兑金酒，和007喝的有点不同，但依然美味。"
	color = "#cddcad" // rgb: 205,220,173
	boozepwr = 65
	quality = DRINK_NICE
	taste_description = "shaken, not stirred"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS


/datum/reagent/consumable/ethanol/white_russian
	name = "White Russian"; display_name = "白俄罗斯"
	description = "老兄，那不过是你的看法……"
	color = "#A68340" // rgb: 166, 131, 64
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "bitter cream"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail
	name = "Screwdriver"; display_name = "螺丝起子"
	description = "伏特加兑普通橙汁，结果意外地好喝。"
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "oranges"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_new(data)
	. = ..()
	// We want to turn only base drinking glasses with screwdriver(cocktail) into screwdrivers(tool),
	// but we can't check style so we have to check type, and we don't want it match subtypes like istype does
	if(holder?.my_atom && holder.my_atom.type == /obj/item/reagent_containers/cup/glass/drinkingglass/)
		RegisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED, PROC_REF(on_reagent_change))
		if(src == holder.get_master_reagent())
			var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
			drink.tool_behaviour = TOOL_SCREWDRIVER
			drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')

/datum/reagent/consumable/ethanol/screwdrivercocktail/Destroy()
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = holder.my_atom
	if(istype(drink))
		if(drink.tool_behaviour == TOOL_SCREWDRIVER)
			drink.tool_behaviour = initial(drink.tool_behaviour)
			drink.usesound = initial(drink.usesound)
		UnregisterSignal(holder, COMSIG_REAGENTS_HOLDER_UPDATED)
	return ..()

/datum/reagent/consumable/ethanol/screwdrivercocktail/proc/on_reagent_change(datum/reagents/reagents)
	SIGNAL_HANDLER
	var/obj/item/reagent_containers/cup/glass/drinkingglass/drink = reagents.my_atom
	if(reagents.get_master_reagent() == src)
		drink.tool_behaviour = TOOL_SCREWDRIVER
		drink.usesound = list('sound/items/tools/screwdriver.ogg', 'sound/items/tools/screwdriver2.ogg')
	else
		drink.tool_behaviour = initial(drink.tool_behaviour)
		drink.usesound = initial(drink.usesound)

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_ENGINEER_METABOLISM))
		ADD_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")
		if (HAS_TRAIT(drinker, TRAIT_IRRADIATED))
			if(drinker.adjust_tox_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_HALT_RADIATION_EFFECTS, "[type]")

/datum/reagent/consumable/ethanol/booger
	name = "Booger"; display_name = "鼻屎"
	description = "呕……"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "sweet 'n creamy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary
	name = "Bloody Mary"; display_name = "血腥玛丽"
	description = "伏特加、番茄汁和青柠汁调成的奇特美味。至少你觉得红色的东西是番茄汁。"
	color = "#bf707c" // rgb: 191,112,124
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "tomatoes with a hint of lime and liquid murder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bloody_mary/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_blood_volume((0.25 + round(2 * drinker.get_drunk_amount() / 40, 0.1)) * metabolization_ratio * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL) // Bloody Mary restores blood loss based on how drunk you are

/datum/reagent/consumable/ethanol/brave_bull
	name = "Brave Bull"; display_name = "勇敢公牛"
	description = "壮胆的效果一点不差！"
	color = "#a79f98" // rgb: 167,159,152
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "alcoholic bravery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY
	metabolized_traits = list(TRAIT_FEARLESS, TRAIT_ANALGESIA)
	var/tough_text

/datum/reagent/consumable/ethanol/brave_bull/on_mob_metabolize(mob/living/drinker)
	. = ..()
	tough_text = pick("强壮", "坚韧", "硬朗", "健壮", "结实") //Tuff stuff
	to_chat(drinker, span_notice("你感觉自己变得[tough_text]！"))
	drinker.maxHealth += 10 //Brave Bull makes you sturdier, and thus capable of withstanding a tiny bit more punishment.
	drinker.health += 10

/datum/reagent/consumable/ethanol/brave_bull/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("你不再感觉自己那么[tough_text]了。"))
	drinker.maxHealth -= 10
	drinker.health = min(drinker.health - 10, drinker.maxHealth) //This can indeed crit you if you're alive solely based on alchol ingestion

/datum/reagent/consumable/ethanol/tequila_sunrise
	name = "Tequila Sunrise"; display_name = "龙舌兰日出"
	description = "龙舌兰酒、红石榴糖浆与橙汁。"
	color = "#FFE48C" // rgb: 255, 228, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "oranges with a hint of pomegranate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("你感觉一股柔和的暖意遍布全身！"))
	light_holder = new(drinker)
	light_holder.set_light(3, 0.7, COLOR_TANGERINE_YELLOW) //Tequila Sunrise makes you radiate dim light, like a sunrise!

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != drinker)
		light_holder.forceMove(drinker)
	return ..()

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	to_chat(drinker, span_notice("体内的暖意渐渐消退。"))
	QDEL_NULL(light_holder)

/datum/reagent/consumable/ethanol/toxins_special
	name = "Toxins Special"; display_name = "毒物特调"
	description = "这玩意着火了！快叫穿梭机！"
	color = "#8880a8" // rgb: 136,128,168
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "spicy toxins"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/toxins_special/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(15 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/beepsky_smash
	name = "Beepsky Smash"; display_name = "哔普斯基重击"
	description = "喝下它，准备迎接法律的制裁。"
	color = COLOR_OLIVE // rgb: 128,128,0
	boozepwr = 60 //THE FIST OF THE LAW IS STRONG AND HARD
	quality = DRINK_GOOD
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "JUSTICE"
	overdose_threshold = 40
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/beepsky/beepsky_hallucination

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		metabolization_rate = 4 * REAGENTS_METABOLISM
	// if you don't have a liver, or your liver isn't an officer's liver
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		beepsky_hallucination = new()
		drinker.gain_trauma(beepsky_hallucination, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_jitter_if_lower(4 SECONDS)
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you have a liver and that liver is an officer's liver
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		if(drinker.adjust_stamina_loss(-4 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
		if(SPT_PROB(10, seconds_per_tick))
			drinker.cause_hallucination(get_random_valid_hallucination_subtype(/datum/hallucination/nearby_fake_item), name)
		if(SPT_PROB(5, seconds_per_tick))
			drinker.cause_hallucination(/datum/hallucination/stray_bullet, name)

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(beepsky_hallucination)
		QDEL_NULL(beepsky_hallucination)

/datum/reagent/consumable/ethanol/beepsky_smash/overdose_start(mob/living/carbon/drinker, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	// if you don't have a liver, or your liver isn't an officer's liver
	if(!liver || !HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		drinker.gain_trauma(/datum/brain_trauma/mild/phobia/security, TRAUMA_RESILIENCE_BASIC)

/datum/reagent/consumable/ethanol/irish_cream
	name = "Irish Cream"; display_name = "爱尔兰奶油酒"
	description = "融入威士忌的奶油，还能指望爱尔兰人做什么？"
	color = "#e3d0b2" // rgb: 227,208,178
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "creamy alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manly_dorf
	name = "The Manly Dorf"; display_name = "硬汉矮人"
	description = "啤酒和艾尔啤酒调成的美味混合物，专供真正的男子汉。"
	color = "#815336" // rgb: 129,83,54
	boozepwr = 100 //For the manly only
	quality = DRINK_NICE
	taste_description = "hair on your chest and your chin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/dorf_mode = FALSE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/potential_dwarf = drinker
		if(HAS_TRAIT(potential_dwarf, TRAIT_DWARF))
			to_chat(potential_dwarf, span_notice("这才叫男子气概！"))
			boozepwr = 50 // will still smash but not as much.
			dorf_mode = TRUE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_life(mob/living/carbon/dwarf, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(dorf_mode)
		var/need_mob_update
		need_mob_update = dwarf.adjust_brute_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += dwarf.adjust_fire_loss(-2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/longislandicedtea
	name = "Long Island Iced Tea"; display_name = "长岛冰茶"
	description = "把整个酒柜调成一杯美味，专供酗酒的中年女性。"
	color = "#ff6633" // rgb: 255,102,51
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "a mixture of cola and alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/moonshine
	name = "Moonshine"; display_name = "私酿烈酒"
	description = "你真是堕落到底了……你的肝昨晚已经收拾行李跑路了。"
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha) (like water)
	boozepwr = 95
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/b52
	name = "B-52"; display_name = "B-52轰炸机"
	description = "咖啡、爱尔兰奶油酒和干邑白兰地。保准把你灌倒。"
	color = "#8f1733" // rgb: 143,23,51
	boozepwr = 85
	quality = DRINK_GOOD
	taste_description = "angry and irish"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/b52/on_mob_metabolize(mob/living/drinker)
	. = ..()
	playsound(drinker, 'sound/effects/explosion/explosion_distant.ogg', 100, FALSE)

/datum/reagent/consumable/ethanol/irishcoffee
	name = "Irish Coffee"; display_name = "爱尔兰咖啡"
	description = "咖啡加酒，早上喝比含羞草鸡尾酒更有意思。"
	color = "#874010" // rgb: 135,64,16
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "giving up on the day"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/margarita
	name = "Margarita"; display_name = "玛格丽塔"
	description = "加冰，杯沿抹盐。干杯～！"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "dry and salty"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/black_russian
	name = "Black Russian"; display_name = "黑俄罗斯"
	description = "适合乳糖不耐受者，和白俄罗斯一样优雅。"
	color = "#360000" // rgb: 54, 0, 0
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan
	name = "Manhattan"; display_name = "曼哈顿"
	description = "侦探卧底时的首选酒饮。他一直喝不惯金酒……"
	color = "#ff3300" // rgb: 255,51,0
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "mild dryness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/manhattan_proj
	name = "Manhattan Project"; display_name = "曼哈顿计划"
	description = "科学家琢磨如何炸掉空间站时的首选酒饮。"
	color = COLOR_MOSTLY_PURE_RED
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "death, the destroyer of worlds"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/manhattan_proj/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(1 MINUTES * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/whiskeysoda
	name = "Whiskey Soda"; display_name = "苏打威士忌"
	description = "献给更有品位的捣蛋鬼。"
	color = "#ffcc33" // rgb: 255,204,51
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze
	name = "Anti-freeze"; display_name = "防冻液"
	description = "极致清爽，别被名字吓着。"
	color = "#30f0f8" // rgb: 48,240,248
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "Jack Frost's piss"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/antifreeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, drinker.get_body_temp_normal() + 20) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/barefoot
	name = "Barefoot"; display_name = "赤足"
	description = "赤着脚，怀着孕。"
	color = "#fc5acc" // rgb: 252,90,204
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "creamy berries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/barefoot/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker)) //Barefoot causes the imbiber to quickly regenerate brute trauma if they're not wearing shoes.
		var/mob/living/carbon/human/unshoed = drinker
		if(!unshoed.shoes)
			if(unshoed.adjust_brute_loss(-3 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/snowwhite
	name = "Snow White"; display_name = "白雪公主"
	description = "冰凉的消暑饮品。"
	color = COLOR_WHITE // rgb: 255, 255, 255
	boozepwr = 20
	quality = DRINK_NICE
	taste_description = "refreshing cold"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/demonsblood
	name = "Demon's Blood"; display_name = "恶魔之血"
	description = "啊啊啊啊！！！！"
	color = "#820000" // rgb: 130, 0, 0
	boozepwr = 75
	quality = DRINK_VERYGOOD
	taste_description = "sweet tasting iron"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/demonsblood/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED, PROC_REF(pre_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/demonsblood/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_PRE_CONSUMED)

/// Prevents the imbiber from being dragged into a pool of blood by a slaughter demon.
/datum/reagent/consumable/ethanol/demonsblood/proc/pre_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
	obj/effect/decal/cleanable/blood,
)

	SIGNAL_HANDLER

	var/turf/jaunt_turf = get_turf(jaunter)
	jaunt_turf.visible_message(
		span_warning("有什么东西阻止了[source]进入[blood]！"),
		blind_message = span_notice("你听见水花声和一声闷响。")
	)
	to_chat(jaunter, span_warning("一股奇异的力量阻止了[source]进入！"))

	return COMPONENT_STOP_CONSUMPTION

/datum/reagent/consumable/ethanol/devilskiss
	name = "Devil's Kiss"; display_name = "魔鬼之吻"
	description = "惊悚时刻到了！"
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "bitter iron"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/devilskiss/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	RegisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED, PROC_REF(on_bloodcrawl_consumed))

/datum/reagent/consumable/ethanol/devilskiss/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	UnregisterSignal(metabolizer, COMSIG_LIVING_BLOOD_CRAWL_CONSUMED)

/// If eaten by a slaughter demon, the demon will regret it.
/datum/reagent/consumable/ethanol/devilskiss/proc/on_bloodcrawl_consumed(
	mob/living/source,
	datum/action/cooldown/spell/jaunt/bloodcrawl/crawl,
	mob/living/jaunter,
)

	SIGNAL_HANDLER

	. = COMPONENT_STOP_CONSUMPTION

	to_chat(jaunter, span_boldwarning("啊！血肉！烧起来了！"))
	jaunter.apply_damage(25, BRUTE, wound_bonus = CANT_WOUND)

	for(var/obj/effect/decal/cleanable/nearby_blood in range(1, get_turf(source)))
		if(!nearby_blood.can_bloodcrawl_in())
			continue
		source.forceMove(get_turf(nearby_blood))
		source.visible_message(span_warning("[nearby_blood]猛烈地将[source]喷了出来！"))
		crawl.exit_blood_effect(source)
		return

	// Fuck it, just eject them, thanks to some split second cleaning
	source.forceMove(get_turf(source))
	source.visible_message(span_warning("[source]浑身是血地凭空出现了！"))
	crawl.exit_blood_effect(source)

/datum/reagent/consumable/ethanol/vodkatonic
	name = "Vodka and Tonic"; display_name = "伏特加汤力"
	description = "适合嫌金汤力不够俄罗斯的人。"
	color = "#0064C8" // rgb: 0, 100, 200
	boozepwr = 40
	quality = DRINK_NICE
	taste_description = "tart bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ginfizz
	name = "Gin Fizz"; display_name = "金菲士"
	description = "清新柠香，爽口干冽。"
	color = "#ffffcc" // rgb: 255,255,204
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "dry, tart lemons"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bahama_mama
	name = "Bahama Mama"; display_name = "巴哈马妈妈"
	description = "风味丰富的热带鸡尾酒。"
	color = "#FF7F3B" // rgb: 255, 127, 59
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "pineapple, coconut, and a hint of coffee"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/singulo
	name = "Singulo"; display_name = "奇点鸡尾酒"
	description = "一种蓝空间饮料！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "concentrated matter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_MADNESS_IMMUNE)
	var/static/list/ray_filter = list(type = "rays", size = 40, density = 15, color = SUPERMATTER_SINGULARITY_RAYS_COLOUR, factor = 15)

/datum/reagent/consumable/ethanol/singulo/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_filter("singulo_rays")

/datum/reagent/consumable/ethanol/singulo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		// 20u = 1x1, 45u = 2x2, 80u = 3x3
		var/volume_to_radius = FLOOR(sqrt(volume/5), 1) - 1
		var/suck_range = clamp(volume_to_radius, 0, 3)

		if(!suck_range)
			return ..()

		var/turf/gravity_well_turf = get_turf(drinker)
		goonchem_vortex(gravity_well_turf, 0, suck_range)
		playsound(get_turf(drinker), 'sound/effects/supermatter.ogg', 150, TRUE)
		drinker.add_filter("singulo_rays", 1, ray_filter)
		animate(drinker.get_filter("singulo_rays"), offset = 10, time = 1.5 SECONDS, loop = -1)
		addtimer(CALLBACK(drinker, TYPE_PROC_REF(/datum, remove_filter), "singulo_rays"), 1.5 SECONDS)
		drinker.emote("burp")

/datum/reagent/consumable/ethanol/sbiten
	name = "Sbiten"; display_name = "香料蜜酒"
	description = "辛辣的伏特加！小个子可能会觉得有点烫！"
	color = "#d8d5ae" // rgb: 216,213,174
	boozepwr = 70
	quality = DRINK_GOOD
	taste_description = "hot and spice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sbiten/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(50 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, BODYTEMP_HEAT_DAMAGE_LIMIT) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/red_mead
	name = "Red Mead"; display_name = "红蜜酒"
	description = "真正的维京人饮品！虽然红得有点古怪。"
	color = "#C73C00" // rgb: 199, 60, 0
	boozepwr = 31 //Red drinks are stronger
	quality = DRINK_GOOD
	taste_description = "sweet and salty alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mead
	name = "Mead"; display_name = "蜂蜜酒"
	description = "一种维京人饮品，不过是便宜货。"
	color = "#e0c058" // rgb: 224,192,88
	nutriment_factor = 1
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "sweet, sweet alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer
	name = "Iced Beer"; display_name = "冰啤酒"
	description = "冷得连周围空气都会冻结的啤酒。"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 15
	taste_description = "refreshingly cold"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/iced_beer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, T0C) //310.15 is the normal bodytemp.

/datum/reagent/consumable/ethanol/grog
	name = "Grog"; display_name = "格罗格酒"
	description = "兑水的朗姆酒，纳诺传讯表示赞同！"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 1 //Basically nothing
	taste_description = "a poor excuse for alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aloe
	name = "Aloe"; display_name = "芦荟鸡尾酒"
	description = "好喝得不得了。"
	color = "#f8f800" // rgb: 248,248,0
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "sweet 'n creamy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	//somewhat annoying mix
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/andalusia
	name = "Andalusia"; display_name = "安达卢西亚"
	description = "名字奇怪，却很好喝。"
	color = "#c8f860" // rgb: 200,248,96
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "lemons"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/alliescocktail
	name = "Allies Cocktail"; display_name = "盟友鸡尾酒"
	description = "用你的盟友调成的饮料，没有用敌人调成的那么甜。"
	color = "#60f8f8" // rgb: 96,248,248
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "bitter yet free"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/acid_spit
	name = "Acid Spit"; display_name = "酸液喷吐"
	description = "献给胆大之人的饮品，调配不当可能致命！"
	color = "#365000" // rgb: 54, 80, 0
	boozepwr = 70
	quality = DRINK_VERYGOOD
	taste_description = "stomach acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amasec
	name = "Amasec"; display_name = "阿玛赛克酒"
	description = "纳诺传讯枪械俱乐部官方饮品！"
	color = "#e0e058" // rgb: 224,224,88
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "dark and metallic"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting
	name = "Changeling Sting"; display_name = "变形怪之刺"
	description = "轻轻抿一口，一股灼烧感随之而来……"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "your brain coming out your nose"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/changelingsting/on_mob_life(mob/living/carbon/target, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(target)
	changeling?.adjust_chemicals(metabolization_rate * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/irishcarbomb
	name = "Irish Car Bomb"; display_name = "爱尔兰汽车炸弹"
	description = "嗯，有爱尔兰自由邦的味道。"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "the spirit of Ireland"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb
	name = "Syndicate Bomb"; display_name = "辛迪加炸弹"
	description = "尝起来像恐怖主义！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 90
	quality = DRINK_GOOD
	taste_description = "purified antagonism"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/syndicatebomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2.5, seconds_per_tick))
		playsound(get_turf(drinker), 'sound/effects/explosion/explosionfar.ogg', 100, TRUE)

/datum/reagent/consumable/ethanol/hiveminderaser
	name = "Hivemind Eraser"; display_name = "蜂巢意识清除剂"
	description = "满载纯粹风味的容器。"
	color = "#FF80FC" // rgb: 255, 128, 252
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "psychic links"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/erikasurprise
	name = "Erika Surprise"; display_name = "艾丽卡惊喜"
	description = "惊喜就是，它是绿色的！"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "tartness and bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/driestmartini
	name = "Driest Martini"; display_name = "极干马天尼"
	description = "仅供老手。你仿佛看见杯里漂着沙子。"
	nutriment_factor = 1
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 65
	quality = DRINK_GOOD
	taste_description = "a beach"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk
	name = "Banana Honk"; display_name = "香蕉HONK"
	description = "来自小丑天堂的饮品。"
	nutriment_factor = 1
	color = "#FFFF91" // rgb: 255, 255, 140
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "a bad joke"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bananahonk/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if((liver && HAS_TRAIT(liver, TRAIT_COMEDY_METABOLISM)) || HAS_TRAIT(drinker, TRAIT_SIMIAN))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/silencer
	name = "Silencer"; display_name = "消音器"
	description = "来自默剧演员天堂的饮品。"
	nutriment_factor = 2
	color = "#a8a8a8" // rgb: 168,168,168
	boozepwr = 59 //Proof that clowns are better than mimes right here
	quality = DRINK_GOOD
	taste_description = "a pencil eraser"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/silencer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/drunkenblumpkin
	name = "Drunken Blumpkin"; display_name = "醉蓝南瓜"
	description = "威士忌和蓝南瓜汁的古怪混合物。"
	color = "#1EA0FF" // rgb: 30,160,255
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "molasses and a mouthful of pool water"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/whiskey_sour //Requested since we had whiskey cola and soda but not sour.
	name = "Whiskey Sour"; display_name = "威士忌酸"
	description = "柠檬汁、威士忌和糖的混合物，酒精含量适中。"
	color = rgb(255, 201, 49)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "sour lemons"

/datum/reagent/consumable/ethanol/hcider
	name = "Hard Cider"; display_name = "苹果酒"
	description = "成年人喝的苹果汁。"
	color = "#CD6839"
	nutriment_factor = 1
	boozepwr = 25
	taste_description = "the season that <i>falls</i> between summer and winter"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/fetching_fizz //A reference to one of my favorite games of all time. Pulls nearby ores to the imbiber!
	name = "Fetching Fizz"; display_name = "引力气泡"
	description = "威士忌酸、铁和铀混成的强磁性浆液，酒精含量较低。" //Requires no alcohol to make but has alcohol anyway because ~magic~
	color = rgb(255, 91, 15)
	boozepwr = 10
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	taste_description = "charged metal" // the same as teslium, honk honk.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fetching_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/turf/drinker_turf = get_turf(drinker)
	for(var/obj/item/stack/ore/ore in orange(3, drinker))
		step_towards(ore, drinker_turf)

//Another reference. Heals those in critical condition extremely quickly.
/datum/reagent/consumable/ethanol/hearty_punch
	name = "Hearty Punch"; display_name = "强心宾治"
	description = "勇敢公牛、辛迪加炸弹和苦艾酒调成的提神饮料，酒精含量较低。"
	color = rgb(140, 0, 0)
	boozepwr = 90
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	taste_description = "bravado in the face of disaster"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hearty_punch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health <= 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_oxy_loss(-5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_tox_loss(-3.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bacchus_blessing //An EXTREMELY powerful drink. Smashed in seconds, dead in minutes.
	name = "Bacchus' Blessing"; display_name = "巴克斯的祝福"
	description = "成分不明的混合物，酒精含量高得无法测量。"
	color = rgb(51, 19, 3) //Sickly brown
	boozepwr = 300 //I warned you
	taste_description = "a wall of bricks"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/atomicbomb
	name = "Atomic Bomb"; display_name = "原子弹"
	description = "核扩散从未如此美味。"
	color = "#666300" // rgb: 102, 99, 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	taste_description = "da bomb"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/atomicbomb/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_confusion(2 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_slurring(6 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(52 to 201)
			drinker.Sleeping(100 * metabolization_ratio * seconds_per_tick)
		if(202 to INFINITY)
			drinker.AdjustSleeping(4 SECONDS * metabolization_ratio * seconds_per_tick)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/gargle_blaster
	name = "Pan-Galactic Gargle Blaster"; display_name = "泛银河含漱爆破酒"
	description = "哇，这东西看起来很不稳定！"
	color = "#9cc8b4" // rgb: 156,200,180
	boozepwr = 0 //custom drunk effect
	quality = DRINK_GOOD
	taste_description = "your brains smashed out by a lemon wrapped around a gold brick"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/gargle_blaster/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_dizzy(3 SECONDS * metabolization_ratio * seconds_per_tick)
	switch(current_cycle)
		if(16 to 46)
			drinker.adjust_slurring(3 SECONDS * metabolization_ratio * seconds_per_tick)
		if(46 to 56)
			if(SPT_PROB(30, seconds_per_tick))
				drinker.adjust_confusion(3 SECONDS * metabolization_ratio)
		if(56 to 201)
			drinker.set_drugginess(110 SECONDS * metabolization_ratio * seconds_per_tick)
		if(201 to INFINITY)
			if(drinker.adjust_tox_loss(2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
				return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin
	name = "Neurotoxin"; display_name = "神经毒素"
	description = "能让饮用者陷入假死状态的强效神经毒素。"
	color = "#2E2E61" // rgb: 46, 46, 97
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "a numbing sensation"
	metabolization_rate = REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/neurotoxin/proc/pick_paralyzed_limb()
	return (pick(TRAIT_PARALYSIS_L_ARM,TRAIT_PARALYSIS_R_ARM,TRAIT_PARALYSIS_R_LEG,TRAIT_PARALYSIS_L_LEG))

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(50 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.adjust_dizzy(2 SECONDS * metabolization_ratio * seconds_per_tick)
	var/need_mob_update
	need_mob_update = drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * metabolization_ratio * seconds_per_tick, 150, required_organ_flag = affected_organ_flags)
	if(SPT_PROB(10, seconds_per_tick))
		need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		drinker.drop_all_held_items()
		to_chat(drinker, span_notice("你的双手失去了知觉！"))
	if(current_cycle > 6)
		if(SPT_PROB(10, seconds_per_tick))
			var/paralyzed_limb = pick_paralyzed_limb()
			ADD_TRAIT(drinker, paralyzed_limb, type)
			need_mob_update += drinker.adjust_stamina_loss(5 * metabolization_ratio, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(current_cycle > 31)
			need_mob_update += drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 1 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
			if(current_cycle > 51 && SPT_PROB(7.5, seconds_per_tick))
				if(!drinker.undergoing_cardiac_arrest() && drinker.can_heartattack())
					drinker.set_heartattack(TRUE)
					if(!IS_UNCONSCIOUS_OR_CRIT(drinker))
						drinker.visible_message(span_userdanger("[drinker]捂住胸口，仿佛心脏停止了跳动！"))
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/neurotoxin/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_ARM, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_R_LEG, type)
	REMOVE_TRAIT(drinker, TRAIT_PARALYSIS_L_LEG, type)
	drinker.adjust_stamina_loss(10, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/hippies_delight
	name = "Hippie's Delight"; display_name = "嬉皮之乐"
	description = "老兄，你就是不懂。"
	color = "#b16e8b" // rgb: 177,110,139
	nutriment_factor = 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	taste_description = "giving peace a chance"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/hippies_delight/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_slurring_if_lower(2.5 SECONDS * metabolization_ratio * seconds_per_tick)

	switch(current_cycle)
		if(2 to 6)
			drinker.set_dizzy_if_lower(50 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(150 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(5, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(6 to 11)
			drinker.set_jitter_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(100 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(225 SECONDS * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(10, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if (11 to 201)
			drinker.set_jitter_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(200 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(5 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(16, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
		if(201 to INFINITY)
			drinker.set_jitter_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_dizzy_if_lower(300 SECONDS * metabolization_ratio * seconds_per_tick)
			drinker.set_drugginess(6.25 MINUTES * metabolization_ratio * seconds_per_tick)
			if(SPT_PROB(23, seconds_per_tick))
				drinker.emote(pick("twitch","giggle"))
			if(SPT_PROB(16, seconds_per_tick))
				if(drinker.adjust_tox_loss(5 * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
					return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/eggnog
	name = "Eggnog"; display_name = "蛋奶酒"
	description = "享受一年中最美好的时光。"
	color = "#ffe2ad" // rgb: 255, 226, 173
	nutriment_factor = 2
	boozepwr = 1
	quality = DRINK_VERYGOOD
	taste_description = "custard and alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dreadnog
	name = "Dreadnog"; display_name = "恐惧蛋奶酒"
	description = "在欢乐时节饱受折磨。"
	color = "#f7ffad" // rgb: 247, 255, 173
	nutriment_factor = 3 * REAGENTS_METABOLISM
	boozepwr = 1
	quality = DRINK_REVOLTING
	taste_description = "custard and alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour
	name = "Nar'Sour"; display_name = "纳尔酸"
	description = "副作用包括自残和囤积塑钢。"
	color = RUNE_COLOR_DARKRED
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "bloody"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/narsour/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_timed_status_effect(6 SECONDS * metabolization_ratio * seconds_per_tick, /datum/status_effect/speech/slurring/cult, max_duration = 6 SECONDS)
	drinker.adjust_stutter_up_to(6 SECONDS * metabolization_ratio * seconds_per_tick, 6 SECONDS)

/datum/reagent/consumable/ethanol/triple_sec
	name = "Triple Sec"; display_name = "三重橙酒"
	description = "香甜鲜明的橙味利口酒。"
	color = COLOR_ICECREAM_PEACH
	boozepwr = 30
	taste_description = "a warm flowery orange taste which recalls the ocean air and summer wind of the caribbean"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_menthe
	name = "Creme de Menthe"; display_name = "薄荷利口酒"
	description = "薄荷味利口酒，非常适合调制清凉饮品。"
	color = "#467446" //rgb: 70, 116, 70
	boozepwr = 20
	taste_description = "a minty, cool, and invigorating splash of cold streamwater"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_cacao
	name = "Creme de Cacao"; display_name = "可可利口酒"
	description = "巧克力味利口酒，适合为饮品增添甜点风味，也适合贿赂女生联谊会。"
	color = "#350900" // rgb: 53, 9, 0
	boozepwr = 20
	taste_description = "a slick and aromatic hint of chocolates swirling in a bite of alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/creme_de_coconut
	name = "Creme de Coconut"; display_name = "椰子利口酒"
	description = "适合调制顺滑浓郁热带饮品的椰子利口酒。"
	color = "#F7F0D0"
	boozepwr = 20
	taste_description = "a sweet milky flavor with notes of toasted sugar"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec
	name = "Quadruple Sec"; display_name = "四重橙酒"
	description = "劲头像舔电击棍电池一样猛，但更好喝。"
	color = "#cc0000"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "an invigorating bitter freshness which suffuses your being; no enemy of the station will go unrobusted this day"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quadruple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/quintuple_sec
	name = "Quintuple Sec"; display_name = "五重橙酒"
	description = "将法律、秩序、酒精和警察暴力蒸馏成一剂正义灵药。"
	color = "#ff3300"
	boozepwr = 55
	quality = DRINK_FANTASTIC
	taste_description = "THE LAW"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/quintuple_sec/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//Securidrink in line with the Screwdriver for engineers or Nothing for mimes but STRONG..
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(2 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio *  seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/grasshopper
	name = "Grasshopper"; display_name = "蚱蜢"
	description = "清新香甜的甜点短饮，喝它时很难显得有男子气概。"
	color = "#00ff00"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "chocolate and mint dancing around your mouth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/stinger
	name = "Stinger"; display_name = "毒刺"
	description = "干脆利落地结束这一天。"
	color = "#ccff99"
	boozepwr = 55
	quality = DRINK_NICE
	taste_description = "a slap on the face in the best possible way"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bastion_bourbon
	name = "Bastion Bourbon"; display_name = "堡垒波本威士忌"
	description = "舒缓身心、恢复活力的热草药酒饮，带有淡淡柑橘与浆果风味。"
	color = COLOR_CYAN
	boozepwr = 30
	quality = DRINK_FANTASTIC
	taste_description = "hot herbal brew with a hint of fruit"
	metabolization_rate = 2 * REAGENTS_METABOLISM //0.4u per second
	ph = 4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_metabolize(mob/living/drinker)
	. = ..()
	var/heal_points = 10
	if(drinker.health <= 0)
		heal_points = 20 //heal more if we're in softcrit
	var/need_mob_update
	var/heal_amt = min(volume, heal_points) //only heals 1 point of damage per unit on add, for balance reasons
	need_mob_update = drinker.adjust_brute_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_fire_loss(-heal_amt, updating_health = FALSE, required_bodytype = affected_bodytype)
	need_mob_update += drinker.adjust_tox_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype)
	need_mob_update += drinker.adjust_oxy_loss(-heal_amt, updating_health = FALSE, required_biotype = affected_biotype)
	// heal stamina loss on first metabolization, but only to a max of 20
	need_mob_update += drinker.adjust_stamina_loss(max(-heal_amt * 5, -20), updating_stamina = FALSE, required_biotype = affected_biotype)
	if(need_mob_update)
		drinker.updatehealth()
	drinker.visible_message(span_warning("[drinker]浑身一振，恢复了活力！"), span_notice("一口[display_name || name]便让你充满能量！"))
	if(!IS_UNCONSCIOUS_OR_CRIT(drinker) && heal_points == 20) //brought us out of softcrit
		drinker.visible_message(span_danger("[drinker]摇晃着站了起来！"), span_boldnotice("起来继续干，小子。"))

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.health > 0)
		var/need_mob_update
		need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += drinker.adjust_tox_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_oxy_loss(-0.75 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_stamina_loss(-1.25 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/squirt_cider
	name = "Squirt Cider"; display_name = "喷汁苹果酒"
	description = "发酵的喷汁提取液，闻起来像陈面包和海水。谁知道喷汁是什么。"
	color = COLOR_RED
	boozepwr = 40
	taste_description = "stale bread with a staler aftertaste"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/squirt_cider/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety += 5 * metabolization_ratio * seconds_per_tick //for context, vitamins give 15 satiety per second

/datum/reagent/consumable/ethanol/fringe_weaver
	name = "Fringe Weaver"; display_name = "边缘编织者"
	description = "气泡丰富、优雅又够劲，是故障城的经典饮品。"
	color = "#FFEAC4"
	boozepwr = 90 //classy hooch, essentially, but lower pwr to make up for slightly easier access
	quality = DRINK_GOOD
	taste_description = "ethylic alcohol with a hint of sugar"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush
	name = "Sugar Rush"; display_name = "糖分冲刺"
	description = "香甜轻盈，果味十足，少女心拉满。"
	color = "#FF226C"
	boozepwr = 10
	quality = DRINK_GOOD
	taste_description = "your arteries clogging with sugar"
	nutriment_factor = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sugar_rush/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.satiety -= 10 * metabolization_ratio * seconds_per_tick //junky as hell! a whole glass will keep you from being able to eat junk food

/datum/reagent/consumable/ethanol/crevice_spike
	name = "Crevice Spike"; display_name = "裂隙尖刺"
	description = "又酸又苦，醒酒效果惊人。"
	color = "#5BD231"
	boozepwr = -10 //sobers you up - ideally, one would drink to get hit with brute damage now to avoid alcohol problems later
	quality = DRINK_VERYGOOD
	taste_description = "a bitter SPIKE with a sour aftertaste"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/crevice_spike/on_mob_metabolize(mob/living/drinker) //damage only applies when drink first enters system and won't again until drink metabolizes out
	. = ..()
	drinker.adjust_brute_loss(3 * min(5,volume), required_bodytype = affected_bodytype) //minimum 3 brute damage on ingestion to limit non-drink means of injury - a full 5 unit gulp of the drink trucks you for the full 15

/datum/reagent/consumable/ethanol/sake
	name = "Sake"; display_name = "清酒"
	description = "合法性存疑、劲头极大的甜米酒。"
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "sweet rice wine"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/peppermint_patty
	name = "Peppermint Patty"; display_name = "薄荷夹心"
	description = "低度酒饮，兼具薄荷醇和可可的好处。"
	color = "#45ca7a"
	taste_description = "mint and chocolate"
	boozepwr = 25
	quality = DRINK_GOOD
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/peppermint_patty/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)
	drinker.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, drinker.get_body_temp_normal())

/datum/reagent/consumable/ethanol/alexander
	name = "Alexander"; display_name = "亚历山大"
	description = "以希腊英雄命名，据说能强化饮用者的盾牌，仿佛置身方阵。"
	color = "#F5E9D3"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "bitter, creamy cacao"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/weakref/mighty_shield

/datum/reagent/consumable/ethanol/alexander/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(ishuman(drinker))
		var/mob/living/carbon/human/the_human = drinker
		for(var/obj/item/shield/the_shield in the_human.contents)
			mighty_shield = WEAKREF(the_shield)
			the_shield.block_chance += 10
			to_chat(the_human, span_notice("[the_shield]看起来被擦亮了，虽然你不记得自己擦过。"))
			break

/datum/reagent/consumable/ethanol/alexander/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield && !(the_shield in drinker.contents)) //If you had a shield and lose it, you lose the reagent as well. Otherwise this is just a normal drink.
		holder.remove_reagent(type, volume)
		return
	return ..()

/datum/reagent/consumable/ethanol/alexander/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	var/obj/item/shield/the_shield = mighty_shield?.resolve()
	if(the_shield)
		the_shield.block_chance -= 10
		to_chat(drinker,span_notice("你发现[the_shield]又变得破旧了，真奇怪。"))
		mighty_shield = null

/datum/reagent/consumable/ethanol/amaretto_alexander
	name = "Amaretto Alexander"; display_name = "杏仁亚历山大"
	description = "度数较低的亚历山大，用风味弥补了劲头的不足。"
	color = "#DBD5AE"
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "sweet, creamy cacao"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sidecar
	name = "Sidecar"; display_name = "边车"
	description = "唯一让你乐意把方向盘交给别人的座驾。"
	color = "#FFC55B"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "delicious freedom"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets
	name = "Between the Sheets"; display_name = "床笫之间"
	description = "名字撩人的经典酒饮。有趣的是，医生建议盖着床单小睡前喝一杯。"
	color = "#F4C35A"
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "seduction"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/between_the_sheets/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/is_between_the_sheets = FALSE
	for(var/obj/item/bedsheet/bedsheet in range(drinker.loc, 0))
		if(bedsheet.loc != drinker.loc) // bedsheets in your backpack/neck don't count
			continue
		is_between_the_sheets = TRUE
		break

	if(!drinker.IsSleeping() || !is_between_the_sheets)
		return

	var/need_mob_update
	if(drinker.get_brute_loss() && drinker.get_fire_loss()) //If you are damaged by both types, slightly increased healing but it only heals one. The more the merrier wink wink.
		if(prob(50))
			need_mob_update = drinker.adjust_brute_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
		else
			need_mob_update = drinker.adjust_fire_loss(-0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_brute_loss()) //If you have only one, it still heals but not as well.
		need_mob_update = drinker.adjust_brute_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE,  required_bodytype = affected_bodytype)
	else if(drinker.get_fire_loss())
		need_mob_update = drinker.adjust_fire_loss(-0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/kamikaze
	name = "Kamikaze"; display_name = "神风"
	description = "神赐之风。"
	color = "#EEF191"
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "divine windiness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mojito
	name = "Mojito"; display_name = "莫吉托"
	description = "看起来和喝起来一样清爽的酒饮。"
	color = "#DFFAD9"
	boozepwr = 20
	quality = DRINK_GOOD
	taste_description = "refreshing mint"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/moscow_mule
	name = "Moscow Mule"; display_name = "莫斯科骡子"
	description = "冰冷的酒饮，让你想起废弃空间站。"
	color = "#EEF1AA"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "refreshing spiciness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet
	name = "Fernet"; display_name = "菲奈特苦酒"
	description = "极苦的草本利口酒，用作餐后酒。"
	color = "#1B2E24" // rgb: 27, 46, 36
	boozepwr = 80
	taste_description = "utter bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fernet_cola
	name = "Fernet Cola"; display_name = "菲奈特可乐"
	description = "广受欢迎的苦甜餐后酒，适合大餐后享用。按传统用锯开的可乐瓶盛装最佳。"
	color = "#390600" // rgb: 57, 6,
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "sweet relief"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/fernet_cola/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.nutrition <= NUTRITION_LEVEL_STARVING)
		if(drinker.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
			. = UPDATE_MOB_HEALTH
	drinker.adjust_nutrition(-3 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli
	name = "Fanciulli"; display_name = "范丘利"
	description = "如果曼哈顿鸡尾酒真用苦草本利口酒来调呢？有助于醒酒。" //also causes a bit of stamina damage to symbolize the afterdrink lazyness
	color = "#CA933F" // rgb: 202, 147, 63
	boozepwr = -10
	quality = DRINK_NICE
	taste_description = "a sweet sobering mix"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/fanciulli/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_nutrition(-5 * metabolization_ratio * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/fanciulli/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(20, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/branca_menta
	name = "Branca Menta"; display_name = "布兰卡薄荷"
	description = "苦涩菲奈特与薄荷利口酒的清爽混合物。"
	color = "#4B5746" // rgb: 75, 87, 70
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "a bitter freshness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/branca_menta/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, T0C)

/datum/reagent/consumable/ethanol/branca_menta/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(drinker.health > 0)
		drinker.adjust_stamina_loss(35, required_biotype = affected_biotype)

/datum/reagent/consumable/ethanol/blank_paper
	name = "Blank Paper"; display_name = "空白纸页"
	description = "一杯冒泡的空白纸页，光看着就让人神清气爽。"
	nutriment_factor = 1
	color = "#DCDCDC" // rgb: 220, 220, 220
	boozepwr = 20
	quality = DRINK_GOOD
	taste_description = "bubbling possibility"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blank_paper/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(ishuman(drinker) && HAS_MIND_TRAIT(drinker, TRAIT_MIMING))
		drinker.set_silence_if_lower(MIMEDRINK_SILENCE_DURATION)
		var/heal = 1 * metabolization_ratio * seconds_per_tick
		if(drinker.heal_bodypart_damage(brute = heal, burn = heal, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/fruit_wine
	name = "Fruit Wine"; display_name = "果酒"
	description = "用种植作物酿成的酒。"
	color = COLOR_WHITE
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "bad coding"
	ph = 4
	var/list/names = list("null fruit" = 1) //Names of the fruits used. Associative list where name is key, value is the percentage of that fruit.
	var/list/tastes = list("bad coding" = 1) //List of tastes. See above.

/datum/reagent/consumable/ethanol/fruit_wine/on_new(list/data)
	if(!data)
		return

	src.data = data
	names = data["names"]
	tastes = data["tastes"]
	boozepwr = data["boozepwr"]
	color = data["color"]
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/on_merge(list/mix_data, amount)
	. = ..()
	var/diff = (amount/volume)
	if(diff < 1)
		color = BlendRGB(color, mix_data["color"], diff/2) //The percentage difference over two, so that they take average if equal.
	else
		color = BlendRGB(color, mix_data["color"], (1/diff)/2) //Adjust so it's always blending properly.
	var/oldvolume = volume-amount

	var/list/cachednames = mix_data["names"]
	for(var/name in names | cachednames)
		names[name] = ((names[name] * oldvolume) + (cachednames[name] * amount)) / volume

	var/list/cachedtastes = mix_data["tastes"]
	for(var/taste in tastes | cachedtastes)
		tastes[taste] = ((tastes[taste] * oldvolume) + (cachedtastes[taste] * amount)) / volume

	boozepwr *= oldvolume
	var/newzepwr = mix_data["boozepwr"] * amount
	boozepwr += newzepwr
	boozepwr /= volume //Blending boozepwr to volume.
	generate_data_info(data)

/datum/reagent/consumable/ethanol/fruit_wine/proc/generate_data_info(list/data)
	// BYOND's compiler fails to catch non-consts in a ranged switch case, and it causes incorrect behavior. So this needs to explicitly be a constant.
	var/const/minimum_percent = 0.15 //Percentages measured between 0 and 1.
	var/list/primary_tastes = list()
	var/list/secondary_tastes = list()
	for(var/taste in tastes)
		switch(tastes[taste])
			if(minimum_percent*2 to INFINITY)
				primary_tastes += taste
			if(minimum_percent to minimum_percent*2)
				secondary_tastes += taste

	var/minimum_name_percent = 0.35
	name = ""; display_name = ""
	var/list/names_in_order = sortTim(names, GLOBAL_PROC_REF(cmp_numeric_dsc), TRUE)
	var/named = FALSE
	for(var/fruit_name in names)
		if(names[fruit_name] >= minimum_name_percent)
			name += "[fruit_name] "; display_name += "[fruit_name]"
			named = TRUE
	if(named)
		name += "Wine"; display_name += "果酒"
	else
		name = "Mixed [names_in_order[1]] Wine"; display_name = "[names_in_order[1]]混酿果酒"

	var/alcohol_description
	switch(boozepwr)
		if(120 to INFINITY)
			alcohol_description = "suicidally strong"
		if(90 to 120)
			alcohol_description = "rather strong"
		if(70 to 90)
			alcohol_description = "strong"
		if(40 to 70)
			alcohol_description = "rich"
		if(20 to 40)
			alcohol_description = "mild"
		if(0 to 20)
			alcohol_description = "sweet"
		else
			alcohol_description = "watery" //How the hell did you get negative boozepwr?

	var/list/fruits = list()
	if(names_in_order.len <= 3)
		fruits = names_in_order
	else
		for(var/i in 1 to 3)
			fruits += names_in_order[i]
		fruits += "其他植物"
	var/fruit_list = english_list(fruits)
	description = "用[fruit_list]酿成的果酒，风味[list("suicidally strong" = "烈得要命", "rather strong" = "相当浓烈", "strong" = "浓烈", "rich" = "醇厚", "mild" = "温和", "sweet" = "香甜", "watery" = "寡淡")[alcohol_description]]。"

	var/flavor = ""
	if(!primary_tastes.len)
		primary_tastes = list("[alcohol_description] alcohol")
	flavor += english_list(primary_tastes)
	if(secondary_tastes.len)
		flavor += ", with a hint of "
		flavor += english_list(secondary_tastes)
	taste_description = flavor

/datum/reagent/consumable/ethanol/champagne //How the hell did we not have champagne already!?
	name = "Champagne"; display_name = "香槟"
	description = "一种以出击迅猛有力著称的起泡酒。"
	color = "#ffffc1"
	boozepwr = 40
	taste_description = "auspicious occasions and bad decisions"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/wizz_fizz
	name = "Wizz Fizz"; display_name = "巫师气泡"
	description = "魔法药水，气泡狂野！入口却出奇温和。"
	color = "#4235d0" //Just pretend that the triple-sec was blue curacao.
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "friendship! It is magic, after all"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wizz_fizz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	//A healing drink similar to Quadruple Sec, Ling Stings, and Screwdrivers for the Wizznerds; the check is consistent with the changeling sting
	if(drinker?.mind?.has_antag_datum(/datum/antagonist/wizard))
		var/need_mob_update
		need_mob_update = drinker.heal_bodypart_damage(1 * metabolization_ratio * seconds_per_tick, 1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += drinker.adjust_oxy_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_tox_loss(-1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += drinker.adjust_stamina_loss(-5 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype)
		if(need_mob_update)
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/bug_spray
	name = "Bug Spray"; display_name = "杀虫喷雾"
	description = "刺激、辛涩又苦的酒饮，献给需要打起精神的人。"
	color = "#33ff33"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "the pain of ten thousand slain mosquitos"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	affected_biotype = MOB_BUG

/datum/reagent/consumable/ethanol/bug_spray/on_new(data)
	. = ..()
	AddElement(/datum/element/bugkiller_reagent)

/datum/reagent/consumable/ethanol/bug_spray/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Does some damage to bug biotypes
	if(drinker.adjust_tox_loss(1 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
		// Random chance of causing a screm if we did some damage
		if(SPT_PROB(2, seconds_per_tick))
			drinker.emote("scream")

/datum/reagent/consumable/ethanol/applejack
	name = "Applejack"; display_name = "苹果白兰地"
	description = "想要撒欢胡闹时的绝佳饮品。"
	color = "#ff6633"
	boozepwr = 20
	taste_description = "an honest day's work at the orchard"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/jack_rose
	name = "Jack Rose"; display_name = "杰克玫瑰"
	description = "清淡的鸡尾酒，适合配着一块派慢慢品尝。"
	color = "#ff6633"
	boozepwr = 15
	quality = DRINK_NICE
	taste_description = "a sweet and sour slice of apple"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo
	name = "Turbo"; display_name = "涡轮增压"
	description = "与非法悬浮摩托竞速有关的狂暴鸡尾酒，胆小者勿试。"
	color = "#e94c3a"
	boozepwr = 85
	quality = DRINK_VERYGOOD
	taste_description = "the outlaw spirit"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/turbo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(2, seconds_per_tick))
		to_chat(drinker, span_notice("[pick("你觉得法律不值一提。", "你热血沸腾！", "你的头阵阵作痛。", "你的思绪飞速运转……")]"))
	if(drinker.adjust_stamina_loss(-0.5 * drinker.get_drunk_amount() * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/old_timer
	name = "Old Timer"; display_name = "老古董"
	description = "深受各年龄段老顽固喜爱的古老酒饮。"
	color = "#996835"
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "simpler times"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_timer/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(10, seconds_per_tick) && ishuman(drinker))
		var/mob/living/carbon/human/metabolizer = drinker
		metabolizer.age += 1
		if(metabolizer.age > 70)
			metabolizer.set_facial_haircolor("#cccccc", update = FALSE)
			metabolizer.set_haircolor("#cccccc", update = TRUE)
			if(metabolizer.age > 100)
				metabolizer.become_nearsighted(type)
				if(metabolizer.gender == MALE)
					metabolizer.set_facial_hairstyle("Beard (Very Long)", update = TRUE)

				if(metabolizer.age > 969) //Best not let people get older than this or i might incur G-ds wrath
					metabolizer.visible_message(span_notice("[metabolizer]衰老到了凡人不该有的程度……随后化成了尘埃！"))
					metabolizer.dust(just_ash = FALSE, drop_items = TRUE, force = FALSE)

/datum/reagent/consumable/ethanol/rubberneck
	name = "Rubberneck"; display_name = "橡皮颈"
	description = "优质的橡皮颈不该含有恶心的天然原料。"
	color = "#ffe65b"
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "artificial fruitiness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/duplex
	name = "Duplex"; display_name = "双层复式"
	description = "两种果味饮料密不可分的组合。"
	color = "#50e5cf"
	boozepwr = 25
	quality = DRINK_NICE
	taste_description = "green apples and blue raspberries"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist
	name = "Trappist Beer"; display_name = "特拉普修道院啤酒"
	description = "太空修士酿造的烈性深色艾尔啤酒。"
	color = "#390c00"
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "dried plums and malt"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/trappist/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.mind?.holy_role)
		if(drinker.adjust_fire_loss(-2.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype))
			. = UPDATE_MOB_HEALTH
		drinker.adjust_jitter(-2 SECONDS * metabolization_ratio * seconds_per_tick)
		drinker.adjust_stutter(-2 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/blazaam
	name = "Blazaam"; display_name = "闪现佳酿"
	description = "很少有人记得它存在过的奇怪酒饮，还能清除贝伦斯坦印记。"
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "alternate realities"
	var/stored_teleports = 0

/datum/reagent/consumable/ethanol/blazaam/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_drunk_amount() > 40)
		if(stored_teleports)
			do_teleport(drinker, get_turf(drinker), rand(1,3), channel = TELEPORT_CHANNEL_WORMHOLE)
			stored_teleports--

		if(SPT_PROB(5, seconds_per_tick))
			stored_teleports += rand(2, 6)
			if(prob(70))
				drinker.vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/purple)

/datum/reagent/consumable/ethanol/planet_cracker
	name = "Planet Cracker"; display_name = "碎星者"
	description = "庆祝人类战胜外星威胁的欢庆酒饮，可能冒犯非人类船员。"
	boozepwr = 50
	quality = DRINK_FANTASTIC
	taste_description = "triumph with a hint of bitterness"

/datum/reagent/consumable/ethanol/mauna_loa
	name = "Mauna Loa"; display_name = "冒纳罗亚"
	description = "极其火热，胆小者勿试！"
	boozepwr = 40
	color = "#fe8308" // 254, 131, 8
	quality = DRINK_FANTASTIC
	taste_description = "fiery, with an aftertaste of burnt flesh"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/mauna_loa/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Heats the user up while the reagent is in the body. Occasionally makes you burst into flames.
	drinker.adjust_bodytemperature(25 * metabolization_ratio * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick)
	if (SPT_PROB(2.5, seconds_per_tick))
		drinker.adjust_fire_stacks(1 * metabolization_ratio)
		drinker.ignite_mob()

/datum/reagent/consumable/ethanol/painkiller
	name = "Painkiller"; display_name = "止痛药"
	description = "减轻你的痛苦。心里的痛苦。"
	boozepwr = 20
	color = "#EAD677"
	quality = DRINK_NICE
	taste_description = "sugary tartness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_ANALGESIA)

/datum/reagent/consumable/ethanol/pina_colada
	name = "Pina Colada"; display_name = "椰林飘香"
	description = "新鲜菠萝饮品加椰子朗姆酒，真好喝。"
	boozepwr = 40
	color = "#FFF1B2"
	quality = DRINK_FANTASTIC
	taste_description = "pineapple, coconut, and a hint of the ocean"

/datum/reagent/consumable/ethanol/pina_olivada
	name = "Piña Olivada"; display_name = "橄榄菠萝特调"
	description = "橄榄油与菠萝汁调成的古怪饮品。"
	boozepwr = 20 // the oil coats your gastrointestinal tract, meaning you can't absorb as much alcohol. horrifying
	color = "#493c00"
	quality = DRINK_NICE
	taste_description = "a horrible emulsion of pineapple and olive oil"

/datum/reagent/consumable/ethanol/pina_olivada/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(8, seconds_per_tick))
		drinker.manual_emote(pick("咳出了一些油", "咽下了喉咙里的异物", "干呕起来", "呛了一下"))
	if(SPT_PROB(3, seconds_per_tick))
		var/static/list/messages = list(
			"难受的余味充斥着你的嘴。",
			"你觉得喉咙里的油快把你呛死了。",
			"你开始感到胃里烧灼。",
			"你想吐，但食道堵住了，什么也吐不出来。",
			"你的喉咙难受极了。",
		)
		to_chat(drinker, span_notice(pick(messages)))

/datum/reagent/consumable/ethanol/pruno // pruno mix is in drink_reagents
	name = "Pruno"; display_name = "狱酿果酒"
	color = "#E78108"
	description = "用水果、糖和绝望发酵的监狱果酒。安保很爱没收它，这也是安保唯一做过的好事。"
	boozepwr = 85
	taste_description = "your tastebuds being individually shanked"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pruno/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/ginger_amaretto
	name = "Ginger Amaretto"; display_name = "姜味杏仁酒"
	description = "简单而美味，让感官愉悦的鸡尾酒。"
	boozepwr = 30
	color = "#EFB42A"
	quality = DRINK_GOOD
	taste_description = "sweetness followed by a soft sourness and warmth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/godfather
	name = "Godfather"; display_name = "教父"
	description = "与非法勾当有牵连的粗犷鸡尾酒。"
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "a delightful softened punch"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/godmother
	name = "Godmother"; display_name = "教母"
	description = "经典酒饮的变体，更受成熟女性喜爱。"
	boozepwr = 50
	color = "#E68F00"
	quality = DRINK_GOOD
	taste_description = "sweetness and a zesty twist"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara
	name = "Kortara"; display_name = "科塔乳"
	description = "提兹拉流行的香甜乳状坚果饮料，常混入果汁或可可，喝起来更清爽。"
	boozepwr = 25
	color = "#EEC39A"
	quality = DRINK_GOOD
	taste_description = "sweet nectar"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kortara/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(drinker.get_brute_loss() && SPT_PROB(10, seconds_per_tick))
		if(drinker.heal_bodypart_damage(brute = 1 * metabolization_ratio, burn = 0, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/sea_breeze
	name = "Sea Breeze"; display_name = "海风"
	description = "轻盈清爽，薄荷与可可风味交织，就像能喝的薄荷巧克力碎冰淇淋！"
	boozepwr = 15
	color = "#CFFFE5"
	quality = DRINK_VERYGOOD
	taste_description = "mint choc chip"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sea_breeze/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/ethanol/white_tiziran
	name = "White Tiziran"; display_name = "白提兹拉"
	description = "伏特加与科塔乳的混合物，蜥蜴人也要喝一杯。"
	boozepwr = 50
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "strikes and gutters"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier
	name = "Drunken Espatier"; display_name = "醉太空步兵"
	description = "听着，要是在冰冷的太空真空里打枪战，你也想先灌醉自己。"
	boozepwr = 65
	color = "#A68340"
	quality = DRINK_GOOD
	taste_description = "sorrow"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.add_mood_event("numb", /datum/mood_event/narcotic_medium, name) //comfortably numb

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/consumable/ethanol/protein_blend
	name = "Protein Blend"; display_name = "蛋白混合饮"
	description = "蛋白质、纯谷物酒精、科塔粉与血液的恶心混合物。能增肌，前提是你不吐出来。"
	boozepwr = 65
	color = "#FF5B69"
	quality = DRINK_NICE
	taste_description = "regret"
	nutriment_factor = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/protein_blend/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. =	..()
	drinker.adjust_nutrition(2 * metabolization_ratio * seconds_per_tick)
	if(!HAS_TRAIT(drinker, TRAIT_LIZARD_METABOLISM))
		drinker.adjust_disgust(5 * metabolization_ratio * seconds_per_tick)
	else
		drinker.adjust_disgust(2 * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/mushi_kombucha
	name = "Mushi Kombucha"; display_name = "蘑菇康普茶"
	description = "提兹拉流行的夏日饮品，用加糖蘑菇茶制成。"
	boozepwr = 10
	color = "#C46400"
	quality = DRINK_VERYGOOD
	taste_description = "sweet 'shrooms"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch
	name = "Triumphal Arch"; display_name = "凯旋门"
	description = "庆祝蜥蜴帝国及其军事胜利的饮品，统一日时在酒吧里很受欢迎。"
	boozepwr = 60
	color = COLOR_GOLD
	quality = DRINK_FANTASTIC
	taste_description = "victory"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/triumphal_arch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(HAS_TRAIT(drinker, TRAIT_LIZARD_METABOLISM))
		drinker.add_mood_event("triumph", /datum/mood_event/memories_of_home, name)

/datum/reagent/consumable/ethanol/the_juice
	name = "The Juice"; display_name = "那杯汁"
	description = "哇，老兄，这感觉可真熟悉。"
	color = "#4c14be"
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "like, the future, man"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/datum/brain_trauma/special/bluespace_prophet/prophet_trauma

/datum/reagent/consumable/ethanol/the_juice/on_mob_metabolize(mob/living/carbon/drinker)
	. = ..()
	prophet_trauma = new()
	drinker.gain_trauma(prophet_trauma, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/consumable/ethanol/the_juice/on_mob_end_metabolize(mob/living/carbon/drinker)
	. = ..()
	if(prophet_trauma)
		QDEL_NULL(prophet_trauma)

//a jacked up absinthe that causes hallucinations to the game master controller basically, used in smuggling objectives
/datum/reagent/consumable/ethanol/ritual_wine
	name = "Ritual Wine"; display_name = "仪式酒"
	description = "仪式酒中危险而强效的酒精成分。"
	color = rgb(35, 231, 25)
	boozepwr = 90 //enjoy near death intoxication
	taste_mult = 6
	taste_description = "concentrated herbs"

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.add_filter("ritual_wine", 1, list("type" = "wave", "size" = 1, "x" = 5, "y" = 0, "flags" = WAVE_SIDEWAYS))

/datum/reagent/consumable/ethanol/ritual_wine/on_mob_end_metabolize(mob/living/psychonaut)
	. = ..()
	if(!psychonaut.hud_used)
		return
	var/atom/movable/plane_master_controller/game_plane_master_controller = psychonaut.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller.remove_filter("ritual_wine")

//Moth Drinks
/datum/reagent/consumable/ethanol/curacao
	name = "Curaçao"; display_name = "库拉索橙酒"
	description = "以拉腊哈苦橙制成，余韵芳香。"
	boozepwr = 30
	color = "#1a5fa1"
	quality = DRINK_NICE
	taste_description = "blue orange"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/navy_rum //IN THE NAVY
	name = "Navy Rum"; display_name = "海军朗姆酒"
	description = "最出色水手喝的朗姆酒。"
	boozepwr = 90 //the finest sailors are often drunk
	color = "#d8e8f0"
	quality = DRINK_NICE
	taste_description = "a life on the waves"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bitters //why do they call them bitters, anyway? they're more spicy than anything else
	name = "Andromeda Bitters"; display_name = "仙女座苦精"
	description = "调酒师最好的朋友，常用于为饮品增添细腻辛香。永远在新特立尼达生产。"
	boozepwr = 70
	color = "#1c0000"
	quality = DRINK_NICE
	taste_description = "spiced alcohol"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/admiralty //navy rum, vermouth, fernet
	name = "Admiralty"; display_name = "海军部"
	description = "以海军朗姆酒、味美思和菲奈特苦酒调成的精致苦味酒饮。"
	boozepwr = 80
	color = "#1F0001"
	quality = DRINK_VERYGOOD
	taste_description = "haughty arrogance"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_haul //Rum, Curacao, Sugar, dash of bitters, lengthened with soda water
	name = "Long Haul"; display_name = "长途货运"
	description = "货船驾驶员、无良走私犯和纳夫兽牧人的最爱。"
	boozepwr = 20
	color = "#003153"
	quality = DRINK_VERYGOOD
	taste_description = "companionship"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/long_john_silver //navy rum, bitters, lemonade
	name = "Long John Silver"; display_name = "高个约翰·西尔弗"
	description = "以海军朗姆酒、苦精和柠檬汽水调成的长饮。配给花费少而风味足，尤其受蛾人舰队欢迎。"
	boozepwr = 45
	color = "#c4b35c"
	quality = DRINK_VERYGOOD
	taste_description = "rum and spices"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tropical_storm //dark rum, pineapple juice, triple citrus, curacao
	name = "Tropical Storm"; display_name = "热带风暴"
	description = "一杯尽享加勒比风味。"
	boozepwr = 25
	color = "#00bfa3"
	quality = DRINK_VERYGOOD
	taste_description = "the tropics"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/dark_and_stormy //rum and ginger beer- simple and classic
	name = "Dark and Stormy"; display_name = "暗黑风暴"
	description = "伴着雷鸣般掌声登场的经典酒饮。" //thank you, thank you, I'll be here forever
	boozepwr = 30
	color = "#8c5046"
	quality = DRINK_GOOD
	taste_description = "ginger and rum"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/salt_and_swell //navy rum, tochtause syrup, egg whites, dash of saline-glucose solution
	name = "Salt and Swell"; display_name = "咸潮"
	description = "提神的酸酒，带有有趣的咸味。"
	boozepwr = 60
	color = "#b4abd0"
	quality = DRINK_FANTASTIC
	taste_description = "salt and spice"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tiltaellen //yoghurt, salt, vinegar
	name = "Tiltällen"; display_name = "咸酸乳酒"
	description = "轻度发酵的酸奶饮品，加了盐和少许醋，带有明显的酸奶酪风味。"
	boozepwr = 10
	color = "#F4EFE2"
	quality = DRINK_NICE
	taste_description = "sour cheesy yoghurt"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/tich_toch
	name = "Tich Toch"; display_name = "滴嗒特调"
	description = "咸酸乳酒、苦辣莓糖浆与伏特加的混合饮品，口味并非人人都能接受。"
	boozepwr = 75
	color = "#b4abd0"
	quality = DRINK_VERYGOOD
	taste_description = "spicy sour cheesy yoghurt"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/helianthus
	name = "Helianthus"; display_name = "向日葵"
	description = "苦艾酒和致幻剂调成的幽暗而耀眼的混合物，真正艺术家的选择。"
	boozepwr = 75
	color = "#fba914"
	quality = DRINK_VERYGOOD
	taste_description = "golden memories"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/hal_amt = 4
	var/hal_cap = 24

/datum/reagent/consumable/ethanol/helianthus/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(5, seconds_per_tick))
		drinker.adjust_hallucinations_up_to(4 SECONDS * metabolization_ratio, 48 SECONDS)

/datum/reagent/consumable/ethanol/plumwine
	name = "Plum wine"; display_name = "李子酒"
	description = "用李子酿成的酒。"
	color = "#8a0421"
	nutriment_factor = 1
	boozepwr = 20
	taste_description = "a poet's love and undoing"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/the_hat
	name = "The Hat"; display_name = "礼帽"
	description = "精致的酒饮，通常盛在男士礼帽里。"
	color = "#b90a5c"
	boozepwr = 80
	quality = DRINK_NICE
	taste_description = "something perfumy"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_STOCK

/datum/reagent/consumable/ethanol/gin_garden
	name = "Gin Garden"; display_name = "金酒花园"
	description = "清凉上乘的酒饮，味道非同寻常。"
	boozepwr = 20
	color = "#6cd87a"
	quality = DRINK_VERYGOOD
	taste_description = "light gin with sweet ginger and cucumber"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/gin_garden/on_mob_life(mob/living/carbon/doll, seconds_per_tick, metabolization_ratio)
	. = ..()
	doll.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, doll.get_body_temp_normal())

/datum/reagent/consumable/ethanol/wine_voltaic
	name = "Voltaic Yellow Wine"; display_name = "伏打黄酒"
	description = "带电的酒，能给以太人充电，而且无毒。"
	boozepwr = 30
	color = "#FFAA00"
	taste_description = "static with a hint of sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/wine_voltaic/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/telepole
	name = "Telepole"; display_name = "电线杆"
	description = "饮料形式的接地棒，能给以太人充电，并提供暂时的电击抗性。"
	boozepwr = 50
	color = "#b300ff"
	quality = DRINK_NICE
	taste_description = "the howling storm"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SHOCKIMMUNE)

/datum/reagent/consumable/ethanol/telepole/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 20 * ETHEREAL_DISCHARGE_RATE)

/datum/reagent/consumable/ethanol/pod_tesla
	name = "Pod Tesla"; display_name = "荚果特斯拉"
	description = "驾驭闪电！为以太人充电，抑制恐惧症，并提供暂时的强效电击抗性。"
	boozepwr = 80
	color = "#00fbff"
	quality = DRINK_FANTASTIC
	taste_description = "victory, with a hint of insanity"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_SHOCKIMMUNE,TRAIT_TESLA_SHOCKIMMUNE,TRAIT_FEARLESS), type)

/datum/reagent/consumable/ethanol/pod_tesla/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume) //can't be on life because of the way blood works.
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(exposed_mob))
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 30 * ETHEREAL_DISCHARGE_RATE)

// Welcome to the Blue Room Bar and Grill, home to Mars' finest cocktails
/datum/reagent/consumable/ethanol/rice_beer
	name = "Rice Beer"; display_name = "米啤酒"
	description = "火星流行的清淡米酿拉格啤酒。按1516年《啤酒纯酿法》，这是针对巴伐利亚人的仇恨犯罪。"
	boozepwr = 5
	color = "#664300"
	quality = DRINK_NICE
	taste_description = "mild carbonated malt"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/shochu
	name = "Shochu"; display_name = "烧酎"
	description = "也称烧酒或白酒。与清酒一样由发酵米制成，但度数通常更高，更接近真正的烈酒。"
	boozepwr = 45
	color = "#DDDDDD"
	quality = DRINK_NICE
	taste_description = "stiff rice wine"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/yuyake
	name = "Yūyake"; display_name = "夕烧"
	description = "日本出产的甜蜜瓜利口酒，多数人视其为20世纪80年代的遗物。鲜红的颜色让它在部分鸡尾酒中仍有一席之地。"
	boozepwr = 40
	color = "#F54040"
	quality = DRINK_NICE
	taste_description = "sweet melon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/coconut_rum
	name = "Coconut Rum"; display_name = "椰子朗姆酒"
	description = "蒸馏出的海滩精华，尝起来像漂金的头发和防晒霜。"
	boozepwr = 21
	color = "#e4f2f5"
	quality = DRINK_NICE
	taste_description = "coconut rum"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Mixed Martian Drinks
/datum/reagent/consumable/ethanol/yuyakita
	name = "Yūyakita"; display_name = "夕烧玛格丽塔"
	description = "某位无名酒客放到世间的地狱。"
	boozepwr = 40
	color = "#e43414"
	quality = DRINK_NICE
	taste_description = "death"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/saibasan
	name = "Saibāsan"; display_name = "赛博太阳特调"
	description = "颂扬赛博太阳生意长青的酒饮。"
	boozepwr = 20
	color = "#f25100"
	quality = DRINK_FANTASTIC
	taste_description = "betrayal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/banzai_ti
	name = "Banzai-Tī"; display_name = "万岁茶"
	description = "长岛冰茶的变体，加入夕烧，带来难以名状的别样风味。"
	boozepwr = 40
	color = "#fd3b00"
	quality = DRINK_VERYGOOD
	taste_description = "an asian twist on the liquor cabinet"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sanraizusoda
	name = "Sanraizusōda"; display_name = "日出苏打"
	description = "含酒精的蜜瓜奶油汽水，有什么理由不爱呢？嗯……宿醉也许算一个。"
	boozepwr = 6
	color = "#f37d7b"
	quality = DRINK_GOOD
	taste_description = "creamy melon soda"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kumicho
	name = "Kumichō"; display_name = "组长"
	description = "经典鸡尾酒的新演绎，在教父配方中加入烧酎，带来亚洲风味。"
	boozepwr = 62
	color = "#b87456"
	quality = DRINK_VERYGOOD
	taste_description = "rice and rye"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_planet
	name = "Red Planet"; display_name = "红色星球"
	description = "为庆祝火星租界而调制，基于经典的总统鸡尾酒。鲜红的颜色和爱国热情一样浓烈。"
	boozepwr = 45
	color = "#ac4948"
	quality = DRINK_VERYGOOD
	taste_description = "the spirit of freedom"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/amaterasu
	name = "Amaterasu"; display_name = "天照"
	description = "以神道教太阳女神天照命名，象征光辉——大概就是这个意思。"
	boozepwr = 54 //1 part bitters is a lot
	color = "#e43414"
	quality = DRINK_VERYGOOD
	taste_description = "sweet nectar of the gods"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nekomimosa
	name = "Nekomimosa"; display_name = "猫耳含羞草"
	description = "甜得过头的鸡尾酒，由蜜瓜利口酒、蜜瓜汁和香槟调成，可惜香槟不含蜜瓜。"
	boozepwr = 17
	color = "#FF0C8D"
	quality = DRINK_GOOD
	taste_description = "MELON"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/sentai_quencha //melon soda, triple citrus, shochu, blue curacao
	name = "Sentai Quencha"; display_name = "战队解渴特调"
	description = "以银河闻名的《究极忍者力量战队》为灵感，深受动漫展和宅文化酒吧欢迎。"
	boozepwr = 28
	color = "#00ffa6"
	quality = DRINK_GOOD
	taste_description = "ultimate ninja power"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bosozoku
	name = "Bōsōzoku"; display_name = "暴走族"
	description = "来自火星的简单夏日酒饮，米啤酒与柠檬汽水以1:1混合。"
	boozepwr = 6
	color = "#d7d84f"
	quality = DRINK_GOOD
	taste_description = "bittersweet lemon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/ersatzche
	name = "Ersatzche"; display_name = "仿酿苦甜酒"
	description = "甜、苦、辣，绝妙的组合。"
	boozepwr = 6
	color = "#bc6a2b"
	quality = DRINK_VERYGOOD
	taste_description = "spicy pineapple beer"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/red_city_am
	name = "Red City AM"; display_name = "红城清晨"
	description = "来自新大阪的早餐酒饮，适合非要早上九点半喝醉、又想比在新干线上喝袋装酒体面些的人。当然，也不建议在新干线上喝这个。"
	boozepwr = 5 //this thing is fucking disgusting and both less tasty and less alcoholic than a bloody mary. it is against god and nature
	color = "#ef0903"
	quality = DRINK_NICE
	taste_description = "breakfast in a glass"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/kings_ransom
	name = "King's Ransom"; display_name = "国王赎金"
	description = "又烈又苦的酒饮，名字古怪，配方更古怪。"
	boozepwr = 26
	color = "#bd2e20"
	quality = DRINK_VERYGOOD
	taste_description = "bitter raspberry"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/four_bit
	name = "Four Bit"; display_name = "四比特"
	description = "为敲键盘的双手补充动力。"
	boozepwr = 26
	color = "#c4b000"
	quality = DRINK_GOOD
	taste_description = "cyberspace"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/white_hawaiian //coconut milk, coconut rum, coffee liqueur
	name = "White Hawaiian"; display_name = "白夏威夷"
	description = "经典白俄罗斯的变体，以热带风味替换传统原料。"
	boozepwr = 16
	color = "#ffffeb"
	quality = DRINK_GOOD
	taste_description = "COCONUT"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/maui_sunrise //coconut rum, pineapple juice, yuyake, triple citrus, lemon-lime soda
	name = "Maui Sunrise"; display_name = "毛伊日出"
	description = "红色外表下藏着鲜明复杂的风味。"
	boozepwr = 15
	color = "#f1922b"
	quality = DRINK_VERYGOOD
	taste_description = "sunrise over the pacific"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/imperial_mai_tai //navy rum, rum, lime, triple sec, korta nectar
	name = "Imperial Mai Tai"; display_name = "帝国迈泰"
	description = "杏仁糖浆不够时，学学太空旅人，就地取材凑合着调。"
	boozepwr = 52
	color = "#cf7d61"
	quality = DRINK_VERYGOOD
	taste_description = "spicy nutty rum"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/konococo_rumtini //todo: add espresso | coffee, coffee liqueur, coconut rum, sugar
	name = "Konococo Rumtini"; display_name = "椰香咖啡朗姆马天尼"
	description = "椰子朗姆酒、咖啡利口酒和浓缩咖啡，组合虽怪，却很讨喜。"
	boozepwr = 20
	color = "#421711"
	quality = DRINK_VERYGOOD
	taste_description = "coconut coffee"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/blue_hawaiian //pineapple juice, lemon juice, coconut rum, blue curacao
	name = "Blue Hawaiian"; display_name = "蓝夏威夷"
	description = "甜美鲜明，椰香十足。"
	boozepwr = 30
	color = "#295875"
	quality = DRINK_VERYGOOD
	taste_description = "the aloha state"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/boston_sour
	name = "Boston Sour"; display_name = "波士顿酸"
	description = "用蛋清提升口感的威士忌酸。"
	boozepwr = 35
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "foamy lemony sourness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/star
	name = "Star"; display_name = "星辰"
	description = "苹果白兰地与味美思的混合酒，以苦精点缀。"
	boozepwr = 40
	color = "#e5a654"
	quality = DRINK_GOOD
	taste_description = "vinous apples"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/old_fashioned
	name = "Old Fashioned"; display_name = "古典鸡尾酒"
	description = "从某种意义上说是第一种鸡尾酒，以糖和苦精调味烈酒，现代通常选用威士忌。"
	boozepwr = 60
	color = "#b4a287"
	quality = DRINK_GOOD
	taste_description = "rounded out whiskey"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/sazerac
	name = "Sazerac"; display_name = "萨泽拉克"
	description = "用苦艾酒和克里奥尔苦精增香的威士忌。"
	boozepwr = 65
	color = "#f43f69"
	quality = DRINK_GOOD
	taste_description = "flowery anise-scented whiskey"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/amaretto_sour
	name = "Amaretto Sour"; display_name = "杏仁酸"
	description = "以香甜杏仁利口酒调成的酸酒。"
	boozepwr = 15
	color = "#ddc28b"
	quality = DRINK_VERYGOOD
	taste_description = "foamy lemony sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/ramos_gin_fizz
	name = "Ramos Gin Fizz"; display_name = "拉莫斯金菲士"
	description = "金菲士的复杂变体，在柠檬汁之外加入奶油和蛋清，带来独特口感。此版本用一滴橙味利口酒替代标志性的橙花水。"
	boozepwr = 35
	color = "#f9e7c2"
	quality = DRINK_FANTASTIC
	taste_description = "creamy fluffy citrusy gin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/french_75
	name = "French 75"; display_name = "法国75"
	description = "精致的鸡尾酒，以金酒增强香槟的酒劲，再用柠檬汁和糖调味。"
	boozepwr = 35
	color = "#ffffc1"
	quality = DRINK_GOOD
	taste_description = "glory and gunnery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/sangria
	name = "Sangria"; display_name = "桑格利亚"
	description = "血红色葡萄酒宾治，加入烈酒提升酒劲，再尽可能多地加入水果丁增甜。"
	boozepwr = 20
	color = "#c4383b"
	quality = DRINK_GOOD
	taste_description = "refreshing fruity wine"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard
	name = "Suffering Bastard"; display_name = "受苦的混蛋"
	description = "提基风格的解宿醉酒饮，以姜汁啤酒、烈酒和苦精调成。"
	boozepwr = 20
	color = "#e8ca78"
	quality = DRINK_VERYGOOD
	taste_description = "ginger-flavored recuperation"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/suffering_bastard/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/headache_soothed) //prevents headaches
	affected_mob.adjust_disgust(-5 * metabolization_ratio * seconds_per_tick) //removes disgust, same with sol dry
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, -0.5 * metabolization_ratio * seconds_per_tick * normalise_creation_purity(), required_organ_flag = affected_organ_flags)) //heals brain damage very slowly, about 12 damage per 5u
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/blue_blazer
	name = "Blue Blazer"; display_name = "蓝色火焰"
	description = "19世纪一位传奇调酒师的招牌酒饮。尽管他以革新调酒艺术闻名，这杯酒归根结底只是加热加糖的威士忌。"
	boozepwr = 25
	color = "#b5949b"
	quality = DRINK_NICE
	taste_description = "scorched sweet whiskey"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/blue_blazer/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/hot_toddy
	name = "Hot Toddy"; display_name = "热托迪"
	description = "加热的烈酒、糖与香料混合物。做法虽古老，这种用干邑和精制糖的版本却较现代。"
	boozepwr = 25
	color = "#f2d2b4"
	quality = DRINK_GOOD
	taste_description = "the warmth of a comfy fireplace"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/hot_toddy/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT * metabolization_ratio * seconds_per_tick, 0, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/tizirian_sour
	name = "Tizirian Sour"; display_name = "提兹拉酸"
	description = "特立尼达酸的变体，用科塔花蜜替代杏仁糖浆。虽叫这个名字，发明者却是火星酒保。"
	boozepwr = 35
	color = "#9b4b3a"
	quality = DRINK_VERYGOOD
	taste_description = "sweetened and spiced bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/daiquiri
	name = "Daiquiri"; display_name = "代基里"
	description = "堪称热带鸡尾酒的典范，几乎所有朗姆酒饮都多少源于这款经典。"
	boozepwr = 35
	color = "#b6d3a6"
	quality = DRINK_NICE
	taste_description = "crisp lime"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail
	name = "Flip Cocktail"; display_name = "翻转鸡尾酒"
	description = "一种比鸡尾酒更古老饮品的简化现代版。旧版用艾尔啤酒并加热饮用，此版冷饮，两者主要的共同点是都用整颗鸡蛋。"
	boozepwr = 30
	color = "#dddfca"
	quality = DRINK_GOOD
	taste_description = "creamy brandy and nutmeg"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/flip_cocktail/on_mob_metabolize(mob/living/drinker)
	. = ..()
	if(prob(10))
		drinker.emote("flip")

/datum/reagent/consumable/ethanol/aperitivo
	name = "Aperitivo Liqueur"; display_name = "开胃利口酒"
	description = "苦甜味强烈的利口酒，以金鸡纳树皮等植物调味，适合开胃或对抗疟疾。"
	boozepwr = 40
	color = "#bf1038"
	taste_description = "intense citrusy bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/aperitivo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //This and some of the cocktails it gets mixed into stimulate the apetite, as an aperitivo should
	. = ..()
	drinker.adjust_nutrition(-1 * REM * seconds_per_tick)
	drinker.overeatduration = 0

/datum/reagent/consumable/ethanol/herbal_liqueur
	name = "Herbal Liqueur"; display_name = "草本利口酒"
	description = "多种草药与香料经蒸馏、浸泡融入烈酒。成分实在太多，几乎不可能仅靠香气和味道一一分辨……"
	boozepwr = 75
	color = "#95be7d"
	quality = DRINK_NICE
	taste_description = "confounding herbaceousness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/maraschino
	name = "Maraschino Liqueur"; display_name = "马拉斯奇诺樱桃利口酒"
	description = "用酸樱桃的果实、叶片甚至枝条制成的经典甜利口酒，出人意料地并没有太多樱桃味。"
	boozepwr = 50
	color = "#DDDDDD"
	taste_description = "nutty sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake
	name = "Bartender's Handshake"; display_name = "调酒师的握手"
	description = "这项传统起源众说纷纭，或许与某种挑战币营销有关。调酒师以只有同行才能欣赏的酒互相致意、试探本领。版本几乎和酒吧一样多，此版用酒吧里最苦的两种原料考验味蕾。"
	boozepwr = 50
	color = "#270101"
	quality = DRINK_VERYGOOD
	taste_description = "pretentious bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/bartenders_handshake/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired) //Heals bartenders brute and burn, disgusts otherwise
	. = ..()
	var/obj/item/organ/liver/liver = drinker.get_organ_slot(ORGAN_SLOT_LIVER)
	if(HAS_TRAIT(liver, TRAIT_BARTENDER_METABOLISM))
		if(drinker.heal_bodypart_damage(brute = 1 * REM * seconds_per_tick, burn = 1 * REM * seconds_per_tick, updating_health = FALSE))
			. = UPDATE_MOB_HEALTH
	else
		drinker.adjust_disgust(2 * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/brandy_crusta
	name = "Brandy Crusta"; display_name = "白兰地糖霜"
	description = "边车鸡尾酒更为华丽的前身，装饰繁复，也是当今许多经典酒饮的祖辈。"
	boozepwr = 30
	color = "#f8c51c"
	quality = DRINK_VERYGOOD
	taste_description = "orangy sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/casino
	name = "Casino"; display_name = "赌场"
	description = "以金酒为主的经典，用少量柑橘柔化杜松味，再以利口酒增甜。"
	boozepwr = 45
	color = "#fdee65"
	quality = DRINK_GOOD
	taste_description = "sweet juniper"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/garibaldi //Makes revs resitant to wounds and fearless.
	name = "Garibaldi"; display_name = "加里波第"
	description = "以19世纪的意大利将军命名，橙红色让人想起追随他征战各地的红衫军。"
	boozepwr = 15
	color = "#f77e2e"
	quality = DRINK_GOOD
	taste_description = "bitter oranges"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/garibaldi/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(IS_REVOLUTIONARY(drinker))
		//status effect has a duration of 5 seconds which gets refreshed by this, falls off on it's own in case of running out of drink or deconversion
		drinker.apply_status_effect(/datum/status_effect/rev_resilience)

/datum/reagent/consumable/ethanol/improved_whiskey
	name = "Improved Whiskey Cocktail"; display_name = "改良威士忌鸡尾酒"
	description = "在经典威士忌鸡尾酒中加入苦艾酒和马拉斯奇诺樱桃酒，并用柠檬替代常见的橙皮装饰。"
	boozepwr = 65
	color = "#b8a385"
	quality = DRINK_VERYGOOD
	taste_description = "nutty anise-scented whiskey"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_MEDIUM

/datum/reagent/consumable/ethanol/jungle_bird
	name = "Jungle Bird"; display_name = "丛林鸟"
	description = "提基风格晚期的作品，以苦利口酒和菠萝汁的绝妙搭配创造出格外均衡的风味。"
	boozepwr = 25
	color = "#da8370"
	quality = DRINK_VERYGOOD
	taste_description = "pineapple and quinine"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_SUPERMATTER_SOOTHER) //If you have this in your system, you calm down the SM by being near it.

/datum/reagent/consumable/ethanol/last_word
	name = "Last Word"; display_name = "最后一语"
	description = "诞生于20世纪之交，却一直默默无闻，直到21世纪初鸡尾酒复兴才风靡酒吧，并催生无数配方变体。"
	boozepwr = 50
	color = "#dddfcaff"
	quality = DRINK_VERYGOOD
	taste_description = "herbal finality"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/last_word/expose_mob(mob/living/drinker, methods, reac_volume, show_message, touch_protection)
	. = ..()
	//Mutes people for 5 seconds on their first sip every 5 minutes. Requires ingest, you can't savor something that's injected into your eyes or whatever.
	if(!(methods & INGEST) || !iscarbon(drinker) || HAS_TRAIT(drinker, TRAIT_HAD_LAST_WORD))
		return

	ADD_TRAIT(drinker, TRAIT_HAD_LAST_WORD, type)
	to_chat(drinker, span_notice("你静静地品味了一会儿杯中酒……"))
	drinker.set_silence_if_lower(5 SECONDS)
	addtimer(TRAIT_CALLBACK_REMOVE(drinker, TRAIT_HAD_LAST_WORD, type), 300 SECONDS)

/datum/reagent/consumable/ethanol/mary_pickford
	name = "Mary Pickford"; display_name = "玛丽·璧克馥"
	description = "以20世纪初的电影明星命名，将朗姆与菠萝风味展现得格外精致优雅。"
	boozepwr = 35
	color = "#f7b7a7ff"
	quality = DRINK_GOOD
	taste_description = "elegant pineapple"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/negroni //Aperitif that supresses overeating
	name = "Negroni"; display_name = "尼格罗尼"
	description = "标志性的意大利开胃酒，简单而浓烈，堪称苦味鸡尾酒的典范。据说一位意大利伯爵想喝更烈的斯普利兹，便请调酒师用金酒代替苏打水，这款酒也因此得名。"
	boozepwr = 50
	color = "#cf0e00ff"
	quality = DRINK_GOOD
	taste_description = "bittersweet vermouth"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/negroni/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.overeatduration -= 20

/datum/reagent/consumable/ethanol/nuclear_daiquiri
	name = "Nuclear daiquiri"; display_name = "核子代基里"
	description = "高度数、风味浓烈的壶式蒸馏朗姆与草本利口酒，将古巴代基里简单优雅的风格彻底颠覆。"
	boozepwr = 65
	color = "#22cc22"
	quality = DRINK_GOOD
	taste_description = "hogo and herbs"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo
	name = "Thermonuclear Daiquiri"; display_name = "热核代基里"
	description = "献给喜欢更猛事物的人，比如高酯朗姆酒和钴60。"
	boozepwr = 80
	color = "#00dd00"
	quality = DRINK_FANTASTIC
	taste_description = "approximately 3.6 roentgen"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_add(mob/living/living_mob)
	. = ..()
	living_mob.apply_status_effect(/datum/status_effect/cherenkov_radiation) //makes the drinker glow blue, and rarely emit high-energy nuclear particles.

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_delete(mob/living/living_mob)
	. = ..()
	living_mob.remove_status_effect(/datum/status_effect/cherenkov_radiation)

/datum/reagent/consumable/ethanol/nuclear_daiquiri_thermo/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.set_drugginess(100 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_jitter_if_lower(20 SECONDS * metabolization_ratio * seconds_per_tick)
	drinker.set_dizzy_if_lower(10 SECONDS * metabolization_ratio * seconds_per_tick)

/datum/reagent/consumable/ethanol/poets_dream
	name = "Poet's Dream"; display_name = "诗人之梦"
	description = "以经典马天尼为基础，调出甜美草本风味。纳诺传讯规定睡前不宜饮用，否则可能发生“梦境侵蚀”，不管那是什么意思。"
	boozepwr = 50
	color = "#d4b14f"
	quality = DRINK_GOOD
	taste_description = "honeyed herbal gin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/consumable/ethanol/poets_dream/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.apply_status_effect(/datum/status_effect/grouped/heretic_dreams, type)

/datum/reagent/consumable/ethanol/poets_dream/on_mob_end_metabolize(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/grouped/heretic_dreams, type)

/datum/reagent/consumable/ethanol/pousse_cafe
	name = "Pousse Cafe"; display_name = "彩虹分层酒"
	description = "将各种酒小心地分层倒入，制成漂亮的鸡尾酒，调起来极其麻烦。"
	boozepwr = 50
	color = "#93cf33"
	quality = DRINK_FANTASTIC
	taste_description = "a cascade of varying liqueurs"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/consumable/ethanol/spritz //Aperitif that supresses overeating
	name = "Spritz"; display_name = "斯普利兹" // If someone wants to add an elderflower spritz or something else like that, just rename this to spritz al bitter or whatever
	description = "苦甜清爽的开胃酒，让人想起威尼斯美丽的夏日落霞。"
	boozepwr = 20
	color = "#ee714b"
	quality = DRINK_GOOD
	taste_description = "bittersweet refreshment"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	glass_price = DRINK_PRICE_EASY

/datum/reagent/consumable/ethanol/spritz/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	drinker.overeatduration -= 20

/datum/reagent/consumable/ethanol/vieux_carre
	name = "Vieux Carré"; display_name = "老广场"
	description = "新奥尔良众多佳酿中的佼佼者，名字与风味都向这座城市的法国区致敬。"
	boozepwr = 60
	color = "#b43110"
	quality = DRINK_VERYGOOD
	taste_description = "Creole hospitality"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash
	name = "Mouthwash"; display_name = "漱口水"
	description = "略带泡沫的薄荷液体，糖似乎比酒精还多，气味有点像冰龙吐息。"
	boozepwr = 14
	color = "#10b486"
	taste_description = "sweet and minty"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash/on_mob_life(mob/living/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)

/datum/reagent/consumable/ethanol/mouthwash_strong
	name = "Strong Mouthwash"; display_name = "烈性漱口水"
	description = "略带泡沫的薄荷液体。再烈也不能真帮你清洁牙齿，再甜也会在嘴里留下苦味。"
	boozepwr = 30
	color = "#10b4ac"
	taste_description = "dentist appointment"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/mouthwash_strong/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/throat_soothed)
	if(SPT_PROB(5, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)

/datum/reagent/consumable/ethanol/frosty_dorf
	name = "Frosty Dorf"; display_name = "冰霜矮人"
	description = "矮人经典酒饮的草本变体，让你想挖出一座山中要塞。"
	boozepwr = 75
	color = "#A1C89A"
	taste_description = "hair on your beard"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/stone_cold_stout
	name = "Stone Cold Stout"; display_name = "冰石世涛"
	description = "冰冷刺骨，连老酒客也难以驾驭。喝完还能活下来，就什么也不怕了。"
	boozepwr = 100
	color = "#9DDCFA"
	taste_description = "bitter rock bottom"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/stone_cold_stout/on_mob_metabolize(mob/living/carbon/human/drinker)
	. = ..()
	MODIFY_PHYSIOLOGY(drinker, BRUTE, 0.8)
	MODIFY_PHYSIOLOGY(drinker, BURN, 0.8)

/datum/reagent/consumable/ethanol/stone_cold_stout/on_mob_end_metabolize(mob/living/carbon/human/drinker)
	. = ..()
	MODIFY_PHYSIOLOGY(drinker, BRUTE, 1.25)
	MODIFY_PHYSIOLOGY(drinker, BURN, 1.25)

/datum/reagent/consumable/ethanol/ramp_rager
	name = "Ramp Rager"; display_name = "狂怒坡道"
	description = "猛烈冒泡、能让人狂暴的酒饮，酒吧斗殴的邀请函。"
	boozepwr = 65
	color = "#1D789B"
	taste_description = "bottled rage"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_ANALGESIA, TRAIT_STIMULATED, TRAIT_FEARLESS)

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	if(SPT_PROB(15, seconds_per_tick) && !HAS_TRAIT(drinker, TRAIT_ALCOHOL_TOLERANCE))
		drinker.adjust_hallucinations(8 SECONDS * metabolization_ratio)
	need_mob_update += drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.75 * metabolization_ratio * seconds_per_tick)
	drinker.AdjustAllImmobility(-1 SECONDS * metabolization_ratio * seconds_per_tick)
	if(drinker.adjust_stamina_loss(-15 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
		. = UPDATE_MOB_HEALTH
	if(need_mob_update)
		. = UPDATE_MOB_HEALTH
	if(SPT_PROB(5, seconds_per_tick))
		drinker.emote(pick("twitch", "drool"))

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_metabolize(mob/living/drinker)
	. = ..()
	drinker.apply_status_effect(/datum/status_effect/spasms)
	RegisterSignal(drinker, COMSIG_LIVING_ENTER_STAMCRIT, PROC_REF(on_stamcrit))

/datum/reagent/consumable/ethanol/ramp_rager/on_mob_end_metabolize(mob/living/drinker)
	. = ..()
	drinker.remove_status_effect(/datum/status_effect/spasms)
	UnregisterSignal(drinker, COMSIG_LIVING_ENTER_STAMCRIT)

/datum/reagent/consumable/ethanol/ramp_rager/proc/on_stamcrit(mob/living/drinker)
	SIGNAL_HANDLER
	drinker.set_stamina_loss(90, updating_stamina = TRUE)
	to_chat(drinker, span_message("不能就这样结束……血液从你的头部退去……"))
	volume -= (min(volume, 6))
	return STAMCRIT_CANCELLED

/datum/reagent/consumable/ethanol/sea_lantern
	name = "Sea Lantern"; display_name = "海灯"
	description = "利用灯柱果独特性质制成的分层酒饮，愿它在艰难时刻引领你远离伤害。"
	boozepwr = 35
	color = "#9FE7EC"
	taste_description = "sweet and minty"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/ethanol/icegrave
	name = "Ice Grave"; display_name = "冰墓"
	description = "冷得刺骨的酒饮，摸起来几乎像带刺，仿佛液态冰魔法。"
	boozepwr = 40
	color = "#443EAC"
	taste_description = "cold"
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/consumable/ethanol/icegrave/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM)) //Coroners know your icegraves. Also, its made using formaldehyde, so.
		return

	var/icegrave_temp = -200
	affected_mob.apply_status_effect(/datum/status_effect/ice_block_talisman, 5 SECONDS)
	var/thermal_protection = 1 - affected_mob.get_insulation_protection(affected_mob.bodytemperature + icegrave_temp)
	var/applied_temp = (thermal_protection * icegrave_temp) + icegrave_temp
	affected_mob.adjust_bodytemperature(applied_temp)

#undef ALCOHOL_EXPONENT
#undef ALCOHOL_THRESHOLD_MODIFIER
