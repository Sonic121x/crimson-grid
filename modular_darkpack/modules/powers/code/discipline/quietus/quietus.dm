/datum/discipline/quietus
	name = "Quietus"
	desc = {"哈基姆之裔的标志性律能。静谧术让使用者操纵血液、制造毒素，悄无声息地暗杀目标。违反避世戒律。
● 死亡寂静：被动
●● 毒蝎之触：永久意志力（难度 6）
●●● 达贡之唤：耐力，对抗目标的意志力
●●●● 巴尔之抚：被动
●●●●● 死亡之味：耐力 + 运动（难度 6）"}
	icon_state = "quietus"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/quietus
	signature_clan = VAMPIRE_CLAN_BANU_HAQIM

/datum/discipline_power/quietus
	name = "Quietus power name"
	desc = "Quietus power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/quietus.ogg' // REPLACE THIS PRICE IS RIGHT ASS SOUND!!!

//SILENCE OF DEATH
/datum/discipline_power/quietus/silence_of_death
	name = "死亡寂静"
	desc = "在周围创造一片绝对寂静的区域，淹没目标的尖叫。这种神秘的寂静从你体内向外扩散，消除半径 7 格范围内的所有声音。"

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	vitae_cost = 1
	cancelable = TRUE

	duration_length = 1 SCENES
	cooldown_length = 2 SCENES
	var/datum/proximity_monitor/advanced/silence_of_death/silence_field
	frenzy_usable = FALSE

/datum/discipline_power/quietus/silence_of_death/activate()
	. = ..()
	silence_field = new(owner, 7, FALSE)

/datum/discipline_power/quietus/silence_of_death/deactivate(atom/target, direct = FALSE)
	. = ..()
	QDEL_NULL(silence_field)


/datum/storyteller_roll/scorpions_touch
	applicable_stats = list(STAT_PERMANENT_WILLPOWER)
	numerical = TRUE

//SCORPIONS TOUCH
/datum/discipline_power/quietus/scorpions_touch
	name = "毒蝎之触"
	desc = "制造强效毒液，摧毁目标的耐力。"

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND
	vitae_cost = 0
	violates_masquerade = TRUE
	cooldown_length = 1 MINUTES
	var/blood_converted
	var/debuff_duration

/datum/discipline_power/quietus/scorpions_touch/pre_activation_checks(atom/target)
	. = ..()
	var/success_count = SSroll.storyteller_roll_datum(owner, roll_datum = /datum/storyteller_roll/scorpions_touch)

	if(success_count <= 0)
		to_chat(owner, span_warning("你的血液未能转化为毒液！"))
		return FALSE

	switch(success_count)
		if(1)
			debuff_duration = 5 TURNS
		if(2)
			debuff_duration = 10 TURNS
		if(3)
			debuff_duration = 20 TURNS
		if(4)
			debuff_duration = 5 MINUTES
		if(5 to INFINITY)
			debuff_duration = 2 SCENES

	//the book says they can use however many dots in stamina they have to convert bloodpoints into poison just FYI
	//so if this were to be lore accurate max_conversion would be owner.st_get_stat(STAT_STAMINA), but it also says 0 stamina = instant torpor so...
	var/max_conversion = 2 // 2 bps max for the stat mod reduction since instantly torporing people is bad
	var/list/bp_options = list()
	for(var/i in 1 to min(max_conversion, owner.bloodpool))
		bp_options += i

	blood_converted = tgui_input_list(owner, "你要消耗多少血点来制造这种毒素？", "毒蝎之触", bp_options)
	if(!blood_converted)
		return FALSE

	owner.adjust_blood_pool(-blood_converted)

	return TRUE

/datum/discipline_power/quietus/scorpions_touch/activate()
	. = ..()
	var/obj/item/held_weapon = owner.get_active_held_item()
	if(held_weapon && isitem(held_weapon))
		if(held_weapon.GetComponent(/datum/component/scorpions_touch_poison))
			to_chat(owner, span_warning("[held_weapon]已经淬毒了！"))
			return

		held_weapon.AddComponent(/datum/component/scorpions_touch_poison, blood_converted, debuff_duration)
		to_chat(owner, span_notice("你将有毒的血液涂在[held_weapon]上！"))
	else
		owner.drop_all_held_items()
		//Banu Haqim can 'spit' this venom too - perhaps throw the touch attack item...?
		var/obj/item/melee/touch_attack/quietus/touch = new(owner.loc, blood_converted, debuff_duration)
		owner.put_in_active_hand(touch)

//DAGON'S CALL
/datum/discipline_power/quietus/dagons_call
	name = "达贡之唤"
	desc = "诅咒你在过去一小时内触碰过的人，使其溺毙于自身的血液之中。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING
	vitae_cost = 0
	//willpower_cost = 1
	cooldown_length = 5 SECONDS

	var/list/marked_targets = list()

/datum/discipline_power/quietus/dagons_call/post_gain()
	. = ..()
	RegisterSignal(owner, COMSIG_HUMAN_PUNCHED, PROC_REF(on_punch))
	RegisterSignal(owner, COMSIG_HUMAN_GOT_PUNCHED, PROC_REF(on_punch))
	RegisterSignal(owner, COMSIG_CARBON_HELP_ACT, PROC_REF(on_touch))
	RegisterSignal(owner, COMSIG_CARBON_HELPED, PROC_REF(on_touch))

/datum/discipline_power/quietus/dagons_call/Destroy()
	UnregisterSignal(owner, list(COMSIG_HUMAN_PUNCHED, COMSIG_CARBON_HELP_ACT, COMSIG_CARBON_HELPED))
	marked_targets.Cut()
	return ..()

/datum/discipline_power/quietus/dagons_call/proc/on_punch(datum/source, mob/living/carbon/human/victim)
	SIGNAL_HANDLER
	mark_target(victim)

/datum/discipline_power/quietus/dagons_call/proc/on_touch(datum/source, mob/living/carbon/human/target)
	SIGNAL_HANDLER
	mark_target(target)

/datum/discipline_power/quietus/dagons_call/proc/mark_target(mob/living/carbon/human/target)
	if(!target || !ishuman(target) || target == owner)
		return

	var/datum/weakref/target_ref = WEAKREF(target)
	marked_targets[target_ref] = world.time

	to_chat(owner, span_notice("你通过触碰在[target]身上留下印记。"))

/datum/discipline_power/quietus/dagons_call/proc/get_valid_targets()
	var/list/valid = list()
	var/current_time = world.time

	for(var/datum/weakref/target_ref as anything in marked_targets)
		var/mark_time = marked_targets[target_ref]

		if(current_time - mark_time > 20 MINUTES)
			marked_targets -= target_ref
			continue

		var/mob/living/carbon/human/target = target_ref.resolve()
		if(!target || QDELETED(target))
			marked_targets -= target_ref
			continue

		valid[target] = mark_time

	return valid

/datum/discipline_power/quietus/dagons_call/pre_activation_checks(atom/target)
	. = ..()

	var/list/valid_targets = get_valid_targets()

	if(!length(valid_targets))
		to_chat(owner, span_warning("你尚未通过触碰给任何人留下印记！"))
		return FALSE

	return TRUE

/datum/discipline_power/quietus/dagons_call/activate()
	. = ..()

	var/list/valid_targets = get_valid_targets()
	var/list/target_names = list()

	for(var/mob/living/carbon/human/target as anything in valid_targets)
		target_names[target.name] = target

	var/chosen_name = tgui_input_list(owner, "选择目标：", "达贡之唤", target_names)
	if(!chosen_name)
		return

	var/mob/living/carbon/human/victim = target_names[chosen_name]
	strike_victim(victim)

/datum/discipline_power/quietus/dagons_call/proc/strike_victim(mob/living/carbon/human/victim)
	var/victim_willpower = victim.st_get_stat(STAT_PERMANENT_WILLPOWER)

	var/attacker_successes = SSroll.storyteller_roll_datum(owner, victim, difficulty = victim_willpower, applic_stats = list(STAT_STAMINA), numerical = TRUE)
	var/victim_successes = SSroll.storyteller_roll_datum(victim, owner, difficulty = victim_willpower, applic_stats = list(STAT_STAMINA), numerical = TRUE)

	var/net_successes = attacker_successes - victim_successes

	if(net_successes <= 0)
		to_chat(owner, span_warning("[victim]抵抗了达贡之唤。"))
		return

	victim.adjust_fire_loss(10 * net_successes)

	to_chat(owner, span_boldwarning("你对[victim]施展达贡之唤，让其被自身的血液呛住！"))
	to_chat(victim, span_userdanger("你的血管破裂，自身的血液正将你溺毙！"))

	if(victim.stat != DEAD)
		var/continue_call = tgui_alert(owner, "额外消耗 1 点意志力以继续达贡之唤？", "达贡之唤", list("是", "否"))
		if(continue_call == "是" && owner.st_add_stat_mod(STAT_TEMPORARY_WILLPOWER, -1, "Dagon's Call")) //requires stat preferences pr
			strike_victim(victim)

//BAAL'S CARESS
/datum/discipline_power/quietus/baals_caress
	name = "巴尔之抚"
	desc = "将你的血粹转化为毒素，摧毁它触及的一切血肉。"

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND
	vitae_cost = 0
	target_type = TARGET_OBJ
	range = 1

	violates_masquerade = TRUE

	cooldown_length = 15 SECONDS

/datum/discipline_power/quietus/baals_caress/can_activate(atom/target)
	. = ..()
	if(!isitem(target))
		to_chat(owner, span_warning("[src]只能用于武器！"))
		return FALSE

	var/obj/item/weapon = target

	if(!weapon.sharpness)
		to_chat(owner, span_warning("[src]只能用于带刃武器！"))
		return FALSE

	if(weapon.GetComponent(/datum/component/baals_caress))
		to_chat(owner, span_warning("这件武器已经淬毒了！"))
		return FALSE

/datum/discipline_power/quietus/baals_caress/activate(obj/item/melee/vamp/target)
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/user = owner
	var/max_layers = user.bloodpool

	if(max_layers <= 0)
		to_chat(owner, span_warning("你没有可用于涂抹武器的血液！"))
		return

	var/layers = tgui_input_number(owner, "你要消耗多少血点？", "巴尔之抚", 1, max_layers, 1)
	if(!layers)
		return
	user.adjust_blood_pool(-layers)
	target.AddComponent(/datum/component/baals_caress, owner, layers)
	to_chat(owner, span_notice("你为[target]涂上了 [layers] 层有毒的血粹！"))

//TASTE OF DEATH
/obj/projectile/quietus
	name = "酸毒唾液"
	icon_state = "toxin"
	pass_flags = PASSTABLE
	damage = 60
	damage_type = BURN
	hitsound = 'sound/items/weapons/effects/searwall.ogg'
	hitsound_wall = 'sound/items/weapons/effects/searwall.ogg'
	ricochets_max = 0
	ricochet_chance = 0

/obj/item/gun/magic/quietus
	name = "酸毒唾液"
	desc = "向目标喷吐毒液。"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "har4ok"
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	ammo_type = /obj/item/ammo_casing/magic/quietus
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	item_flags = DROPDEL

/obj/item/ammo_casing/magic/quietus
	name = "酸毒唾液"
	desc = "一口唾液。"
	projectile_type = /obj/projectile/quietus
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	item_flags = DROPDEL

/obj/item/gun/magic/quietus/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	. = ..()
	if(charges == 0)
		qdel(src)
/*
	playsound(target.loc, 'modular_darkpack/modules/deprecated/sounds/quietus.ogg', 50, TRUE)
	target.Stun(5*level_casting)
	if(level_casting >= 3)
		if(target.bloodpool > 1)
			var/transfered = max(1, target.bloodpool-3)
			owner.adjust_blood_points(transfered)
			target.adjust_blood_points(-transfered)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.remove_overlay(POWERS_LAYER)
		var/mutable_appearance/quietus_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "quietus", -POWERS_LAYER)
		H.overlays_standing[POWERS_LAYER] = quietus_overlay
		H.apply_overlay(POWERS_LAYER)
		spawn(5*level_casting)
			H.remove_overlay(POWERS_LAYER)
*/


/datum/storyteller_roll/taste_of_death
	applicable_stats = list(STAT_STAMINA, STAT_ATHLETICS)

/datum/discipline_power/quietus/taste_of_death
	name = "死亡之味"
	desc = "向敌人吐出一团具有腐蚀性的血液。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_LYING | DISC_CHECK_FREE_HAND

	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS

/datum/discipline_power/quietus/taste_of_death/can_activate()
	range = 3 + owner.st_get_stat(STAT_STRENGTH)
	return ..()

/datum/discipline_power/quietus/taste_of_death/pre_activation_checks(atom/target)
	. = ..()
	var/roll = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/taste_of_death)
	if(roll == ROLL_SUCCESS)
		return TRUE
	else
		return FALSE

/datum/discipline_power/quietus/taste_of_death/activate()
	. = ..()
	owner.drop_all_held_items()
	//should be changed to a ranged attack targeting turfs
	owner.put_in_active_hand(new /obj/item/gun/magic/quietus(owner))
