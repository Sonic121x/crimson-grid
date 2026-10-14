//These mutations change your overall "form" somehow, like size

//Epilepsy gives a very small chance to have a seizure every life tick, knocking you unconscious.
/datum/mutation/epilepsy
	name = "癫痫"
	desc = "受试者会不时癫痫发作。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_danger("你感到头痛。")
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/epilepsy/on_life(seconds_per_tick)
	if(SPT_PROB(0.5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick))
		trigger_seizure()

/datum/mutation/epilepsy/proc/trigger_seizure()
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return
	owner.visible_message(span_danger("[owner]癫痫发作了！"), span_userdanger("你癫痫发作了！"))
	owner.Unconscious(200 * GET_MUTATION_POWER(src))
	owner.set_jitter(2000 SECONDS * GET_MUTATION_POWER(src)) //yes this number looks crazy but the jitter animations are amplified based on the duration.
	owner.add_mood_event("epilepsy", /datum/mood_event/epilepsy)
	addtimer(CALLBACK(src, PROC_REF(jitter_less)), 9 SECONDS)

/datum/mutation/epilepsy/proc/jitter_less()
	if(QDELETED(owner))
		return

	owner.set_jitter(20 SECONDS)

/datum/mutation/epilepsy/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_FLASHED, PROC_REF(get_flashed_nerd))

/datum/mutation/epilepsy/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_FLASHED)

/datum/mutation/epilepsy/proc/get_flashed_nerd()
	SIGNAL_HANDLER

	if(!prob(30))
		return
	trigger_seizure()


//Unstable DNA induces random mutations!
/datum/mutation/bad_dna
	name = "不稳定DNA"
	desc = "受试者会随机产生其他突变或改变自身特征。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你感觉很奇怪。")
	locked = TRUE

/datum/mutation/bad_dna/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	to_chat(owner, text_gain_indication)
	var/mob/new_mob
	if(prob(95))
		switch(rand(1,3))
			if(1)
				new_mob = owner.easy_random_mutate(NEGATIVE + MINOR_NEGATIVE)
			if(2)
				new_mob = owner.random_mutate_unique_identity()
			if(3)
				new_mob = owner.random_mutate_unique_features()
	else
		new_mob = owner.easy_random_mutate(POSITIVE)
	if(new_mob && ismob(new_mob))
		owner = new_mob
	. = owner
	on_losing(owner)


//Cough gives you a chronic cough that causes you to drop items.
/datum/mutation/cough
	name = "咳嗽"
	desc = "受试者患有慢性咳嗽。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你开始咳嗽。")
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/cough/on_life(seconds_per_tick)
	if(SPT_PROB(2.5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner))
		owner.drop_all_held_items()
		owner.emote("cough")
		if(GET_MUTATION_POWER(src) > 1)
			var/cough_range = GET_MUTATION_POWER(src) * 4
			var/turf/target = get_ranged_target_turf(owner, REVERSE_DIR(owner.dir), cough_range)
			owner.throw_at(target, cough_range, GET_MUTATION_POWER(src))

/datum/mutation/paranoia
	name = "偏执症"
	desc = "受试者容易受到惊吓，还可能出现幻觉。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_danger("你感觉尖叫声在脑海中回荡……")
	text_lose_indication = span_notice("脑海中的尖叫声消散了。")

/datum/mutation/paranoia/on_life(seconds_per_tick)
	if(SPT_PROB(2.5, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner))
		owner.emote("scream")
		if(prob(25))
			owner.adjust_hallucinations(40 SECONDS)

//Dwarfism shrinks your body and lets you pass tables.
/datum/mutation/dwarfism
	name = "侏儒症"
	desc = "受试者的细胞更加紧密，使其体型变小。"
	quality = POSITIVE
	difficulty = 16
	instability = POSITIVE_INSTABILITY_MINOR
	conflicts = list(/datum/mutation/gigantism, /datum/mutation/acromegaly)
	locked = TRUE // Default intert species for now, so locked from regular pool.

/datum/mutation/dwarfism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("你周围的一切似乎都变大了……"))

/datum/mutation/dwarfism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然变大了！"), span_notice("你周围的一切似乎都变小了……"))

/datum/mutation/acromegaly
	name = "肢端肥大症"
	desc = "受试者的细胞相互堆叠，使其身材异常高大。"
	quality = MINOR_NEGATIVE
	difficulty = 16
	instability = NEGATIVE_STABILITY_MODERATE
	synchronizer_coeff = 1
	conflicts = list(/datum/mutation/dwarfism)

