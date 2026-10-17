/* Toys!
 * Contains
 * Balloons
 * Captain's Aid
 * Fake singularity
 * Toy gun
 * Toy swords
 * Crayons
 * Snap pops
 * AI core prizes
 * Toy codex gigas
 * Skeleton toys
 * Toy nuke
 * Fake meteor
 * Foam armblade
 * Toy big red button
 * Beach ball
 * Toy xeno
 * Kitty toys!
 * Snowballs
 * Clockwork Watches
 * Toy Daggers
 * Squeaky Brain
 * Broken Radio
 * Fake heretic codex
 * Fake Pierced Reality
 * Intento
 * Extendo hand
 * Ban hammer
 */
/obj/item/toy
	abstract_type = /obj/item/toy
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	worn_icon_state = "nothing"

	/// Can this toy be placed on the floor?
	var/floor_placeable = FALSE

/obj/item/toy/Initialize(mapload)
	. = ..()
	if(floor_placeable)
		AddElement(/datum/element/floor_placeable)

/*
 * Balloons
 */
/obj/item/toy/waterballoon
	name = "water balloon"
	desc = "A translucent balloon. There's nothing in it."
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon_red-e"
	inhand_icon_state = "balloon-empty"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/toy/waterballoon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	create_reagents(10)

/obj/item/toy/waterballoon/attack(mob/living/carbon/human/M, mob/user)
	return

/obj/item/toy/waterballoon/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!istype(interacting_with, /obj/structure/reagent_dispensers))
		return NONE
	var/obj/structure/reagent_dispensers/RD = interacting_with
	if(RD.reagents.total_volume <= 0)
		to_chat(user, span_warning("[RD] is empty."))
	else if(reagents.total_volume >= 10)
		to_chat(user, span_warning("[src] is full."))
	else
		interacting_with.reagents.trans_to(src, 10, transferred_by = user)
		to_chat(user, span_notice("You fill the balloon with the contents of [interacting_with]."))
		desc = "A translucent balloon with some form of liquid sloshing around in it."
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/item/toy/waterballoon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/cup) && tool.reagents)
		if(tool.reagents.total_volume <= 0)
			to_chat(user, span_warning("[tool] is empty."))
			return ITEM_INTERACT_BLOCKING

		if(reagents.total_volume >= 10)
			to_chat(user, span_warning("[src] is full."))
			return ITEM_INTERACT_BLOCKING

		desc = "A translucent balloon with some form of liquid sloshing around in it."
		to_chat(user, span_notice("You fill the balloon with the contents of [tool]."))
		tool.reagents.trans_to(src, 10, transferred_by = user)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(tool.get_sharpness())
		balloon_burst()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/toy/waterballoon/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		balloon_burst(hit_atom)

/obj/item/toy/waterballoon/proc/balloon_burst(atom/AT)
	if(reagents.total_volume >= 1)
		var/turf/T
		if(AT)
			T = get_turf(AT)
		else
			T = get_turf(src)
		T.visible_message(span_danger("[src] bursts!"),span_hear("You hear a pop and a splash."))
		reagents.expose(T)
		for(var/atom/A in T)
			reagents.expose(A)
		icon_state = "burst"
		qdel(src)

/obj/item/toy/waterballoon/update_icon_state()
	if(reagents.total_volume >= 1)
		icon_state = "waterballoon"
		inhand_icon_state = "balloon"
	else
		icon_state = "balloon_red-e"
		inhand_icon_state = "balloon-empty"
	return ..()

#define BALLOON_COLORS list("red", "blue", "green", "yellow", "orange", "purple")

/obj/item/toy/balloon
	name = "balloon"
	desc = "No birthday is complete without it. Sealed with a mechanical bluespace wrap so it remains floating no matter what."
	icon = 'icons/obj/toys/balloons.dmi'
	icon_state = "balloon"
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	force = 0
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.6)
	var/random_color = TRUE
	/// the string describing the name of balloon's current colour.
	var/current_color

/obj/item/toy/balloon/long
	name = "long balloon"
	desc = "A perfect balloon to contort into goofy forms. Sealed with a mechanical bluespace wrap so it remains floating no matter what."
	icon_state = "balloon_long"
	inhand_icon_state = "balloon"
	w_class = WEIGHT_CLASS_NORMAL
	/// Combinations of balloon colours to make specific animals.
	var/list/balloon_combos = list(
		list("red", "blue") = /obj/item/toy/balloon_animal/guy,
		list("red", "green") = /obj/item/toy/balloon_animal/nukie,
		list("red", "yellow") = /obj/item/toy/balloon_animal/clown,
		list("red", "orange") = /obj/item/toy/balloon_animal/cat,
		list("red", "purple") = /obj/item/toy/balloon_animal/fly,
		list("blue", "green") = /obj/item/toy/balloon_animal/podguy,
		list("blue", "yellow") = /obj/item/toy/balloon_animal/ai,
		list("blue", "orange") = /obj/item/toy/balloon_animal/dog,
		list("blue", "purple") = /obj/item/toy/balloon_animal/xeno,
		list("green", "yellow") = /obj/item/toy/balloon_animal/banana,
		list("green", "orange") = /obj/item/toy/balloon_animal/lizard,
		list("green", "purple") = /obj/item/toy/balloon_animal/slime,
		list("yellow", "orange") = /obj/item/toy/balloon_animal/moth,
		list("yellow", "purple") = /obj/item/toy/balloon_animal/ethereal,
		list("orange", "purple") = /obj/item/toy/balloon_animal/plasmaman,
	)


/obj/item/toy/balloon/long/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/balloon/long) || !HAS_TRAIT(user, TRAIT_BALLOON_SUTRA))
		return ..()

	var/obj/item/toy/balloon/long/hit_by = tool
	if(hit_by.current_color == current_color)
		to_chat(user, span_warning("You must use balloons of different colours to do that!"))
		return ITEM_INTERACT_BLOCKING
	user.visible_message(
		span_notice("[user.name] starts contorting up a balloon animal!"),
		span_notice("You start twisting together a balloon animal!"),
		span_hear("You hear balloons being contorted."),
		vision_distance = 3,
		ignored_mobs = user,
	)
	for(var/list/pair_of_colors in balloon_combos)
		if((hit_by.current_color == pair_of_colors[1] && current_color == pair_of_colors[2]) || (current_color == pair_of_colors[1] && hit_by.current_color == pair_of_colors[2]))
			var/path_to_spawn = balloon_combos[pair_of_colors]
			user.put_in_hands(new path_to_spawn)
			break
	qdel(hit_by)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/ammo_casing/foam_dart) || !HAS_TRAIT(user, TRAIT_SIMIAN))
		return NONE
	pop_balloon(monkey_pop = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/balloon/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	var/mob/thrower = throwingdatum?.get_thrower()
	if(HAS_TRAIT(thrower, TRAIT_SIMIAN) && istype(AM, /obj/item/ammo_casing/foam_dart))
		pop_balloon(monkey_pop = TRUE)
	else
		return ..()

/obj/item/toy/balloon/bullet_act(obj/projectile/proj)
	if((istype(proj, /obj/projectile/bullet/p50) || istype(proj,/obj/projectile/bullet/foam_dart)) && HAS_TRAIT(proj.firer, TRAIT_SIMIAN))
		pop_balloon(monkey_pop = TRUE)
		return BULLET_ACT_HIT
	return ..()

/obj/item/toy/balloon/proc/pop_balloon(monkey_pop = FALSE)
	playsound(src, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 50, vary = TRUE)
	if(monkey_pop) // Monkeys make money from popping bloons
		new /obj/item/coin/iron(get_turf(src))
	qdel(src)

/obj/item/toy/balloon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!random_color)
		return
	current_color = pick(BALLOON_COLORS)
	update_appearance()

/obj/item/toy/balloon/update_name(updates)
	. = ..()
	name = "[current_color ? "[current_color] ":null][initial(name)]"

/obj/item/toy/balloon/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, current_color))
		update_appearance()

