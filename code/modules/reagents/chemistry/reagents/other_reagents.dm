/datum/reagent/blood
	name = "Blood"; display_name = "血液"
	description  = "悬浮在血浆中的血细胞，其中数量最多的是含有血红蛋白的红细胞。"
	color = "#C80000" // rgb: 200, 0, 0
	metabolization_rate = 25 * REAGENTS_METABOLISM //fast rate so it disappears fast. DARKPACK EDIT CHANGE - changed from 12.5 to 25
	taste_description = "iron"
	taste_mult = 1.3
	penetrates_skin = NONE
	ph = 7.4
	default_container = /obj/item/reagent_containers/blood

/datum/glass_style/shot_glass/blood
	required_drink_type = /datum/reagent/blood
	icon_state = "shotglassred"

/datum/glass_style/drinking_glass/blood
	required_drink_type = /datum/reagent/blood
	name = "一杯番茄汁"
	desc = "你确定这是番茄汁吗？"

// FEED ME
/datum/reagent/blood/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_pestlevel(rand(2, 3))

/datum/reagent/blood/on_new(list/data)
	. = ..()
	// If we were artificially created without blood data, we still want to have the blood_reagent element for exposure effects
	if(isnull(LAZYACCESS(data, BLOOD_DATA_TYPE)))
		RegisterSignal(src, COMSIG_REAGENT_GROWN_IN_PLANT, PROC_REF(grown_in_plant))
		AddElement(/datum/element/blood_reagent, null, get_blood_type(/datum/blood_type/universal))
		return

	var/datum/blood_type/blood_type = data[BLOOD_DATA_TYPE]
	if(!istype(blood_type))
		return

	var/blood_color = blood_type.get_color()
	if(blood_color == BLOOD_COLOR_RED) // If the blood is default red, just use the darker red color for the reagent.
		color = initial(color)

/datum/reagent/blood/get_taste_description(mob/living/taster)
	if(isnull(taster))
		return ..()
	if(!HAS_TRAIT(taster, TRAIT_DETECTIVES_TASTE))
		return ..()
	var/blood_type = data?[BLOOD_DATA_TYPE]
	if(!blood_type)
		return ..()
	return list("[blood_type]型血液" = 1)

// DARKPACK EDIT ADD START - blood increments bloodpool
/datum/reagent/blood/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(methods & INGEST)
		if(data?["donor"])
			LAZYOR(exposed_mob.mobs_tasted_blood_of, data["donor"])
		if((!istype(src, /datum/reagent/blood/vitae)) && get_kindred_splat(exposed_mob) && !HAS_TRAIT(exposed_mob, TRAIT_THIRST_OF_AGES))
			if(get_splat_with_vitae(exposed_mob))
				//100u of vitae = 1bp, keeping consistent w/ give vitae action. 200u of normal blood = 1 bp
				exposed_mob.adjust_blood_pool(reac_volume * 0.005)
// DARKPACK EDIT ADD END

/// All blood grown in plants defaults to O-
/datum/reagent/blood/proc/grown_in_plant(datum/source, obj/item/seeds/our_seeds, obj/item/our_plant)
	SIGNAL_HANDLER

	LAZYSET(data, BLOOD_DATA_TYPE, get_blood_type(/datum/blood_type/human/o_minus))

/datum/reagent/consumable/liquidgibs
	name = "Liquid Gibs"; display_name = "碎肉浆"
	color = "#CC4633"
	description = "你连想都不愿意想这里面是什么。"
	taste_description = "gross iron"
	nutriment_factor = 2
	material = /datum/material/meat
	ph = 7.45
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/shot_glass/liquidgibs
	required_drink_type = /datum/reagent/consumable/liquidgibs
	icon_state = "shotglassred"

/datum/reagent/bone_dust
	name = "Bone Dust"; display_name = "骨粉"
	color = "#dbcdcb"
	description = "磨碎的骨头，真恶心！"
	taste_description = "the most disgusting grain in existence"

/datum/reagent/vaccine
	//data must contain virus type
	name = "Vaccine"; display_name = "疫苗"
	color = "#C81040" // rgb: 200, 16, 64
	taste_description = "slime"
	penetrates_skin = NONE

/datum/reagent/vaccine/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(!islist(data) || !(methods & (INGEST|INJECT)))
		return

	for(var/thing in exposed_mob.diseases)
		var/datum/disease/infection = thing
		if(infection.GetDiseaseID() in data)
			infection.cure(add_resistance = TRUE)
	LAZYOR(exposed_mob.disease_resistances, data)

/datum/reagent/vaccine/on_merge(list/mix_data, amount)
	. = ..()
	if(mix_data)
		data |= mix_data

/datum/reagent/vaccine/fungal_tb
	name = "Vaccine (Fungal Tuberculosis)"; display_name = "疫苗（真菌性结核病）"

/datum/reagent/vaccine/fungal_tb/New(data)
	. = ..()
	var/list/cached_data
	if(!data)
		cached_data = list()
	else
		cached_data = data
	cached_data |= "[/datum/disease/tuberculosis]"
	src.data = cached_data

/datum/reagent/water
	name = "Water"; display_name = "水"
	description = "一种由氢和氧组成、随处可见的化学物质。"
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "water"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/waterbottle
	var/cooling_temperature = 1.2 // DARKPACK EDIT CHANGE - TURF_FIRE

/datum/glass_style/shot_glass/water
	required_drink_type = /datum/reagent/water
	icon_state = "shotglassclear"

/datum/glass_style/drinking_glass/water
	required_drink_type = /datum/reagent/water
	name = "一杯水"
	desc = "一切清凉饮品的源头。"
	icon_state = "glass_clear"

/*
 * Water reaction to turf
 */

/datum/reagent/water/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()

	if(!istype(exposed_turf))
		return

	for(var/mob/living/basic/slime/exposed_slime in exposed_turf)
		exposed_slime.apply_water()

	var/cool_temp = cooling_temperature

	/* // DARKPACK EDIT REMOVAL - TURF_FIRE
	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in exposed_turf)
	if(hotspot && !isspaceturf(exposed_turf)) // the water evaporates in an endothermic reaction
		if(exposed_turf.air)
			var/datum/gas_mixture/air = exposed_turf.air
			air.temperature = min(max(min(air.temperature-(cool_temp*1000), air.temperature/cool_temp), T0C), air.temperature) // the outer min temperature check is for weird phenomena like freon combustion
			exposed_turf.temperature = clamp(min(exposed_turf.temperature-(cool_temp*1000), exposed_turf.temperature/cool_temp), T20C, exposed_turf.temperature) // turfs normally don't go below T20C so I'll just clamp it to that in case of weird phenomena.
			air.react(src)
			qdel(hotspot)
	*/
	exposed_turf.extinguish_turf(cool_temp) // DARKPACK EDIT ADD - TURF_FIRE

	if(isgroundlessturf(exposed_turf) || isnoslipturf(exposed_turf))
		return

	// DARKPACK EDIT CHANGE START - TURF_FIRE
	if(reac_volume >= 5 && prob(25+reac_volume))
		exposed_turf.MakeSlippery(TURF_WET_WATER, 10 SECONDS, min(reac_volume*1.5 SECONDS, 60 SECONDS))
	// DARKPACK EDIT CHANGE END

/*
 * Water reaction to an object
 */

/datum/reagent/water/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	exposed_obj.extinguish()
	exposed_obj.wash(CLEAN_TYPE_ACID)
	// Monkey cube
	if(istype(exposed_obj, /obj/item/food/monkeycube))
		var/obj/item/food/monkeycube/cube = exposed_obj
		cube.Expand()

	// Dehydrated carp
	else if(istype(exposed_obj, /obj/item/toy/plush/carpplushie/dehy_carp))
		var/obj/item/toy/plush/carpplushie/dehy_carp/dehy = exposed_obj
		dehy.Swell() // Makes a carp

	else if(istype(exposed_obj, /obj/item/stack/sheet/hairlesshide))
		var/obj/item/stack/sheet/hairlesshide/HH = exposed_obj
		new /obj/item/stack/sheet/wethide(get_turf(HH), HH.amount)
		qdel(HH)


/// How many wet stacks you get per units of water when it's applied by touch.
#define WATER_TO_WET_STACKS_FACTOR_TOUCH 0.5
/// How many wet stacks you get per unit of water when it's applied by vapor. Much less effective than by touch, of course.
#define WATER_TO_WET_STACKS_FACTOR_VAPOR 0.1


/**
 * Water reaction to a mob
 */
/datum/reagent/water/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume)//Splashing people with water can help put them out!
	. = ..()
	if(methods & TOUCH)
		exposed_mob.extinguish_mob() // extinguish removes all fire stacks
		exposed_mob.adjust_wet_stacks(reac_volume * WATER_TO_WET_STACKS_FACTOR_TOUCH) // Water makes you wet, at a 50% water-to-wet-stacks ratio. Which, in turn, gives you some mild protection from being set on fire!

	if(methods & VAPOR)
		exposed_mob.adjust_wet_stacks(reac_volume * WATER_TO_WET_STACKS_FACTOR_VAPOR) // Spraying someone with water with the hope to put them out is just simply too funny to me not to add it.

		if(!HAS_TRAIT(exposed_mob, TRAIT_WATER_HATER) || HAS_TRAIT(exposed_mob, TRAIT_WATER_ADAPTATION))
			return

		exposed_mob.incapacitate(1) // startles the felinid, canceling any do_after
		exposed_mob.add_mood_event("watersprayed", /datum/mood_event/watersprayed)

	if(methods & (TOUCH|VAPOR)) // wakey wakey eggs and bakey
		exposed_mob.adjust_dizzy(-2 SECONDS)
		exposed_mob.adjust_confusion(-2 SECONDS)
		exposed_mob.adjust_drowsiness(-4 SECONDS)
		exposed_mob.adjust_jitter(-4 SECONDS)
		exposed_mob.AdjustSleeping(-15 SECONDS)
		exposed_mob.AdjustUnconscious(-8 SECONDS)
		var/drunkness_restored = HAS_TRAIT(exposed_mob, TRAIT_WATER_ADAPTATION) ? -0.5 : -0.25
		exposed_mob.adjust_drunk_effect(drunkness_restored)

	if((methods & INGEST) && HAS_TRAIT(exposed_mob, TRAIT_WATER_ADAPTATION) && reac_volume >= 4)
		exposed_mob.adjust_wet_stacks(0.15 * reac_volume)

#undef WATER_TO_WET_STACKS_FACTOR_TOUCH
#undef WATER_TO_WET_STACKS_FACTOR_VAPOR


/datum/reagent/water/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver?.damage && !IS_ROBOTIC_ORGAN(liver) && !(liver.organ_flags & ORGAN_FAILING))
		var/healing_bonus = liver.healing_factor * liver.maxHealth
		liver.apply_organ_damage(-0.5 * healing_bonus * metabolization_ratio * seconds_per_tick)

	var/water_adaptation = HAS_TRAIT(affected_mob, TRAIT_WATER_ADAPTATION)
	var/blood_restored = water_adaptation ? 0.3 : 0.1
	affected_mob.adjust_blood_volume(0.5 * blood_restored * metabolization_ratio * seconds_per_tick) // water is good for you!
	var/drunkness_restored = water_adaptation ? -0.5 : -0.25
	affected_mob.adjust_drunk_effect(0.5 * drunkness_restored * metabolization_ratio * seconds_per_tick) // and even sobers you up slowly!!
	if(water_adaptation)
		var/need_mob_update = FALSE
		need_mob_update = affected_mob.adjust_tox_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype)
		need_mob_update += affected_mob.adjust_fire_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		need_mob_update += affected_mob.adjust_brute_loss(-0.125 * metabolization_ratio * seconds_per_tick, updating_health = FALSE, required_bodytype = affected_bodytype)
		return need_mob_update ? UPDATE_MOB_HEALTH : .

// For weird backwards situations where water manages to get added to trays nutrients, as opposed to being snowflaked away like usual.
/datum/reagent/water/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	//You don't belong in this world, monster!
	mytray.reagents.remove_reagent(type, volume)

/datum/reagent/water/mineral
	name = "Mineral Water"; display_name = "矿泉水"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE|REAGENT_CLEANS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/water/mineral/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_tox_loss(-0.05 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	return UPDATE_MOB_HEALTH

/datum/reagent/water/salt
	name = "Saltwater"; display_name = "盐水"
	description = "咸味的水。闻起来像是……站上的医务室？"
	color = "#aaaaaa9d" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "the sea"
	cooling_temperature = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/waterbottle

/datum/glass_style/shot_glass/water/salt
	required_drink_type = /datum/reagent/water/salt
	icon_state = "shotglassclear"

/datum/glass_style/drinking_glass/water/salt
	required_drink_type = /datum/reagent/water/salt
	name = "一杯盐水"
	desc = "喉咙疼的话，可以用盐水漱漱口。也能凑合用来处理伤口。"
	icon_state = "glass_clear"

/datum/reagent/water/salt/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	var/mob/living/carbon/carbies = exposed_mob
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return
	for(var/datum/wound/iter_wound as anything in carbies.all_wounds)
		iter_wound.on_saltwater(reac_volume, carbies)

// Mixed salt with water! All the help of salt with none of the irritation. Plus increased volume.
/datum/wound/proc/on_saltwater(reac_volume, mob/living/carbon/carbies)
	return

/datum/wound/pierce/bleed/on_saltwater(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.06 * reac_volume, initial_flow * 0.6)
	to_chat(carbies, span_notice("盐水溅过[LOWER_TEXT(src)]，冲去了血迹。"))

/datum/wound/slash/flesh/on_saltwater(reac_volume, mob/living/carbon/carbies)
	adjust_blood_flow(-0.1 * reac_volume, initial_flow * 0.5)
	to_chat(carbies, span_notice("盐水溅过[LOWER_TEXT(src)]，冲去了血迹。"))

/datum/wound/burn/flesh/on_saltwater(reac_volume)
	// Similar but better stats from normal salt.
	sanitization += VALUE_PER(0.6, 30) * reac_volume
	infection -= max(VALUE_PER(0.5, 30) * reac_volume, 0)
	infection_rate += VALUE_PER(0.07, 30) * reac_volume
	to_chat(victim, span_notice("盐水溅过[LOWER_TEXT(src)]，冲去了那些……杂七杂八的体液。之后感觉稍微好受了一些。"))
	return

/datum/reagent/water/holywater
	name = "Holy Water"; display_name = "圣水"
	description = "得到某位神祇祝福的水。"
	color = "#E0E8EF" // rgb: 224, 232, 239
	self_consuming = TRUE //divine intervention won't be limited by the lack of a liver
	ph = 7.5 //God is alkaline
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS|REAGENT_UNAFFECTED_BY_METABOLISM // Operates at fixed metabolism for balancing memes.
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/item/reagent_containers/cup/glass/bottle/holywater
	metabolized_traits = list(TRAIT_HOLY)
	COOLDOWN_DECLARE(spell_clear_cd)

/datum/glass_style/drinking_glass/holywater
	required_drink_type = /datum/reagent/water/holywater
	name = "一杯圣水"
	desc = "一杯圣水。"
	icon_state = "glass_clear"

/datum/reagent/water/holywater/on_new(list/data)
	// Tracks the total amount of deciseconds that the reagent has been metab'd for, for the purpose of deconversion
	if(isnull(data))
		data = list("deciseconds_metabolized" = 0)
	else if(isnull(data["deciseconds_metabolized"]))
		data["deciseconds_metabolized"] = 0

	return ..()

// Holy water. Unlike water, which is nuked, stays in and heals the plant a little with the power of the spirits. Also ALSO increases instability.
/datum/reagent/water/holywater/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume))
	mytray.adjust_plant_health(round(volume * 0.1))
	mytray.myseed?.adjust_instability(round(volume * 0.15))

/datum/reagent/water/holywater/on_mob_add(mob/living/affected_mob, amount)
	. = ..()
	if(IS_CULTIST(affected_mob))
		to_chat(affected_mob, span_userdanger("令人憎恶的圣洁化作光辉触须，开始在你的脑海中蔓延，净除鲜血几何师的影响！"))