/datum/mutation/acromegaly/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_TOO_TALL, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然长高了！"), span_notice("你莫名有点想和拿着投石索的小个子打一架。或者去打打篮球。"))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(head_bonk))
	owner.regenerate_icons()

/datum/mutation/acromegaly/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_TOO_TALL, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("你恢复了平常的身高。"))
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(head_bonk))
	owner.regenerate_icons()

// This is specifically happening because they're not used to their new height and are stumbling around into machinery made for normal humans
/datum/mutation/acromegaly/proc/head_bonk(mob/living/parent)
	SIGNAL_HANDLER
	var/atom/movable/whacked_by = (locate(/obj/machinery/door/airlock) in parent.loc) || (locate(/obj/machinery/door/firedoor) in parent.loc) || (locate(/obj/structure/mineral_door) in parent.loc)
	if(!whacked_by || prob(100 - (8 *  GET_MUTATION_SYNCHRONIZER(src))))
		return
	to_chat(parent, span_danger("你的头撞上了[whacked_by]的门楣！"))
	var/dmg = HAS_TRAIT(parent, TRAIT_HEAD_INJURY_BLOCKED) ? rand(1,4) : rand(2,9)
	parent.apply_damage(dmg, BRUTE, BODY_ZONE_HEAD)
	parent.do_attack_animation(whacked_by, ATTACK_EFFECT_PUNCH)
	playsound(whacked_by, 'sound/effects/bang.ogg', 10, TRUE)
	parent.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, 10 SECONDS)

/datum/mutation/gigantism
	name = "巨人症" //negative version of dwarfism
	desc = "受试者的细胞排列更加疏松，使其体型变大。"
	quality = MINOR_NEGATIVE
	difficulty = 12
	conflicts = list(/datum/mutation/dwarfism)

/datum/mutation/gigantism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_GIANT, GENETIC_MUTATION)
	owner.update_transform(1.25)
	owner.visible_message(span_danger("[owner]突然变大了！"), span_notice("你周围的一切似乎都变小了……"))

/datum/mutation/gigantism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_GIANT, GENETIC_MUTATION)
	owner.update_transform(0.8)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("你周围的一切似乎都变大了……"))

//Clumsiness has a very large amount of small drawbacks depending on item.
/datum/mutation/clumsy
	name = "笨手笨脚"
	desc = "受试者的脑功能受损，表现出如同小丑般的行为。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你感到头晕。")
	mutation_traits = list(TRAIT_CLUMSY)

//Tourettes causes you to randomly stand in place and shout.
/datum/mutation/tourettes
	name = "图雷特综合征"
	desc = "受试者患有慢性抽动障碍，会不由自主地喊叫或抽搐。"
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_NONE
	text_gain_indication = span_danger("你抽搐了一下。")
	synchronizer_coeff = 1

/datum/mutation/tourettes/on_life(seconds_per_tick)
	if(SPT_PROB(5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner) && !owner.IsStun())
		switch(rand(1, 3))
			if(1)
				owner.emote("twitch")
			if(2 to 3)
				owner.say("[prob(50) ? ";" : ""][pick("屎", "尿", "操", "屄", "舔屌货", "狗娘养的", "奶子")]", forced="Tourette's Syndrome")
		var/w_offset =  rand(-2, 2)
		var/z_offset = rand(-1, 1)
		animate(owner, pixel_w = w_offset, pixel_z = z_offset, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(owner, pixel_w = -w_offset, pixel_z = -z_offset, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)


//Deafness makes you deaf.
/datum/mutation/deaf
	name = "耳聋"
	desc = "受试者完全失聪，听不到任何声音。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你好像什么都听不见了。")
	mutation_traits = list(TRAIT_DEAF)

//Monified turns you into a monkey.
/datum/mutation/race
	name = "猴化"
	desc = "一组奇特的基因，人们认为它是猴子与人类之间的区别所在。"
	text_gain_indication = span_green("你感觉自己像猴子一样。")
	text_lose_indication = span_notice("你感觉自己又恢复原样了。")
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_MAJOR // mmmonky
	remove_on_aheal = FALSE
	locked = TRUE //Species specific, keep out of actual gene pool
	warn_admins_on_inject = TRUE
	var/datum/species/original_species = /datum/species/human
	var/original_name

/datum/mutation/race/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	if(HAS_TRAIT(owner, TRAIT_LESSER_HUMANOID))
		return
	original_species = owner.dna.species.type
	original_name = owner.real_name
	owner.monkeyize()

/datum/mutation/race/on_losing(mob/living/carbon/human/owner)
	if(owner.stat == DEAD)
		return
	. = ..()
	if(.)
		return
	if(QDELETED(owner))
		return

	owner.fully_replace_character_name(null, original_name)
	owner.humanize(original_species)