/obj/item/toy/balloon/update_icon_state()
	. = ..()
	var/new_icon = "[initial(icon_state)][current_color ? "_[current_color]":null]"
	inhand_icon_state = new_icon
	icon_state = "[new_icon][isturf(loc) ? null : "_storage"]"

/obj/item/toy/balloon/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()
	update_appearance()

/obj/item/toy/balloon/corgi
	name = "corgi balloon"
	desc = "A balloon in the shape of a corgi's head. For the all year good boys."
	icon_state = "corgi"
	inhand_icon_state = "corgi"
	random_color = FALSE

/obj/item/toy/balloon/heart
	name = "heart balloon"
	desc = "A balloon in the shape of a heart. How lovely"
	icon_state = "heart"
	inhand_icon_state = "heart"
	random_color = FALSE

/obj/item/toy/balloon/syndicate
	name = "辛迪加气球"
	desc = "背面的标签上写着\"去他妈的纳诺传讯！11！\"。"
	icon_state = "syndballoon"
	inhand_icon_state = "syndballoon"
	random_color = FALSE

/obj/item/toy/balloon/syndicate/pickup(mob/living/user)
	. = ..()
	if(user && user.mind && user.mind.has_antag_datum(/datum/antagonist, TRUE))
		user.add_mood_event("badass_antag", /datum/mood_event/badass_antag)

/obj/item/toy/balloon/syndicate/dropped(mob/living/user)
	if(user)
		user.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/syndicate/Destroy()
	if(ismob(loc))
		var/mob/living/M = loc
		M.clear_mood_event("badass_antag")
	. = ..()

/obj/item/toy/balloon/arrest
	name = "arreyst balloon"
	desc = "A half inflated balloon about a boyband named Arreyst that was popular about ten years ago, famous for making fun of red jumpsuits as unfashionable."
	icon_state = "arrestballoon"
	inhand_icon_state = "arrestballoon"
	random_color = FALSE

#undef BALLOON_COLORS

/*
* Balloon animals
*/

/obj/item/toy/balloon_animal
	name = "balloon animal"
	desc = "You shouldn't have this."
	icon = 'icons/obj/toys/balloons.dmi'
	inhand_icon_state = "balloon"
	lefthand_file = 'icons/mob/inhands/items/balloons_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/balloons_righthand.dmi'
	abstract_type = /obj/item/toy/balloon_animal
	throwforce = 0
	throw_speed = 2
	throw_range = 5
	force = 0
	floor_placeable = TRUE

/obj/item/toy/balloon_animal/guy
	name = "balloon guy"
	desc = "A balloon effigy of the everyday standard issue human guy. Wonder if he pays balloon taxes. He probably evades them."
	icon_state = "balloon_guy"

/obj/item/toy/balloon_animal/nukie
	name = "balloon nukie"
	desc = "A balloon effigy of syndicate's nuclear operative. Either made to appease them and pray for survival, or to poke fun at them."
	icon_state = "balloon_nukie"

/obj/item/toy/balloon_animal/clown
	name = "balloon clown"
	desc = "A balloon clown, smiling from ear to ear and beyond!"
	icon_state = "balloon_clown"

/obj/item/toy/balloon_animal/cat
	name = "balloon cat"
	desc = "Without the sharp claws, balloon cats are possibly cuter than their live counterparts, though not as relatable, warm and fuzzy."
	icon_state = "balloon_cat"

/obj/item/toy/balloon_animal/fly
	name = "balloon fly"
	desc = "A balloon effigy of a flyperson. Thankfully, it doesn't come with balloon vomit."
	icon_state = "balloon_fly"

/obj/item/toy/balloon_animal/podguy
	name = "balloon podguy"
	desc = "A balloon effigy of a podperson. Though, actual podpeople have heads and not stalks and leaves."
	icon_state = "balloon_podguy"

/obj/item/toy/balloon_animal/ai
	name = "balloon ai core"
	desc = "A somewhat unrealistic balloon effigy of the station's AI core. Actual AI probably wouldn't smile like this."
	icon_state = "balloon_ai"

/obj/item/toy/balloon_animal/dog
	name = "balloon dog"
	desc = "A balloon effigy of the best boy. It cannot truly compare, but it makes an effort."
	icon_state = "balloon_dog"

/obj/item/toy/balloon_animal/xeno
	name = "balloon xeno"
	desc = "A balloon effigy of a spooky xeno! Too squishy to scare anyone itself, though."
	icon_state = "balloon_xeno"

/obj/item/toy/balloon_animal/banana
	name = "balloon banana"
	desc = "A balloon banana. This one can't be slipped on. Good for psychological warfare, though."
	icon_state = "balloon_banana"

/obj/item/toy/balloon_animal/lizard
	name = "balloon lizard"
	desc = "A balloon effigy of a lizard. One of the first species to adapt to clown planet's culture. Perhaps because they are naturally laughable?"
	icon_state = "balloon_lizard"

/obj/item/toy/balloon_animal/slime
	name = "balloon slime"
	desc = "A balloon effigy of single specimen of the galaxy-wide slime scourge, of purple variety. Slimes tried to invade clown planet once. They got quickly washed out by water-spitting flowers, though."
	icon_state = "balloon_slime"

/obj/item/toy/balloon_animal/moth
	name = "balloon moth"
	desc = "A balloon effigy of a common member of moth flotillas. Very few of them ever decide to settle on the clown planet, but those who do have the best 'piece-of-cloth-disappearing' acts."
	icon_state = "balloon_moth"

/obj/item/toy/balloon_animal/ethereal
	name = "balloon ethereal"
	desc = "A balloon effigy of an ethereal artisan. Clownery is one form of art, and as such, ethereals were both drawn to and readily accepted at clown planet. Don't mind the lighbulb head, it's art too."
	icon_state = "balloon_ethereal"

/obj/item/toy/balloon_animal/plasmaman
	name = "balloon plasmaman"
	desc = "A balloon effigy of a plasmaman. Among the rarest on the clown planet, only having appeared recently thanks to ready trade between clown planet and NT."
	icon_state = "balloon_plasmaman"


/*
* Captain's Aid
*/
#define CAPTAINSAID_MODE_OFF 1

/obj/item/toy/captainsaid
	name = "\improper 站长好帮手"
	desc = "每位站长探索浩瀚虚空时的最佳伙伴，如今配备彩色显示屏！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "captainsaid_off"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// List of modes it can cycle through
	var/list/modes = list(
		"off",
		"port",
		"starboard",
		"fore",
		"aft",
	)
	/// Current mode of the item, changed when cycling through modes
	var/current_mode = CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/examine_more(mob/user)
	. = ..()
	. += span_notice("你敢发誓，那个平板版'即将推出'的广告，你已经听了快三年了……")

/obj/item/toy/captainsaid/attack_self(mob/living/user)
	current_mode++
	playsound(src, 'sound/items/tools/screwdriver2.ogg', 50, vary = TRUE)
	if (current_mode <= modes.len)
		balloon_alert(user, "已设为模式[current_mode]")
	else
		balloon_alert(user, "已关闭")
		current_mode = CAPTAINSAID_MODE_OFF
	icon_state = "captainsaid_[modes[current_mode]]"
	update_appearance(UPDATE_ICON)

#undef CAPTAINSAID_MODE_OFF

/obj/item/toy/captainsaid/collector
	name = "\improper Collector's Edition Captain's Aid"
	desc = "A copy of the first run of Captain's Aid ever released. Functionally the same as the later batches, just more expensive. For the truly aristocratic."

/*
 * Fake singularity
 */
