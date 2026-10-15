/**
 * A component to reset the parent to its previous state after some time passes
 */
/datum/component/dejavu
	dupe_mode = COMPONENT_DUPE_ALLOWED

	///message sent when dejavu rewinds
	var/rewind_message = "你回想起不久前的一刻……"
	///message sent when dejavu is out of rewinds
	var/no_rewinds_message = "但那段记忆已变得遥不可及。"

	/// The turf the parent was on when this components was applied, they get moved back here after the duration
	var/turf/starting_turf
	/// Determined by the type of the parent so different behaviours can happen per type
	var/rewind_type
	/// How many rewinds will happen before the effect ends
	var/rewinds_remaining
	/// How long to wait between each rewind
	var/rewind_interval
	/// Do we add a new component before teleporting the target to they teleport to the place where *we* teleported them from?
	var/repeating_component

	/// The starting value of toxin loss at the beginning of the effect
	var/tox_loss = 0
	/// The starting value of oxygen loss at the beginning of the effect
	var/oxy_loss = 0
	/// The starting value of stamina loss at the beginning of the effect
	var/stamina_loss = 0
	/// The starting value of brain loss at the beginning of the effect
	var/brain_loss = 0
	/// The starting value of brute loss at the beginning of the effect
	/// This only applies to simple animals
	var/brute_loss
	/// The starting value of integrity at the beginning of the effect
	/// This only applies to objects
	var/integrity
	/// A list of body parts saved at the beginning of the effect
	var/list/datum/saved_bodypart/saved_bodyparts

/datum/component/dejavu/Initialize(rewinds = 1, interval = 10 SECONDS, add_component = FALSE)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	starting_turf = get_turf(parent)
	rewinds_remaining = rewinds
	rewind_interval = interval
	repeating_component = add_component

	if(isliving(parent))
		var/mob/living/L = parent
		tox_loss = L.get_tox_loss()
		oxy_loss = L.get_oxy_loss()
		stamina_loss = L.get_stamina_loss()
		brain_loss = L.get_organ_loss(ORGAN_SLOT_BRAIN)
		rewind_type = PROC_REF(rewind_living)
		aggravated_loss = L.get_agg_loss() // DARKPACK EDIT ADD - AGGRAVATED_DAMAGE

	if(iscarbon(parent))
		var/mob/living/carbon/C = parent
		saved_bodyparts = C.save_bodyparts()
		rewind_type = PROC_REF(rewind_carbon)

	else if(isanimal_or_basicmob(parent))
		var/mob/living/animal = parent
		brute_loss = animal.bruteloss
		rewind_type = PROC_REF(rewind_animal)

	else if(isobj(parent))
		var/obj/O = parent
		integrity = O.get_integrity()
		rewind_type = PROC_REF(rewind_obj)

	addtimer(CALLBACK(src, rewind_type), rewind_interval)

/datum/component/dejavu/Destroy()
	starting_turf = null
	saved_bodyparts = null
	return ..()

/datum/component/dejavu/proc/rewind()
	to_chat(parent, span_notice(rewind_message))

	//comes after healing so new limbs comically drop to the floor
	if(starting_turf)
		if(!check_teleport_valid(parent, starting_turf))
			to_chat(parent, span_warning("不知为何，当你试图回想自己先前的位置时，便感到头痛欲裂、思绪混沌……仿佛正在对抗某种沉闷而不可阻挡的宇宙之力。"))
		else
			var/atom/movable/master = parent
			master.forceMove(starting_turf)

	rewinds_remaining --
	if(rewinds_remaining || rewinds_remaining < 0)
		addtimer(CALLBACK(src, rewind_type), rewind_interval)
	else
		to_chat(parent, span_notice(no_rewinds_message))
		qdel(src)

/datum/component/dejavu/proc/rewind_living()
	if (rewinds_remaining == 1 && repeating_component && !iscarbon(parent) && !isanimal_or_basicmob(parent))
		parent.AddComponent(type, 1, rewind_interval, TRUE)

	var/mob/living/master = parent
	master.set_tox_loss(tox_loss)
	master.set_oxy_loss(oxy_loss)
	master.set_stamina_loss(stamina_loss)
	master.set_organ_loss(ORGAN_SLOT_BRAIN, brain_loss)
	master.set_agg_loss(aggravated_loss) // DARKPACK EDIT ADD - AGGRAVATED_DAMAGE
	rewind()

/datum/component/dejavu/proc/rewind_carbon()
	if (rewinds_remaining == 1 && repeating_component)
		parent.AddComponent(type, 1, rewind_interval, TRUE)

	if(saved_bodyparts)
		var/mob/living/carbon/master = parent
		master.apply_saved_bodyparts(saved_bodyparts)
	rewind_living()

/datum/component/dejavu/proc/rewind_animal()
	if (rewinds_remaining == 1 && repeating_component)
		parent.AddComponent(type, 1, rewind_interval, TRUE)

	var/mob/living/master = parent
	master.bruteloss = brute_loss
	master.updatehealth()
	rewind_living()

/datum/component/dejavu/proc/rewind_obj()
	if (rewinds_remaining == 1 && repeating_component)
		parent.AddComponent(type, 1, rewind_interval, TRUE)

	var/obj/master = parent
	master.update_integrity(integrity)
	rewind()

///differently themed dejavu for modsuits.
/datum/component/dejavu/timeline
	rewind_message = "你的服装启动回溯，将你拉过时空！"
	no_rewinds_message = "\"回溯完成。你已抵达：10 秒之前。\""

/datum/component/dejavu/timeline/rewind()
	playsound(get_turf(parent), 'sound/items/modsuit/rewinder.ogg', 50, TRUE)
	return ..()

/datum/component/dejavu/wizard
	rewind_message = "你的时间结界已激活，将你拉过时空！"

/datum/component/dejavu/wizard/rewind()
	playsound(get_turf(parent), 'sound/items/modsuit/rewinder.ogg', 50, TRUE)
	return ..()