/datum/reagent/water/holywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	// Microdosing holy water is less effective than just gulping it down
	data["deciseconds_metabolized"] += seconds_per_tick * 1 SECONDS * metabolization_ratio

	affected_mob.adjust_jitter_up_to(2 SECONDS * metabolization_ratio * seconds_per_tick, 20 SECONDS)
	var/need_mob_update = FALSE

	if(COOLDOWN_FINISHED(src, spell_clear_cd))
		if(IS_CULTIST(affected_mob))
			for(var/datum/action/innate/cult/blood_magic/BM in affected_mob.actions)
				var/removed_any = FALSE
				for(var/datum/action/innate/cult/blood_spell/BS in BM.spells)
					removed_any = TRUE
					qdel(BS)
				if(removed_any)
					to_chat(affected_mob, span_cult_large("圣水冲刷着你的身体，你的鲜血仪式开始失效！"))
					COOLDOWN_START(src, spell_clear_cd, 3 SECONDS)

		if(IS_HERETIC(affected_mob))
			var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(affected_mob)
			var/removed_any = FALSE
			for(var/datum/heretic_knowledge/spell/spell in heretic_datum.get_researched_knowledge())
				if(spell.remove_charges(ceil(spell.max_charges * spell.holywater_drain_amount)))
					removed_any = TRUE
			if(removed_any)
				to_chat(affected_mob, span_mansus("圣水冲刷着你的身体，扰乱了你精密的仪式！"))
				COOLDOWN_START(src, spell_clear_cd, 3 SECONDS)

	if(data["deciseconds_metabolized"] >= (25 SECONDS)) // 10 units
		affected_mob.adjust_stutter_up_to(2 SECONDS * metabolization_ratio * seconds_per_tick, 20 SECONDS)
		affected_mob.set_dizzy_if_lower(10 SECONDS)
		if(IS_CULTIST(affected_mob) && SPT_PROB(10, seconds_per_tick))
			affected_mob.say(pick("Av'te Nar'Sie","Pa'lid Mors","INO INO ORA ANA","SAT ANA!","Daim'niodeis Arc'iai Le'eones","R'ge Na'sie","Diabo us Vo'iscum","Eld' Mon Nobis"), forced = "holy water")
			if(prob(10))
				affected_mob.visible_message(span_danger("[affected_mob]突然抽搐起来！"), span_userdanger("你突然抽搐起来！"))
				affected_mob.Unconscious(12 SECONDS)
				to_chat(affected_mob, span_cult_large("[pick("鲜血便是你的纽带，没有它你什么也不是。", "别忘了自己的身份。", \
					"拥有如此力量，你居然还是失败了？", "若你无法净除这毒物，我便净除你卑微的生命！")]"))
		else if(HAS_TRAIT(affected_mob, TRAIT_EVIL) && SPT_PROB(25, seconds_per_tick)) //Congratulations, your committment to evil has now made holy water a deadly poison to you!
			if(!IS_CULTIST(affected_mob) || affected_mob.mind?.holy_role != HOLY_ROLE_PRIEST)
				affected_mob.emote("scream")
				need_mob_update += affected_mob.adjust_fire_loss(1.5 * metabolization_ratio, updating_health = FALSE)

	if(data["deciseconds_metabolized"] >= (1 MINUTES)) // 24 units
		if(IS_CULTIST(affected_mob))
			affected_mob.mind.remove_antag_datum(/datum/antagonist/cult)
			affected_mob.Unconscious(10 SECONDS)
		else if(HAS_TRAIT(affected_mob, TRAIT_EVIL)) //At this much holy water, you're probably going to fucking melt. good luck
			if(!IS_CULTIST(affected_mob) || affected_mob.mind?.holy_role != HOLY_ROLE_PRIEST)
				need_mob_update += affected_mob.adjust_fire_loss(5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		affected_mob.remove_status_effect(/datum/status_effect/jitter)
		affected_mob.remove_status_effect(/datum/status_effect/speech/stutter)
		for(var/datum/status_effect/eldritch_painting/eldritch_curses in affected_mob.status_effects)
			qdel(eldritch_curses)
		holder?.remove_reagent(type, volume) // maybe this is a little too perfect and a max() cap on the statuses would be better??
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/water/holywater/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	if(reac_volume >= 10)
		for(var/obj/effect/rune/R in exposed_turf)
			qdel(R)
	exposed_turf.bless_turf()

/datum/reagent/water/hollowwater
	name = "Hollow Water"; display_name = "空心水"
	description = "一种由氢和氧组成、随处可见的化学物质，不过看起来有些空洞。"
	color = "#88878777"
	taste_description = "emptyiness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/hydrogen_peroxide
	name = "Hydrogen Peroxide"; display_name = "过氧化氢"
	description = "一种常见的化学物质，由氢、氧，还有氧组成。" //intended intended
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha)
	taste_description = "burning water"
	ph = 6.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/glass_style/shot_glass/hydrogen_peroxide
	required_drink_type = /datum/reagent/hydrogen_peroxide
	icon_state = "shotglassclear"

/datum/glass_style/drinking_glass/hydrogen_peroxide
	required_drink_type = /datum/reagent/hydrogen_peroxide
	name = "一杯增氧水"
	desc = "一切清凉饮品之父。喝起来肯定很棒，对吧？"
	icon_state = "glass_clear"

/*
 * Water reaction to turf
 */

/datum/reagent/hydrogen_peroxide/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if (reac_volume < 1.5)
		return
	if (!isplatingturf(exposed_turf) && exposed_turf.type != /turf/closed/wall)
		return
	if (!HAS_TRAIT(exposed_turf, TRAIT_RUSTY))
		exposed_turf.AddElement(/datum/element/rust)
/*
 * Water reaction to a mob
 */

/datum/reagent/hydrogen_peroxide/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0) //Exposing people to h2o2 can burn them !
	. = ..()
	if(!(methods & (VAPOR|TOUCH)))
		return

	var/damage_to_inflict = 2 * max(1 - touch_protection, 0)

	if(damage_to_inflict)
		exposed_mob.adjust_fire_loss(damage_to_inflict)

/datum/reagent/fuel/unholywater //if you somehow managed to extract this from someone, dont splash it on yourself and have a smoke
	name = "Unholy Water"; display_name = "邪水"
	description = "一种本不该存在于此位面的东西。"
	taste_description = "suffering"
	self_consuming = TRUE //unholy intervention won't be limited by the lack of a liver
	metabolization_rate = 2.5 * REAGENTS_METABOLISM  //0.5u/second
	penetrates_skin = TOUCH|VAPOR
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/fuel/unholywater/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(IS_CULTIST(affected_mob))
		ADD_TRAIT(affected_mob, TRAIT_COAGULATING, type)

/datum/reagent/fuel/unholywater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	var/need_mob_update = FALSE
	if(IS_CULTIST(affected_mob))
		affected_mob.adjust_drowsiness(-2 SECONDS * metabolization_ratio * seconds_per_tick)
		affected_mob.AdjustAllImmobility(-8 * metabolization_ratio * seconds_per_tick)
		need_mob_update += affected_mob.adjust_stamina_loss(-2 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
		need_mob_update += affected_mob.adjust_tox_loss(-0.4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_oxy_loss(-0.4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_brute_loss(-0.4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_fire_loss(-0.4 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		affected_mob.adjust_blood_volume(0.6 * metabolization_ratio * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL)
		affected_mob.coagulant_effect(0.4 * metabolization_ratio * seconds_per_tick)

	else  // Will deal about 90 damage when 50 units are thrown
		need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.6 * metabolization_ratio * seconds_per_tick, 150)
		need_mob_update += affected_mob.adjust_tox_loss(0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_fire_loss(0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_oxy_loss(0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
		need_mob_update += affected_mob.adjust_brute_loss(0.2 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/fuel/unholywater/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_COAGULATING, type) //We don't cult check here because potentially our imbiber may no longer be a cultist for whatever reason! It doesn't purge holy water, after all!

/datum/reagent/hellwater //if someone has this in their system they've really pissed off an eldrich god
	name = "Hell Water"; display_name = "地狱之水"
	description = "你的血肉！正在燃烧！"
	taste_description = "burning"
	ph = 0.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/hellwater/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_fire_stacks(min(affected_mob.fire_stacks + (1.5 * seconds_per_tick), 5))
	affected_mob.ignite_mob() //Only problem with igniting people is currently the commonly available fire suits make you immune to being on fire
	var/need_mob_update
	need_mob_update = affected_mob.adjust_tox_loss(0.5*seconds_per_tick, updating_health = FALSE)
	need_mob_update += affected_mob.adjust_fire_loss(0.5*seconds_per_tick, updating_health = FALSE) //Hence the other damages... ain't I a bastard?
	affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2.5*seconds_per_tick, 150)
	if(holder)
		holder.remove_reagent(type, 0.5 * seconds_per_tick)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/medicine/omnizine/godblood
	name = "Godblood"; display_name = "神血"
	description = "缓慢治疗各种损伤，过量阈值相当高。闪耀着神秘力量的光辉。"
	overdose_threshold = 150
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

///Used for clownery
/datum/reagent/lube
	name = "Space Lube"; display_name = "太空润滑剂"
	description = "润滑剂置于两个相对运动的表面之间，能减少摩擦和磨损。嘿嘿，你懂的。"
	color = "#009CA8" // rgb: 0, 156, 168
	taste_description = "cherry" // by popular demand
	var/lube_kind = TURF_WET_LUBE ///What kind of slipperiness gets added to turfs
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/lube/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(isopenturf(exposed_turf) && reac_volume >= 1)
		exposed_turf.MakeSlippery(lube_kind, 15 SECONDS, min(reac_volume * 2 SECONDS, 12 SECONDS))

/datum/reagent/lube/expose_obj(obj/exposed_obj, reac_volume, methods, show_message)
	. = ..()
	if(isitem(exposed_obj) && reac_volume >= 1)
		exposed_obj.AddComponent( \
			/datum/component/slippery_item, \
			fall_chance = (lube_kind == TURF_WET_SUPERLUBE ? 80 : 50), \
			fall_catch_chance = (lube_kind == TURF_WET_SUPERLUBE ? 10 : 30), \
			examine_msg = span_info("它表面涂着一层滑溜溜的物质！"), \
			wash_flags = CLEAN_TYPE_HARD_DECAL, \
			duration = min(reac_volume * 3 SECONDS, 30 SECONDS), \
		)

/datum/reagent/lube/used_on_fish(obj/item/fish/fish)
	ADD_TRAIT(fish, TRAIT_FISH_FED_LUBE, type) //required for the lubefish mutation
	addtimer(TRAIT_CALLBACK_REMOVE(fish, TRAIT_FISH_FED_LUBE, type), fish.feeding_frequency, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE

///Stronger kind of lube. Applies TURF_WET_SUPERLUBE.
/datum/reagent/lube/superlube
	name = "Super Duper Lube"; display_name = "超级无敌润滑剂"
	description = "自\[资料已删除\]事件后，这种\[已删改\]便遭到禁止。"
	lube_kind = TURF_WET_SUPERLUBE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/spraytan
	name = "Spray Tan"; display_name = "美黑喷雾"
	description = "涂在皮肤上使肤色变深的物质。"
	color = "#FFC080" // rgb: 255, 196, 128  Bright orange
	metabolization_rate = 10 * REAGENTS_METABOLISM // very fast, so it can be applied rapidly.  But this changes on an overdose
	overdose_threshold = 11 //Slightly more than one un-nozzled spraybottle.
	taste_description = "sour oranges"
	ph = 5
	fallback_icon = 'icons/obj/drinks/drink_effects.dmi'
	fallback_icon_state = "spraytan_fallback"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	glass_price = DRINK_PRICE_HIGH

/datum/reagent/spraytan/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(ishuman(exposed_mob))
		if(methods & (PATCH|VAPOR) && touch_protection < 1)
			var/mob/living/carbon/human/exposed_human = exposed_mob
			if(HAS_TRAIT(exposed_human, TRAIT_USES_SKINTONES))
				switch(exposed_human.skin_tone)
					if("african1")
						exposed_human.skin_tone = "african2"
					if("indian")
						exposed_human.skin_tone = "mixed2"
					if("arab")
						exposed_human.skin_tone = "indian"
					if("asian2")
						exposed_human.skin_tone = "arab"
					if("asian1")
						exposed_human.skin_tone = "asian2"
					if("mediterranean")
						exposed_human.skin_tone = "mixed1"
					if("latino")
						exposed_human.skin_tone = "mediterranean"
					if("caucasian3")
						exposed_human.skin_tone = "mediterranean"
					if("caucasian2")
						exposed_human.skin_tone = pick("caucasian3", "latino")
					if("caucasian1")
						exposed_human.skin_tone = "caucasian2"
					if("albino")
						exposed_human.skin_tone = "caucasian1"
					if("mixed1")
						exposed_human.skin_tone = "mixed2"
					if("mixed2")
						exposed_human.skin_tone = "mixed3"
					if("mixed3")
						exposed_human.skin_tone = "african1"
					if("mixed4")
						exposed_human.skin_tone = "mixed3"
			//take current alien color and darken it slightly
			else if(HAS_TRAIT(exposed_human, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(exposed_human, TRAIT_FIXED_MUTANT_COLORS))
				var/list/existing_color = rgb2num(exposed_human.dna.features[FEATURE_MUTANT_COLOR])
				var/list/darkened_color = list()
				// Reduces each part of the color by 16
				for(var/channel in existing_color)
					darkened_color += max(channel - 17, 0)

				var/new_color = rgb(darkened_color[1], darkened_color[2], darkened_color[3])
				var/list/new_hsv = rgb2hsv(new_color)
				// Can't get too dark now
				if(new_hsv[3] >= 50)
					exposed_human.dna.features[FEATURE_MUTANT_COLOR] = new_color
			exposed_human.update_body(is_creating = TRUE)

		if((methods & INGEST) && show_message)
			to_chat(exposed_mob, span_notice("味道糟透了。"))

/datum/reagent/spraytan/overdose_process(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	metabolization_rate = REAGENTS_METABOLISM

	if(ishuman(affected_mob))
		var/mob/living/carbon/human/affected_human = affected_mob
		var/obj/item/bodypart/head/head = affected_human.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.head_flags |= HEAD_HAIR //No hair? No problem!
		if(!HAS_TRAIT(affected_human, TRAIT_SHAVED))
			affected_human.set_facial_hairstyle("Shaved", update = FALSE)
		affected_human.set_facial_haircolor(COLOR_BLACK, update = FALSE)
		if(!HAS_TRAIT(affected_human, TRAIT_BALD))
			affected_human.set_hairstyle("Spiky", update = FALSE)
		affected_human.set_haircolor(COLOR_BLACK, update = FALSE)
		if(HAS_TRAIT(affected_human, TRAIT_USES_SKINTONES))
			affected_human.skin_tone = "orange"
		else if(HAS_TRAIT(affected_human, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(affected_human, TRAIT_FIXED_MUTANT_COLORS)) //Aliens with custom colors simply get turned orange
			affected_human.dna.features[FEATURE_MUTANT_COLOR] = "#ff8800"
		affected_human.update_body(is_creating = TRUE)
		if(SPT_PROB(3.5, seconds_per_tick))
			if(affected_human.w_uniform)
				affected_mob.visible_message(pick("<b>[affected_mob]</b>的衣领突然竖了起来。</span>", "<b>[affected_mob]</b>屈臂秀出肌肉。"))
			else
				affected_mob.visible_message("<b>[affected_mob]</b>屈臂秀出肌肉。")
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.say(pick("这他妈太赚了。", "世上所有的烂事都集中在你身上了。", "除了对着日本裸体二次元撸管，你还玩什么运动？", "别见外，拿出你的全力来吧。", "我叫约翰，我恨你们每一个人。"), forced = /datum/reagent/spraytan)

#define MUT_MSG_IMMEDIATE 1
#define MUT_MSG_EXTENDED 2
#define MUT_MSG_ABOUT2TURN 3

/// the current_cycle threshold / iterations needed before one can transform
#define CYCLES_TO_TURN 20
/// the cycle at which 'immediate' mutation text begins displaying
#define CYCLES_MSG_IMMEDIATE 6
/// the cycle at which 'extended' mutation text begins displaying
#define CYCLES_MSG_EXTENDED 16

/datum/reagent/mutationtoxin
	name = "Stable Mutation Toxin"; display_name = "稳定突变毒素"
	description = "一种能使生物变成人类的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	metabolization_rate = 0.5 * REAGENTS_METABOLISM //metabolizes to prevent micro-dosage
	taste_description = "slime"
	affected_biotype = MOB_ORGANIC|MOB_SKELETAL|MOB_UNDEAD
	var/race = /datum/species/human
	var/list/mutationtexts = list( "你感觉有些不舒服。" = MUT_MSG_IMMEDIATE,
									"你的皮肤感觉有些异样。" = MUT_MSG_IMMEDIATE,
									"你的四肢开始改变形状。" = MUT_MSG_EXTENDED,
									"你的肢体开始变形。" = MUT_MSG_EXTENDED,
									"你感觉自己随时都会发生蜕变！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!ishuman(affected_mob))
		return
	var/mob/living/carbon/affected_human = affected_mob
	if(!(affected_human.dna?.species) || !(affected_human.mob_biotypes & affected_biotype))
		return

	if(SPT_PROB(5, seconds_per_tick))
		var/list/pick_ur_fav = list()
		var/filter = NONE
		if(current_cycle <= CYCLES_MSG_IMMEDIATE)
			filter = MUT_MSG_IMMEDIATE
		else if(current_cycle <= CYCLES_MSG_EXTENDED)
			filter = MUT_MSG_EXTENDED
		else
			filter = MUT_MSG_ABOUT2TURN

		for(var/i in mutationtexts)
			if(mutationtexts[i] == filter)
				pick_ur_fav += i
		to_chat(affected_human, span_warning("[pick(pick_ur_fav)]"))

	if(current_cycle >= CYCLES_TO_TURN)
		var/datum/species/species_type = race
		affected_human.set_species(species_type)
		holder.del_reagent(type)
		to_chat(affected_human, span_warning("你变成了[LOWER_TEXT(initial(species_type.name))]！"))
		return

/datum/reagent/mutationtoxin/classic //The one from plasma on green slimes
	name = "Mutation Toxin"; display_name = "突变毒素"
	description = "一种使生物异化的毒素。"
	color = "#13BC5E" // rgb: 19, 188, 94
	race = /datum/species/jelly/slime
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/felinid
	name = "Felinid Mutation Toxin"; display_name = "猫耳人突变毒素"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/felinid
	taste_description = "something nyat good"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/lizard
	name = "Lizard Mutation Toxin"; display_name = "蜥蜴人突变毒素"
	description = "一种使生物变成蜥蜴人的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/lizard
	taste_description = "dragon's breath but not as cool"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/fly
	name = "Fly Mutation Toxin"; display_name = "苍蝇人突变毒素"
	description = "一种使生物昆虫化的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/fly
	taste_description = "trash"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/moth
	name = "Moth Mutation Toxin"; display_name = "蛾人突变毒素"
	description = "一种闪着光的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/moth
	taste_description = "clothing"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/ethereal
	name = "Ethereal Mutation Toxin"; display_name = "以太人突变毒素"
	description = "一种带电的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ethereal
	taste_description = "static"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/pod
	name = "Podperson Mutation Toxin"; display_name = "荚人突变毒素"
	description = "一种使生物植物化的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/pod
	taste_description = "flowers"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/jelly
	name = "Imperfect Mutation Toxin"; display_name = "不完善突变毒素"
	description = "一种使生物胶质化的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/jelly
	taste_description = "grandma's gelatin"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/jelly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	if(!ishuman(affected_mob))
		return ..()
	var/mob/living/carbon/affected_human = affected_mob
	if(affected_human.mob_biotypes & MOB_SLIME)
		var/datum/species/species_type = pick(subtypesof(race))
		affected_human.set_species(species_type)
		holder.del_reagent(type)
		to_chat(affected_human, span_warning("你的胶质身体不断扭曲变形，化作了另一个亚种！"))
		return UPDATE_MOB_HEALTH
	if(current_cycle < CYCLES_TO_TURN) //overwrite since we want subtypes of jelly
		return ..()
	var/datum/species/species_type = pick(subtypesof(race))
	affected_human.set_species(species_type)
	holder.del_reagent(type)
	to_chat(affected_human, span_warning("你变成了[initial(species_type.name)]！"))
	return UPDATE_MOB_HEALTH


/datum/reagent/mutationtoxin/golem
	name = "Golem Mutation Toxin"; display_name = "魔像突变毒素"
	description = "一种晶体毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/golem
	taste_description = "rocks"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/abductor
	name = "Abductor Mutation Toxin"; display_name = "绑架者突变毒素"
	description = "一种外星毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/abductor
	taste_description = "something out of this world... no, universe!"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/android
	name = "Android Mutation Toxin"; display_name = "仿生人突变毒素"
	description = "一种使生物机械化的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/android
	taste_description = "circuitry and steel"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//BLACKLISTED RACES
/datum/reagent/mutationtoxin/skeleton
	name = "Skeleton Mutation Toxin"; display_name = "骷髅突变毒素"
	description = "一种令人毛骨悚然的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/skeleton
	taste_description = "milk... and lots of it"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/zombie
	name = "Zombie Mutation Toxin"; display_name = "僵尸突变毒素"
	description = "一种使生物变成亡灵的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/zombie //Not the infectious kind. The days of xenobio zombie outbreaks are long past.
	taste_description = "brai...nothing in particular"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/ash
	name = "Ash Mutation Toxin"; display_name = "灰烬行者突变毒素"
	description = "一种带有灰烬气息的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/lizard/ashwalker
	taste_description = "savagery"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/ghost
	name = "Spirit Mutation Toxin"; display_name = "灵体突变毒素"
	description = "一种带有灵性的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/spirit
	taste_description = "ectoplasm"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//DANGEROUS RACES
/datum/reagent/mutationtoxin/shadow
	name = "Shadow Mutation Toxin"; display_name = "暗影突变毒素"
	description = "一种黑暗的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadow
	taste_description = "the night"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mutationtoxin/plasma
	name = "Plasma Mutation Toxin"; display_name = "等离子突变毒素"
	description = "一种以等离子体为基础的毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/plasmaman
	taste_description = "plasma"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

#undef MUT_MSG_IMMEDIATE
#undef MUT_MSG_EXTENDED
#undef MUT_MSG_ABOUT2TURN

#undef CYCLES_TO_TURN
#undef CYCLES_MSG_IMMEDIATE
#undef CYCLES_MSG_EXTENDED

/datum/reagent/mulligan
	name = "Mulligan Toxin"; display_name = "重塑毒素"
	description = "这种毒素会迅速改变类人生物的DNA，常被需要紧急更换身份的辛迪加间谍与刺客使用。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	metabolization_rate = INFINITY
	taste_description = "slime"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mulligan/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/affected_human = affected_mob
	to_chat(affected_human, span_boldwarning("你的身体迅速突变，疼得你咬紧牙关！"))
	affected_human.visible_message("<b>[affected_human]</b>突然变了模样！")
	randomize_human_normie(affected_human)

/datum/reagent/aslimetoxin
	name = "Advanced Mutation Toxin"; display_name = "高级突变毒素"
	description = "一种由史莱姆产生的高级异化毒素。"
	color = "#13BC5E" // rgb: 19, 188, 94
	taste_description = "slime"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/aslimetoxin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/slime(), FALSE, TRUE)

/datum/reagent/gluttonytoxin
	name = "Gluttony's Blessing"; display_name = "暴食的祝福"
	description = "一种由某种可怕之物产生的高级异化毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	taste_description = "decay"
	penetrates_skin = NONE

/datum/reagent/gluttonytoxin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(reac_volume <= 1)//This prevents microdosing from infecting masses of people
		return

	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/morph(), FALSE, TRUE)

/datum/reagent/serotrotium
	name = "Serotrotium"; display_name = "血清素促进剂"
	description = "一种促进人体集中生成神经递质血清素的化合物。"
	color = "#202040" // rgb: 20, 20, 40
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "bitterness"
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/serotrotium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(3.5, seconds_per_tick))
		affected_mob.emote(pick("twitch","drool","moan","gasp"))

/datum/reagent/oxygen
	name = "Oxygen"; display_name = "氧"
	description = "一种无色无味的气体。虽然树上就能长出来，却仍然相当宝贵。"
	color = COLOR_GRAY
	taste_mult = 0 // oderless and tasteless
	ph = 9.2//It's acutally a huge range and very dependant on the chemistry but ph is basically a made up var in its implementation anyways
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS


/datum/reagent/oxygen/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		exposed_turf.atmos_spawn_air("[GAS_O2]=[reac_volume/20];[TURF_TEMPERATURE(holder ? holder.chem_temp : T20C)]")
	return

/datum/reagent/copper
	name = "Copper"; display_name = "铜"
	description = "一种延展性很好的金属。铜制物品不算特别耐用，但很适合制作电线。"
	color = "#6E3B08" // rgb: 110, 59, 8
	taste_description = "metal"
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/copper/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(!istype(exposed_obj, /obj/item/stack/sheet/iron))
		return

	var/obj/item/stack/sheet/iron/metal = exposed_obj
	reac_volume = min(reac_volume, metal.amount)
	new/obj/item/stack/sheet/bronze(get_turf(metal), reac_volume)
	metal.use(reac_volume)

/datum/reagent/nitrogen
	name = "Nitrogen"; display_name = "氮"
	description = "一种无色、无臭、无味的气体。能悄无声息地排挤维持生命所需的氧气，造成单纯性窒息。"
	color = COLOR_GRAY
	taste_mult = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/nitrogen/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		exposed_turf.atmos_spawn_air("[GAS_N2]=[reac_volume/20];[TURF_TEMPERATURE(holder ? holder.chem_temp : T20C)]")
	return ..()

/datum/reagent/hydrogen
	name = "Hydrogen"; display_name = "氢"
	description = "一种无色、无臭、无味、非金属且极易燃烧的双原子气体。"
	color = COLOR_GRAY
	taste_mult = 0
	ph = 0.1//Now I'm stuck in a trap of my own design. Maybe I should make -ve phes? (not 0 so I don't get div/0 errors)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/potassium
	name = "Potassium"; display_name = "钾"
	description = "一种质软、熔点低的固体，能轻易用刀切开，遇水会剧烈反应。"
	color = "#A0A0A0" // rgb: 160, 160, 160
	taste_description = "sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mercury
	name = "Mercury"; display_name = "汞"
	description = "一种在室温下呈液态的奇特金属。会导致神经退化，对大脑十分有害。"
	color = COLOR_WEBSAFE_DARK_GRAY // rgb: 72, 72, 72A
	taste_mult = 0 // apparently tasteless.
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/mercury/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_IMMOBILIZED) && isturf(affected_mob.loc) && !isgroundlessturf(affected_mob.loc))
		step(affected_mob, pick(GLOB.cardinals))
	if(SPT_PROB(3.5, seconds_per_tick))
		affected_mob.emote(pick("twitch","drool","moan"))
	if(affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5 * metabolization_ratio * seconds_per_tick))
		return UPDATE_MOB_HEALTH

/datum/reagent/sulfur
	name = "Sulfur"; display_name = "硫"
	description = "一种以难闻气味著称的病态黄色固体。在生物化学中，它的用途远比外表看起来广泛。"
	color = "#BF8C00" // rgb: 191, 140, 0
	taste_description = "rotten eggs"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carbon
	name = "Carbon"; display_name = "碳"
	description = "一种松脆的黑色固体。物理性质虽然平平无奇，却是所有已知生命的基础，可谓举足轻重。"
	color = "#1C1300" // rgb: 30, 20, 0
	taste_description = "sour chalk"
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carbon/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(isspaceturf(exposed_turf))
		return

	exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/dirt)

/datum/reagent/chlorine
	name = "Chlorine"; display_name = "氯"
	description = "一种常见的淡黄色氧化性气体。虽然能组成许多无害的分子，其单质形态却远非无害。"
	color = "#FFFB89" //pale yellow? let's make it light gray
	taste_description = "chlorine"
	ph = 7.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS


// You're an idiot for thinking that one of the most corrosive and deadly gasses would be beneficial
/datum/reagent/chlorine/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume))
	mytray.adjust_toxic(round(volume * 1.5))
	mytray.adjust_waterlevel(-round(volume * 0.5))
	mytray.adjust_weedlevel(-rand(1, 3))
	// White Phosphorous + water -> phosphoric acid. That's not a good thing really.


/datum/reagent/chlorine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.take_bodypart_damage(0.25 * metabolization_ratio * seconds_per_tick, 0))
		return UPDATE_MOB_HEALTH

/datum/reagent/fluorine
	name = "Fluorine"; display_name = "氟"
	description = "一种活泼得近乎滑稽的化学元素。整个宇宙似乎都不愿让它以这种形态存在。"
	color = COLOR_GRAY
	taste_description = "acid"
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// You're an idiot for thinking that one of the most corrosive and deadly gasses would be beneficial
/datum/reagent/fluorine/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 2))
	mytray.adjust_toxic(round(volume * 2.5))
	mytray.adjust_waterlevel(-round(volume * 0.5))
	mytray.adjust_weedlevel(-rand(1, 4))