/obj/item/toy/spinningtoy
	name = "gravitational singularity"
	desc = "\"Singulo\" brand spinning toy."
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "singularity_s1"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/spinningtoy/suicide_act(mob/living/user)
	if (!iscarbon(user))
		user.visible_message(span_suicide("[user] consumes [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
		user.spin(8 SECONDS, 1)
		return BRUTELOSS
	var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
	if(!myhead)
		user.visible_message(span_suicide("[user] tries consuming [src]... but [user.p_they()] [user.p_have()] no mouth!")) // and i must scream
		return SHAME
	user.visible_message(span_suicide("[user] consumes [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	playsound(user, 'sound/items/eatfood.ogg', 50, TRUE)
	user.adjust_nutrition(50) // mmmm delicious
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), (3 SECONDS))
	return MANUAL_SUICIDE

/**
 * Internal function used in the toy singularity suicide
 *
 * Cavity implants the toy singularity into the body of the user (arg1), and kills the user.
 * Makes the user vomit and receive 120 suffocation damage if there already is a cavity implant in the user.
 * Throwing the singularity away will cause the user to start choking themself to death.
 * Arguments:
 * * user - Whoever is doing the suiciding
 */
/obj/item/toy/spinningtoy/proc/manual_suicide(mob/living/carbon/human/user)
	if(!user)
		return
	if(!user.is_holding(src)) // Half digestion? Start choking to death
		user.visible_message(span_suicide("[user] panics and starts choking [user.p_them()]self to death!"))
		user.adjust_oxy_loss(200)
		user.death(FALSE) // unfortunately you have to handle the suiciding yourself with a manual suicide
		user.ghostize(FALSE) // get the fuck out of our body
		return
	var/obj/item/bodypart/chest/CH = user.get_bodypart(BODY_ZONE_CHEST)
	if(CH.cavity_item) // if he's (un)bright enough to have a round and full belly...
		user.visible_message(span_danger("[user] regurgitates [src]!")) // I swear i dont have a fetish
		user.vomit(VOMIT_CATEGORY_BLOOD, lost_nutrition = 100, distance = 0)
		user.adjust_oxy_loss(120)
		user.dropItemToGround(src) // incase the crit state doesn't drop the singulo to the floor
		user.set_suicide(FALSE)
		return
	user.transferItemToLoc(src, user, TRUE)
	CH.cavity_item = src // The mother came inside and found Andy, dead with a HUGE belly full of toys
	user.adjust_oxy_loss(200) // You know how most small toys in the EU have that 3+ onion head icon and a warning that says "Unsuitable for children under 3 years of age due to small parts - choking hazard"? This is why.
	user.death(FALSE)
	user.ghostize(FALSE)

/*
 * Fake dark matter singularity!
 */
/obj/item/toy/spinningtoy/dark_matter
	name = "dark matter singularity"
	desc = "<i>\"Surviving the encounter with the \
		horrible thing, I realized immediately what I \
		had to do: sell marketable toys of it. \
		\"</i><br>- Chief Engineer Tenshin Nakamura"
	icon = 'icons/obj/machines/engine/singularity.dmi'
	icon_state = "dark_matter_s1"

/*
 * Toy gun: Why isn't this an /obj/item/gun?
 */
/obj/item/toy/gun
	name = "cap gun"
	desc = "Looks almost like the real thing! Ages 8 and up. Please recycle in an autolathe when you're out of caps."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "revolver"
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = SMALL_MATERIAL_AMOUNT)
	attack_verb_continuous = list("strikes", "pistol whips", "hits", "bashes")
	attack_verb_simple = list("strike", "pistol whip", "hit", "bash")
	var/bullets = 7

/obj/item/toy/gun/examine(mob/user)
	. = ..()
	. += "There [bullets == 1 ? "is" : "are"] [bullets] cap\s left."

/obj/item/toy/gun/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(!istype(tool, /obj/item/toy/ammo/gun))
		return NONE
	var/obj/item/toy/ammo/gun/ammunition = tool
	if (bullets >= 7)
		to_chat(user, span_warning("It's already fully loaded!"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left <= 0)
		to_chat(user, span_warning("There are no more caps!"))
		return ITEM_INTERACT_BLOCKING
	if (ammunition.amount_left < (7 - bullets))
		bullets += ammunition.amount_left
		to_chat(user, span_notice("You reload [ammunition.amount_left] cap\s."))
		ammunition.amount_left = 0
	else
		to_chat(user, span_notice("You reload [7 - bullets] cap\s."))
		ammunition.amount_left -= 7 - bullets
		bullets = 7
	tool.update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/gun/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("You don't have the dexterity to do this!"))
		return ITEM_INTERACT_BLOCKING
	add_fingerprint(user)
	if (bullets < 1)
		user.show_message(span_warning("*click*"), MSG_AUDIBLE)
		playsound(src, 'sound/items/weapons/gun/revolver/dry_fire.ogg', 30, TRUE)
		return ITEM_INTERACT_SUCCESS
	playsound(user, 'sound/items/weapons/gun/revolver/shot.ogg', 100, TRUE)
	bullets--
	user.visible_message(span_danger("[user] fires [src] at [interacting_with]!"), \
		span_danger("You fire [src] at [interacting_with]!"), \
		span_hear("You hear a gunshot!"))
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/ammo
	abstract_type = /obj/item/toy/ammo

/obj/item/toy/ammo/gun
	name = "capgun ammo"
	desc = "Make sure to recycle the box in an autolathe when it gets empty."
	icon = 'icons/obj/weapons/guns/ammo.dmi'
	icon_state = "357OLD-7"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)
	var/amount_left = 7

/obj/item/toy/ammo/gun/update_icon_state()
	icon_state = "357OLD-[amount_left]"
	return ..()

/obj/item/toy/ammo/gun/examine(mob/user)
	. = ..()
	. += "There [amount_left == 1 ? "is" : "are"] [amount_left] cap\s left."

/*
 * Toy swords
 */
/obj/item/toy/sword
	name = "玩具剑"
	desc = "能量剑的廉价塑料仿制品。音效逼真！适合8岁及以上儿童。"
	icon_state = "e_sword"
	inhand_icon_state = "e_sword"
	icon_angle = -45
	icon = 'icons/obj/weapons/transforming_energy.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("attacks", "strikes", "hits")
	attack_verb_simple = list("attack", "strike", "hit")
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 4, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 1.1, /datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1)
	/// Whether our sword has been multitooled to rainbow
	var/hacked = FALSE
	/// The color of our fake energy sword
	var/saber_color = "blue"

/obj/item/toy/sword/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		throw_speed_on = throw_speed, \
		hitsound_on = hitsound, \
		clumsy_check = FALSE, \
		inhand_icon_change = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	AddElement(/datum/element/update_icon_updates_onmob)

	var/static/list/tool_behaviors = list(
		TOOL_SCREWDRIVER = list(
			SCREENTIP_CONTEXT_LMB = "Change blade color"
		),
	)
	AddElement(/datum/element/contextual_screentip_tools, tool_behaviors)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Updates our icon to have the correct color, and give some feedback.
 */
/obj/item/toy/sword/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, "[active ? "弹出":"收起"][src]")

	playsound(src, active ? 'sound/items/weapons/saberon.ogg' : 'sound/items/weapons/saberoff.ogg', 20, TRUE)
	update_appearance(UPDATE_ICON)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/toy/sword/examine(mob/user)
	. = ..()
	. += span_notice("灯光旋钮目前设为[list("red" = "红色", "blue" = "蓝色", "green" = "绿色", "purple" = "紫色", "rainbow" = "彩虹色")[saber_color] || saber_color]，似乎能用<b>螺丝刀</b>转动。")

/obj/item/toy/sword/screwdriver_act(mob/living/user, obj/item/tool)
	switch(saber_color)
		if("red")
			saber_color = "blue"
		if("blue")
			saber_color = "green"
		if("green")
			saber_color = "purple"
		if("purple")
			saber_color = "red"
		else
			return ITEM_INTERACT_SUCCESS
	balloon_alert(user, "已改为[list("red" = "红色", "blue" = "蓝色", "green" = "绿色", "purple" = "紫色")[saber_color] || saber_color]")
	update_appearance(UPDATE_ICON)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/sword/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, saber_color))
		update_appearance(UPDATE_ICON)

/obj/item/toy/sword/update_icon_state()
	. = ..()
	var/last_part = HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "_on[saber_color ? "_[saber_color]" : null]" : null
	icon_state = "[initial(icon_state)][last_part]"
	inhand_icon_state = "[initial(inhand_icon_state)][last_part]"

/obj/item/toy/sword/multitool_act(mob/living/user, obj/item/tool)
	if(hacked)
		to_chat(user, span_warning("已经够绚丽了！"))
		return
	hacked = TRUE
	saber_color = "rainbow"
	to_chat(user, span_warning("彩虹模式启动"))
	update_appearance(UPDATE_ICON)

