/datum/discipline/visceratika
	name = "Visceratika"
	desc = {"岩肤术是石像鬼血系独有的律能，源于他们对岩石、大地及其造物的天生亲和。
● 变色龙之肤：被动
●● 炉石窥探：感知 + 灵觉
●●● 山岩融合：被动
●●●● 大地之甲：无需掷骰——始终生效
●●●●● 山中潜行：被动"}
	icon_state = "visceratika"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/visceratika

/datum/discipline_power/visceratika
	name = "Visceratika power name"
	desc = "Visceratika power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/visceratika.ogg'

/datum/discipline/visceratika/post_gain()
	. = ..()
	// it is rumored that, if a non-gargoyle kindred were to learn Visceratika, their skin would turn stony
	owner.skin_tone = "albino"
	owner.set_body_sprite("gargoyle")
	owner.update_body_parts()
	owner.update_body()

//SKIN OF THE CHAMELEON
/datum/discipline_power/visceratika/skin_of_the_chameleon
	name = "变色龙之肤"
	desc = "让皮肤模仿周围环境，使你更易隐匿身形。"
	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	cooldown_length = 2 SCENES
	duration_length = 1 SCENES
	cancelable = TRUE
	vitae_cost = 1
	frenzy_usable = FALSE

/datum/discipline_power/visceratika/skin_of_the_chameleon/activate()
	. = ..()
	skin_chameleon_run()
	RegisterSignal(owner, COMSIG_MOVE_INTENT_TOGGLED, PROC_REF(skin_chameleon_run))

/datum/discipline_power/visceratika/skin_of_the_chameleon/deactivate(atom/target, direct)
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVE_INTENT_TOGGLED)
	owner.alpha = 255
	remove_wibbly_filters(owner)

/datum/discipline_power/visceratika/skin_of_the_chameleon/proc/skin_chameleon_run()
	SIGNAL_HANDLER
	if(owner.move_intent == MOVE_INTENT_RUN)
		owner.alpha = 40
		apply_wibbly_filters(owner)
	else
		owner.alpha = 10
		remove_wibbly_filters(owner)

//SCRY THE HEARTHSTONE
/datum/discipline_power/visceratika/scry_the_hearthstone
	name = "炉石窥探"
	desc = "感知建筑内所有人的准确位置。"
	willpower_cost = 1

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	toggled = TRUE
	var/datum/storyteller_roll/scry_the_hearthstone/scry_roll
	var/area/monitoring_area
	frenzy_usable = FALSE

/datum/storyteller_roll/scry_the_hearthstone
	bumper_text = "炉石窥探"
	applicable_stats = list(STAT_PERCEPTION, STAT_AWARENESS)
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/visceratika/scry_the_hearthstone/New(datum/discipline/discipline)
	. = ..()

	scry_roll = new()

/datum/discipline_power/visceratika/scry_the_hearthstone/can_activate(atom/target, alert)
	. = ..()
	if (!.)
		return .

	// Can only be used to detect people 'inside a given structure'
	var/area/in_area = get_area(owner)
	if (in_area.outdoors)
		if (alert)
			to_chat(owner, span_warning("你只能在室内使用[name]！"))
		return FALSE

/datum/discipline_power/visceratika/scry_the_hearthstone/pre_activation_checks()
	. = ..()

	if(scry_roll.st_roll(owner, owner) == ROLL_SUCCESS)
		return TRUE
	else
		return FALSE

/datum/discipline_power/visceratika/scry_the_hearthstone/activate()
	. = ..()

	monitoring_area = get_area(owner)

	// In the TTRPG this is resisted when targets are hiding (V20 p. 476), but there is no roll to resist here
	var/found_anyone = FALSE
	for (var/mob/living/player in (GLOB.player_list - owner))
		if (get_area(player) != monitoring_area)
			continue

		to_chat(owner, "- [GET_GUESTBOOK_NAME(owner, player)]位于[get_relative_location_description(player)]。")
		RegisterSignal(player, COMSIG_EXIT_AREA, PROC_REF(on_target_exit_area))
		found_anyone = TRUE

	if (!found_anyone)
		to_chat(owner, span_notice("你没有感知到这片区域内有值得留意的人。"))

	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, DISCIPLINE_TRAIT(type))
	owner.update_sight()
	//visceratika 2 gives a gargoyle a heatmap of all living people in a building. if they leave the building, they need to re-cast it.
	RegisterSignal(owner, COMSIG_EXIT_AREA, PROC_REF(on_caster_exit_area))
	// Also alert the user when someone enters the building
	RegisterSignal(monitoring_area, COMSIG_AREA_ENTERED, PROC_REF(on_area_entered))