/datum/reagent/fluorine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_tox_loss(0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/sodium
	name = "Sodium"; display_name = "钠"
	description = "一种质软的银色金属，能轻易用刀切开。它还不是食盐，所以别往薯条上撒。"
	color = COLOR_GRAY
	taste_description = "salty metal"
	ph = 11.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/phosphorus
	name = "Phosphorus"; display_name = "磷"
	description = "一种很容易燃烧的暗红色粉末。虽然有多种颜色，基本脾气却大同小异。"
	color = "#832828" // rgb: 131, 40, 40
	taste_description = "vinegar"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Phosphoric salts are beneficial though. And even if the plant suffers, in the long run the tray gets some nutrients. The benefit isn't worth that much.
/datum/reagent/phosphorus/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(-round(volume * 0.75))
	mytray.adjust_waterlevel(-round(volume * 0.5))
	mytray.adjust_weedlevel(-rand(1, 2))

/datum/reagent/lithium
	name = "Lithium"; display_name = "锂"
	description = "一种以极低密度著称的银色金属。用它让自己平静下来，效果未免有些过头。"
	color = COLOR_GRAY
	taste_description = "metal"
	ph = 11.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/lithium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_IMMOBILIZED) && isturf(affected_mob.loc) && !isgroundlessturf(affected_mob.loc))
		step(affected_mob, pick(GLOB.cardinals))
	if(SPT_PROB(2.5, seconds_per_tick))
		affected_mob.emote(pick("twitch","drool","moan"))

/datum/reagent/glycerol
	name = "Glycerol"; display_name = "甘油"
	description = "一种简单的多元醇化合物，味甜且毒性低。"
	color = "#D3B913"
	taste_description = "sweetness"
	ph = 9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/space_cleaner/sterilizine
	name = "Sterilizine"; display_name = "灭菌灵"
	description = "为伤口灭菌，以便进行手术。"
	color = "#D0EFEE" // space cleaner but lighter
	taste_description = "bitterness"
	ph = 10.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_AFFECTS_WOUNDS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/space_cleaner/sterilizine/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (TOUCH|VAPOR|PATCH)))
		return

	exposed_mob.add_surgery_speed_mod(type, 0.8, min(reac_volume * 1 MINUTES, 5 MINUTES))

/datum/reagent/space_cleaner/sterilizine/on_burn_wound_processing(datum/wound/burn/flesh/burn_wound)
	burn_wound.sanitization += 0.9

/datum/reagent/iron
	name = "Iron"; display_name = "铁"
	description = "纯铁是一种金属。"
	taste_description = "iron"
	material = /datum/material/iron
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	color = "#606060" //pure iron? let's make it violet of course
	ph = 6

/datum/reagent/gold
	name = "Gold"; display_name = "金"
	description = "一种密度高、质软而有光泽的金属，也是已知延展性最好的金属。"
	color = "#F7C430" // rgb: 247, 196, 48
	taste_description = "expensive metal"
	material = /datum/material/gold
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/silver
	name = "Silver"; display_name = "银"
	description = "一种质软、洁白而有光泽的过渡金属，导电性在元素中居首，导热性也位居金属之最。"
	color = "#D0D0D0" // rgb: 208, 208, 208
	taste_description = "expensive yet reasonable metal"
	material = /datum/material/silver
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/uranium
	name = "Uranium"; display_name = "铀"
	description = "一种属于锕系的翡翠绿色金属元素，具有微弱放射性。"
	color = "#5E9964" //this used to be silver, but liquid uranium can still be green and it's more easily noticeable as uranium like this so why bother?
	taste_description = "the inside of a reactor"
	ph = 4
	material = /datum/material/uranium
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/effect/decal/cleanable/greenglow
	/// How much tox damage to deal per tick
	var/tox_damage = 0.25
	/// How radioactive is this reagent
	var/rad_power = 1

/datum/reagent/uranium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_IRRADIATED) && SSradiation.can_irradiate_basic(affected_mob))
		var/chance = min(volume / (20 - rad_power * 5), rad_power)
		if(SPT_PROB(chance, seconds_per_tick)) // ignore rad protection calculations bc it's inside of us
			affected_mob.AddComponent(/datum/component/irradiated)

	if(affected_mob.adjust_tox_loss(tox_damage * seconds_per_tick * metabolization_rate, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/uranium/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()

	if(!SSradiation.can_irradiate_basic(exposed_obj))
		return

	radiation_pulse(
		source = exposed_obj,
		max_range = 0,
		threshold = RAD_VERY_LIGHT_INSULATION,
		chance = (min(reac_volume * rad_power, CALCULATE_RAD_MAX_CHANCE(rad_power))),
	)

/datum/reagent/uranium/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()

	if(!SSradiation.can_irradiate_basic(exposed_mob))
		return

	if(ishuman(exposed_mob) && SSradiation.wearing_rad_protected_clothing(exposed_mob))
		return

	if(!(methods & (TOUCH|VAPOR)))
		return

	var/exposure_probability = min(100 - (touch_protection * 100), 0, 100)
	if(exposure_probability && !prob(exposure_probability))
		return


	radiation_pulse(
		source = exposed_mob,
		max_range = 0,
		threshold = RAD_VERY_LIGHT_INSULATION,
		chance = (min(reac_volume * rad_power, CALCULATE_RAD_MAX_CHANCE(rad_power))),
	)

/datum/reagent/uranium/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if((reac_volume < 3) || isspaceturf(exposed_turf))
		return

	var/obj/effect/decal/cleanable/greenglow/glow = exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/greenglow)
	if(QDELETED(glow))
		return

	glow.decal_reagent = type
	var/rounded_volume = round(reac_volume, 1)
	glow.reagent_amount = rounded_volume
	if(glow.lazy_init_reagents()) // Decal already has reagents inited, add instead
		glow.reagents.maximum_volume = min(glow.reagents.maximum_volume + rounded_volume, 300) // Increase reagent holder volume up to a max of 300
		glow.reagents.add_reagent(type, rounded_volume)

//Mutagenic chem side-effects.
/datum/reagent/uranium/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.radioactive_exposure(modifier = volume * 0.1)
	mytray.myseed?.adjust_instability(round(volume * 0.1))
	mytray.adjust_toxic(round(0.5 * volume * tox_damage))

/datum/reagent/uranium/radium
	name = "Radium"; display_name = "镭"
	description = "一种具有极强放射性的碱土金属。"
	color = "#00CC00" // ditto
	taste_description = "the colour blue and regret"
	tox_damage = 0.5
	material = null
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	rad_power = 2

/datum/reagent/bluespace
	name = "Bluespace Dust"; display_name = "蓝空间粉尘"
	description = "由微小蓝空间晶体组成的粉尘，具有轻微的空间扭曲性质。"
	color = "#0000CC"
	taste_description = "fizzling blue"
	material = /datum/material/bluespace
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/bluespace/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (VAPOR|TOUCH)))
		return

	do_teleport(exposed_mob, get_turf(exposed_mob), (reac_volume / 5), asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE) //4 tiles per crystal

/datum/reagent/bluespace/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 10 && SPT_PROB(7.5, seconds_per_tick))
		to_chat(affected_mob, span_warning("你感觉自身变得不稳定了……"))
		affected_mob.set_jitter_if_lower(2 SECONDS)
		current_cycle = 1
		addtimer(CALLBACK(affected_mob, TYPE_PROC_REF(/mob/living, bluespace_shuffle)), 3 SECONDS)

/mob/living/proc/bluespace_shuffle()
	do_teleport(src, get_turf(src), 5, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)

/datum/reagent/aluminium
	name = "Aluminium"; display_name = "铝"
	description = "一种银白色、富有延展性的硼族元素。"
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_description = "metal"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/silicon
	name = "Silicon"; display_name = "硅"
	description = "一种四价类金属元素，化学性质比同族的碳更不活泼。"
	color = "#A8A8A8" // rgb: 168, 168, 168
	taste_mult = 0
	material = /datum/material/glass
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/fuel
	name = "Welding Fuel"; display_name = "焊接燃料"
	description = "焊接工具所需的燃料。易燃。"
	color = "#660000" // rgb: 102, 0, 0
	taste_description = "gross metal"
	penetrates_skin = NONE
	ph = 4
	burning_temperature = 1725 //more refined than oil
	burning_volume = 0.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/alcohol = 300)

/datum/glass_style/drinking_glass/fuel
	required_drink_type = /datum/reagent/fuel
	name = "一杯焊接燃料"
	desc = "除非你是工业工具，否则喝下它大概不会安全。"
	icon_state = "dr_gibb_glass"