/obj/item/toy/sword/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/sword))
		return NONE
	var/obj/item/toy/sword/attatched_sword = tool
	if(HAS_TRAIT(tool, TRAIT_NODROP))
		to_chat(user, span_warning("[tool]粘在你手上了，无法把它装到[src]上！"))
		return ITEM_INTERACT_BLOCKING
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_warning("[src]粘在你手上了，无法把它装到[tool]上！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把两把塑料剑的尾部接在一起，做成了一把双刃玩具剑！你可真会装酷。"))
	var/obj/item/dualsaber/toy/new_saber = new /obj/item/dualsaber/toy(user.loc)
	if(attatched_sword.hacked || hacked)
		new_saber.hacked = TRUE
		new_saber.saber_color = "rainbow"
	qdel(tool)
	qdel(src)
	user.put_in_hands(new_saber)
	return ITEM_INTERACT_SUCCESS

/*
 * Foam armblade
 */
/obj/item/toy/foamblade
	name = "泡沫臂刃"
	desc = "上面写着\"艉区异形头号粉丝\"。"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "foamblade"
	inhand_icon_state = "arm_blade"
	icon_angle = -180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	attack_verb_continuous = list("pricks", "absorbs", "gores")
	attack_verb_simple = list("prick", "absorb", "gore")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/windup_toolbox
	name = "windup toolbox"
	desc = "A replica toolbox that rumbles when you turn the key."
	icon = 'icons/obj/storage/toolbox.dmi'
	icon_state = "green"
	inhand_icon_state = "toolbox_green"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	hitsound = 'sound/items/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox/toolbox_pickup.ogg'
	attack_verb_continuous = list("robusts")
	attack_verb_simple = list("robust")
	var/active = FALSE

/obj/item/toy/windup_toolbox/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/toy/windup_toolbox/update_overlays()
	. = ..()
	if(active)
		. += "single_latch_open"
	else
		. += "single_latch"

/obj/item/toy/windup_toolbox/attack_self(mob/user)
	if(!active)
		to_chat(user, span_notice("You wind up [src], it begins to rumble."))
		active = TRUE
		update_appearance()
		playsound(src, 'sound/effects/pope_entry.ogg', 100)
		Rumble()
		addtimer(CALLBACK(src, PROC_REF(stopRumble)), 60 SECONDS)
	else
		to_chat(user, span_warning("[src] is already active!"))

/obj/item/toy/windup_toolbox/proc/Rumble()
	var/static/list/transforms
	if(!transforms)
		var/matrix/M1 = matrix()
		var/matrix/M2 = matrix()
		var/matrix/M3 = matrix()
		var/matrix/M4 = matrix()
		M1.Translate(-1, 0)
		M2.Translate(0, 1)
		M3.Translate(1, 0)
		M4.Translate(0, -1)
		transforms = list(M1, M2, M3, M4)
	animate(src, transform=transforms[1], time=0.2, loop=-1)
	animate(transform=transforms[2], time=0.1)
	animate(transform=transforms[3], time=0.2)
	animate(transform=transforms[4], time=0.3)

/obj/item/toy/windup_toolbox/proc/stopRumble()
	active = FALSE
	update_appearance()
	visible_message(span_warning("[src] slowly stops rattling and falls still, its latch snapping shut.")) //subtle difference
	playsound(loc, 'sound/items/weapons/batonextend.ogg', 100, TRUE)
	animate(src, transform = matrix())

/*
 * Subtype of Double-Bladed Energy Swords
 */
/obj/item/dualsaber/toy
	name = "双刃玩具剑"
	desc = "两把能量剑的廉价塑料仿制品。双倍快乐！"
	force = 0
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	two_hand_force = 0
	attack_verb_continuous = list("attacks", "strikes", "hits")
	attack_verb_simple = list("attack", "strike", "hit")

/obj/item/dualsaber/toy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	return 0

/obj/item/dualsaber/toy/IsReflect() //Stops Toy Dualsabers from reflecting energy projectiles
	return 0

/obj/item/dualsaber/toy/impale(mob/living/user)//Stops Toy Dualsabers from injuring clowns
	to_chat(user, span_warning("你转了几圈，随后失去平衡，把自己戳在了[src]上。"))
	user.adjust_stamina_loss(25)

/obj/item/toy/katana
	name = "replica katana"
	desc = "Woefully underpowered in D20."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "katana"
	inhand_icon_state = "katana"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "slices")
	attack_verb_simple = list("attack", "slash", "slice")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT)
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/toy/katana/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)

/*
 * Snap pops
 */
/obj/item/toy/snappop
	name = "摔炮"
	desc = "哇！"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snappop"
	w_class = WEIGHT_CLASS_TINY
	var/ash_type = /obj/effect/decal/cleanable/ash

/obj/item/toy/snappop/proc/pop_burst(n = 3, c = TRUE)
	do_sparks(n, c, src)
	new ash_type(loc)
	visible_message(span_warning("[src]炸响了！"),
		span_hear("你听到啪的一声！"))
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
	qdel(src)

/obj/item/toy/snappop/fire_act(exposed_temperature, exposed_volume)
	pop_burst()

/obj/item/toy/snappop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		pop_burst()

/obj/item/toy/snappop/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/toy/snappop/proc/on_entered(datum/source, H as mob|obj)
	SIGNAL_HANDLER
	if(ishuman(H) || issilicon(H)) //i guess carp and shit shouldn't set them off
		var/mob/living/carbon/M = H
		if(issilicon(H) || M.move_intent == MOVE_INTENT_RUN)
			to_chat(M, span_danger("你踩到了摔炮！"))
			pop_burst(2, 0)

/obj/item/toy/snappop/phoenix
	name = "phoenix snap pop"
	desc = "Wow! And wow! And wow!"
	ash_type = /obj/effect/decal/cleanable/ash/snappop_phoenix

/obj/effect/decal/cleanable/ash/snappop_phoenix
	var/respawn_time = 300

/obj/effect/decal/cleanable/ash/snappop_phoenix/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(respawn)), respawn_time)

/obj/effect/decal/cleanable/ash/snappop_phoenix/proc/respawn()
	new /obj/item/toy/snappop/phoenix(get_turf(src))
	qdel(src)

/obj/item/toy/talking
	name = "talking action figure"
	desc = "A generic action figure modeled after nothing in particular."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "owlprize"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = FALSE
	var/messages = list("I'm super generic!", "Mathematics class is of variable difficulty!")
	var/span = "danger"
	var/recharge_time = 30

	var/chattering = FALSE
	var/phomeme

// Talking toys are language universal, and thus all species can use them
/obj/item/toy/talking/attack_alien(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/item/toy/talking/attack_self(mob/user)
	if(!cooldown)
		activation_message(user)
		playsound(loc, 'sound/machines/click.ogg', 20, TRUE)

		INVOKE_ASYNC(src, PROC_REF(do_toy_talk), user)

		cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, cooldown, FALSE), recharge_time)
		return
	..()

/obj/item/toy/talking/proc/activation_message(mob/user)
	user.visible_message(
		span_notice("[user] pulls the string on \the [src]."),
		span_notice("You pull the string on \the [src]."),
		span_notice("You hear a string being pulled."))

/obj/item/toy/talking/proc/generate_messages()
	return list(pick(messages))

/obj/item/toy/talking/proc/do_toy_talk(mob/user)
	for(var/message in generate_messages())
		toy_talk(user, message)
		sleep(1 SECONDS)

/obj/item/toy/talking/proc/toy_talk(mob/user, message)
	say(message, spans = list(span))
	if(chattering)
		chatter(message, phomeme, user)

/*
 * AI core prizes
 */
/obj/item/toy/talking/ai
	name = "toy AI"
	desc = "A little toy model AI core with real law announcing action!"
	icon_state = "AI"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/ai/generate_messages()
	return list(generate_ion_law())