/**
 * Returns a text description of the distance and direction from the owner to the target
 */
/datum/discipline_power/visceratika/scry_the_hearthstone/proc/get_relative_location_description(mob/living/target)
	var/distance = get_dist(owner, target)
	if (distance == 0)
		return "你身旁"
	else
		return "你[list("north" = "北", "south" = "南", "east" = "东", "west" = "西", "northeast" = "东北", "northwest" = "西北", "southeast" = "东南", "southwest" = "西南")[dir2text(get_dir(owner, target))]]方[distance]码处"

/datum/discipline_power/visceratika/scry_the_hearthstone/proc/on_target_exit_area(mob/living/source, area/old_area)
	SIGNAL_HANDLER

	if (!active)
		return

	to_chat(owner, span_warning("[GET_GUESTBOOK_NAME(owner, source)]离开了你监视的区域，位于[get_relative_location_description(source)]。"))
	UnregisterSignal(source, COMSIG_EXIT_AREA)

/datum/discipline_power/visceratika/scry_the_hearthstone/proc/on_area_entered(area/source, atom/movable/arrived, area/old_area)
	SIGNAL_HANDLER

	if (!isliving(arrived))
		return
	var/mob/living/entering_mob = arrived

	// Only players are interesting enough to alert the caster of
	if (!GET_CLIENT(entering_mob))
		return

	to_chat(owner, span_warning("[GET_GUESTBOOK_NAME(owner, entering_mob)]进入了你监视的区域，位于[get_relative_location_description(entering_mob)]。"))
	RegisterSignal(entering_mob, COMSIG_EXIT_AREA, PROC_REF(on_target_exit_area))

/datum/discipline_power/visceratika/scry_the_hearthstone/proc/on_caster_exit_area(mob/living/source, area/old_area)
	SIGNAL_HANDLER

	to_chat(owner, span_warning("离开这片区域后，你与岩石的联系中断了。"))
	try_deactivate()

/datum/discipline_power/visceratika/scry_the_hearthstone/deactivate(atom/target, direct)
	. = ..()

	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, DISCIPLINE_TRAIT(type))
	owner.update_sight()
	UnregisterSignal(owner, COMSIG_EXIT_AREA)

	UnregisterSignal(monitoring_area, COMSIG_AREA_ENTERED)
	monitoring_area = null

//BOND WITH THE MOUNTAIN
/datum/discipline_power/visceratika/bond_with_the_mountain
	name = "山岩融合"
	desc = "与周围环境融为一体，让人难以发现你。"

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	vitae_cost = 2
	cancelable = TRUE
	toggled = TRUE
	duration_length = 0
	cooldown_length = 10 SECONDS
	var/datum/weakref/exit_turf
	var/datum/weakref/stone_turf
	frenzy_usable = FALSE

/datum/discipline_power/visceratika/bond_with_the_mountain/pre_activation_checks()
	. = ..()
	for(var/turf/closed/adjacent in orange(1, owner))
		stone_turf = WEAKREF(adjacent)
		break

	if(!stone_turf)
		to_chat(owner, span_warning("你必须紧邻石面才能施展山岩融合。"))
		return FALSE
	return TRUE

/datum/discipline_power/visceratika/bond_with_the_mountain/activate()
	. = ..()

	exit_turf = WEAKREF(get_turf(owner))
	to_chat(owner, span_notice("你开始沉入岩石之中……"))

	if(!do_after(owner, 2 TURNS))
		to_chat(owner, span_warning("你与附近岩石的融合被打断了！"))
		exit_turf = null
		return FALSE

	var/turf/resolved_stone = stone_turf?.resolve()

	if(resolved_stone)
		owner.forceMove(resolved_stone)
	owner.alpha = 30
	ADD_TRAIT(owner, TRAIT_BOND_WITHIN_THE_MOUNTAIN, DISCIPLINE_TRAIT(type))
	ADD_TRAIT(owner, TRAIT_IMMOBILIZED, DISCIPLINE_TRAIT(type))
	owner.damage_deflection = 3 TTRPG_DAMAGE

/datum/discipline_power/visceratika/bond_with_the_mountain/deactivate(forced = TRUE)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_IMMOBILIZED, DISCIPLINE_TRAIT(type))
	REMOVE_TRAIT(owner, TRAIT_BOND_WITHIN_THE_MOUNTAIN, DISCIPLINE_TRAIT(type))
	owner.damage_deflection = 0
	if(forced) //only false when using visceratika 5. we inherit the alpha from this ability and when visceratika 5 deactivates, return to 255
		var/turf/resolved_exit = exit_turf?.resolve()
		if(resolved_exit)
			owner.forceMove(resolved_exit)
		owner.alpha = 255
	exit_turf = null
	stone_turf = null