/datum/mutation/glow
	name = "微光"
	desc = "受试者的皮肤发出柔和的光芒，照亮周围区域。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的皮肤开始发出柔和的光芒。")
	instability = POSITIVE_INSTABILITY_MINI
	power_coeff = 1
	conflicts = list(/datum/mutation/glow/anti)
	var/glow_power = 2
	var/glow_range = 2.5
	var/glow_color
	var/obj/effect/dummy/lighting_obj/moblight/glow

/datum/mutation/glow/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	glow_color = get_glow_color()
	glow = owner.mob_light()

// Override modify here without a parent call, because we don't actually give an action.
/datum/mutation/glow/setup()
	if(!glow)
		return

	glow.set_light_range_power_color(glow_range * GET_MUTATION_POWER(src), glow_power, glow_color)

/datum/mutation/glow/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	QDEL_NULL(glow)

/// Returns a color for the glow effect
/datum/mutation/glow/proc/get_glow_color()
	return pick(COLOR_RED, COLOR_BLUE, COLOR_YELLOW, COLOR_GREEN, COLOR_PURPLE, COLOR_ORANGE)

/datum/mutation/glow/anti
	name = "吸光"
	desc = "受试者的皮肤吸收光线，使周围区域变暗。"
	text_gain_indication = span_notice("你周围的光线似乎消失了。")
	conflicts = list(/datum/mutation/glow)
	instability = POSITIVE_INSTABILITY_MINOR
	locked = TRUE
	glow_power = -1.5

/datum/mutation/glow/anti/get_glow_color()
	return COLOR_BLACK

/datum/mutation/strong
	name = "力量"
	desc = "受试者的肌肉略微增大，提升整体力量和锻炼效率。"
	quality = POSITIVE
	text_gain_indication = span_notice("你感到强壮有力。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 16
	mutation_traits = list(TRAIT_STRENGTH)

/datum/mutation/stimmed
	name = "亢奋"
	desc = "受试者体内的化学平衡更加稳健，从而提高锻炼效率。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINI
	text_gain_indication = span_notice("你感到精神亢奋。")
	difficulty = 16
	mutation_traits = list(TRAIT_STIMMED)

/datum/mutation/insulated
	name = "绝缘"
	desc = "受试者的身体不导电。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的指尖麻木了。")
	text_lose_indication = span_notice("你的指尖恢复了知觉。")
	difficulty = 16
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_SHOCKIMMUNE)

/datum/mutation/fire
	name = "烈焰汗液"
	desc = "受试者的皮肤会随机自燃，但也会变得更耐烧伤。"
	quality = NEGATIVE
	text_gain_indication = span_warning("你感到燥热。")
	text_lose_indication = span_notice("你感觉凉快多了。")
	conflicts = list(/datum/mutation/adaptation/heat)
	difficulty = 14
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/fire/on_life(seconds_per_tick)
	if(SPT_PROB((0.05+(100-dna.stability)/19.5) * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick))
		owner.adjust_fire_stacks(2 * GET_MUTATION_POWER(src))
		owner.ignite_mob()

/datum/mutation/fire/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	MODIFY_PHYSIOLOGY(owner, BURN, 0.5)

/datum/mutation/fire/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	MODIFY_PHYSIOLOGY(owner, BURN, 2)

/datum/mutation/badblink
	name = "空间不稳定"
	desc = "受试者与现实空间的联系极为脆弱，可能发生空间位移，常伴有强烈的恶心感。"
	quality = NEGATIVE
	text_gain_indication = span_warning("你周围的空间扭曲得令人作呕。")
	text_lose_indication = span_notice("你周围的空间恢复了正常。")
	difficulty = 18//high so it's hard to unlock and abuse
	instability = NEGATIVE_STABILITY_MODERATE
	synchronizer_coeff = 1
	energy_coeff = 1
	power_coeff = 1
	var/warpchance = 0

/datum/mutation/badblink/on_life(seconds_per_tick)
	if(SPT_PROB(warpchance, seconds_per_tick))
		var/warpmessage = pick(
		span_warning("[owner]的背部以令人作呕的姿态扭转了720度，随后整个人凭空消失了。"),
		span_warning("[owner]做了个古怪的后空翻，翻进了另一个维度。看起来相当疼。"),
		span_warning("[owner]向左一跳，向右一步，随即跃出了现实。"),
		span_warning("[owner]的躯干开始由内向外翻折，最终连同[owner]一起从现实中消失了。"),
		span_warning("前一刻，你还看得见[owner]。下一刻，[owner]就不见了。"))
		owner.visible_message(warpmessage, span_userdanger("你跌穿了现实，一阵恶心感随之涌来！"))
		var/warpdistance = rand(10, 15) * GET_MUTATION_POWER(src)
		do_teleport(owner, get_turf(owner), warpdistance, channel = TELEPORT_CHANNEL_FREE)
		owner.adjust_disgust(GET_MUTATION_SYNCHRONIZER(src) * (warpchance * warpdistance))
		warpchance = 0
		owner.visible_message(span_danger("[owner]凭空出现了！"))
	else
		warpchance += 0.0625 * seconds_per_tick / GET_MUTATION_ENERGY(src)