/obj/item/toy/talking/codex_gigas
	name = "Toy Codex Gigas"
	desc = "A tool to help you write fictional devils!"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "demonomicon"
	inhand_icon_state = "demonomicon"
	lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	messages = list("You must challenge the devil to a dance-off!", "The devils true name is Ian", "The devil hates salt!", "Would you like infinite power?", "Would you like infinite wisdom?", "Would you like infinite healing?")
	w_class = WEIGHT_CLASS_SMALL
	recharge_time = 60

/obj/item/toy/talking/codex_gigas/activation_message(mob/user)
	user.visible_message(
		span_notice("[user] presses the button on \the [src]."),
		span_notice("You press the button on \the [src]."),
		span_notice("You hear a soft click."))

/obj/item/toy/talking/owl
	name = "owl action figure"
	desc = "An action figure modeled after 'The Owl', defender of justice."
	icon_state = "owlprize"
	messages = list("You won't get away this time, Griffin!", "Stop right there, criminal!", "Hoot! Hoot!", "I am the night!")
	chattering = TRUE
	phomeme = "owl"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/talking/griffin
	name = "griffin action figure"
	desc = "An action figure modeled after 'The Griffin', criminal mastermind."
	icon_state = "griffinprize"
	messages = list("You can't stop me, Owl!", "My plan is flawless! The vault is mine!", "Caaaawwww!", "You will never catch me!")
	chattering = TRUE
	phomeme = "griffin"
	w_class = WEIGHT_CLASS_SMALL

/*
 * Fake nuke
 */
/obj/item/toy/nuke
	name = "\improper Nuclear Fission Explosive toy"
	desc = "A plastic model of a Nuclear Fission Explosive."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoyidle"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/nuke/attack_self(mob/user)
	if (obj_flags & EMAGGED && cooldown < world.time)
		cooldown = world.time + 600
		user.audible_message(span_hear("You hear the click of a button."), self_message = span_notice("You activate [src], it plays a loud noise!"))
		sleep(0.5 SECONDS)
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(14 SECONDS)
		user.visible_message(span_alert("[src] violently explodes!"))
		explosion(src, light_impact_range = 1)
		qdel(src)
	else if (cooldown < world.time)
		cooldown = world.time + 600 //1 minute
		user.visible_message(span_warning("[user] presses a button on [src]."), span_notice("You activate [src], it plays a loud noise!"), span_hear("You hear the click of a button."))
		sleep(0.5 SECONDS)
		icon_state = "nuketoy"
		playsound(src, 'sound/announcer/alarm/nuke_alarm.ogg', 20, FALSE)
		sleep(13.5 SECONDS)
		icon_state = "nuketoycool"
		sleep(cooldown - world.time)
		icon_state = "nuketoyidle"
	else
		var/timeleft = (cooldown - world.time)
		to_chat(user, span_alert("Nothing happens, and '</span>[round(timeleft/10)]<span class='alert'>' appears on the small display."))
		sleep(0.5 SECONDS)

/obj/item/toy/nuke/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "explosive simulation enabled")
	obj_flags |= EMAGGED
	return TRUE

/*
 * Fake meteor
 */
/obj/item/toy/minimeteor
	name = "\improper Mini-Meteor"
	desc = "Relive the excitement of a meteor shower! SweetMeat-eor Co. is not responsible for any injuries, headaches or hearing loss caused by Mini-Meteor."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "minimeteor"
	inhand_icon_state = "minimeteor"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE

/obj/item/toy/minimeteor/emag_act(mob/user, obj/item/card/emag/emag_card)
	if (obj_flags & EMAGGED)
		return FALSE
	to_chat(user, span_warning("You short circuit whatever electronics exist inside. The \"meteor\" suddenly feels a lot heavier...?"))
	// not adding a balloon alert here since its hard to actually describe what this emag does in the balloon
	obj_flags |= EMAGGED
	return TRUE

/obj/item/toy/minimeteor/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(src, 'sound/effects/meteorimpact.ogg', 40, TRUE)
	for(var/mob/M in urange(10, src))
		if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M))
			shake_camera(M, 3, 1)
	if (obj_flags & EMAGGED)
		explosion(src, devastation_range = -1, heavy_impact_range = -1, light_impact_range = 1)

/*
 * Toy big red button
 */
/obj/item/toy/redbutton
	name = "big red button"
	desc = "A big, plastic red button. Reads 'From HonkCo Pranks!' on the back."
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bigred"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/redbutton/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = (world.time + 300) // Sets cooldown at 30 seconds
		user.visible_message(span_warning("[user] presses the big red button."), span_notice("You press the button, it plays a loud noise!"), span_hear("The button clicks loudly."))
		playsound(src, 'sound/effects/explosion/explosionfar.ogg', 50, FALSE)
		for(var/mob/M in urange(10, src)) // Checks range
			if(!IS_UNCONSCIOUS_OR_CRIT(M) && !isAI(M)) // Checks to make sure whoever's getting shaken is alive/not the AI
				// Short delay to match up with the explosion sound
				// Shakes player camera 2 squares for 1 second.
				addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(shake_camera), M, 2, 1), 0.8 SECONDS)

	else
		to_chat(user, span_alert("Nothing happens."))

/*
 * Snowballs
 */
/obj/item/toy/snowball
	name = "snowball"
	desc = "A compact ball of snow. Good for throwing at people."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "snowball"
	throwforce = 20 //the same damage as a disabler shot
	damtype = STAMINA //maybe someday we can add stuffing rocks (or perhaps ore?) into snowballs to make them deal brute damage
	custom_materials = list(/datum/material/snow = SHEET_MATERIAL_AMOUNT)

/obj/item/toy/snowball/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	user.throw_item(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/toy/snowball/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..())
		playsound(src, 'sound/effects/pop.ogg', 20, TRUE)
		qdel(src)

/*
 * Beach ball
 */
/obj/item/toy/beach_ball
	name = "beach ball"
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "ball"
	inhand_icon_state = "beachball"
	w_class = WEIGHT_CLASS_BULKY //Stops people from hiding it in their bags/pockets
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/beach_ball/branded
	name = "\improper Nanotrasen-brand beach ball"
	desc = "The simple beach ball is one of Nanotrasen's most popular products. 'Why do we make beach balls? Because we can! (TM)' - Nanotrasen"

/obj/item/toy/beach_ball/baseball
	name = "baseball"
	desc = "Enter the world of concussions and become who you were destined to be."
	icon = 'icons/obj/toys/balls.dmi'
	icon_state = "baseball"
	inhand_icon_state = "baseball"
	w_class = WEIGHT_CLASS_SMALL
	throw_range = 9
	throw_speed = 0.5

/*
 * Clockwork Watch
 */
/obj/item/toy/clockwork_watch
	name = "steampunk watch"
	desc = "A stylish steampunk watch made out of thousands of tiny cogwheels."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "dread_ipad"
	worn_icon_state = "dread_ipad"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/clockwork_watch/attack_self(mob/user)
	if (cooldown < world.time)
		cooldown = world.time + 1800 //3 minutes
		user.visible_message(span_warning("[user] rotates a cogwheel on [src]."), span_notice("You rotate a cogwheel on [src], it plays a loud noise!"), span_hear("You hear cogwheels turning."))
		playsound(src, 'sound/effects/magic/clockwork/ark_activation.ogg', 50, FALSE)
	else
		to_chat(user, span_alert("The cogwheels are already turning!"))

/obj/item/toy/clockwork_watch/examine(mob/user)
	. = ..()
	. += span_info("Station Time: [server_timestamp(ic_time = TRUE, twelve_hour_clock = user.client?.prefs.read_preference(/datum/preference/toggle/twelve_hour))]")
	if(user.is_literate())
		. += span_info("That means it is currently [round_timestamp()] into the shift.")

/*
 * Toy Dagger
 */
/obj/item/toy/toy_dagger
	name = "toy dagger"
	desc = "A cheap plastic replica of a dagger. Produced by THE ARM Toys, Inc."
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "render"
	inhand_icon_state = "cultdagger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

/*
 * Xenomorph action figure
 */
/obj/item/toy/toy_xeno
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_xeno"
	name = "xenomorph action figure"
	desc = "MEGA presents the new Xenos Isolated action figure! Comes complete with realistic sounds! Pull back string to use."
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0