//ARMOR OF TERRA
/datum/discipline_power/visceratika/armor_of_terra
	name = "大地之甲"
	desc = "这项能力无需掷骰，始终生效。你的岩质皮肤变得极其坚硬，几乎所有伤害都会减轻。"

	level = 4
	check_flags = NONE

	vitae_cost = 0

/datum/discipline_power/visceratika/armor_of_terra/post_gain()
	MODIFY_PHYSIOLOGY(owner, BRUTE, 0.8)
	MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_HEAT, 0.5)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, DISCIPLINE_TRAIT(type))
	if (!owner.is_clan(/datum/subsplat/vampire_clan/gargoyle))
		ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, DISCIPLINE_TRAIT(type))

/datum/discipline_power/visceratika/armor_of_terra/post_loss()
	MODIFY_PHYSIOLOGY(owner, BRUTE, 1.25)
	MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_HEAT, 2)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, DISCIPLINE_TRAIT(type))
	REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, DISCIPLINE_TRAIT(type))

/datum/discipline_power/visceratika/armor_of_terra/can_activate_untargeted(alert)
	. = ..()

	if (alert)
		to_chat(owner, span_danger("[name]是被动能力，效果已经生效！"))

	return FALSE

//FLOW WITHIN THE MOUNTAIN
/datum/discipline_power/visceratika/flow_within_the_mountain
	name = "山中潜行"
	desc = "融入坚实的岩石，在其中穿行而不扰动岩体。"

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 2
	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 1 SCENES // might be too long...
	cooldown_length = 10 SECONDS

/datum/discipline_power/visceratika/flow_within_the_mountain/can_activate(atom/target, alert)
	. = ..()
	if (!.)
		return .

	if(!HAS_TRAIT(owner, TRAIT_BOND_WITHIN_THE_MOUNTAIN))
		to_chat(owner, span_notice("你必须先施展山岩融合，才能使用山中潜行。"))
		return FALSE

/datum/discipline_power/visceratika/flow_within_the_mountain/activate()
	. = ..()
	var/datum/discipline_power/visceratika/bond_with_the_mountain/bond = discipline.get_power(/datum/discipline_power/visceratika/bond_with_the_mountain)
	bond.deactivate(forced = FALSE)
	owner.generic_canpass = FALSE
	RegisterSignal(owner, COMSIG_MOVABLE_CAN_PASS_THROUGH, PROC_REF(can_pass_through_walls))
	apply_wibbly_filters(owner)

/datum/discipline_power/visceratika/flow_within_the_mountain/deactivate()
	. = ..()
	owner.generic_canpass = TRUE
	UnregisterSignal(owner, COMSIG_MOVABLE_CAN_PASS_THROUGH)
	owner.alpha = 255
	remove_wibbly_filters(owner)

/datum/discipline_power/visceratika/flow_within_the_mountain/proc/can_pass_through_walls(datum/source, atom/blocker, movement_dir)
	SIGNAL_HANDLER
	if(!istype(blocker, /turf/closed))
		return
	if(istype(blocker, /turf/cordon))
		return
	if(get_area(owner) == get_area(blocker))
		return COMSIG_COMPONENT_PERMIT_PASSAGE

/*
//ROCKHEART
/datum/discipline_power/visceratika/rockheart
	name = "Rockheart"
	desc = "Solidify your innermost organs to prevent damage"

	level = 6
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	violates_masquerade = FALSE

	toggled = TRUE
	cooldown_length = 1 MINUTES

/datum/discipline_power/visceratika/rockheart/activate()
	. = ..()
	to_chat(owner, span_warning("You harden your internal organs, protecting you against many forms of damage and stakes!"))
	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC)
	ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC)
	ADD_TRAIT(owner, TRAIT_NOBLEED, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_PIERCEIMMUNE, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_NEVER_WOUNDED, MAGIC_TRAIT)

	owner.stakeimmune = TRUE

/datum/discipline_power/visceratika/rockheart/deactivate()
	. = ..()
	to_chat(owner, span_warning("You soften your internal organs, to their normal durability."))
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC)
	REMOVE_TRAIT(owner, TRAIT_NOBLEED, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_PIERCEIMMUNE, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NEVER_WOUNDED, MAGIC_TRAIT)

	owner.stakeimmune = FALSE
*/