/datum/reagent/fuel/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)//Splashing people with welding fuel to make them easy to ignite!
	. = ..()
	if(!(methods & (VAPOR|TOUCH)))
		return

	exposed_mob.adjust_fire_stacks(reac_volume / 10)

/datum/reagent/fuel/on_mob_life(mob/living/carbon/victim, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = victim.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_HUMAN_AI_METABOLISM))
		return
	if(victim.adjust_tox_loss(0.5 * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		return UPDATE_MOB_HEALTH

/datum/reagent/fuel/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf) || isspaceturf(exposed_turf))
		return

	if((reac_volume < 5))
		return

	var/obj/effect/decal/cleanable/fuel_pool/pool = exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/fuel_pool)
	if(pool)
		pool.burn_amount = max(min(round(reac_volume / 5), 10), 1)

/datum/reagent/fuel/on_spark_act(power_charge, spark_flags)
	// Doesn't go boom in open air unless we pass a REALLY high current or if we're hot enough
	if (!(spark_flags & SPARK_ACT_ENCLOSED) && power_charge < STANDARD_BATTERY_VALUE && holder.chem_temp < 474)
		var/turf/our_turf = get_turf(holder.my_atom)
		our_turf?.hotspot_expose(holder.chem_temp * 10, volume)
		return NONE

	var/strengthdiv = 10
	if (spark_flags & SPARK_ACT_WEAKEN_COMMON)
		strengthdiv *= 3 // Noticeably weaker than waterpot, at least put some effort in, cmon

	reagent_explode(holder, volume, strengthdiv = strengthdiv, clear_holder_reagents = FALSE, flame_factor = 1)
	return SPARK_ACT_DESTRUCTIVE | SPARK_ACT_CLEAR_ALL

/datum/reagent/space_cleaner
	name = "Space Cleaner"; display_name = "太空清洁剂"
	description = "一种清洁用化合物，现在多含50%的次氯酸钠！也能用来清洁伤口，但它并不是为此设计的。"
	color = "#A5F0EE" // rgb: 165, 240, 238
	taste_description = "sourness"
	reagent_weight = 0.6 //so it sprays further
	penetrates_skin = VAPOR
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_CLEANS|REAGENT_AFFECTS_WOUNDS
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/clean_types = CLEAN_WASH

/datum/reagent/space_cleaner/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	exposed_obj?.wash(clean_types)

/datum/reagent/space_cleaner/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 1)
		return

	exposed_turf.wash(clean_types, TRUE)

	for(var/mob/living/basic/slime/exposed_slime in exposed_turf)
		exposed_slime.adjust_tox_loss(rand(5,10))

/datum/reagent/space_cleaner/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection=0)
	. = ..()
	if(!(methods & (VAPOR|TOUCH)))
		return

	exposed_mob.wash(clean_types)

/datum/reagent/space_cleaner/on_burn_wound_processing(datum/wound/burn/flesh/burn_wound)
	burn_wound.sanitization += 0.3
	if(prob(5))
		to_chat(burn_wound.victim, span_notice("[src]覆盖在[burn_wound]上，带来刺痛与灼热！不过看起来<i>确实</i>干净了不少。"))
		burn_wound.victim.apply_damage(0.5, TOX)
		burn_wound.victim.apply_damage(0.5, BURN, burn_wound.limb, wound_bonus = CANT_WOUND)

/datum/reagent/space_cleaner/ez_clean
	name = "EZ Clean"; display_name = "轻松净"
	description = "华夫公司销售的强力酸性清洁剂。仅作用于有机物，不影响其他物品。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "acid"
	penetrates_skin = VAPOR
	ph = 2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/space_cleaner/ez_clean/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/heal = 1.1 * metabolization_ratio * seconds_per_tick
	var/need_mob_update
	need_mob_update = affected_mob.adjust_brute_loss(heal, updating_health = FALSE)
	need_mob_update += affected_mob.adjust_fire_loss(heal, updating_health = FALSE)
	need_mob_update += affected_mob.adjust_tox_loss(heal, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/space_cleaner/ez_clean/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || issilicon(exposed_mob))
		return

	var/damage_to_inflict = 1.5 * max(1 - touch_protection, 0)

	if(damage_to_inflict)
		exposed_mob.adjust_brute_loss(damage_to_inflict)
		exposed_mob.adjust_fire_loss(damage_to_inflict)

/datum/reagent/cryptobiolin
	name = "Cryptobiolin"; display_name = "眩惑灵"
	description = "眩惑灵会使人混乱和眩晕。"
	color = "#ADB5DB" //i hate default violets and 'crypto' keeps making me think of cryo so it's light blue now
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "sourness"
	ph = 11.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/cryptobiolin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.set_dizzy_if_lower(2 SECONDS)

	// Cryptobiolin adjusts the mob's confusion down to 20 seconds if it's higher,
	// or up to 1 second if it's lower, but will do nothing if it's in between
	var/confusion_left = affected_mob.get_timed_status_effect_duration(/datum/status_effect/confusion)
	if(confusion_left < 1 SECONDS)
		affected_mob.set_confusion(1 SECONDS)

	else if(confusion_left > 20 SECONDS)
		affected_mob.set_confusion(20 SECONDS)

/datum/reagent/impedrezene
	name = "Impedrezene"; display_name = "抑智嗪"
	description = "一种通过减缓高等脑细胞功能来妨碍行动能力的麻醉药物。"
	color = "#E07DDD" // pink = happy = dumb
	taste_description = "numbness"
	ph = 9.1
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/opioids = 120)

/datum/reagent/impedrezene/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_jitter(-5 SECONDS * seconds_per_tick)
	if(SPT_PROB(55, seconds_per_tick))
		affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)
		. = TRUE
	if(SPT_PROB(30, seconds_per_tick))
		affected_mob.adjust_drowsiness(6 SECONDS)
	if(SPT_PROB(5, seconds_per_tick))
		affected_mob.emote("drool")

/datum/reagent/cyborg_mutation_nanomachines
	name = "Nanomachines"; display_name = "纳米机器"
	description = "微观建筑机器人。纳米机器，小子！"
	color = "#535E66" // rgb: 83, 94, 102
	taste_description = "sludge"
	penetrates_skin = NONE
	randomized_spawns = REAGENT_SPAWN_MAINTENANCE_PILL

/datum/reagent/cyborg_mutation_nanomachines/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	var/obj/item/organ/liver/liver = exposed_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_HUMAN_AI_METABOLISM))
		return
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/robot(), FALSE, TRUE)

/datum/reagent/xenomicrobes
	name = "Xenomicrobes"; display_name = "异种微生物"
	description = "具有完全异于地球生命的细胞结构的微生物。"
	color = "#535E66" // rgb: 83, 94, 102
	taste_description = "sludge"
	penetrates_skin = NONE
	randomized_spawns = REAGENT_SPAWN_MAINTENANCE_PILL

/datum/reagent/xenomicrobes/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/transformation/xeno(), FALSE, TRUE)

/datum/reagent/fungalspores
	name = "Tubercle Bacillus Cosmosis Microbes"; display_name = "星际真菌性结核杆菌微生物"
	description = "活跃的真菌孢子。"
	color = "#92D17D" // rgb: 146, 209, 125
	taste_description = "slime"
	penetrates_skin = NONE
	ph = 11

/datum/reagent/fungalspores/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/tuberculosis(), FALSE, TRUE)

/datum/reagent/snail
	name = "Agent-S"; display_name = "S因子"
	description = "使受试者感染蜗化病的病毒制剂。"
	color = COLOR_VERY_DARK_LIME_GREEN // rgb(0, 51, 0)
	taste_description = "goo"
	penetrates_skin = NONE
	ph = 11

/datum/reagent/snail/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new /datum/disease/gastrolosis(), FALSE, TRUE)

/datum/reagent/fluorosurfactant//foam precursor
	name = "Fluorosurfactant"; display_name = "含氟表面活性剂"
	description = "一种全氟磺酸，与水混合时会产生泡沫。"
	color = "#9E6B38" // rgb: 158, 107, 56
	taste_description = "metal"
	ph = 11
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/foaming_agent// Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming Agent"; display_name = "发泡剂"
	description = "与轻金属和强酸混合时会产生金属泡沫的试剂。"
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"
	ph = 11.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/smart_foaming_agent //Smart foaming agent. Functions similarly to metal foam, but conforms to walls.
	name = "Smart Foaming Agent"; display_name = "智能发泡剂"
	description = "与轻金属和强酸混合时，能产生沿区域边界成形的金属泡沫的试剂。"
	color = "#664B63" // rgb: 102, 75, 99
	taste_description = "metal"
	ph = 11.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/ammonia
	name = "Ammonia"; display_name = "氨"
	description = "一种具有腐蚀性的物质，常用于肥料和家用清洁剂。"
	color = "#404030" // rgb: 64, 64, 48
	taste_description = "mordant"
	ph = 11.6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/ammonia/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	// Ammonia is bad ass.
	mytray.adjust_plant_health(round(volume * 0.12))

	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed) && prob(10))
		myseed.adjust_yield(1)
		myseed.adjust_instability(1)

/datum/reagent/diethylamine
	name = "Diethylamine"; display_name = "二乙胺"
	description = "一种具有轻微腐蚀性的仲胺。"
	color = "#604030" // rgb: 96, 64, 48
	taste_description = "iron"
	ph = 12
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// This is more bad ass, and pests get hurt by the corrosive nature of it, not the plant. The new trade off is it culls stability.
/datum/reagent/diethylamine/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume))
	mytray.adjust_pestlevel(-rand(1,2))
	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_yield(round(volume))
		myseed.adjust_instability(-round(volume))

/datum/reagent/carbondioxide
	name = "Carbon Dioxide"; display_name = "二氧化碳"
	description = "一种常由含碳燃料燃烧产生的气体。你的肺里也在不断产生它。"
	color = "#B0B0B0" // rgb : 192, 192, 192
	taste_description = "something unknowable"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carbondioxide/expose_turf(turf/open/exposed_turf, reac_volume)
	if(istype(exposed_turf))
		exposed_turf.atmos_spawn_air("[GAS_CO2]=[reac_volume/20];[TURF_TEMPERATURE(holder ? holder.chem_temp : T20C)]")
	return ..()

/datum/reagent/nitrous_oxide
	name = "Nitrous Oxide"; display_name = "一氧化二氮"
	description = "一种强氧化剂，用于火箭燃料及手术麻醉。它也具有抗凝作用，因此最好\
		与凝血灵配合使用，以维持凝血能力。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	color = COLOR_GRAY
	taste_description = "sweetness"
	ph = 5.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/nitrous_oxide/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(istype(exposed_turf))
		exposed_turf.atmos_spawn_air("[GAS_N2O]=[reac_volume/20];[TURF_TEMPERATURE(holder ? holder.chem_temp : T20C)]")

/datum/reagent/nitrous_oxide/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(methods & (VAPOR|INHALE))
		// apply 2 seconds of drowsiness per unit applied, with a min duration of 4 seconds
		var/drowsiness_to_apply = max(round(reac_volume, 1) * 2 SECONDS * (1 - touch_protection), 4 SECONDS)
		exposed_mob.adjust_drowsiness(drowsiness_to_apply)
	if(methods & INHALE)
		exposed_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.25 * reac_volume, required_organ_flag = affected_organ_flags)
		exposed_mob.adjust_hallucinations(10 SECONDS * reac_volume)

/datum/reagent/nitrous_oxide/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_COAGULATING)) //IF the mob does not have a coagulant in them, we add the blood mess trait to make the bleed quicker
		ADD_TRAIT(affected_mob, TRAIT_BLOOD_FOUNTAIN, type)

/datum/reagent/nitrous_oxide/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	REMOVE_TRAIT(affected_mob, TRAIT_BLOOD_FOUNTAIN, type)

/datum/reagent/nitrous_oxide/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_drowsiness(1.34 SECONDS * metabolization_ratio * seconds_per_tick)

	if(!HAS_TRAIT(affected_mob, TRAIT_BLOOD_FOUNTAIN) && !HAS_TRAIT(affected_mob, TRAIT_COAGULATING)) //So long as they do not have a coagulant, if they did not have the bloody mess trait, they do now
		ADD_TRAIT(affected_mob, TRAIT_BLOOD_FOUNTAIN, type)

	else if(HAS_TRAIT(affected_mob, TRAIT_COAGULATING)) //if we find they now have a coagulant, we remove the trait
		REMOVE_TRAIT(affected_mob, TRAIT_BLOOD_FOUNTAIN, type)

	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.losebreath += 2
		affected_mob.adjust_confusion_up_to(2 SECONDS, 5 SECONDS)

/////////////////////////Colorful Powder////////////////////////////
//For colouring in /proc/mix_color_from_reagents

/datum/reagent/colorful_reagent/powder
	name = "Mundane Powder"; display_name = "普通颜料粉" //the name's a bit similar to the name of colorful reagent, but hey, they're practically the same chem anyway
	description = "一种用来给物品染色的粉末。"
	color = COLOR_WHITE
	taste_description = "the back of class"
	can_color_organs = TRUE
	var/colorname = "none"

/datum/reagent/colorful_reagent/powder/New()
	if(colorname == "none")
		description = "一种看起来十分普通的粉末，似乎染不了什么东西……"
	else if(colorname == "invisible")
		description = "一种隐形粉末。可惜正因为看不见，它似乎也染不了什么东西……"
	else
		description = "一份[display_name || name]，可将物品染成相应的颜色。"
	return ..()

/datum/reagent/colorful_reagent/powder/red
	name = "Red Powder"; display_name = "红色粉末"
	colorname = "red"
	color = COLOR_CRAYON_RED
	random_color_list = list("#FC7474")
	ph = 0.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/orange
	name = "Orange Powder"; display_name = "橙色粉末"
	colorname = "orange"
	color = COLOR_CRAYON_ORANGE
	random_color_list = list(COLOR_CRAYON_ORANGE)
	ph = 2

/datum/reagent/colorful_reagent/powder/yellow
	name = "Yellow Powder"; display_name = "黄色粉末"
	colorname = "yellow"
	color = COLOR_CRAYON_YELLOW
	random_color_list = list(COLOR_CRAYON_YELLOW)
	ph = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/green
	name = "Green Powder"; display_name = "绿色粉末"
	colorname = "green"
	color = COLOR_CRAYON_GREEN
	random_color_list = list(COLOR_CRAYON_GREEN)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/blue
	name = "Blue Powder"; display_name = "蓝色粉末"
	colorname = "blue"
	color = COLOR_CRAYON_BLUE
	random_color_list = list("#71CAE5")
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/purple
	name = "Purple Powder"; display_name = "紫色粉末"
	colorname = "purple"
	color = COLOR_CRAYON_PURPLE
	random_color_list = list("#BD8FC4")
	ph = 13
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/invisible
	name = "Invisible Powder"; display_name = "隐形粉末"
	colorname = "invisible"
	color = "#FFFFFF00" // white + no alpha
	random_color_list = list(COLOR_WHITE) //because using the powder color turns things invisible
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/black
	name = "Black Powder"; display_name = "黑色粉末"
	colorname = "black"
	color = COLOR_CRAYON_BLACK
	random_color_list = list("#8D8D8D") //more grey than black, not enough to hide your true colors
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/white
	name = "White Powder"; display_name = "白色粉末"
	colorname = "white"
	color = COLOR_WHITE
	random_color_list = list(COLOR_WHITE)
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/* used by crayons, can't color living things but still used for stuff like food recipes */

/datum/reagent/colorful_reagent/powder/red/crayon
	name = "Red Crayon Powder"; display_name = "红色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/orange/crayon
	name = "Orange Crayon Powder"; display_name = "橙色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/yellow/crayon
	name = "Yellow Crayon Powder"; display_name = "黄色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/green/crayon
	name = "Green Crayon Powder"; display_name = "绿色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/blue/crayon
	name = "Blue Crayon Powder"; display_name = "蓝色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/purple/crayon
	name = "Purple Crayon Powder"; display_name = "紫色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//datum/reagent/colorful_reagent/powder/invisible/crayon

/datum/reagent/colorful_reagent/powder/black/crayon
	name = "Black Crayon Powder"; display_name = "黑色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent/powder/white/crayon
	name = "White Crayon Powder"; display_name = "白色蜡笔粉末"
	can_color_mobs = FALSE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//////////////////////////////////Hydroponics stuff///////////////////////////////

/datum/reagent/plantnutriment
	name = "Generic Nutriment"
	description = "Some kind of nutriment. You can't really tell what it is. You should probably report it, along with how you obtained it."
	color = COLOR_BLACK // RBG: 0, 0, 0
	taste_description = "plant food"
	ph = 3
	/// The chance of toxin damage for a mob (heals toxins for MOB_PLANT biotype)
	var/tox_prob = 0

/datum/reagent/plantnutriment/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	if(SPT_PROB(tox_prob, seconds_per_tick))
		var/tox_modifier = (affected_mob.mob_biotypes & MOB_PLANT) ? -1 : 1
		if(affected_mob.adjust_tox_loss(tox_modifier * metabolization_ratio, updating_health = FALSE, required_biotype = affected_biotype))
			return UPDATE_MOB_HEALTH

/datum/reagent/plantnutriment/eznutriment
	name = "E-Z Nutrient"; display_name = "简易营养液"
	description = "含有电解质，植物就馋这一口。"
	color = "#376400" // RBG: 50, 100, 0
	tox_prob = 5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plantnutriment/eznutriment/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_instability(0.2)
		myseed.adjust_potency(round(volume * 0.3))
		myseed.adjust_yield(round(volume * 0.1))

/datum/reagent/plantnutriment/left4zednutriment
	name = "Left 4 Zed"; display_name = "求生之植"
	description = "不稳定的营养液，能使植物更频繁地发生突变。"
	color = "#1A1E4D" // RBG: 26, 30, 77
	tox_prob = 13
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plantnutriment/left4zednutriment/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume * 0.1))
	mytray.myseed?.adjust_instability(round(volume * 0.2))