/obj/item/toy/toy_xeno/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 50) //5 second cooldown
		user.visible_message(span_notice("[user] pulls back the string on [src]."))
		icon_state = "[initial(icon_state)]_used"
		sleep(0.5 SECONDS)
		audible_message(span_danger("[icon2html(src, viewers(src))] Hiss!"))
		var/list/possible_sounds = list('sound/mobs/non-humanoids/hiss/hiss1.ogg', 'sound/mobs/non-humanoids/hiss/hiss2.ogg', 'sound/mobs/non-humanoids/hiss/hiss3.ogg', 'sound/mobs/non-humanoids/hiss/hiss4.ogg')
		var/chosen_sound = pick(possible_sounds)
		playsound(get_turf(src), chosen_sound, 50, TRUE)
		addtimer(VARSET_CALLBACK(src, icon_state, "[initial(icon_state)]"), 4.5 SECONDS)
	else
		to_chat(user, span_warning("The string on [src] hasn't rewound all the way!"))
		return

// TOY MOUSEYS :3 :3 :3
/obj/item/toy/cattoy
	name = "toy mouse"
	desc = "A colorful toy mouse!"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "toy_mouse"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	floor_placeable = TRUE


/*
 * Action Figures
 */
/obj/item/toy/figure
	name = "\improper 普通角色手办"
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "nuketoy"
	w_class = WEIGHT_CLASS_SMALL
	floor_placeable = TRUE
	var/cooldown = 0
	var/toysay = "你他妈干了什么？"
	var/toysound = 'sound/machines/click.ogg'

/obj/item/toy/figure/Initialize(mapload)
	. = ..()
	desc = "黑犬游戏工厂出品的[src]。" // DARKPACK EDIT CHANGE
	AddElement(/datum/element/toy_talk)

/obj/item/toy/figure/attack_self(mob/user as mob)
	if(cooldown <= world.time)
		cooldown = world.time + 50
		to_chat(user, span_notice("[src]说：“[toysay]”"))
		playsound(user, toysound, 20, TRUE)

/obj/item/toy/figure/cmo
	name = "\improper 医疗主管手办"
	icon_state = "cmo"
	toysay = "打开制服传感器！"

/obj/item/toy/figure/assistant
	name = "\improper 助理手办"
	icon_state = "assistant"
	inhand_icon_state = "assistant"
	toysay = "灰潮席卷全球！"

/obj/item/toy/figure/atmos
	name = "\improper 大气技师手办"
	icon_state = "atmos"
	toysay = "荣耀归于大气之国！"

/obj/item/toy/figure/bartender
	name = "\improper 调酒师手办"
	icon_state = "bartender"
	toysay = "庞庞在哪儿？"

/obj/item/toy/figure/bitrunner
	name = "\improper 比特潜行者手办"
	icon_state = "bitrunner"
	toysay = "我进来了……"

/obj/item/toy/figure/borg
	name = "\improper 机器人手办"
	icon_state = "borg"
	toysay = "我。又。活了。"
	toysound = 'sound/mobs/non-humanoids/cyborg/liveagain.ogg'

/obj/item/toy/figure/botanist
	name = "\improper 植物学家手办"
	icon_state = "botanist"
	toysay = "抽起来！"

/obj/item/toy/figure/captain
	name = "\improper 站长手办"
	icon_state = "captain"
	toysay = "有部门主管在吗？"

/obj/item/toy/figure/cargotech
	name = "\improper 货运技师手办"
	icon_state = "cargotech"
	toysay = "为了货运国！"

/obj/item/toy/figure/ce
	name = "\improper 总工程师手办"
	icon_state = "ce"
	toysay = "给太阳能板接线！"

/obj/item/toy/figure/chaplain
	name = "\improper 随站牧师手办"
	icon_state = "chaplain"
	toysay = "赞美太空耶稣！"

/obj/item/toy/figure/chef
	name = "\improper 厨师手办"
	icon_state = "chef"
	toysay = "我要把你做成汉堡！"

/obj/item/toy/figure/chemist
	name = "\improper 化学家手办"
	icon_state = "chemist"
	toysay = "快来领药！"

/obj/item/toy/figure/clown
	name = "\improper 小丑手办"
	icon_state = "clown"
	toysay = "Honk!"
	toysound = 'sound/items/bikehorn.ogg'

/obj/item/toy/figure/ian
	name = "\improper 伊恩手办"
	icon_state = "ian"
	toysay = "汪！"

/obj/item/toy/figure/detective
	name = "\improper 侦探手办"
	icon_state = "detective"
	toysay = "这扇气闸上有灰色连体服和绝缘手套的纤维。"

/obj/item/toy/figure/dsquad
	name = "\improper 死亡小队队员手办"
	icon_state = "dsquad"
	toysay = "杀光他们！"

/obj/item/toy/figure/engineer
	name = "\improper 空间站工程师手办"
	icon_state = "engineer"
	toysay = "天啊，奇点失控了！"

/obj/item/toy/figure/geneticist
	name = "\improper 遗传学家手办"
	icon_state = "geneticist"
	toysay = "砸烂！"

/obj/item/toy/figure/hop
	name = "\improper 人事主管手办"
	icon_state = "hop"
	toysay = "人人都有全站通行权！"

/obj/item/toy/figure/hos
	name = "\improper 安保主管手办"
	icon_state = "hos"
	toysay = "来啊，让我痛快一回。"

/obj/item/toy/figure/qm
	name = "\improper 军需官手办"
	icon_state = "qm"
	toysay = "请签署这份一式三份的表格，我们会争取在三个工作日内给您配发焊接面罩。"

/obj/item/toy/figure/janitor
	name = "\improper 清洁工手办"
	icon_state = "janitor"
	toysay = "看警示牌啊，白痴。"

/obj/item/toy/figure/lawyer
	name = "\improper 律师手办"
	icon_state = "lawyer"
	toysay = "我的当事人是个卑鄙的叛徒！"

/obj/item/toy/figure/curator
	name = "\improper 馆员手办"
	icon_state = "curator"
	toysay = "有一天……"

/obj/item/toy/figure/md
	name = "\improper 医生手办"
	icon_state = "md"
	toysay = "病人已经死了！"

/obj/item/toy/figure/coroner
	name = "\improper 法医手办"
	icon_state = "coroner"
	toysay = "把那该死的亡魂赶出去！"

/obj/item/toy/figure/paramedic
	name = "\improper 急救员手办"
	icon_state = "paramedic"
	toysay = "最妙的是？我甚至不是真正的医生！"

/obj/item/toy/figure/psychologist
	name = "\improper 心理医生手办"
	icon_state = "psychologist"
	toysay = "好啦，把这些快乐药丸吃下去！"

/obj/item/toy/figure/prisoner
	name = "\improper 囚犯手办"
	icon_state = "prisoner"
	toysay = "我没有打她！我没有！"

/obj/item/toy/figure/mime
	name = "\improper 默剧演员手办"
	icon_state = "mime"
	toysay = "..."
	toysound = null

/obj/item/toy/figure/miner
	name = "\improper 矿工手办"
	icon_state = "miner"
	toysay = "巨像就在基地外面！"

/obj/item/toy/figure/ninja
	name = "\improper 太空忍者手办"
	icon_state = "ninja"
	toysay = "我是暗影武士！"

/obj/item/toy/figure/wizard
	name = "\improper 巫师手办"
	icon_state = "wizard"
	toysay = "化为尘埃！"
	toysound = 'sound/effects/magic/disintegrate.ogg'

/obj/item/toy/figure/wizard/special
	name = "\improper 巫师手办特别版"
	toysay = "铛！";
	toysound = 'sound/effects/clang.ogg'

/obj/item/toy/figure/rd
	name = "\improper 科研主管手办"
	icon_state = "rd"
	toysay = "引爆所有机器人！"

/obj/item/toy/figure/roboticist
	name = "\improper 机器人专家手办"
	icon_state = "roboticist"
	toysay = "轰隆作响的大机甲！"
	toysound = 'sound/vehicles/mecha/mechstep.ogg'