/datum/mutation/acidflesh
	name = "酸蚀血肉"
	desc = "受试者的皮肤下不断积聚酸性化学物质，往往会危及生命。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_userdanger("你的血肉化为酸液，可怕的灼烧感席卷全身！")
	text_lose_indication = span_notice("你的血肉恢复正常，全身都轻松了下来。")
	difficulty = 18//high so it's hard to unlock and use on others
	/// The cooldown for the warning message
	COOLDOWN_DECLARE(msgcooldown)

/datum/mutation/acidflesh/on_life(seconds_per_tick)
	if(SPT_PROB(13, seconds_per_tick))
		if(COOLDOWN_FINISHED(src, msgcooldown))
			to_chat(owner, span_danger("你酸化的血肉冒起了泡……"))
			COOLDOWN_START(src, msgcooldown, 20 SECONDS)
		if(prob(15))
			owner.acid_act(rand(30, 50), 10)
			owner.visible_message(span_warning("[owner]的皮肤冒出气泡，接连破裂。"), span_userdanger("你血肉上的气泡炸开了！好烫！"))
			playsound(owner,'sound/items/weapons/sear.ogg', 50, TRUE)

/datum/mutation/spastic
	name = "肌肉痉挛"
	desc = "受试者会出现肌肉痉挛。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_warning("你的身体猛地一抽。")
	text_lose_indication = span_notice("你的身体不再抽动了。")
	difficulty = 16

/datum/mutation/spastic/on_acquiring()
	. = ..()
	if(!.)
		return
	owner.apply_status_effect(/datum/status_effect/spasms)

/datum/mutation/spastic/on_losing()
	if(..())
		return
	owner.remove_status_effect(/datum/status_effect/spasms)

/datum/mutation/extrastun
	name = "两只左脚"
	desc = "受试者的右脚变成了另一只左脚，症状包括迈步时与地板亲密接触。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_warning("你的右脚感觉……变成左脚了。")
	text_lose_indication = span_notice("你的右脚感觉正常了。")
	difficulty = 16

/datum/mutation/extrastun/on_acquiring()
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/datum/mutation/extrastun/on_losing()
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

///Triggers on moved(). Randomly makes the owner trip
/datum/mutation/extrastun/proc/on_move()
	SIGNAL_HANDLER

	if(prob(99.5)) //The brawl mutation
		return
	if(owner.buckled || owner.body_position == LYING_DOWN || HAS_TRAIT(owner, TRAIT_IMMOBILIZED) || owner.throwing || owner.movement_type & (VENTCRAWLING | FLYING | FLOATING))
		return //remove the 'edge' cases
	to_chat(owner, span_danger("你被自己的脚绊倒了。"))
	owner.Knockdown(30)

/datum/mutation/martyrdom
	name = "血肉殉爆"
	desc = "受试者在濒死时会猛烈地撕裂自身，这一过程不可逆转。\
		据称不会损坏周围物体，但目睹这一幕会让人极其、极其晕眩。"
	instability = NEGATIVE_STABILITY_MAJOR // free stability >:)
	locked = TRUE
	quality = POSITIVE //not that cloning will be an option a lot but generally lets keep this around i guess?
	text_gain_indication = span_warning("你感到强烈的烧心感。")
	text_lose_indication = span_notice("你的内脏感觉舒适了。")

/datum/mutation/martyrdom/on_acquiring()
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(bloody_shower))

/datum/mutation/martyrdom/on_losing()
	. = ..()
	if(.)
		return TRUE
	UnregisterSignal(owner, COMSIG_MOB_STATCHANGE)