/datum/reagent/plantnutriment/robustharvestnutriment
	name = "Robust Harvest"; display_name = "丰收营养液"
	description = "效力强劲、能减缓植物突变的营养液。"
	color = "#9D9D00" // RBG: 157, 157, 0
	tox_prob = 8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plantnutriment/robustharvestnutriment/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_instability(-0.25)
		myseed.adjust_potency(round(volume * 0.1))
		myseed.adjust_yield(round(volume * 0.2))

/datum/reagent/plantnutriment/endurogrow
	name = "Enduro Grow"; display_name = "强韧营养液"
	description = "一种特制营养液，降低产量和效力，但能增强植物的耐久。"
	color = "#a06fa7" // RBG: 160, 111, 167
	tox_prob = 8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plantnutriment/endurogrow/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_potency(-round(volume * 0.1))
		myseed.adjust_yield(-round(volume * 0.075))
		myseed.adjust_endurance(round(volume * 0.35))

/datum/reagent/plantnutriment/liquidearthquake
	name = "Liquid Earthquake"; display_name = "液体地震"
	description = "一种特制营养液，能加快植物生长，同时让它更容易受到杂草侵扰。"
	color = "#912e00" // RBG: 145, 46, 0
	tox_prob = 13
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plantnutriment/liquidearthquake/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)

	var/obj/item/seeds/myseed = mytray.myseed
	if(!isnull(myseed))
		myseed.adjust_weed_rate(round(volume * 0.1))
		myseed.adjust_weed_chance(round(volume * 0.3))
		myseed.adjust_production(-round(volume * 0.075))

// GOON OTHERS



/datum/reagent/fuel/oil
	name = "Oil"; display_name = "油"
	description = "燃烧时火势不大，但会冒烟，可用于获取灰烬。"
	color = "#2D2D2D"
	taste_description = "oil"
	burning_temperature = 1200//Oil is crude
	burning_volume = 0.05 //but has a lot of hydrocarbons
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = null
	default_container = /obj/effect/decal/cleanable/blood/oil

/datum/reagent/stable_plasma
	name = "Stable Plasma"; display_name = "稳定等离子液"
	description = "固定为液态的不可燃等离子体，无法点燃，也不会变成气体或固体。"
	color = "#2D2D2D"
	taste_description = "bitterness"
	taste_mult = 1.5
	ph = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjustPlasma(5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/iodine
	name = "Iodine"; display_name = "碘"
	description = "常作为营养成分添加进食盐，单独尝起来就没那么令人愉快了。"
	color = "#BC8A00"
	taste_description = "metal"
	ph = 4.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet
	name = "Carpet"; display_name = "地毯"
	description = "献给想用更有创意的方式铺开红毯的人。"
	color = "#771100"
	taste_description = "carpet" // Your tounge feels furry.
	var/carpet_type = /turf/open/floor/carpet
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/expose_turf(turf/exposed_turf, reac_volume)
	if(isopenturf(exposed_turf) && exposed_turf.turf_flags & IS_SOLID && !istype(exposed_turf, /turf/open/floor/carpet))
		exposed_turf.place_on_top(carpet_type, flags = CHANGETURF_INHERIT_AIR)
	..()

/datum/reagent/carpet/black
	name = "Black Carpet"; display_name = "黑色地毯"
	description = "这地毯还有……嘿色款！" //yes, the typo is intentional
	color = "#1E1E1E"
	taste_description = "licorice"
	carpet_type = /turf/open/floor/carpet/black
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/blue
	name = "Blue Carpet"; display_name = "蓝色地毯"
	description = "献给真需要冷静一阵子的人。"
	color = "#0000DC"
	taste_description = "frozen carpet"
	carpet_type = /turf/open/floor/carpet/blue
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/cyan
	name = "Cyan Carpet"; display_name = "青色地毯"
	description = "献给怀念用有毒物质盖房子那段岁月的人。闻起来像石棉。"
	color = "#00B4FF"
	taste_description = "asbestos"
	carpet_type = /turf/open/floor/carpet/cyan
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/green
	name = "Green Carpet"; display_name = "绿色地毯"
	description = "献给想为绿鸡蛋和火腿配上完美点缀的人。"
	color = COLOR_CRAYON_GREEN
	taste_description = "Green" //the caps is intentional
	carpet_type = /turf/open/floor/carpet/green
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/orange
	name = "Orange Carpet"; display_name = "橙色地毯"
	description = "献给想用健康地毯搭配健康饮食的人。"
	color = "#E78108"
	taste_description = "orange juice"
	carpet_type = /turf/open/floor/carpet/orange
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/purple
	name = "Purple Carpet"; display_name = "紫色地毯"
	description = "献给为了显得气派，不惜浪费大量治疗凝胶的人。"
	color = "#91D865"
	taste_description = "jelly"
	carpet_type = /turf/open/floor/carpet/purple
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/red
	name = "Red Carpet"; display_name = "红色地毯"
	description = "献给想要更红的地毯的人。"
	color = "#731008"
	taste_description = "blood and gibs"
	carpet_type = /turf/open/floor/carpet/red
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/royal
	name = "Royal Carpet?"; display_name = "皇家地毯？"
	description = "献给把游戏弄坏、需要提交问题报告的人。"

/datum/reagent/carpet/royal/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver)
		// Heads of staff and the captain have a "royal metabolism"
		if(HAS_TRAIT(liver, TRAIT_ROYAL_METABOLISM))
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(affected_mob, "你感觉自己就是王室。")
			if(SPT_PROB(2.5, seconds_per_tick))
				affected_mob.say(pick("贱民……","这地毯比你们的合同都值钱！","我随时都能解雇你……"), forced = "royal carpet")

		// The quartermaster, as a semi-head, has a "pretender royal" metabolism
		else if(HAS_TRAIT(liver, TRAIT_PRETENDER_ROYAL_METABOLISM))
			if(SPT_PROB(8, seconds_per_tick))
				to_chat(affected_mob, "你感觉自己像个冒牌货……")

/datum/reagent/carpet/royal/black
	name = "Royal Black Carpet"; display_name = "皇家黑色地毯"
	description = "献给想炫耀自己浪费时间本领的人。"
	color = COLOR_BLACK
	taste_description = "royalty"
	carpet_type = /turf/open/floor/carpet/royalblack
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/royal/blue
	name = "Royal Blue Carpet"; display_name = "皇家蓝色地毯"
	description = "献给想炫耀自己浪费时间本领的人……还是蓝色的。"
	color = "#5A64C8"
	taste_description = "blueyalty" //also intentional
	carpet_type = /turf/open/floor/carpet/royalblue
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/carpet/neon
	name = "Neon Carpet"; display_name = "霓虹地毯"
	description = "献给喜欢二十世纪八十年代、拉斯维加斯和调试的人。"
	color = COLOR_ALMOST_BLACK
	taste_description = "neon"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon

/datum/reagent/carpet/neon/simple_white
	name = "Simple White Neon Carpet"; display_name = "简洁白色霓虹地毯"
	description = "献给喜欢荧光照明的人。"
	color = LIGHT_COLOR_HALOGEN
	taste_description = "sodium vapor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/white

/datum/reagent/carpet/neon/simple_red
	name = "Simple Red Neon Carpet"; display_name = "简洁红色霓虹地毯"
	description = "献给喜欢一点不确定性的人。"
	color = COLOR_RED
	taste_description = "neon hallucinations"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/red

/datum/reagent/carpet/neon/simple_orange
	name = "Simple Orange Neon Carpet"; display_name = "简洁橙色霓虹地毯"
	description = "献给喜欢棱角分明的人。"
	color = COLOR_ORANGE
	taste_description = "neon spines"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/orange

/datum/reagent/carpet/neon/simple_yellow
	name = "Simple Yellow Neon Carpet"; display_name = "简洁黄色霓虹地毯"
	description = "献给生活中需要一点稳定的人。"
	color = COLOR_YELLOW
	taste_description = "stabilized neon"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/yellow

/datum/reagent/carpet/neon/simple_lime
	name = "Simple Lime Neon Carpet"; display_name = "简洁黄绿色霓虹地毯"
	description = "献给需要一点苦涩的人。"
	color = COLOR_LIME
	taste_description = "neon citrus"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/lime

/datum/reagent/carpet/neon/simple_green
	name = "Simple Green Neon Carpet"; display_name = "简洁绿色霓虹地毯"
	description = "献给生活中需要一点变化的人。"
	color = COLOR_GREEN
	taste_description = "radium"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/green

/datum/reagent/carpet/neon/simple_teal
	name = "Simple Teal Neon Carpet"; display_name = "简洁蓝绿色霓虹地毯"
	description = "献给需要抽根烟的人。"
	color = COLOR_TEAL
	taste_description = "neon tobacco"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/teal

/datum/reagent/carpet/neon/simple_cyan
	name = "Simple Cyan Neon Carpet"; display_name = "简洁青色霓虹地毯"
	description = "献给需要喘口气的人。"
	color = COLOR_DARK_CYAN
	taste_description = "neon air"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/cyan

/datum/reagent/carpet/neon/simple_blue
	name = "Simple Blue Neon Carpet"; display_name = "简洁蓝色霓虹地毯"
	description = "献给想再次感受快乐的人。"
	color = COLOR_NAVY
	taste_description = "neon blue"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/blue

/datum/reagent/carpet/neon/simple_purple
	name = "Simple Purple Neon Carpet"; display_name = "简洁紫色霓虹地毯"
	description = "献给需要一点探索的人。"
	color = COLOR_PURPLE
	taste_description = "neon hell"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/purple

/datum/reagent/carpet/neon/simple_violet
	name = "Simple Violet Neon Carpet"; display_name = "简洁紫罗兰色霓虹地毯"
	description = "献给想试探命运的人。"
	color = COLOR_VIOLET
	taste_description = "neon hell"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/violet

/datum/reagent/carpet/neon/simple_pink
	name = "Simple Pink Neon Carpet"; display_name = "简洁粉色霓虹地毯"
	description = "献给只想别再想那么多的人。"
	color = COLOR_PINK
	taste_description = "neon pink"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/pink

/datum/reagent/carpet/neon/simple_black
	name = "Simple Black Neon Carpet"; display_name = "简洁黑色霓虹地毯"
	description = "献给需要歇口气的人。"
	color = COLOR_BLACK
	taste_description = "neon ash"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	carpet_type = /turf/open/floor/carpet/neon/simple/black

/datum/reagent/bromine
	name = "Bromine"; display_name = "溴"
	description = "一种高度活泼的棕色液体，可抑制自由基，但不适合人类饮用。"
	color = "#D35415"
	taste_description = "chemicals"
	ph = 7.8
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/pentaerythritol
	name = "Pentaerythritol"; display_name = "季戊四醇"
	description = "一种用于合成炸药及其他化学品的晶体化合物。"
	color = "#EEEEEF"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/acetaldehyde
	name = "Acetaldehyde"; display_name = "乙醛"
	description = "一种气味强烈的无色液体，用于合成其他化学品。"
	color = "#EEEEEF"
	taste_description = "dead people" //made from formaldehyde, ya get da joke ?
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/acetone_oxide
	name = "Acetone Oxide"; display_name = "丙酮氧化物"
	description = "一种由丙酮衍生的高度活泼化合物，接触时会造成灼伤，用于合成多种炸药。"
	color = "#966199cb"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/acetone_oxide/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)//Splashing people kills people!
	. = ..()
	if(!(methods & TOUCH))
		return

	var/damage_to_inflict = 2 * max(1 - touch_protection, 0)

	if(damage_to_inflict)
		exposed_mob.adjust_fire_loss(damage_to_inflict)

	exposed_mob.adjust_fire_stacks((reac_volume / 10))

/datum/reagent/phenol
	name = "Phenol"; display_name = "苯酚"
	description = "带有羟基的芳香碳环，可作为某些药物的合成原料，但本身没有治疗作用。"
	color = "#E7EA91"
	taste_description = "acid"
	ph = 5.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/ash
	name = "Ash"; display_name = "灰烬"
	description = "细细的灰烬。据说凤凰会从中重生，不过你从没见过。"
	color = "#515151"
	taste_description = "ash"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	default_container = /obj/effect/decal/cleanable/ash

// Ash is also used IRL in gardening, as a fertilizer enhancer and weed killer
/datum/reagent/ash/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume))
	mytray.adjust_weedlevel(-1)

/datum/reagent/acetone
	name = "Acetone"; display_name = "丙酮"
	description = "一种滑溜溜、略有致癌性的液体，在日常生活中用途广泛。"
	color = "#AF14B7"
	taste_description = "acid"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/colorful_reagent
	name = "Colorful Reagent"; display_name = "缤纷试剂"
	description = "把彩虹的颜色尝个遍。"
	var/list/random_color_list = list("#00aedb","#a200ff","#f47835","#d41243","#d11141","#00b159","#00aedb","#f37735","#ffc425","#008744","#0057e7","#d62d20","#ffa700")
	color = COLOR_GRAY
	taste_description = "rainbows"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/colorful_reagent
	/// Whenever this reagent can color mob limbs and organs upon exposure
	var/can_color_mobs = TRUE
	/// Whenever this reagent can color mob equipment when they're exposed to it externally
	var/can_color_clothing = TRUE
	/// Whenever this reagent can color mob organs when taken internally
	var/can_color_organs = FALSE // False by default as this would cause chaotic flickering of victim's eyes
	var/datum/callback/color_callback

/datum/reagent/colorful_reagent/New()
	color_callback = CALLBACK(src, PROC_REF(UpdateColor))
	SSticker.OnRoundstart(color_callback)
	return ..()

/datum/reagent/colorful_reagent/Destroy()
	LAZYREMOVE(SSticker.round_end_events, color_callback) //Prevents harddels during roundstart
	color_callback = null //Fly free little callback
	return ..()

/datum/reagent/colorful_reagent/proc/UpdateColor()
	color_callback = null
	color = pick(random_color_list)

/datum/reagent/colorful_reagent/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	var/picked_color = pick(random_color_list)
	var/color_filter = color_transition_filter(picked_color, SATURATION_OVERRIDE)
	if (can_color_clothing && (methods & (TOUCH|VAPOR|INHALE)))
		var/include_flags = INCLUDE_HELD|INCLUDE_ACCESSORIES
		if (methods & (VAPOR|INHALE) || touch_protection >= 1)
			include_flags |= INCLUDE_POCKETS
		// Not as anyting because this can produce nulls with the flags we passed
		for (var/obj/item/to_color in exposed_mob.get_equipped_items(include_flags))
			to_color.add_atom_colour(color_filter, WASHABLE_COLOUR_PRIORITY)

	if (ishuman(exposed_mob))
		var/mob/living/carbon/human/exposed_human = exposed_mob
		exposed_human.set_facial_haircolor(picked_color, update = FALSE)
		exposed_human.set_haircolor(picked_color)

	if (!can_color_mobs)
		return

	if (!iscarbon(exposed_mob))
		exposed_mob.add_atom_colour(color_filter, WASHABLE_COLOUR_PRIORITY)
		return

	var/mob/living/carbon/exposed_carbon = exposed_mob

	for (var/obj/item/organ/organ as anything in exposed_carbon.organs)
		organ.add_atom_colour(color_filter, WASHABLE_COLOUR_PRIORITY)

	for (var/obj/item/bodypart/part as anything in exposed_carbon.get_bodyparts())
		part.add_atom_colour(color_filter, WASHABLE_COLOUR_PRIORITY)

/datum/reagent/colorful_reagent/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	if (!iscarbon(affected_mob))
		if (can_color_mobs)
			affected_mob.add_atom_colour(color_transition_filter(pick(random_color_list), SATURATION_OVERRIDE), WASHABLE_COLOUR_PRIORITY)
		return

	if(!can_color_organs)
		return

	var/mob/living/carbon/carbon_mob = affected_mob
	var/color_priority = WASHABLE_COLOUR_PRIORITY
	if (current_cycle >= 30) // Seeps deep into your tissues
		color_priority = FIXED_COLOUR_PRIORITY

	for (var/obj/item/organ/organ as anything in carbon_mob.organs)
		organ.add_atom_colour(color_transition_filter(pick(random_color_list), SATURATION_OVERRIDE), color_priority)

/// Colors anything it touches a random color.
/datum/reagent/colorful_reagent/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(!isliving(exposed_atom))
		exposed_atom.add_atom_colour(color_transition_filter(pick(random_color_list), SATURATION_OVERRIDE), WASHABLE_COLOUR_PRIORITY)

/datum/reagent/hair_dye
	name = "Quantum Hair Dye"; display_name = "量子染发剂"
	description = "很有可能让你看起来像个疯狂科学家。"
	var/list/potential_colors = list("#00aadd","#aa00ff","#ff7733","#dd1144","#dd1144","#00bb55","#00aadd","#ff7733","#ffcc22","#008844","#0055ee","#dd2222","#ffaa00") // fucking hair code
	color = COLOR_GRAY
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/hair_dye/New()
	SSticker.OnRoundstart(CALLBACK(src, PROC_REF(UpdateColor)))
	return ..()

/datum/reagent/hair_dye/proc/UpdateColor()
	color = pick(potential_colors)

/datum/reagent/hair_dye/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (TOUCH|VAPOR|INHALE)) || !ishuman(exposed_mob))
		return

	var/exposure_probability = min(100 - (touch_protection * 100), 0, 100)
	if(exposure_probability && !prob(exposure_probability))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	exposed_human.set_facial_haircolor(pick(potential_colors), update = FALSE)
	exposed_human.set_haircolor(pick(potential_colors)) //this will call update_body_parts()

