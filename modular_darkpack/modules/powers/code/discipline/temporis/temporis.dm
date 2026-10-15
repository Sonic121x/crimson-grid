/datum/discipline/temporis
	name = "Temporis"
	desc = {"时流术是真布鲁赫独有的律能。据说它是迅捷术的精进形式，赋予该隐后裔操纵时间流动本身的能力。
● 心灵沙漏：被动
●● 循环沉思：被动
●●● 凝铅时刻：被动
●●●● 诺伦之耐：被动
●●●●● 克洛托之赐：被动"}
	icon_state = "temporis"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/temporis
	signature_clan = VAMPIRE_CLAN_TRUE_BRUJAH

/datum/discipline_power/temporis
	name = "Temporis power name"
	desc = "Temporis power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/temporis/temporis.ogg'

	magic_subtype = MAGIC_SUBTYPE_BLOOD_TIME

/datum/discipline_power/temporis/activate()
	. = ..()
	ADD_TRAIT(owner, TRAIT_TIMEWARPER, DISCIPLINE_TRAIT(type))

/datum/discipline_power/temporis/proc/celerity_explode(datum/source, datum/discipline_power/power, atom/target)
	SIGNAL_HANDLER

	if (!istype(power, /datum/discipline_power/celerity))
		return

	to_chat(owner, span_userdanger("你试图使用迅捷术，但正在生效的时流术使你的身体自行撕裂！"))
	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob/living/carbon/human, gib)), 3 SECONDS)

	return POWER_CANCEL_ACTIVATION

//HOURGLASS OF THE MIND
/datum/discipline_power/temporis/hourglass_of_the_mind
	name = "心灵沙漏"
	desc = "获得完美的时间感，准确知晓自己身处何时。"

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0

/datum/discipline_power/temporis/hourglass_of_the_mind/post_gain()
	ADD_TRAIT(owner, TRAIT_TIME_SENSE, DISCIPLINE_TRAIT(type))

/datum/discipline_power/temporis/hourglass_of_the_mind/activate()
	. = ..()
	to_chat(owner, "<b>[server_timestamp("hh:mm:ss", ic_time = TRUE, twelve_hour_clock = owner.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]</b>")

	// Check range for targets with that have warped time this round and display them, if any exist
	var/list/targets = list()
	for(var/mob/living/carbon/human/target in view(range, owner))
		if(target == owner)
			continue
		if(HAS_TRAIT(target, TRAIT_TIMEWARPER))
			targets += target
	if(targets.len)
		var/target_list = ""
		for(var/i = 1 to targets.len)
			var/mob/living/carbon/human/target = targets[i]
			target_list += target.name
			if(i < targets.len - 1)
				target_list += ", "
			else if(i == targets.len - 1)
				target_list += " and "
		to_chat(owner, span_notice("[english_list(targets, nothing_text = "无人", and_text = "和", comma_text = "、", final_comma_text = "")]周围存在时间扭曲。"))
	else
		to_chat(owner, span_notice("附近没有时间扭曲。"))

//RECURRING CONTEMPLATION
/datum/discipline_power/temporis/recurring_contemplation
	name = "循环沉思"
	desc = "使目标陷入循环，反复执行同一组动作。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7
	vitae_cost = 0 //You *can* spend a BP to boost this, but it'd extend time to hours or a day.

	hostile = TRUE
	frenzy_usable = FALSE

	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/recurring_contemplation/activate(mob/living/target)
	. = ..()
	target.AddComponent(/datum/component/dejavu, rewinds = 4, interval = 2 SECONDS)

//LEADEN MOMENT
/datum/discipline_power/temporis/leaden_moment
	name = "凝铅时刻"
	desc = "减缓对手周围的时间流动，使其速度降低。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7

	hostile = TRUE

	multi_activate = TRUE
	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/leaden_moment/activate(mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("<b>慢下来。</b>"))
	target.add_movespeed_modifier(/datum/movespeed_modifier/temporis)

/datum/discipline_power/temporis/leaden_moment/deactivate(mob/living/target)
	. = ..()
	target.remove_movespeed_modifier(/datum/movespeed_modifier/temporis)

/datum/movespeed_modifier/temporis
	multiplicative_slowdown = 7.5

//PATIENCE OF THE NORNS
/datum/discipline_power/temporis/patience_of_the_norns
	name = "诺伦之耐"
	desc = "同时出现在多处，制造多个幻影。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE

	violates_masquerade = TRUE
	frenzy_usable = FALSE

	cancelable = TRUE
	duration_length = 10 SECONDS
	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/patience_of_the_norns/activate()
	. = ..()
	var/matrix/initial_matrix = matrix(owner.transform)
	var/matrix/secondary_matrix = matrix(owner.transform)
	var/matrix/tertiary_matrix = matrix(owner.transform)
	initial_matrix.Translate(1,0)
	secondary_matrix.Translate(0,1)
	tertiary_matrix.Translate(1)
	animate(owner, transform = initial_matrix, time = 1 SECONDS, loop = 0)
	animate(owner, transform = secondary_matrix, time = 1 SECONDS, loop = 0, ANIMATION_PARALLEL)
	animate(owner, transform = tertiary_matrix, time = 1 SECONDS, loop = 0, ANIMATION_PARALLEL)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(temporis_visual))
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(celerity_explode))

/datum/discipline_power/temporis/patience_of_the_norns/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)

/datum/discipline_power/temporis/patience_of_the_norns/proc/temporis_visual(datum/discipline_power/temporis/source, atom/newloc, dir)
	SIGNAL_HANDLER

	new /obj/effect/temporis/patience_of_the_norns(owner.loc, owner)

	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

//CLOTHOS GIFT
/datum/discipline_power/temporis/clothos_gift
	name = "克洛托之赐"
	desc = "加快自身的时间流动，大幅提升速度。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	vitae_cost = 3

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 10 SECONDS
	cooldown_length = 15 SECONDS

/datum/discipline_power/temporis/clothos_gift/activate()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/temporis5)
	owner.next_move_modifier *= 0.25
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(temporis_visual))
	RegisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(celerity_explode))

/datum/discipline_power/temporis/clothos_gift/deactivate()
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/temporis5)
	owner.next_move_modifier /= 0.25
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(owner, COMSIG_POWER_PRE_ACTIVATION)

/datum/discipline_power/temporis/clothos_gift/proc/temporis_visual(datum/discipline_power/temporis/source, atom/newloc, dir)
	SIGNAL_HANDLER

	new /obj/effect/temporis/clothos_gift(owner.loc, owner)

	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

/datum/movespeed_modifier/temporis5
	multiplicative_slowdown = -2.5