/datum/mutation/martyrdom/proc/bloody_shower(datum/source, new_stat)
	SIGNAL_HANDLER

	if(new_stat < HARD_CRIT)
		return
	var/list/organs = owner.get_organs_for_zone(BODY_ZONE_HEAD, TRUE)

	for(var/obj/item/organ/I in organs)
		qdel(I)

	explosion(owner, light_impact_range = 2, adminlog = TRUE, explosion_cause = src)
	for(var/mob/living/carbon/human/splashed in view(2, owner))
		var/obj/item/organ/eyes/eyes = splashed.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes)
			to_chat(splashed, span_userdanger("一阵血雨让你眼前一黑！"))
			eyes.apply_organ_damage(5)
		else
			to_chat(splashed, span_userdanger("你被一阵……血浪击倒了？！"))
		splashed.Stun(2 SECONDS)
		splashed.set_eye_blur_if_lower(40 SECONDS)
		splashed.adjust_confusion(3 SECONDS)
	for(var/mob/living/silicon/borgo in view(2, owner))
		to_chat(borgo, span_userdanger("一阵血雨让你的传感器失灵了！"))
		borgo.Paralyze(6 SECONDS)
	owner.investigate_log("has been gibbed by the martyrdom mutation.", INVESTIGATE_DEATHS)
	owner.gib(DROP_ALL_REMAINS)

/datum/mutation/headless
	name = "头部过敏排斥综合征"
	desc = "简称H.A.R.S.，受试者的身体会排斥头部，导致大脑退入胸腔。\
		逆转这种突变非常危险，不过会使头部的非关键器官再生。"
	instability = NEGATIVE_STABILITY_MAJOR
	difficulty = 12 //pretty good for traitors
	quality = NEGATIVE //holy shit no eyes or tongue or ears
	text_gain_indication = span_warning("你感觉有些不对劲。")
	warn_admins_on_inject = TRUE

/datum/mutation/headless/on_acquiring()
	. = ..()
	if(!.)
		return

	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.Remove(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)
		brain.zone = BODY_ZONE_CHEST
		brain.Insert(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)

	var/obj/item/bodypart/head/head = owner.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		owner.visible_message(span_warning("伴随着令人作呕的碎裂声，[owner]的头颅炸得血肉四溅！"), ignored_mobs = list(owner))
		new /obj/effect/gibspawner/generic(get_turf(owner), owner)
		head.drop_organs()
		head.dismember(dam_type = BRUTE, silent = TRUE)
		qdel(head)
	RegisterSignal(owner, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB, PROC_REF(abort_attachment))

/datum/mutation/headless/on_losing()
	. = ..()
	if(.)
		return TRUE

	UnregisterSignal(owner, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB)
	var/successful = owner.regenerate_limb(BODY_ZONE_HEAD)
	if(!successful)
		stack_trace("HARS mutation head regeneration failed! (usually caused by headless syndrome having a head)")
		return TRUE
	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.Remove(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)
		brain.zone = initial(brain.zone)
		brain.Insert(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)

	var/list/excluded_zones = GLOB.all_body_zones - BODY_ZONE_HEAD
	owner.dna.species.regenerate_organs(owner, replace_current = FALSE, excluded_zones = excluded_zones) //replace_current needs to be FALSE to prevent weird adding and removing mutation healing
	owner.apply_damage(damage = 50, damagetype = BRUTE, def_zone = BODY_ZONE_HEAD) //and this to DISCOURAGE organ farming, or at least not make it free.
	owner.visible_message(span_warning("伴随着令人作呕的碎裂声，[owner]的头颅重新长了出来！"), span_warning("伴随着令人作呕的爆裂声，你的头颅重新长了出来！好痛。"))
	new /obj/effect/gibspawner/generic(get_turf(owner), owner)

/datum/mutation/headless/proc/abort_attachment(datum/source, obj/item/bodypart/new_limb, special) //you aren't getting your head back
	SIGNAL_HANDLER

	if(istype(new_limb, /obj/item/bodypart/head))
		return COMPONENT_NO_ATTACH

// You bleed faster but regenerate blood faster
/datum/mutation/bloodier
	name = "血液代谢亢进"
	desc = "受试者的代谢变得异常旺盛，造血速度大幅提高。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINOR
	text_gain_indication = span_notice("你能感觉到心跳加快了。")
	text_lose_indication = span_notice("你的心跳又慢了下来。")
	difficulty = 16
	synchronizer_coeff = 1
	power_coeff = 1

	/// Modifies the bleed rate of the owner
	var/bleed_rate = 1.5
	/// Modifies the blood regeneration rate of the owner
	var/blood_regen_rate = 6
	/// Tracks if we've modified the physiology of the owner
	VAR_PRIVATE/physiology_modified = FALSE

/datum/mutation/bloodier/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	if(!physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, blood_regen_rate)
		physiology_modified = TRUE

/datum/mutation/bloodier/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	if(physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 1/bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, 1/blood_regen_rate)
		physiology_modified = FALSE // just in case