/datum/reagent/barbers_aid
	name = "Barber's Aid"; display_name = "生发助剂"
	description = "解决全球脱发难题的方案。"
	color = "#A86B45" //hair is brown
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/barbers_aid/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob) || (HAS_TRAIT(exposed_mob, TRAIT_BALD) && HAS_TRAIT(exposed_mob, TRAIT_SHAVED)))
		return

	var/exposure_probability = min(100 - (touch_protection * 100), 0, 100)
	if(exposure_probability && !prob(exposure_probability))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	if(!HAS_TRAIT(exposed_human, TRAIT_SHAVED))
		var/datum/sprite_accessory/facial_hair/picked_beard = pick(SSaccessories.facial_hairstyles_list)
		exposed_human.set_facial_hairstyle(picked_beard, update = FALSE)
	if(!HAS_TRAIT(exposed_human, TRAIT_BALD))
		var/datum/sprite_accessory/hair/picked_hair = pick(SSaccessories.hairstyles_list)
		exposed_human.set_hairstyle(picked_hair, update = TRUE)
	to_chat(exposed_human, span_notice("你的[HAS_TRAIT(exposed_human, TRAIT_BALD) ? "脸上" : "头皮上"]开始长出毛发。"))

/datum/reagent/concentrated_barbers_aid
	name = "Concentrated Barber's Aid"; display_name = "浓缩生发助剂"
	description = "解决全球脱发难题的浓缩方案。"
	color = "#7A4E33" //hair is dark browmn
	taste_description = "sourness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/concentrated_barbers_aid/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob) || (HAS_TRAIT(exposed_mob, TRAIT_BALD) && HAS_TRAIT(exposed_mob, TRAIT_SHAVED)))
		return

	var/exposure_probability = min(100 - (touch_protection * 100), 0, 100)
	if(exposure_probability && !prob(exposure_probability))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	if(!HAS_TRAIT(exposed_human, TRAIT_SHAVED))
		exposed_human.set_facial_hairstyle("Beard (Very Long)", update = FALSE)
	if(!HAS_TRAIT(exposed_human, TRAIT_BALD))
		exposed_human.set_hairstyle("Very Long Hair", update = TRUE)
	to_chat(exposed_human, span_notice("你的[HAS_TRAIT(exposed_human, TRAIT_BALD) ? "面部毛发" : "头发"]开始以惊人的速度生长！"))

/datum/reagent/concentrated_barbers_aid/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(current_cycle > 21 / creation_purity)
		if(!ishuman(affected_mob))
			return
		var/mob/living/carbon/human/human_mob = affected_mob
		if(creation_purity == 1 && human_mob.has_quirk(/datum/quirk/item_quirk/bald))
			human_mob.remove_quirk(/datum/quirk/item_quirk/bald)
		var/obj/item/bodypart/head/head = human_mob.get_bodypart(BODY_ZONE_HEAD)
		if(!head || (head.head_flags & HEAD_HAIR))
			return
		head.head_flags |= HEAD_HAIR
		if(HAS_TRAIT(affected_mob, TRAIT_BALD))
			to_chat(affected_mob, span_warning("你感觉头皮发生了突变，但依旧秃得无可救药。"))
		else
			to_chat(affected_mob, span_notice("你的头皮发生了突变，长出一头茂密的头发。"))
			human_mob.update_body_parts()

/datum/reagent/baldium
	name = "Baldium"; display_name = "秃发素"
	description = "全球脱发问题的重要成因。"
	color = "#ecb2cf"
	taste_description = "bitterness"
	penetrates_skin = NONE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/baldium

/datum/reagent/baldium/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message=TRUE, touch_protection = 0)
	. = ..()
	if(!(methods & (TOUCH|VAPOR)) || !ishuman(exposed_mob))
		return

	var/exposure_probability = min(100 - (touch_protection * 100), 0, 100)
	if(exposure_probability && !prob(exposure_probability))
		return

	var/mob/living/carbon/human/exposed_human = exposed_mob
	to_chat(exposed_human, span_danger("你的头发正成把地脱落！"))
	exposed_human.set_facial_hairstyle("Shaved", update = FALSE)
	exposed_human.set_hairstyle("Bald", update = TRUE)

/datum/reagent/saltpetre
	name = "Saltpetre"; display_name = "硝石"
	description = "易变，备受争议，还有第三件事。"
	color = "#60A584" // rgb: 96, 165, 132
	taste_description = "cool salt"
	ph = 11.2
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Saltpetre is used for gardening IRL, to simplify highly, it speeds up growth and strengthens plants
/datum/reagent/saltpetre/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_plant_health(round(volume * 0.18))
	mytray.myseed?.adjust_production(-round(volume / 10)-prob(volume % 10))
	mytray.myseed?.adjust_potency(round(volume))

/datum/reagent/lye
	name = "Lye"; display_name = "碱液"
	description = "又称氢氧化钠。把制造它当成职业，多少有些乏味。"
	color = "#FFFFD6" // very very light yellow
	taste_description = "acid"
	ph = 11.9
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/drying_agent
	name = "Drying Agent"; display_name = "干燥剂"
	description = "一种可以用来干燥物品的吸湿剂。"
	color = "#A70FFF"
	taste_description = "dryness"
	ph = 10.7
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/drying_agent/expose_turf(turf/open/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	// We want one spray of this stuff (5u) to take out a wet floor. Feels better that way
	exposed_turf.MakeDry(ALL, TRUE, reac_volume * 10 SECONDS)

/datum/reagent/drying_agent/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(exposed_obj.type != /obj/item/clothing/shoes/galoshes)
		return
	var/t_loc = get_turf(exposed_obj)
	qdel(exposed_obj)
	new /obj/item/clothing/shoes/galoshes/dry(t_loc)

// Virology virus food chems.

/datum/reagent/toxin/mutagen/mutagenvirusfood
	name = "Mutagenic Agar"; display_name = "致突变琼脂"
	color = "#A3C00F" // rgb: 163,192,15
	taste_description = "sourness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/toxin/mutagen/mutagenvirusfood/sugar
	name = "Sucrose Agar"; display_name = "蔗糖琼脂"
	color = "#41B0C0" // rgb: 65,176,192
	taste_description = "sweetness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/medicine/synaptizine/synaptizinevirusfood
	name = "Virus Rations"; display_name = "病毒口粮"
	color = "#D18AA5" // rgb: 209,138,165
	taste_description = "bitterness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/toxin/plasma/plasmavirusfood
	name = "Virus Plasma"; display_name = "病毒等离子液"
	color = "#A270A8" // rgb: 166,157,169
	taste_description = "bitterness"
	taste_mult = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/toxin/plasma/plasmavirusfood/weak
	name = "Weakened Virus Plasma"; display_name = "弱化病毒等离子液"
	color = "#A28CA5" // rgb: 206,195,198
	taste_description = "bitterness"
	taste_mult = 1.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/uranium/uraniumvirusfood
	name = "Decaying Uranium Gel"; display_name = "衰变铀凝胶"
	color = "#67ADBA" // rgb: 103,173,186
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/uranium/uraniumvirusfood/unstable
	name = "Unstable Uranium Gel"; display_name = "不稳定铀凝胶"
	color = "#2FF2CB" // rgb: 47,242,203
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/uranium/uraniumvirusfood/stable
	name = "Stable Uranium Gel"; display_name = "稳定铀凝胶"
	color = "#04506C" // rgb: 4,80,108
	taste_description = "the inside of a reactor"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/wittelvirusfood
	name = "Exotic Agar"; display_name = "异质琼脂"
	color = "#C3CF7C" // rgb: 195, 207, 124
	taste_description = "sourness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// Bee chemicals

/datum/reagent/royal_bee_jelly
	name = "Royal Bee Jelly"; display_name = "蜂王浆"
	description = "将蜂王浆注入太空蜂后体内，可使其分裂成两只蜜蜂。"
	color = "#00ff80"
	taste_description = "strange honey"
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/royal_bee_jelly/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(1, seconds_per_tick))
		affected_mob.say(pick("嗡嗡……","嗡嗡，嗡嗡","嗡嗡嗡嗡嗡嗡……"), forced = "royal bee jelly")

//Misc reagents

/datum/reagent/romerol
	name = "Romerol"; display_name = "罗梅罗"
	// the REAL zombie powder
	description = "罗梅罗是一种高度实验性的生物恐怖制剂，\
		能使受试者的大脑灰质中形成\
		休眠结节。这些结节只在宿主死亡时\
		才会激活，随后其中的次级结构启动，\
		接管宿主的身体。"
	color = "#123524" // RGB (18, 53, 36)
	metabolization_rate = INFINITY
	taste_description = "brains"
	ph = 0.5

/datum/reagent/romerol/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	// Silently add the zombie infection organ to be activated upon death
	if(can_infect(exposed_mob, reac_volume, methods))
		var/obj/item/organ/zombie_infection/nodamage/zombie_infection = new()
		zombie_infection.Insert(exposed_mob)

/datum/reagent/romerol/proc/can_infect(mob/living/carbon/human/exposed_mob, reac_volume = 5, methods = INGEST)
	if(exposed_mob.get_organ_slot(ORGAN_SLOT_ZOMBIE))
		return FALSE
	if(methods & (PATCH|INGEST|INJECT|INHALE))
		return TRUE
	if(reac_volume >= 1)
		return TRUE
	return FALSE

/datum/reagent/magillitis
	name = "Magillitis"; display_name = "巨猿血清"
	description = "一种使人科动物肌肉迅速生长的实验性血清。副作用可能包括多毛症、暴力发作，以及对香蕉无穷无尽的热爱。"
	color = "#00f041"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/magillitis/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if((ishuman(affected_mob)) && current_cycle > 10)
		var/mob/living/basic/gorilla/new_gorilla = affected_mob.gorillize()
		new_gorilla.AddComponent(/datum/component/regenerator, regeneration_delay = 12 SECONDS, brute_per_second = 1.5, outline_colour = COLOR_PALE_GREEN)

/datum/reagent/growthserum
	name = "Growth Serum"; display_name = "生长血清"
	description = "一种旨在帮助年长男性重振床上雄风的商业化学品。"//not really it just makes you a giant
	color = "#ff0000"//strong red. rgb 255, 0, 0
	var/current_size = RESIZE_DEFAULT_SIZE
	taste_description = "bitterness" // apparently what viagra tastes like
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/growthserum/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/newsize = current_size
	switch(volume)
		if(0 to 19)
			newsize = 1.25*RESIZE_DEFAULT_SIZE
		if(20 to 49)
			newsize = 1.5*RESIZE_DEFAULT_SIZE
		if(50 to 99)
			newsize = 2*RESIZE_DEFAULT_SIZE
		if(100 to 199)
			newsize = 2.5*RESIZE_DEFAULT_SIZE
		if(200 to INFINITY)
			newsize = 3.5*RESIZE_DEFAULT_SIZE

	affected_mob.update_transform(newsize/current_size)
	current_size = newsize

/datum/reagent/growthserum/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.update_transform(RESIZE_DEFAULT_SIZE/current_size)
	current_size = RESIZE_DEFAULT_SIZE

/datum/reagent/growthserum/used_on_fish(obj/item/fish/fish)
	ADD_TRAIT(fish, TRAIT_FISH_QUICK_GROWTH, type)
	addtimer(TRAIT_CALLBACK_REMOVE(fish, TRAIT_FISH_QUICK_GROWTH, type), fish.feeding_frequency * 0.8, TIMER_UNIQUE|TIMER_OVERRIDE)
	return TRUE

/datum/reagent/plastic_polymers
	name = "Plastic Polymers"; display_name = "塑料聚合物"
	description = "以石油为基础的塑料成分。"
	color = "#f7eded"
	taste_description = "plastic"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/glitter
	name = "Glitter"; display_name = "闪粉"
	description = "手工艺界挥之不去的疱疹。"
	data = list("colors" = list(COLOR_WHITE = 100))
	color = COLOR_WHITE //pure white
	taste_description = "plastic"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/glitter/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(25, seconds_per_tick))
		affected_mob.emote("cough")
		expose_turf(get_turf(affected_mob), 0)

/datum/reagent/glitter/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()

	if(!istype(exposed_turf))
		return
	exposed_turf.spawn_glitter(data["colors"])

/datum/reagent/glitter/on_new(data)
	. = ..()

	if(src.data["colors"])
		color = pick_weight(src.data["colors"])
	else
		color = COLOR_WHITE

/datum/reagent/glitter/on_merge(list/mix_data, amount)
	. = ..()

	var/prop_current = (volume-amount)/(volume)

	if(mix_data)
		data["colors"] = blend_weighted_lists(mix_data["colors"], data["colors"], prop_current)

	if(data["colors"])
		color = pick_weight(data["colors"])
	else
		color = COLOR_WHITE

/datum/reagent/glitter/random
	name = "Glitter (Random)"; display_name = "闪粉（随机）"
	// The weighted list of random color choices that can be chosen upon spawning
	var/static/list/possible_colors = list(
		COLOR_WHITE = 25,
		"#ff8080" = 25,
		"#4040ff" = 25,
		"#ff5555" = 8,
		"#55ff55" = 9,
		"#5555ff" = 8,
	)

/datum/reagent/glitter/random/on_new(data)
	src.data["colors"] = possible_colors
	return ..()

/datum/reagent/confetti
	name = "Confetti"; display_name = "彩屑"
	description = "怎么也扫不干净的细小塑料碎片。"
	color = "#7dd87b"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/confetti/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf))
		return
	exposed_turf.spawn_unique_cleanable(/obj/effect/decal/cleanable/confetti)

/datum/reagent/pax
	name = "Pax"; display_name = "平和剂"
	description = "一种抑制使用者暴力倾向的无色液体。"
	color = "#AAAAAA55"
	taste_description = "water"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	ph = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = list(TRAIT_PACIFISM)

/datum/reagent/bz_metabolites
	name = "BZ Metabolites"; display_name = "BZ代谢物"
	description = "BZ气体的一种无害代谢产物。"
	color = "#FAFF00"
	taste_description = "acrid cinnamon"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/bz_metabolites/on_mob_life(mob/living/carbon/target, seconds_per_tick, metabolization_ratio)
	. = ..()
	target.adjust_hallucinations(12.5 SECONDS * metabolization_ratio * seconds_per_tick)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(target)
	changeling?.adjust_chemicals(-5 * metabolization_ratio * seconds_per_tick)

/datum/reagent/pax/peaceborg
	name = "Synthpax"; display_name = "合成平和剂"
	description = "一种抑制使用者暴力倾向的无色液体。合成成本比普通平和剂低，但药效消退更快，\
	也无法压制身体创伤引发的反击反应。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	metabolized_traits = null

/datum/reagent/pax/peaceborg/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if(!HAS_TRAIT(affected_mob, TRAIT_SYNTHPAX_IMMUNE))
		ADD_TRAIT(affected_mob, TRAIT_PACIFISM, METABOLIZATION_TRAIT(type))
	RegisterSignal(affected_mob, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(on_metabolizer_damaged))

/datum/reagent/pax/peaceborg/on_mob_end_metabolize(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	UnregisterSignal(affected_mob, COMSIG_MOB_AFTER_APPLY_DAMAGE)
	REMOVE_TRAIT(affected_mob, TRAIT_PACIFISM, METABOLIZATION_TRAIT(type))

/datum/reagent/pax/peaceborg/proc/on_metabolizer_damaged(mob/living/source, amount)
	SIGNAL_HANDLER
	source.adjust_timed_status_effect(amount * 1 SECONDS, /datum/status_effect/synthpax_immunity, max_duration = 5 SECONDS)

/datum/reagent/peaceborg/confuse
	name = "Dizzying Solution"; display_name = "眩晕溶液"
	description = "使目标失去平衡并感到眩晕。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "dizziness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/peaceborg/confuse/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	affected_mob.adjust_confusion_up_to(1 SECONDS * metabolization_ratio * seconds_per_tick, 5 SECONDS)
	affected_mob.adjust_dizzy_up_to(2 SECONDS * metabolization_ratio * seconds_per_tick, 12 SECONDS)

	if(SPT_PROB(10, seconds_per_tick))
		to_chat(affected_mob, "你感到混乱，分不清方向。")

/datum/reagent/peaceborg/tire
	name = "Tiring Solution"; display_name = "疲劳溶液"
	description = "一种使目标疲倦的极弱体力毒素，完全无害。"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	taste_description = "tiredness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/peaceborg/tire/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/healthcomp = (100 - affected_mob.health) //DOES NOT ACCOUNT FOR ADMINBUS THINGS THAT MAKE YOU HAVE MORE THAN 200/210 HEALTH, OR SOMETHING OTHER THAN A HUMAN PROCESSING THIS.
	. = FALSE
	if(affected_mob.get_stamina_loss() < (45 - healthcomp)) //At 50 health you would have 200 - 150 health meaning 50 compensation. 60 - 50 = 10, so would only do 10-19 stamina.)
		if(affected_mob.adjust_stamina_loss(3.34 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE))
			. = UPDATE_MOB_HEALTH
	if(SPT_PROB(16, seconds_per_tick))
		to_chat(affected_mob, "你该坐下来休息一会儿……")

/datum/reagent/gondola_mutation_toxin
	name = "Tranquility"; display_name = "宁静"
	description = "一种来历不明、致突变性极强的液体。"
	color = "#9A6750" //RGB: 154, 103, 80
	taste_description = "inner peace"
	penetrates_skin = NONE
	var/datum/disease/transformation/gondola_disease = /datum/disease/transformation/gondola

/datum/reagent/gondola_mutation_toxin/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH|INGEST|INJECT|INHALE)) || ((methods & (VAPOR|TOUCH)) && prob(min(reac_volume,100)*(1 - touch_protection))))
		exposed_mob.ForceContractDisease(new gondola_disease, FALSE, TRUE)

/datum/reagent/spider_extract
	name = "Spider Extract"; display_name = "蜘蛛提取物"
	description = "来自澳星星区的高度特化提取物，用于培育蛛母。"
	color = "#ED2939"
	taste_description = "upside down"

/// Improvised reagent that induces vomiting. Created by dipping a dead mouse in welder fluid.
/datum/reagent/yuck
	name = "Organic Slurry"; display_name = "有机浆液"
	description = "由多种颜色的液体混合而成，会引起呕吐。"
	color = "#545000"
	taste_description = "insides"
	taste_mult = 4
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/yuck_cycle = 0 //! The `current_cycle` when puking starts.

