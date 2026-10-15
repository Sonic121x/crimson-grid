/mob/living/basic/corvid
	name = "鸦科鸟类"
	desc = "嘎。"
	abstract_type = /mob/living/basic/corvid
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon_state = "black"
	icon_living = "black"
	icon_dead = "black"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/corax_forms/corvid.dmi'
	density = FALSE
	butcher_results = list(/obj/item/food/meat/slab/chicken = 1)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "啄击"
	response_harm_simple = "啄击"
	attack_verb_continuous = "啄击"
	attack_verb_simple = "啄击"
	friendly_verb_continuous = "用头轻撞"
	friendly_verb_simple = "用头轻撞"
	verb_say = "嘎嘎叫道"
	verb_exclaim = "聒噪地叫道"
	verb_yell = "尖叫道"
	speak_emote = list("嘎嘎叫道")
	health = 20
	maxHealth = 20
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	basic_mob_flags = FLIP_ON_DEATH

	ai_controller = /datum/ai_controller/basic_controller/corvid

	var/sprite_color = "black"
	var/sprite_eye_color = "#FFFFFF"

/mob/living/basic/corvid/Initialize(mapload)
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	GRANT_ACTION(/datum/action/innate/togglecorvidflight)
	AddElement(/datum/element/ai_retaliate) // Birds dont forget
	AddElement(/datum/element/pet_bonus, "caw")
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElementTrait(TRAIT_WADDLING, INNATE_TRAIT, /datum/element/waddling)
	update_appearance(UPDATE_ICON)

	// For bird crime (theft).
	ai_controller.set_blackboard_key(BB_HOARD_LOCATION, get_turf(src))
	AddElement(/datum/element/dextrous, can_throw = TRUE, hands_count = 1)

/mob/living/basic/corvid/update_icon_state()
	. = ..()
	if(stat == DEAD)
		return
	if(HAS_TRAIT(src, TRAIT_MOVE_FLYING))
		icon_state = "[sprite_color]_flying"
	else if(resting)
		icon_state = "[sprite_color]_rest"
	else
		icon_state = "[sprite_color]"

/mob/living/basic/corvid/update_overlays()
	. = ..()

	/*
	var/mutable_appearance/eyes_overlay = mutable_appearance(icon, "eyes[HAS_TRAIT(src, TRAIT_MOVE_FLYING) ? "_flying" : ""]", -EYES_LAYER, src)
	eyes_overlay.color = sprite_eye_color
	. += eyes_overlay
	*/

	var/mutable_appearance/emissive_overlay = emissive_appearance(icon, "eyes[HAS_TRAIT(src, TRAIT_MOVE_FLYING) ? "_flying" : ""]", src, effect_type = EMISSIVE_SPECULAR)
	. += emissive_overlay

/datum/action/innate/togglecorvidflight // this action handles corvid forms toggle their flight, and swaps their sprite to be of the relevant type.
	name = "切换飞行"
	desc = "展开或收起翅膀，切换飞行状态。"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_IMMOBILE
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "fly"

/datum/action/innate/togglecorvidflight/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/basic/corvid/corvid = owner
	if(!istype(corvid))
		return
	// Consider giving them instant do after for moving up and down z levels but require time to get into the air
	// if(!do_after(src, 0.5 SECONDS, timed_action_flags = IGNORE_USER_LOC_CHANGE))
	// 	return
	if (!(HAS_TRAIT(corvid, TRAIT_MOVE_FLYING)))
		to_chat(corvid, span_notice("你拍打翅膀，轻盈地悬浮在地面上方……"))
		corvid.set_resting(FALSE, TRUE)
		// sadly, "is flying animal" does not give us flying traits when life() is called, only during VV or upon Init. We're doing this the hard way.
		// the corax sprites already animate up-and-down bobbing, no need to float
		corvid.add_traits(list(TRAIT_MOVE_FLYING, TRAIT_NO_FLOATING_ANIM), ACTION_TRAIT)
		corvid.remove_traits(list(TRAIT_WADDLING), INNATE_TRAIT)
		// we set this while we wait for the icons to update, otherwise there is latency
	else
		to_chat(corvid, span_notice("你轻轻落回地面……"))
		corvid.remove_traits(list(TRAIT_MOVE_FLYING, TRAIT_NO_FLOATING_ANIM), ACTION_TRAIT)
		corvid.AddElementTrait(TRAIT_WADDLING, INNATE_TRAIT, /datum/element/waddling)

	corvid.update_icon(UPDATE_ICON)


/// Master proc which will determine the intent of OUR attacks on an object and summon the relevant procs accordingly.
/// This is pretty much meant for players, AI will use the task-specific procs instead.
/mob/living/basic/corvid/early_melee_attack(atom/target, list/modifiers, ignore_cooldown)
	. = ..()
	if(.)
		return

	if(iscarbon(target) && steal_from_mob(target))
		return BASIC_MOB_END_ATTACK_CHAIN_COOLDOWN

/// Picks up an item from the ground and puts it in our claws. Returns TRUE if we picked it up, FALSE otherwise.
/mob/living/basic/corvid/put_in_hand_check(obj/item/item_to_pick_up)
	if(item_to_pick_up.w_class > WEIGHT_CLASS_SMALL)
		balloon_alert(src, "太大了，抓不起来！")
		return FALSE

	return ..()

/mob/living/basic/corvid/put_in_hand(obj/item/target, hand_index, forced = FALSE, ignore_anim = TRUE, visuals_only = FALSE)
	if(..())
		visible_message(
			span_notice("[src]抓起了[target]！"),
			span_notice("你抓起了[target]！"),
			span_hear("你听到翅膀猛烈拍打的声音。"),
		)
	return TRUE

/// Looks for an item that we can snatch and puts it in our claws. Returns TRUE if we picked it up, FALSE otherwise.
/mob/living/basic/corvid/proc/steal_from_mob(mob/living/carbon/victim)
	if(!isnull(get_active_held_item()))
		balloon_alert(src, "已经抓着东西了！")
		return FALSE

	for(var/obj/item/stealable in victim.held_items)
		if(stealable.w_class > WEIGHT_CLASS_SMALL)
			continue

		if(!victim.temporarilyRemoveItemFromInventory(stealable))
			continue

		dropItemToGround(stealable)
		visible_message(
			span_notice("[src]从[victim]手中夺走了[stealable]！"),
			span_notice("你从[victim]手中夺走了[stealable]！"),
			span_hear("你听到翅膀猛烈拍打的声音。"),
		)
		return TRUE

	return FALSE


/datum/emote/corvid
	mob_type_allowed_typecache = /mob/living/basic/corvid
	mob_type_blacklist_typecache = list()

/datum/emote/corvid/caw
	key = "caw"
	key_third_person = "caws"
	message = "嘎嘎叫了起来！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/caw.ogg'

/mob/living/basic/corvid/crow
	name = "乌鸦"
	desc = "它的尾巴呈扇形，与渡鸦不同。"

/mob/living/basic/corvid/raven
	name = "渡鸦"
	desc = "它的尾巴呈楔形，与乌鸦不同。"
	verb_say = "低哑地叫道"
	verb_exclaim = "低哑地叫道"
	speak_emote = list("低哑地叫道")

/mob/living/basic/corvid/raven/Initialize(mapload)
	. = ..()
	update_transform(1.2)