/datum/mutation/bloodier/setup()
	if(owner && physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 1/bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, 1/blood_regen_rate)
		physiology_modified = FALSE

	bleed_rate = clamp(initial(bleed_rate) * GET_MUTATION_SYNCHRONIZER(src) * GET_MUTATION_POWER(src), 1, 2)
	blood_regen_rate = clamp(initial(blood_regen_rate) * GET_MUTATION_POWER(src), 4, 12)

	if(owner && !physiology_modified) // redundant but just in case
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, blood_regen_rate)
		physiology_modified = TRUE
	return TRUE

// You eat rocks
/datum/mutation/rock_eater
	name = "食岩"
	desc = "受试者的身体能够消化岩石和矿物。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINI
	text_gain_indication = span_notice("你很想吃些石头。")
	text_lose_indication = span_notice("你想吃顿正常的饭了。")
	difficulty = 12
	mutation_traits = list(TRAIT_ROCK_EATER)
	conflicts = list(/datum/mutation/rock_absorber)

// You eat rock but also get buffs from them
/datum/mutation/rock_absorber
	name = "岩性吸收"
	desc = "受试者的身体能够消化岩石和矿物，并获得它们的特性。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	text_gain_indication = span_notice("你无比渴望吃些石头。")
	text_lose_indication = span_notice("你想吃顿正常的饭了。")
	mutation_traits = list(TRAIT_ROCK_EATER, TRAIT_ROCK_METAMORPHIC)
	conflicts = list(/datum/mutation/rock_eater)
	locked = TRUE

// Soft crit is disabed
/datum/mutation/inexorable
	name = "势不可挡"
	desc = "受试者的身体能够超越常人的耐受极限继续行动，但这一过程会造成内部损伤。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你感到自己势不可挡。")
	text_lose_indication = span_notice("你突然觉得自己更像个普通人了。")
	difficulty = 24
	synchronizer_coeff = 1
	mutation_traits = list(TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA)

/datum/mutation/inexorable/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(acquirer, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(check_health))
	check_health()

/datum/mutation/inexorable/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_LIVING_HEALTH_UPDATE)
	REMOVE_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))

/datum/mutation/inexorable/proc/check_health(...)
	SIGNAL_HANDLER
	if(owner.health > owner.crit_threshold || IS_UNCONSCIOUS_OR_CRIT(owner))
		REMOVE_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))
	else
		ADD_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))