/datum/glass_style/drinking_glass/yuck
	required_drink_type = /datum/reagent/yuck
	name = "一杯……呕！"
	desc = "闻起来像尸体，看起来也好不到哪去。"

/datum/reagent/yuck/on_mob_add(mob/living/affected_mob)
	if(HAS_TRAIT(affected_mob, TRAIT_NOHUNGER)) //they can't puke
		holder.del_reagent(type)
	return ..()

#define YUCK_PUKE_CYCLES 3 // every X cycle is a puke
#define YUCK_PUKES_TO_STUN 3 // hit this amount of pukes in a row to start stunning
/datum/reagent/yuck/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!yuck_cycle)
		if(SPT_PROB(4, seconds_per_tick))
			var/dread = pick("有什么东西正在你的肚子里蠕动……", \
				"你的肚子里传出湿漉漉的咕噜声……", \
				"有一瞬间，你觉得周围的一切都在晃动，其实是你的肚子……")
			to_chat(affected_mob, span_userdanger("[dread]"))
			yuck_cycle = current_cycle
	else
		var/yuck_cycles = current_cycle - yuck_cycle
		if(yuck_cycles % YUCK_PUKE_CYCLES == 0)
			if(yuck_cycles >= YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN)
				if(holder)
					holder.remove_reagent(type, 5)
			var/passable_flags = (MOB_VOMIT_MESSAGE | MOB_VOMIT_HARM)
			if(yuck_cycles >= (YUCK_PUKE_CYCLES * YUCK_PUKES_TO_STUN))
				passable_flags |= MOB_VOMIT_STUN
			affected_mob.vomit(vomit_flags = passable_flags, lost_nutrition = rand(14, 26))

#undef YUCK_PUKE_CYCLES
#undef YUCK_PUKES_TO_STUN

/datum/reagent/yuck/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	yuck_cycle = 0 // reset vomiting

/datum/reagent/yuck/expose_mob(mob/living/carbon/exposed_mob, methods, expose_volume, show_message, touch_protection)
	. = ..()
	if(!(methods & INGEST) || !iscarbon(exposed_mob))
		return

	var/datum/reagents/mob_reagents = exposed_mob.reagents
	mob_reagents.remove_reagent(type, expose_volume)
	mob_reagents.add_reagent(/datum/reagent/fuel, expose_volume * 0.75)
	mob_reagents.add_reagent(/datum/reagent/water, expose_volume * 0.25)

//monkey powder heehoo
/datum/reagent/monkey_powder
	name = "Monkey Powder"; display_name = "猴子粉"
	description = "只需加水！"
	color = "#9C5A19"
	taste_description = "bananas"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/plasma_oxide
	name = "Hyper-Plasmium Oxide"; display_name = "超等离子氧化物"
	description = "在恶魔级行星地核深处形成的化合物，通常可在深层间歇泉中发现。"
	color = "#470750" // rgb: 255, 255, 255
	taste_description = "hell"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/exotic_stabilizer
	name = "Exotic Stabilizer"; display_name = "异质稳定剂"
	description = "由稳定剂与超等离子氧化物混合而成的高级化合物。"
	color = "#180000" // rgb: 255, 255, 255
	taste_description = "blood"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/wittel
	name = "Wittel"; display_name = "银白素"
	description = "一种极其稀有、泛着金属白色光泽的物质，仅产于恶魔级行星。"
	color = COLOR_WHITE // rgb: 255, 255, 255
	taste_mult = 0 // oderless and tasteless
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/metalgen
	name = "Metalgen"; display_name = "金属化剂"
	data = list("material"=null)
	description = "一种泛着金属光泽的紫色液体，据说能让接触到的一切都具有它的金属特性。"
	color = "#b000aa"
	taste_mult = 0 // oderless and tasteless
	chemical_flags = REAGENT_NO_RANDOM_RECIPE

/datum/reagent/metalgen/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	// Don't morph holographic or abstract objects
	if (!(exposed_obj.flags_1 & HOLOGRAM_1) && exposed_obj.invisibility < INVISIBILITY_ABSTRACT)
		metal_morph(exposed_obj)

/datum/reagent/metalgen/expose_turf(turf/exposed_turf, volume)
	. = ..()
	// Or non-real turfs
	if (isclosedturf(exposed_turf) || isopenturf(exposed_turf))
		metal_morph(exposed_turf)

///turn an object into a special material
/datum/reagent/metalgen/proc/metal_morph(atom/target)
	var/metal_ref = data["material"]
	if(!metal_ref)
		return

	metal_transmute(target, metal_ref)

/// Change the material type of an object or turf, but with visuals and effects related to the material
/proc/metal_transmute(atom/target, metal_type, default_material_amount = 100, applied_material_flags = MATERIAL_METALGEN)
	if(is_type_in_typecache(target, GLOB.blacklisted_metalgen_types)) //some stuff can lead to exploits if transmuted
		return

	var/metal_amount = 0
	var/list/materials_to_transmute = target.get_material_composition()
	for(var/metal_key in materials_to_transmute) //list with what they're made of
		metal_amount += materials_to_transmute[metal_key]

	if(!metal_amount)
		metal_amount = default_material_amount //some stuff doesn't have materials at all. To still give them properties, we give them a material. Basically doesn't exist

	// Delete existing materials first before changing the material flags
	if(length(target.custom_materials))
		target.set_custom_materials()
	var/list/metal_dat = list((metal_type) = metal_amount)
	target.material_flags = applied_material_flags
	if (target.has_material_slots())
		var/list/new_slots = target.get_material_slots()
		for (var/slot_type in new_slots)
			new_slots[slot_type] = metal_type
		// Safe to call and doesn't do anything as no materials are currently present on the target
		target.set_material_slots(new_slots)
	target.set_custom_materials(metal_dat)

/datum/reagent/gravitum
	name = "Gravitum"; display_name = "失重液"
	description = "一种罕见的零重流体，能暂时消除接触物的全部重量。" //i dont even
	color = "#050096" // rgb: 5, 0, 150
	taste_mult = 0 // oderless and tasteless
	metabolization_rate = 0.1 * REAGENTS_METABOLISM //20 times as long, so it's actually viable to use
	var/time_multiplier = 1 MINUTES //1 minute per unit of gravitum on objects. Seems overpowered, but the whole thing is very niche
	inverse_chem_val = 0.3
	inverse_chem = /datum/reagent/inverse/gravitum
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	self_consuming = TRUE //this works on objects, so it should work on skeletons and robots too