/obj/item/toy/figure/scientist
	name = "\improper 科学家手办"
	icon_state = "scientist"
	toysay = "军械实验归我。"
	toysound = 'sound/effects/explosion/explosionfar.ogg'

/obj/item/toy/figure/syndie
	name = "\improper 核武特工手办"
	icon_state = "syndie"
	toysay = "快拿到那该死的磁盘！"

/obj/item/toy/figure/secofficer
	name = "\improper 安保员手办"
	icon_state = "secofficer"
	toysay = "我就是法律！"
	toysound = 'sound/runtime/complionator/dredd.ogg'


/obj/item/toy/figure/warden
	name = "\improper 典狱长手办"
	icon_state = "warden"
	toysay = "对着警官咳嗽，关十七分钟！"

/obj/item/toy/dummy
	name = "ventriloquist dummy"
	desc = "It's a dummy, dummy."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "puppet"
	inhand_icon_state = "puppet"
	floor_placeable = TRUE
	var/doll_name = "Dummy"

//Add changing looks when i feel suicidal about making 20 inhands for these.
/obj/item/toy/dummy/attack_self(mob/user)
	var/new_name = tgui_input_text(usr, "What would you like to name the dummy?", "Doll Name", doll_name, max_length = MAX_NAME_LEN)
	if(!new_name || !user.is_holding(src))
		return
	doll_name = new_name
	to_chat(user, span_notice("You name the dummy as \"[doll_name]\"."))
	name = "[initial(name)] - [doll_name]"

/obj/item/toy/dummy/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/toy_talk)

/obj/item/toy/dummy/get_voice(add_id_name)
	return doll_name

/obj/item/toy/seashell
	name = "seashell"
	desc = "May you always have a shell in your pocket and sand in your shoes. Whatever that's supposed to mean."
	icon = 'icons/obj/fluff/beach.dmi'
	icon_state = "shell1"
	floor_placeable = TRUE
	var/static/list/possible_colors = list("" = 2, COLOR_PURPLE_GRAY = 1, COLOR_OLIVE = 1, COLOR_PALE_BLUE_GRAY = 1, COLOR_RED_GRAY = 1)

/obj/item/toy/seashell/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)
	icon_state = "shell[rand(1,3)]"
	color = pick_weight(possible_colors)
	setDir(pick(GLOB.cardinals))

/obj/item/toy/brokenradio
	name = "broken radio"
	desc = "An old radio that produces nothing but static when turned on."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "broken_radio"
	w_class = WEIGHT_CLASS_SMALL
	var/cooldown = 0

/obj/item/toy/brokenradio/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 300)
		user.visible_message(span_notice("[user] adjusts the dial on [src]."))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/items/radiostatic.ogg', 50, FALSE), 0.5 SECONDS)
	else
		to_chat(user, span_warning("The dial on [src] jams up"))
		return

/obj/item/toy/braintoy
	name = "squeaky brain"
	desc = "A Mr. Monstrous brand toy made to imitate a human brain in smell and texture."
	icon = 'icons/obj/medical/organs/organs.dmi'
	icon_state = "brain-old"
	var/cooldown = 0

/obj/item/toy/braintoy/attack_self(mob/user)
	if(cooldown <= world.time)
		cooldown = (world.time + 10)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/effects/blob/blobattack.ogg', 50, FALSE), 0.5 SECONDS)

/*
 * Eldritch Toys
 */
/obj/item/toy/eldritch_book
	name = "Codex Cicatrix"
	desc = "A toy book that closely resembles the Codex Cicatrix. Covered in fake polyester human flesh and has a huge googly eye attached to the cover. The runes are gibberish and cannot be used to summon demons... Hopefully?"
	icon = 'icons/obj/antags/eldritch.dmi'
	base_icon_state = "book"
	icon_state = "book"
	worn_icon_state = "book"
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("sacrifices", "transmutes", "graspes", "curses")
	attack_verb_simple = list("sacrifice", "transmute", "grasp", "curse")
	/// Helps determine the icon state of this item when it's used on self.
	var/book_open = FALSE
	/// id for timer
	var/timer_id

/obj/item/toy/eldritch_book/attack_self(mob/user, modifiers)
	. = ..()
	if(.)
		return

	if(book_open)
		close_animation()
	else
		open_animation()