/datum/mutation/inexorable/on_life(seconds_per_tick)
	if(owner.health > owner.crit_threshold || IS_UNCONSCIOUS_OR_CRIT(owner) || HAS_TRAIT(owner, TRAIT_STASIS))
		return
	if(HAS_TRAIT(owner, TRAIT_NOCRITDAMAGE) && owner.health <= owner.hardcrit_threshold + 10)
		return
	// Gives you 30 seconds of being in fake soft crit... give or take
	if(HAS_TRAIT(owner, TRAIT_TOXIMMUNE) || HAS_TRAIT(owner, TRAIT_TOXINLOVER))
		owner.adjust_brute_loss(1 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
	else
		owner.adjust_tox_loss(0.5 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
		owner.adjust_brute_loss(0.5 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
	// Offsets suffocation but not entirely
	owner.adjust_oxy_loss(-0.5 * seconds_per_tick)

/datum/mutation/limb_regeneration
	name = "再生"
	desc = "只要休息与营养充足，受试者的身体就能在睡眠时再生失去的肢体或器官。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你感到一阵奇怪的麻痒。")
	text_lose_indication = span_notice("那阵奇怪的麻痒消退了。")
	difficulty = 20
	synchronizer_coeff = 1
	power_coeff = 1

	/// Threshold of nutrition required to regenerate limbs/organs
	var/nutrition_threshold = NUTRITION_LEVEL_FED * 0.85
	/// If TRUE we notified the user they could probably use the mutation if they eat/slept first - comes with a bonus to trigger chance
	VAR_PRIVATE/notified_of_ability = FALSE

/datum/mutation/limb_regeneration/can_acquire(mob/living/carbon/human/acquirer)
	return !HAS_TRAIT(acquirer, TRAIT_NOHUNGER)

/datum/mutation/limb_regeneration/on_life(seconds_per_tick)
	if(owner.stat >= HARD_CRIT)
		return
	if(!SPT_PROB(5 * (notified_of_ability ? 4 : 1) * (GET_MUTATION_POWER(src) ** 2), seconds_per_tick))
		return

	var/list/missing_limbs = owner.get_missing_limbs()
	var/list/missing_important_organs = owner.get_missing_organs(include_appendix = (GET_MUTATION_POWER(src) > 1)) // appendix can regrow if you have power
	var/list/missing_special_organs = list()
	for(var/organ_type in owner.dna?.species?.mutant_organs)
		if(!owner.get_organ_by_type(organ_type) && should_visual_organ_apply_to(organ_type, owner))
			missing_special_organs += organ_type

	if(!length(missing_limbs) && !length(missing_important_organs) && !length(missing_special_organs))
		return

	if(owner.nutrition <= nutrition_threshold)
		if(IS_UNCONSCIOUS(owner) && !notified_of_ability)
			to_chat(owner, span_green("你感到一阵奇怪的麻痒，仿佛身体正试图做些什么——不过你觉得应该先吃顿饭。"))
			notified_of_ability = TRUE
		return
	if(!IS_UNCONSCIOUS(owner))
		if(owner.nutrition > nutrition_threshold && !notified_of_ability)
			to_chat(owner, span_green("你感到一阵奇怪的麻痒，仿佛身体正试图做些什么——不过你觉得应该先睡一觉。"))
			notified_of_ability = TRUE
		return

	notified_of_ability = FALSE
	// "core organs" and limbs are prioritized
	if(length(missing_important_organs) || length(missing_limbs))
		if(length(missing_important_organs) && (prob(50) || !length(missing_limbs)))
			var/replacement_type = owner.dna.species.get_mutant_organ_type_for_slot(pick(missing_important_organs))
			var/obj/item/organ/replacement = new replacement_type()
			replacement.Insert(owner, special = TRUE)
			to_chat(owner, span_green("麻痒感越来越强烈，直到你终于感觉到全新的[replacement.name]在原来的位置长了出来！"))
		else
			var/replacing_zone = pick(missing_limbs)
			owner.regenerate_limb(replacing_zone)
			var/obj/item/bodypart/replacement = owner.get_bodypart(replacing_zone)
			to_chat(owner, span_green("麻痒感越来越强烈，直到你终于感觉到全新的[replacement.plaintext_zone]在原来的位置长了出来！"))
			owner.visible_message(span_warning("[owner]的[replacement.plaintext_zone]重新长了出来，发出响亮而怪异的声音！"), ignored_mobs = list(owner))
		owner.adjust_nutrition(-NUTRITION_LEVEL_FULL * 0.5 * GET_MUTATION_SYNCHRONIZER(src))
		playsound(owner, 'sound/effects/magic/demon_consume.ogg', 33, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	// "cosmetic" organs are second priority and cheaper to regenerate
	if(length(missing_special_organs))
		var/replacement_type = pick(missing_special_organs)
		var/obj/item/organ/replacement = new replacement_type()
		replacement.Insert(owner, special = TRUE)
		to_chat(owner, span_green("麻痒感越来越强烈，直到你终于感觉到全新的[replacement.name]在原来的位置长了出来！"))
		if(replacement.organ_flags & ORGAN_EXTERNAL)
			owner.visible_message(span_warning("[owner]的[replacement.name]重新长了出来，发出响亮而怪异的声音！"), ignored_mobs = list(owner))
		owner.adjust_nutrition(-NUTRITION_LEVEL_FULL * 0.3 * GET_MUTATION_SYNCHRONIZER(src))
		playsound(owner, 'sound/effects/magic/demon_consume.ogg', 33, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	stack_trace("Limb regeneration failed to find a missing limb or organ to regenerate for [owner] despite passing the checks")

/datum/mutation/chemical_allergy
	name = "化学过敏"
	desc = "受试者的身体对几乎所有药品和毒品过敏，会暂时扰乱基因稳定性，并引起其他副作用。"
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_MAJOR
	text_gain_indication = span_warning("你的皮肤感到一阵奇怪的刺痒。")
	text_lose_indication = span_notice("你皮肤上的刺痒消退了。")
	difficulty = 20

	/// Typecache of reagents that trigger the allergy
	var/static/list/danger_reagents
	/// If we're currently experiencing negative effects
	VAR_PRIVATE/was_experiencing_allergy = FALSE

/datum/mutation/chemical_allergy/New()
	. = ..()
	if(length(danger_reagents))
		return

	danger_reagents = typecacheof(list(
		/datum/reagent/medicine,
		/datum/reagent/drug,
	)) - typecacheof(list(
		/datum/reagent/medicine/mannitol,
		/datum/reagent/medicine/mutadone,
	)) - GLOB.allergy_reagent_blacklist

/datum/mutation/chemical_allergy/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(acquirer, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_healthscan))

/datum/mutation/chemical_allergy/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_LIVING_HEALTHSCAN)

/datum/mutation/chemical_allergy/proc/on_healthscan(datum/source, list/render_list, advanced, mob/user, mode, tochat)
	SIGNAL_HANDLER

	render_list += "<span class='alert ml-1'>"
	render_list += conditional_tooltip("受试者患有[name]", "受试者会对大多数药品产生不良反应——\
		除非万不得已，治疗时应避免使用化学药剂。", tochat)
	render_list += "</span><br>"

/datum/mutation/chemical_allergy/on_life(seconds_per_tick)
	if(!has_danger_reagent())
		if(was_experiencing_allergy)
			was_experiencing_allergy = FALSE
			instability *= 2
			owner.dna.update_instability()
		return
	if(!SPT_PROB(80, seconds_per_tick))
		return
	if(!was_experiencing_allergy)
		was_experiencing_allergy = TRUE
		instability *= 0.5 // halves the negative instability it rewards, which could push you into danger territory!
		owner.dna.update_instability()

	if(SPT_PROB(66, seconds_per_tick))
		owner.set_stutter_if_lower(4 SECONDS)
	if(SPT_PROB(33, seconds_per_tick))
		owner.adjust_disgust(24, DISGUST_LEVEL_VERYDISGUSTED)
		owner.adjust_tox_loss(pick(2, 3, 4), forced = TRUE)
	if(SPT_PROB(12, seconds_per_tick))
		owner.adjust_jitter_up_to(6 SECONDS, 36 SECONDS)
		owner.adjust_dizzy_up_to(6 SECONDS, 36 SECONDS)
		owner.adjust_blood_volume(-pick(12, 16, 20, 24), minimum = BLOOD_VOLUME_OKAY)
	if(SPT_PROB(6, seconds_per_tick))
		owner.adjust_confusion_up_to(4 SECONDS, 12 SECONDS)
		owner.losebreath = max(owner.losebreath, 4)

/datum/mutation/chemical_allergy/proc/has_danger_reagent()
	for(var/datum/reagent/reagent as anything in owner.reagents?.reagent_list)
		if(!is_type_in_typecache(reagent, danger_reagents))
			continue
		if(!reagent.metabolizing || reagent.volume < 1)
			continue
		return TRUE

	return FALSE

/datum/mutation/venomous_strikes
	name = "带毒"
	desc = "受试者的身体会产生弱效毒素，可通过抓伤或咬伤注入他人体内。\
		若受试者自身接触到同类毒素，也能将其从血液中过滤掉。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你的牙齿和指甲感觉更锋利了。")
	text_lose_indication = span_notice("你的牙齿和指甲感觉更钝了。")
	/// Type of chem to inject
	var/venom_type = /datum/reagent/toxin
	/// Amount of chem to inject per attack
	var/venom_amount = 3

/datum/mutation/venomous_strikes/on_acquiring(mob/living/carbon/human/owner)
	text_gain_indication = (owner.get_active_hand()?.unarmed_attack_effect == ATTACK_EFFECT_CLAW) ? span_notice("你的牙齿和爪子感觉更锋利了。") : initial(text_gain_indication)
	. = ..()
	if(!.)
		return
	apply_venom()

/datum/mutation/venomous_strikes/on_losing(mob/living/carbon/human/owner)
	text_lose_indication = (owner.get_active_hand()?.unarmed_attack_effect == ATTACK_EFFECT_CLAW) ? span_notice("你的牙齿和爪子感觉更钝了。") : initial(text_lose_indication)
	. = ..()
	if(.)
		return
	remove_venom()

/datum/mutation/venomous_strikes/vv_edit_var(var_name, var_value)
	if(var_name != NAMEOF(src, venom_type) && var_name != NAMEOF(src, venom_amount))
		return ..()

	remove_venom()
	. = ..()
	apply_venom()

/datum/mutation/venomous_strikes/pre_apply_chromosome()
	apply_venom()

/datum/mutation/venomous_strikes/post_apply_chromosome()
	remove_venom()

/datum/mutation/venomous_strikes/proc/apply_venom()
	owner.AddElement(/datum/element/venomous, venom_type, venom_amount * GET_MUTATION_POWER(src), INJECT_CHECK_IGNORE_SPECIES)

/datum/mutation/venomous_strikes/proc/remove_venom()
	owner.RemoveElement(/datum/element/venomous, venom_type, venom_amount * GET_MUTATION_POWER(src), INJECT_CHECK_IGNORE_SPECIES)

/datum/mutation/venomous_strikes/on_life(seconds_per_tick)
	owner.reagents.remove_reagent(venom_type, round(venom_amount * 0.33, CHEMICAL_VOLUME_ROUNDING) * seconds_per_tick)