/datum/reagent/gravitum/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	exposed_obj.AddElement(/datum/element/forced_gravity, 0)
	addtimer(CALLBACK(exposed_obj, PROC_REF(_RemoveElement), list(/datum/element/forced_gravity, 0)), volume * time_multiplier, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/reagent/gravitum/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.AddElement(/datum/element/forced_gravity, 0) //0 is the gravity, and in this case weightless

/datum/reagent/gravitum/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.RemoveElement(/datum/element/forced_gravity, 0)

/datum/reagent/cellulose
	name = "Cellulose Fibers"; display_name = "纤维素纤维"
	description = "一种结晶状聚葡萄糖聚合物，植物对它爱不释手。"
	color = "#E6E6DA"
	taste_mult = 0
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

// "Second wind" reagent generated when someone suffers a wound. Epinephrine, adrenaline, and stimulants are all already taken so here we are
/datum/reagent/determination
	name = "Determination"; display_name = "决心"
	description = "在你需要再坚持一下时助你一臂之力。切勿让它靠近植物。"
	color = "#D2FFFA"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM // 5u (WOUND_DETERMINATION_CRITICAL) will last for ~34 seconds
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	self_consuming = TRUE
	metabolized_traits = list(TRAIT_ANALGESIA)
	/// Whether we've had at least WOUND_DETERMINATION_SEVERE (2.5u) of determination at any given time. No damage slowdown immunity or indication we're having a second wind if it's just a single moderate wound
	var/significant = FALSE

/datum/reagent/determination/on_mob_end_metabolize(mob/living/carbon/affected_mob)
	. = ..()
	if(significant)
		var/stam_crash = 0
		for(var/thing in affected_mob.all_wounds)
			var/datum/wound/W = thing
			stam_crash += (W.severity + 1) * 3 // spike of 3 stam damage per wound severity (moderate = 6, severe = 9, critical = 12) when the determination wears off if it was a combat rush
		affected_mob.adjust_stamina_loss(stam_crash)
	affected_mob.remove_status_effect(/datum/status_effect/determined)

/datum/reagent/determination/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(!significant && volume >= WOUND_DETERMINATION_SEVERE)
		significant = TRUE
		affected_mob.apply_status_effect(/datum/status_effect/determined) // in addition to the slight healing, limping cooldowns are divided by 4 during the combat high

	volume = min(volume, WOUND_DETERMINATION_MAX)

	for(var/thing in affected_mob.all_wounds)
		var/datum/wound/W = thing
		var/obj/item/bodypart/wounded_part = W.limb
		if(wounded_part)
			wounded_part.heal_damage(0.167 * metabolization_ratio * seconds_per_tick, 0.25 * metabolization_ratio * seconds_per_tick)
		if(affected_mob.adjust_stamina_loss(-0.67 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)) // the more wounds, the more stamina regen
			return UPDATE_MOB_HEALTH

// unholy water, but for heretics.
// why couldn't they have both just used the same reagent?
// who knows.
// maybe nar'sie is considered to be too "mainstream" of a god to worship in the heretic community.
/datum/reagent/eldritch
	name = "Eldritch Essence"; display_name = "邪异精华"
	description = "一种违背物理定律的奇异液体。\
		它能为看穿这脆弱现实的人恢复活力、治疗伤势，\
		却会严重伤害思想闭塞者。它的代谢速度极快。"
	taste_description = "Ag'hsj'saje'sh"
	self_consuming = TRUE //eldritch intervention won't be limited by the lack of a liver
	color = "#1f8016"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM  //0.5u/second
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/eldritch/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/common = 0.4 * metabolization_ratio * seconds_per_tick
	var/need_mob_update = FALSE
	if(IS_HERETIC_OR_MONSTER(drinker))
		drinker.adjust_drowsiness(-2 * metabolization_ratio * seconds_per_tick)
		drinker.AdjustAllImmobility(-8 * metabolization_ratio * seconds_per_tick)
		need_mob_update += drinker.adjust_stamina_loss(-2 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
		need_mob_update += drinker.adjust_tox_loss(-common, updating_health = FALSE, forced = TRUE)
		need_mob_update += drinker.adjust_oxy_loss(-common, updating_health = FALSE)
		need_mob_update += drinker.adjust_brute_loss(-common, updating_health = FALSE)
		need_mob_update += drinker.adjust_fire_loss(-common, updating_health = FALSE)
		drinker.adjust_blood_volume(0.6 * metabolization_ratio * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL)
		// Slowly regulates your body temp
		drinker.adjust_bodytemperature((drinker.get_body_temp_normal() - drinker.bodytemperature) / 5)
		for(var/datum/reagent/reagent as anything in drinker.reagents.reagent_list)
			if(reagent != src)
				drinker.reagents.remove_reagent(reagent.type, 0.8 * reagent.purge_multiplier * metabolization_ratio * seconds_per_tick)
	else
		need_mob_update = drinker.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.6 * metabolization_ratio * seconds_per_tick, 150)
		need_mob_update += drinker.adjust_tox_loss(common, updating_health = FALSE)
		need_mob_update += drinker.adjust_fire_loss(common, updating_health = FALSE)
		need_mob_update += drinker.adjust_oxy_loss(common, updating_health = FALSE)
		need_mob_update += drinker.adjust_brute_loss(common, updating_health = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/eldritch/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if ((reac_volume >= 1.5 || isplatingturf(exposed_turf)))
		exposed_turf.rust_heretic_act(RUST_RESISTANCE_TITANIUM)

/datum/reagent/universal_indicator
	name = "Universal Indicator"; display_name = "通用酸碱指示剂"
	description = "可用于制作酸碱试纸册的溶液，也可喷洒在物体上，使其依酸碱度显色。"
	taste_description = "a strong chemical taste"
	color = "#1f8016"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//Colours things by their pH
/datum/reagent/universal_indicator/expose_atom(atom/exposed_atom, reac_volume)
	. = ..()
	if(exposed_atom.reagents)
		var/color
		CONVERT_PH_TO_COLOR(exposed_atom.reagents.ph, color)
		exposed_atom.add_atom_colour(color, WASHABLE_COLOUR_PRIORITY)

// [Original ants concept by Keelin on Goon]
/datum/reagent/ants
	name = "Ants"; display_name = "蚂蚁"
	description = "蚂蚁与白蚁的基因杂交品种，叮咬疼痛程度在施密特疼痛指数中达到3级。"
	color = "#993333"
	taste_mult = 1.3
	taste_description = "tiny legs scuttling down the back of your throat"
	metabolization_rate = 5 * REAGENTS_METABOLISM //1u per second
	ph = 4.6 // Ants contain Formic Acid
	/// Number of ticks the ants have been in the person's body
	var/ant_ticks = 0
	/// Amount of damage done per tick the ants have been in the person's system
	var/ant_damage = 0.025
	/// Tells the debuff how many ants we are being covered with.
	var/amount_left = 0
	/// Decal to spawn when spilled
	var/ants_decal = /obj/effect/decal/cleanable/ants
	/// Status effect applied by splashing ants
	var/status_effect = /datum/status_effect/ants
	/// List of possible common statements to scream when eating ants
	var/static/list/ant_screams = list(
		"它们钻到我皮下了！！",
		"快把它们从我身体里弄出去！！",
		"该死，火烧一样疼！！",
		"天啊，它们在我身体里！！",
		"把它们弄出去！！",
	)

/datum/glass_style/drinking_glass/ants
	required_drink_type = /datum/reagent/ants
	name = "一杯蚂蚁"
	desc = "干杯……？"

/datum/reagent/ants/on_mob_life(mob/living/carbon/victim, seconds_per_tick, metabolization_ratio)
	. = ..()
	victim.adjust_brute_loss(0.2 * max(0.1, round((ant_ticks * ant_damage),0.1)) * metabolization_ratio * seconds_per_tick) //Scales with time. Roughly 32 brute with 100u.
	ant_ticks++
	if(ant_ticks < 5) // Makes ant food a little more appetizing, since you won't be screaming as much.
		return
	if(SPT_PROB(5, seconds_per_tick))
		if(SPT_PROB(5, seconds_per_tick)) //Super rare statement
			victim.say("啊！不要！别放蚂蚁！别放蚂蚁！啊啊啊，它们进我眼睛了！我的眼睛！啊啊！！", forced = type)
		else
			victim.say(pick(ant_screams), forced = type)
	if(SPT_PROB(15, seconds_per_tick))
		victim.emote("scream")
	if(SPT_PROB(2, seconds_per_tick)) // Stuns, but purges ants.
		victim.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = rand(5,10), purge_ratio = 1)

/datum/reagent/ants/on_mob_end_metabolize(mob/living/living_anthill)
	. = ..()
	ant_ticks = 0
	to_chat(living_anthill, span_notice("你感觉体内最后一点[src.display_name || src.name]也排出去了。"))

/datum/reagent/ants/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if(!iscarbon(exposed_mob))
		return
	if(methods & INGEST)
		exposed_mob.check_allergic_reaction(BUGS, chance = reac_volume * 10, histamine_add = min(10, reac_volume))
	if(!(methods & (PATCH|TOUCH|VAPOR)))
		return

	amount_left = round(reac_volume,0.1) * (1 - touch_protection)
	if(amount_left)
		exposed_mob.apply_status_effect(status_effect, amount_left)

/datum/reagent/ants/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	var/turf/open/my_turf = exposed_obj.loc // No dumping ants on an object in a storage slot
	if(!istype(my_turf)) //Are we actually in an open turf?
		return
	var/static/list/accepted_types = typecacheof(list(/obj/machinery/atmospherics, /obj/structure/cable, /obj/structure/disposalpipe))
	if(!accepted_types[exposed_obj.type]) // Bypasses pipes, vents, and cables to let people create ant mounds on top easily.
		return
	expose_turf(my_turf, reac_volume)

/datum/reagent/ants/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(!istype(exposed_turf)) // Is the turf valid
		return
	if((reac_volume <= 10)) // Makes sure people don't duplicate ants.
		return

	var/obj/effect/decal/cleanable/ants/pests = exposed_turf.spawn_unique_cleanable(ants_decal)
	if(QDELETED(pests))
		return

	pests.decal_reagent = type
	var/rounded_volume = round(reac_volume, 1)
	pests.reagent_amount = rounded_volume
	if(pests.lazy_init_reagents()) // Decal already has reagents inited, add instead
		pests.reagents.maximum_volume = min(pests.reagents.maximum_volume + rounded_volume, 300) // Increase reagent holder volume up to a max of 300
		pests.reagents.add_reagent(type, rounded_volume)
	pests.update_ant_damage()

/datum/reagent/ants/fire
	name = "Fire ants"; display_name = "火蚁"
	description = "太空蚂蚁在等离子火焰高温中产生的罕见变种，叮咬疼痛程度在施密特疼痛指数中达到3.7级。"
	color = "#b51f1f"
	taste_description = "tiny flaming legs scuttling down the back of your throat"
	ant_damage = 0.05 // Roughly 64 brute with 100u
	ants_decal = /obj/effect/decal/cleanable/ants/fire
	status_effect = /datum/status_effect/ants/fire

/datum/glass_style/drinking_glass/fire_ants
	required_drink_type = /datum/reagent/ants/fire
	name = "一杯火蚁"
	desc = "这主意糟透了。"

//This is intended to a be a scarce reagent to gate certain drugs and toxins with. Do not put in a synthesizer. Renewable sources of this reagent should be inefficient.
/datum/reagent/lead
	name = "Lead"; display_name = "铅"
	description = "一种光泽暗淡、熔点较低的金属元素。"
	taste_description = "metal"
	color = "#80919d"
	metabolization_rate = 0.4 * REAGENTS_METABOLISM

/datum/reagent/lead/on_mob_life(mob/living/carbon/victim, metabolization_ratio)
	. = ..()
	if(victim.adjust_organ_loss(ORGAN_SLOT_BRAIN, 0.5))
		return UPDATE_MOB_HEALTH

//The main feedstock for kronkaine production, also a shitty stamina healer.
/datum/reagent/kronkus_extract
	name = "Kronkus Extract"; display_name = "克朗藤提取物"
	description = "由发酵的克朗藤浆制成的泡沫状提取物。\n因含有多种克朗胺而苦味浓烈。"
	taste_description = "bitterness"
	color = "#228f63"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	addiction_types = list(/datum/addiction/stimulants = 120)

/datum/reagent/kronkus_extract/on_mob_life(mob/living/carbon/kronkus_enjoyer, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = kronkus_enjoyer.adjust_organ_loss(ORGAN_SLOT_HEART, 0.2 * metabolization_ratio * seconds_per_tick, required_organ_flag = affected_organ_flags)
	need_mob_update += kronkus_enjoyer.adjust_stamina_loss(-6 * metabolization_ratio * seconds_per_tick, updating_stamina = FALSE)
	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/brimdust
	name = "Brimdust"; display_name = "硫魔尘"
	description = "硫磺恶魔留下的粉尘。不建议食用，不过植物很喜欢。"
	color = "#522546"
	taste_description = "burning"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

/datum/reagent/brimdust/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.adjust_fire_loss((affected_mob.mob_biotypes & MOB_PLANT) ? -1 : 1 * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/brimdust/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_weedlevel(-1)
	mytray.adjust_pestlevel(-1)
	mytray.adjust_plant_health(round(volume))
	mytray.myseed?.adjust_potency(round(volume * 0.5))

// I made this food....with love.
// Reagent added to food by chef's with a chef's kiss. Makes people happy.
/datum/reagent/love
	name = "Love"; display_name = "爱"
	description = "这份食物是用……爱做成的。"
	color = "#ff7edd"
	taste_description = "love"
	taste_mult = 10
	overdose_threshold = 50 // too much love is a bad thing

/datum/reagent/love/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	// A syringe is not grandma's cooking
	if(methods & ~INGEST)
		exposed_mob.reagents.del_reagent(type)

/datum/reagent/love/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.add_mood_event(name, /datum/mood_event/love_reagent)

/datum/reagent/love/on_mob_delete(mob/living/affected_mob)
	. = ..()
	// When we exit the system we'll leave the moodlet based on the amount we had
	var/duration_of_moodlet = current_cycle * 20 SECONDS
	affected_mob.clear_mood_event(name)
	affected_mob.add_mood_event(name, /datum/mood_event/love_reagent, duration_of_moodlet)

/datum/reagent/love/overdose_process(mob/living/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/mob/living/carbon/carbon_metabolizer = metabolizer
	if(!istype(carbon_metabolizer) || !carbon_metabolizer.can_heartattack() || carbon_metabolizer.undergoing_cardiac_arrest())
		metabolizer.reagents.del_reagent(type)
		return

	if(SPT_PROB(10, seconds_per_tick))
		carbon_metabolizer.set_heartattack(TRUE)

/datum/reagent/hauntium
	name = "Hauntium"; display_name = "幽魂金属液"
	color = "#3B3B3BA3"
	description = "提纯幽灵的存在而得到的诡异液体。如果不慎进入体内，它就会开始伤害你的灵魂。" //soul as in mood and heart
	taste_description = "evil spirits"
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	material = /datum/material/hauntium
	ph = 10
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS

//gives 20 seconds of haunting effect for every unit of it that touches an item
/datum/reagent/hauntium/expose_obj(obj/exposed_obj, reac_volume, methods=TOUCH, show_message=TRUE)
	. = ..()
	if(!isitem(exposed_obj))
		return
	var/obj/item/exposed_item = exposed_obj
	if(HAS_TRAIT_FROM(exposed_item, TRAIT_HAUNTED, HAUNTIUM_REAGENT_TRAIT))
		return
	exposed_item.make_haunted(HAUNTIUM_REAGENT_TRAIT, "#f8f8ff")
	addtimer(CALLBACK(exposed_item, TYPE_PROC_REF(/obj/item/, remove_haunted), HAUNTIUM_REAGENT_TRAIT), reac_volume * 20 SECONDS)

/datum/reagent/hauntium/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick)
	. = ..()
	to_chat(affected_mob, span_userdanger("你感到体内有某种邪恶的存在！"))
	if(affected_mob.mob_biotypes & MOB_UNDEAD || HAS_MIND_TRAIT(affected_mob, TRAIT_MORBID))
		affected_mob.add_mood_event("morbid_hauntium", /datum/mood_event/morbid_hauntium, name) //8 minutes of slight mood buff if undead or morbid
	else
		affected_mob.add_mood_event("hauntium_spirits", /datum/mood_event/hauntium_spirits, name) //8 minutes of mood debuff

/datum/reagent/hauntium/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(affected_mob.mob_biotypes & MOB_UNDEAD || HAS_MIND_TRAIT(affected_mob, TRAIT_MORBID)) //if morbid or undead,acts like an addiction-less drug
		var/common = -3.34 SECONDS * metabolization_ratio * seconds_per_tick
		affected_mob.remove_status_effect(/datum/status_effect/jitter)
		affected_mob.AdjustStun(common)
		affected_mob.AdjustKnockdown(common)
		affected_mob.AdjustUnconscious(common)
		affected_mob.AdjustParalyzed(common)
		affected_mob.AdjustImmobilized(common)
	else
		if(affected_mob.adjust_organ_loss(ORGAN_SLOT_HEART, 1.34 * metabolization_ratio * seconds_per_tick)) //1 heart damage per tick
			. = UPDATE_MOB_HEALTH
		if(SPT_PROB(10, seconds_per_tick))
			affected_mob.emote(pick("twitch","choke","shiver","gag"))

// The same as gold just with a slower metabolism rate, to make using the Hand of Midas easier.
/datum/reagent/gold/cursed
	name = "Cursed Gold"; display_name = "诅咒黄金"
	metabolization_rate = 0.2 * REAGENTS_METABOLISM

/datum/reagent/luminescent_fluid
	name = "Green Luminiscent Fluid"; display_name = "绿色荧光液"
	description = "与氧气发生化学反应而发光的有色液体。" // Reacts with oxygen in hydrogen peroxide IRL
	taste_description = "buttery acid" // Best way I can describe glowstick fluid's taste
	color = LIGHT_COLOR_GREEN
	metabolization_rate = 0.3 * REAGENTS_METABOLISM
	ph = 3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	overdose_threshold = 50 // GLOW GLOW GLOW
	metabolized_traits = list(TRAIT_NIGHT_VISION)
	self_consuming = TRUE
	/// Fake flashlight we're using to make owner's eyes glow
	var/obj/item/flashlight/eyelight/glow/glowing
	/// Previous overlay_ignore_lighting of owner's eyes
	var/prev_ignore_lighting
	/// Have we added a flashlight already and it got destroyed by something?
	var/added_light = FALSE

/datum/reagent/luminescent_fluid/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	if (volume > 20) // Even if you don't have eyes, your eyeholes still glow :)
		glowing = new(affected_mob)
		glowing.set_light_color(color)
		glowing.set_light_on(TRUE)
		added_light = TRUE

	if (!ishuman(affected_mob))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	affected_human.add_eye_color(color, EYE_COLOR_LUMINESCENT_PRIORITY)
	RegisterSignal(affected_human, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(on_organ_added))
	RegisterSignal(affected_human, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(on_organ_removed))
	var/obj/item/organ/eyes/eyes = affected_human.get_organ_slot(ORGAN_SLOT_EYES)
	if (eyes && !IS_ROBOTIC_ORGAN(eyes))
		ADD_TRAIT(affected_human, TRAIT_LUMINESCENT_EYES, REF(src))

/datum/reagent/luminescent_fluid/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(glowing)
	if (!ishuman(affected_mob))
		return

	var/mob/living/carbon/human/affected_human = affected_mob
	affected_human.remove_eye_color(EYE_COLOR_LUMINESCENT_PRIORITY)
	var/obj/item/organ/eyes/eyes = affected_human.get_organ_slot(ORGAN_SLOT_EYES)
	if (eyes && !IS_ROBOTIC_ORGAN(eyes) && !overdosed)
		REMOVE_TRAIT(affected_human, TRAIT_LUMINESCENT_EYES, REF(src))

/datum/reagent/luminescent_fluid/on_mob_life(mob/living/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	if (isnull(glowing) && !added_light && volume > 20)
		glowing = new(affected_mob)
		glowing.set_light_color(color)
		glowing.set_light_on(TRUE)
		added_light = TRUE

	if (SPT_PROB(8, seconds_per_tick))
		if(affected_mob.adjust_tox_loss(3.34 * metabolization_ratio, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

/datum/reagent/luminescent_fluid/proc/on_organ_added(mob/living/source, obj/item/organ/eyes/new_eyes)
	SIGNAL_HANDLER

	if (istype(new_eyes) && !IS_ROBOTIC_ORGAN(new_eyes))
		ADD_TRAIT(source, TRAIT_LUMINESCENT_EYES, REF(src))

/datum/reagent/luminescent_fluid/proc/on_organ_removed(mob/living/source, obj/item/organ/eyes/old_eyes)
	SIGNAL_HANDLER

	if (istype(old_eyes) && !IS_ROBOTIC_ORGAN(old_eyes) && !overdosed)
		REMOVE_TRAIT(source, TRAIT_LUMINESCENT_EYES, REF(src))

/datum/reagent/luminescent_fluid/overdose_start(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	if (!ishuman(affected_mob))
		return
	var/mob/living/carbon/human/affected_human = affected_mob
	var/obj/item/organ/eyes/eyes = affected_human.get_organ_slot(ORGAN_SLOT_EYES)
	if (eyes && !IS_ROBOTIC_ORGAN(eyes))
		eyes.eye_color_left = color
		eyes.eye_color_right = color
		affected_human.update_eyes()

/datum/reagent/luminescent_fluid/red
	name = "Red Luminiscent Fluid"; display_name = "红色荧光液"
	color = COLOR_SOFT_RED
	// The glow *is* unnatural, so...
	metabolized_traits = list(TRAIT_NIGHT_VISION, TRAIT_UNNATURAL_RED_GLOWY_EYES)

/datum/reagent/luminescent_fluid/red/overdose_start(mob/living/affected_mob, metabolization_ratio)
	. = ..()
	if (!ishuman(affected_mob))
		return
	ADD_TRAIT(affected_mob, TRAIT_UNNATURAL_RED_GLOWY_EYES, OVERDOSE_TRAIT)

/datum/reagent/luminescent_fluid/blue
	name = "Blue Luminiscent Fluid"; display_name = "蓝色荧光液"
	color = LIGHT_COLOR_BLUE

/datum/reagent/luminescent_fluid/cyan
	name = "Cyan Luminiscent Fluid"; display_name = "青色荧光液"
	color = LIGHT_COLOR_CYAN

/datum/reagent/luminescent_fluid/yellow
	name = "Yellow Luminiscent Fluid"; display_name = "黄色荧光液"
	color = LIGHT_COLOR_DIM_YELLOW

/datum/reagent/luminescent_fluid/orange
	name = "Orange Luminiscent Fluid"; display_name = "橙色荧光液"
	color = LIGHT_COLOR_ORANGE

/datum/reagent/luminescent_fluid/pink
	name = "Pink Luminiscent Fluid"; display_name = "粉色荧光液"
	color = LIGHT_COLOR_PINK

/// Reagent that polymorphs you
/datum/reagent/polyjuice
	name = "Polyjuice"; display_name = "复方汤剂"
	description = "一种颜色鲜艳的液体，会让生物的体态突然发生不可逆转的变化。"
	color = "#ff00ea"
	metabolization_rate = REAGENTS_METABOLISM
	taste_description = "magic"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_MAINTENANCE_PILL

	/// Cycle to polymorph
	var/polymorph_cycle = 10

/datum/reagent/polyjuice/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()

	if(current_cycle > polymorph_cycle)
		affected_mob.wabbajack()

/// Turns you into STONE
/datum/reagent/metalgen/gorgium
	name = "Gorgium"; display_name = "石化素"
	description = "把受影响者……变成石头！！！"
	color = "#929292"
	metabolization_rate = 10 * REAGENTS_METABOLISM
	taste_description = "rocks"
	chemical_flags = REAGENT_NO_RANDOM_RECIPE
	randomized_spawns = REAGENT_SPAWN_MAINTENANCE_PILL

	data = list("material" = /datum/material/rock)

	/// Less than this and it wont petrify
	var/min_volume_to_pretrify = 3
	/// So 1u of exposure is 5 seconds of statue time
	var/reagent_to_time_conversion = 5 SECONDS

/datum/reagent/metalgen/gorgium/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()

	if(reac_volume < min_volume_to_pretrify)
		return

	exposed_mob.Stun(4 SECONDS)
	exposed_mob.petrify(reac_volume * reagent_to_time_conversion)

/datum/reagent/cement
	name = "Cement"; display_name = "水泥"
	description = "用于生产混凝土的精制胶凝材料。"
	color = "#c4c0bc"
	taste_description = "cement"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/potency = 2
	var/concrete_type = /datum/reagent/concrete
	var/units_per_aggregate = 5

/datum/reagent/cement/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if (!(methods & INGEST))
		return
	exposed_mob.add_mood_event("cement", /datum/mood_event/cement)

/datum/reagent/cement/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/rate = potency * seconds_per_tick * metabolization_ratio
	var/need_mob_update = 0

	if(prob(min(current_cycle/2, 5)))
		need_mob_update += affected_mob.adjust_tox_loss(rate)

	if(prob(min(current_cycle/4, 10)))
		need_mob_update += affected_mob.adjust_organ_loss(ORGAN_SLOT_BRAIN, rate)

	if(need_mob_update)
		return UPDATE_MOB_HEALTH

/datum/reagent/cement/hexement
	name = "Hexement"; display_name = "强化水泥"
	description = "用于生产强化混凝土的先进太空时代胶凝材料。"
	color = "#969390"
	potency = 4
	concrete_type = /datum/reagent/concrete/hexacrete
	units_per_aggregate = 2

/datum/reagent/cement/pavement
	name = "Pavement Cement"; display_name = "路面水泥"
	description = "水泥与沥青的混合物，看起来比普通水泥还难吃。"
	color = "#5c6361"
	potency = 3
	concrete_type = /datum/reagent/concrete/pavement

/datum/reagent/concrete
	name = "Concrete"; display_name = "混凝土"
	description = "水泥与骨料的混合物，常用作大宗建筑材料。"
	color = "#a8988a"
	taste_description = "rocks"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	randomized_spawns = REAGENT_SPAWN_ALL_RANDOM_SPAWNS
	var/units_per_wall = 10
	var/units_per_floor = 2
	var/turf/closed/wall/concrete/wall_type = /turf/closed/wall/concrete
	var/turf/open/floor/concrete/floor_type = /turf/open/floor/concrete

/datum/reagent/concrete/expose_atom(atom/exposed_atom, reac_volume, methods)
	. = ..()
	// VAPOR (foam, spray), TOUCH (splashing) allowed, SMOKE_MACHINE (TOUCH|INHALE) not allowed
	if(!((methods & (TOUCH|INHALE)) == TOUCH) && !(methods & VAPOR))
		return
	var/girder_type = initial(wall_type.girder_type)
	if(istype(exposed_atom, girder_type))
		return concify_girder(exposed_atom, volume)
	if(istype(exposed_atom, /turf/open/floor/catwalk_floor))
		return concify_catwalk(exposed_atom, volume)
	return

/datum/reagent/concrete/proc/pour_amount(atom/target, mob/user)
	if(istype(target, initial(wall_type.girder_type)))
		return units_per_wall
	else if(istype(target, /turf/open/floor/catwalk_floor))
		return units_per_floor
	return 0

/datum/reagent/concrete/proc/concify_girder(obj/exposed_obj, volume)
	if(volume < units_per_wall)
		return FALSE
	var/turf/open/wall_turf = get_turf(exposed_obj)
	if(!istype(wall_turf))
		return FALSE
	var/turf/closed/wall/concrete/wall = wall_turf.place_on_top(wall_type)
	exposed_obj.transfer_fingerprints_to(wall)
	wall.harden_lvl = 0
	wall.check_harden()
	qdel(exposed_obj)
	return TRUE

/datum/reagent/concrete/proc/concify_catwalk(turf/open/floor/catwalk_floor/catwalk, volume)
	if(volume < units_per_floor)
		return FALSE
	var/turf/open/floor/plating = catwalk.make_plating()
	var/turf/open/floor/concrete/concrete_floor = plating.place_on_top(floor_type, flags=CHANGETURF_INHERIT_AIR)
	concrete_floor.harden_lvl = 0
	concrete_floor.check_harden()
	return TRUE

/datum/reagent/concrete/hexacrete
	name = "Hexacrete"; display_name = "强化混凝土"
	description = "用强化水泥与骨料混合制成，是一种实用、坚固的建筑材料。"
	color = "#7b6e60"
	wall_type = /turf/closed/wall/concrete/reinforced
	floor_type = /turf/open/floor/concrete/reinforced

/datum/reagent/concrete/pavement
	name = "Pavement Concrete"; display_name = "路面混凝土"
	description = "路面、黑色路面、沥青混凝土——随你怎么叫，它都是修建飞船跑道和车辆道路最常用的材料。"
	color = "#3f4543"
	floor_type = /turf/open/floor/concrete/pavement

/datum/reagent/concrete_mix
	name = "Concrete Mix"; display_name = "预拌混凝土"
	description = "预先配好的混凝土，是懒惰工程师的理想选择。"
	color = "#c4c0bc"
	taste_description = "chalky concrete"