/// Plays a little animation that shows the book opening and closing.
/obj/item/toy/eldritch_book/proc/open_animation()
	icon_state = "[base_icon_state]_open"
	flick("[base_icon_state]_opening", src)
	book_open = TRUE

	timer_id = addtimer(CALLBACK(src, PROC_REF(close_animation)), 5 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/// Plays a closing animation and resets the icon state.
/obj/item/toy/eldritch_book/proc/close_animation()
	icon_state = base_icon_state
	flick("[base_icon_state]_closing", src)
	book_open = FALSE

	deltimer(timer_id)

/*
 * Fake tear
 */
/obj/item/toy/reality_pierce
	name = "Pierced reality"
	desc = "Hah. You thought it was the real deal!"
	icon = 'icons/effects/eldritch.dmi'
	icon_state = "pierced_illusion"
	item_flags = NO_PIXEL_RANDOM_DROP

/obj/item/toy/foamfinger
	name = "foam finger"
	desc = "root for the home team! wait, does this station even have a sports team?"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "foamfinger"
	inhand_icon_state = "foamfinger_inhand"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	COOLDOWN_DECLARE(foamfinger_cooldown)

/obj/item/toy/foamfinger/attack_self(mob/living/carbon/human/user)
	if(!COOLDOWN_FINISHED(src, foamfinger_cooldown))
		return
	COOLDOWN_START(src, foamfinger_cooldown, 5 SECONDS)
	user.manual_emote("waves around the foam finger.")
	var/direction = prob(50) ? -1 : 1
	if(NSCOMPONENT(user.dir))
		animate(user, pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_w = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	else
		animate(user, pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (-2 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
		animate(pixel_z = (1 * direction), time = 0.1 SECONDS, easing = SINE_EASING, flags = ANIMATION_RELATIVE)
	user.changeNext_move(CLICK_CD_MELEE)

///All people who have used an Intento this round along with their high scores.
GLOBAL_LIST_EMPTY(intento_players)

#define HELP "help"
#define DISARM "disarm"
#define GRAB "grab"
#define HARM "harm"
#define ICON_SPLIT ICON_SIZE_ALL/2

// These states do not have any associated processing.
#define STATE_AWAITING_PLAYER_INPUT "awaiting_player_input"
#define STATE_OFF "off"

// When the Intento is in one of these four states, it has an accompanying
// set of code that runs in processing()
#define STATE_STARTING "starting"
#define STATE_DEMO "demo"
#define STATE_END_OF_GAME "end_of_game"
#define STATE_RETALIATION "retaliation"

#define TIME_TO_BEGIN (1.6 SECONDS)
#define TIME_PER_DEMO_STEP (0.6 SECONDS)
#define TIME_TO_RESET_ICON (0.5 SECONDS)

/obj/item/toy/intento
	name = "\improper 意任堂"
	desc = "无论有意无意，基本都派不上用场。"
	icon = 'icons/obj/toys/intents.dmi'
	icon_state = "blank"
	custom_price = PAYCHECK_COMMAND * 1.25

	/// Current sequence of intents
	var/list/current_sequence = list()
	/// Sequence player inputs
	var/list/player_sequence = list()
	/// Score of the player
	var/score = 0
	/// Associated list of intents to their sounds
	var/static/list/sound_by_intent = list(
		HELP = 'sound/items/intents/Help.ogg',
		DISARM = 'sound/items/intents/Disarm.ogg',
		GRAB = 'sound/items/intents/Grab.ogg',
		HARM = 'sound/items/intents/Harm.ogg',
		)

	/// What state the toy is in.
	var/state = STATE_OFF
	/// Index used for iteration of steps for both demo and retaliation states
	var/index
	/// Time to delay until we start processing whatever state we're in
	COOLDOWN_DECLARE(next_process)
	/// Time until we reset the icon of the Intento
	COOLDOWN_DECLARE(next_icon_reset)

/obj/item/toy/intento/attack_self(mob/user, modifiers) //added params to attack_self, the alternative is registering a signal on clickon but i was advised not to
	..()
	if(state == STATE_OFF)
		boot()
		return

	if(!modifiers)
		return

	if(state != STATE_AWAITING_PLAYER_INPUT)
		return

	var/input
	var/icon_x = text2num(modifiers[ICON_X])
	var/icon_y = text2num(modifiers[ICON_Y])
	if(icon_x > ICON_SPLIT && icon_y > ICON_SPLIT)
		input = DISARM
	if(icon_x < ICON_SPLIT && icon_y > ICON_SPLIT)
		input = HELP
	if(icon_x > ICON_SPLIT && icon_y < ICON_SPLIT)
		input = GRAB
	if(icon_x < ICON_SPLIT && icon_y < ICON_SPLIT)
		input = HARM

	player_input(user, input)

/obj/item/toy/intento/proc/boot()
	say("游戏开始！")
	playsound(src, 'sound/machines/synth/synth_yes.ogg', 50, FALSE)

	state = STATE_STARTING
	COOLDOWN_START(src, next_process, TIME_TO_BEGIN)
	START_PROCESSING(SSfastprocess, src)

/obj/item/toy/intento/proc/player_input(mob/player, intent)
	// All branches of this proc lead to us wanting to process
	START_PROCESSING(SSfastprocess, src)

	render(intent)

	player_sequence += intent
	for(var/i in 1 to player_sequence.len)
		if(player_sequence[i] != current_sequence[i])
			state = STATE_END_OF_GAME
			COOLDOWN_START(src, next_process, TIME_TO_RESET_ICON)
			return

	if(player_sequence.len == current_sequence.len)
		score++

		state = STATE_STARTING
		COOLDOWN_START(src, next_process, TIME_TO_BEGIN)

/obj/item/toy/intento/process()
	if(next_icon_reset && next_icon_reset <= world.time)
		icon_state = initial(icon_state)
		COOLDOWN_RESET(src, next_icon_reset)

	if(next_process && next_process > world.time)
		return

	switch(state)
		if(STATE_STARTING)
			process_start()

		if(STATE_DEMO)
			process_demo()

		if(STATE_END_OF_GAME)
			process_end(isliving(loc) ? loc : null)

		if(STATE_RETALIATION)
			process_retaliation()

	if(!next_process && !next_icon_reset)
		return PROCESS_KILL

/obj/item/toy/intento/proc/process_start()
	player_sequence.Cut()

	current_sequence += pick(list(HELP, DISARM, GRAB, HARM))

	state = STATE_DEMO
	next_process = world.time
	index = 1

/obj/item/toy/intento/proc/process_demo()
	if(index > length(current_sequence))
		state = STATE_AWAITING_PLAYER_INPUT
		COOLDOWN_RESET(src, next_process)
		return

	var/intent = current_sequence[index]
	render(intent)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/process_end(mob/user)
	if(user && GLOB.intento_players[user.ckey] < score)
		GLOB.intento_players[user.ckey] = score
		var/award_status = user.client.get_award_status(/datum/award/score/intento_score)
		var/award_score = score - award_status
		if(award_score > 0)
			user.client.give_award(/datum/award/score/intento_score, user, award_score)

	say("游戏结束。你的得分为[score]！")
	playsound(src, 'sound/machines/synth/synth_no.ogg', 50, FALSE)

	if(user && loc == user && obj_flags & EMAGGED)
		ADD_TRAIT(src, TRAIT_NODROP, type)
		to_chat(user, span_userdanger("大错特错。"))

		state = STATE_RETALIATION
		next_process = world.time
		index = 1
	else
		cleanup()

/obj/item/toy/intento/proc/process_retaliation()
	var/mob/living/victim = loc
	if(!isliving(victim) || index > length(current_sequence))
		cleanup()
		return

	var/intent = current_sequence[index]
	render(intent)
	switch(intent)
		if(HELP)
			to_chat(victim, span_danger("[src]抱了抱你，想让你好受一点！"))
			victim.add_mood_event("hug", /datum/mood_event/hug)
		if(DISARM)
			to_chat(victim, span_danger("[src]一把将你推倒了！"))
			victim.Knockdown(2 SECONDS)
		if(GRAB)
			to_chat(victim, span_danger("[src]凶狠地抓住了你！"))
			victim.Stun(2 SECONDS)
		if(HARM)
			to_chat(victim, span_danger("[src]打了你一拳！"))
			victim.apply_damage(rand(20, 30), BRUTE)

	index += 1
	COOLDOWN_START(src, next_process, TIME_PER_DEMO_STEP)

/obj/item/toy/intento/proc/cleanup()
	score = 0
	index = 1
	player_sequence.Cut()
	current_sequence.Cut()

	state = STATE_OFF
	COOLDOWN_RESET(src, next_process)
	REMOVE_TRAIT(src, TRAIT_NODROP, type)

/obj/item/toy/intento/proc/render(input)
	icon_state = input
	playsound(src, sound_by_intent[input], 50, FALSE)

	START_PROCESSING(SSfastprocess, src)
	COOLDOWN_START(src, next_icon_reset, TIME_TO_RESET_ICON)

/obj/item/toy/intento/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "负反馈循环已启用")
	return TRUE

/obj/item/toy/intento/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

#undef HELP
#undef DISARM
#undef GRAB
#undef HARM
#undef ICON_SPLIT
#undef STATE_AWAITING_PLAYER_INPUT
#undef STATE_OFF
#undef STATE_STARTING
#undef STATE_DEMO
#undef STATE_END_OF_GAME
#undef STATE_RETALIATION
#undef TIME_TO_BEGIN
#undef TIME_PER_DEMO_STEP
#undef TIME_TO_RESET_ICON

/*
 * Runic Scepter
 */
/obj/item/toy/foam_runic_scepter
	name = "foam scepter"
	desc = "A foam replica of the scepters Wizards use on Vendormancy Soccer."
	icon_state = "vendor_staff"
	worn_icon_state = "vendor_staff" //For the back
	inhand_icon_state = "vendor_staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon = 'icons/obj/weapons/guns/magic.dmi'
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("smacks", "clubs", "wacks", "vendors")
	attack_verb_simple = list("smack", "club", "wack", "vendor")
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE

/obj/item/extendohand
	name = "extendo-hand"
	desc = "Futuristic tech has allowed these classic spring-boxing toys to essentially act as a fully functional hand-operated hand prosthetic."
	icon = 'icons/obj/toys/toy.dmi'
	icon_state = "extendohand"
	inhand_icon_state = "extendohand"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 0
	throwforce = 5
	reach = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5)
	var/min_reach = 2

/obj/item/extendohand/acme
	name = "\improper ACME Extendo-Hand"
	desc = "A novelty extendo-hand produced by the ACME corporation. Originally designed to knock out roadrunners."

/obj/item/extendohand/attack(atom/M, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	var/dist = get_dist(M, user)
	if(dist < min_reach)
		to_chat(user, span_warning("[M] is too close to use [src] on."))
		return
	M.attack_hand(user, modifiers)

/obj/item/banhammer
	desc = "A banhammer."
	name = "banhammer"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "toyhammer"
	icon_angle = -45
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb_continuous = list("bans")
	attack_verb_simple = list("ban")
	max_integrity = 200
	armor_type = /datum/armor/item_banhammer
	resistance_flags = FIRE_PROOF

/datum/armor/item_banhammer
	fire = 100
	acid = 70

/obj/item/banhammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/banhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is hitting [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to ban [user.p_them()]self from life."))
	return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/living/user)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message(span_danger("[user] are stroking the head of [M] with a bangammer."), span_userdanger("[user] are stroking your head with a bangammer."), span_hear("You hear a bangammer stroking a head.")) // see above comment
	else
		M.visible_message(span_danger("[M] has been banned FOR NO REISIN by [user]!"), span_userdanger("You have been banned FOR NO REISIN by [user]!"), span_hear("You hear a banhammer banning someone."))
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.combat_mode)
		return ..(M, user)
