/obj/item/lighter
	name = "\improper 芝宝打火机"
	desc = "芝宝打火机。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "zippo"
	inhand_icon_state = "zippo"
	worn_icon_state = "lighter"
	w_class = WEIGHT_CLASS_TINY
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	resistance_flags = FIRE_PROOF
	custom_price = 20 // DARKPACK EDIT CHANGE - ECONOMY
	light_system = OVERLAY_LIGHT
	light_range = 2
	light_power = 1.3
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE
	toolspeed = 1.5
	tool_behaviour = TOOL_WELDER
	///The amount of heat a lighter has while it's on. We're using the define to ensure lighters can't do things we don't want them to.
	var/heat_while_on = HIGH_TEMPERATURE_REQUIRED - 100
	///The amount of time the lighter has been on for, for fuel consumption.
	var/burned_fuel_for = 0
	///The max amount of fuel the lighter can hold.
	var/maximum_fuel = 6
	/// Whether the lighter is lit.
	var/lit = FALSE
	/// Whether the lighter is fancy. Fancy lighters have fancier flavortext and won't burn thumbs.
	var/fancy = TRUE
	/// The engraving overlay used by this lighter.
	var/overlay_state
	/// A list of possible engraving overlays.
	var/list/overlay_list = list(
		"plain",
		"dame",
		"thirteen",
		"snake",
	)
	/// Whether the lighter starts with fuel
	var/spawns_with_reagent = TRUE
	/// Lighting middleman, lets us do a flicker effect
	var/datum/light_middleman/middleman

/obj/item/lighter/Initialize(mapload)
	. = ..()
	if(IS_OVERLAY_LIGHT_SYSTEM(light_system))
		middleman = new(src, "lighter")
		RegisterSignal(middleman, COMSIG_LIGHT_MIDDLEMAN_UPDATED, PROC_REF(light_updated))
		middleman.being_overriding_light()
	create_reagents(maximum_fuel, REFILLABLE | DRAINABLE)
	if(spawns_with_reagent)
		reagents.add_reagent(/datum/reagent/fuel, maximum_fuel)
	if(!overlay_state)
		overlay_state = pick(overlay_list)
	AddComponent(\
		/datum/component/bullet_intercepting,\
		block_chance = 0.5,\
		active_slots = ITEM_SLOT_SUITSTORE,\
		on_intercepted = CALLBACK(src, PROC_REF(on_intercepted_bullet)),\
	)
	update_appearance()

/obj/item/lighter/Destroy(force)
	if(!isnull(middleman))
		QDEL_NULL(middleman)
	return ..()

/obj/item/lighter/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/fuel/oil = 5)

/obj/item/lighter/examine(mob/user)
	. = ..()
	if(get_fuel() <= 0)
		. += span_warning("打火机燃料用完了！可以用焊接燃料补充。")
	else
		. += span_notice("内有[get_fuel()]单位燃料，容量为[maximum_fuel]单位。")

/obj/item/lighter/proc/light_updated(datum/source)
	SIGNAL_HANDLER
	fire_flicker_middleman(middleman)

/// Destroy the lighter when it's shot by a bullet
/obj/item/lighter/proc/on_intercepted_bullet(mob/living/victim, obj/projectile/bullet)
	victim.visible_message(span_warning("[bullet]撞上[victim]的打火机，碎裂了！"))
	playsound(victim, SFX_RICOCHET, 100, TRUE)
	new /obj/effect/decal/cleanable/blood/oil(get_turf(src))
	do_sparks(1, TRUE, src)
	victim.dropItemToGround(src, force = TRUE, silent = TRUE)
	qdel(src)

/obj/item/lighter/cyborg_unequip(mob/user)
	if(!lit)
		return
	set_lit(FALSE)

/obj/item/lighter/suicide_act(mob/living/user)
	if (lit)
		user.visible_message(span_suicide("[user]开始把[src]的火焰凑到自己脸上！看起来是想自杀！"))
		playsound(src, 'sound/items/tools/welder.ogg', 50, TRUE)
		return FIRELOSS
	else
		user.visible_message(span_suicide("[user]开始用[src]敲打自己！看起来是想自杀！"))
		return BRUTELOSS

/obj/item/lighter/update_icon_state()
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"
	return ..()

/obj/item/lighter/update_overlays()
	. = ..()
	. += create_lighter_overlay()

/// Generates an overlay used by this lighter.
/obj/item/lighter/proc/create_lighter_overlay()
	return mutable_appearance(icon, "lighter_overlay_[overlay_state][lit ? "-on" : ""]")

/obj/item/lighter/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_infoplain(span_rose("[user]手腕轻轻一抖，便潇洒地用[src]点燃了[A]。真是帅呆了。"))

/obj/item/lighter/proc/set_lit(new_lit)
	if(lit == new_lit)
		return

	lit = new_lit
	if(lit)
		force = 5
		damtype = BURN
		hitsound = 'sound/items/tools/welder.ogg'
		attack_verb_continuous = string_list(list("灼烧", "燎烧"))
		attack_verb_simple = string_list(list("灼烧", "燎烧"))
		heat = heat_while_on
		START_PROCESSING(SSobj, src)
		if(fancy)
			playsound(src.loc , 'sound/items/lighter/zippo_on.ogg', 100, 1)
		else
			playsound(src.loc, 'sound/items/lighter/lighter_on.ogg', 100, 1)
		if(isliving(loc))
			var/mob/living/male_model = loc
			if(male_model.fire_stacks && !(male_model.on_fire))
				male_model.ignite_mob()
	else
		hitsound = SFX_SWING_HIT
		force = 0
		heat = 0
		attack_verb_continuous = null //human_defense.dm takes care of it
		attack_verb_simple = null
		STOP_PROCESSING(SSobj, src)
		if(fancy)
			playsound(src.loc , 'sound/items/lighter/zippo_off.ogg', 100, 1)
		else
			playsound(src.loc , 'sound/items/lighter/lighter_off.ogg', 100, 1)
	set_light_on(lit)
	update_appearance()

/obj/item/lighter/extinguish()
	. = ..()
	set_lit(FALSE)

/obj/item/lighter/attack_self(mob/living/user)
	if(!user.is_holding(src))
		return ..()
	if(lit)
		set_lit(FALSE)
		if(fancy)
			user.visible_message(
				span_notice("你听到轻轻一声咔哒，[user]连看都没看就熄灭了[src]。真潇洒。"),
				span_notice("你连看都没看，就轻轻熄灭了[src]。真潇洒。")
			)
		else
			user.visible_message(
				span_notice("[user]轻轻熄灭了[src]。"),
				span_notice("你轻轻熄灭了[src]。")
			)
		return

	if(get_fuel() <= 0)
		return

	set_lit(TRUE)

	if(fancy)
		user.visible_message(
			span_notice("[user]脚步不停，翻开并点燃[src]，动作一气呵成。"),
			span_notice("你脚步不停，翻开并点燃[src]，动作一气呵成。")
		)
		return

	var/hand_protected = FALSE
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user) || HAS_TRAIT(human_user, TRAIT_RESISTHEAT) || HAS_TRAIT(human_user, TRAIT_RESISTHEATHANDS))
		hand_protected = TRUE
	else if(!istype(human_user.gloves, /obj/item/clothing/gloves))
		hand_protected = FALSE
	else
		var/obj/item/clothing/gloves/gloves = human_user.gloves
		if(gloves.max_heat_protection_temperature)
			hand_protected = (gloves.max_heat_protection_temperature > 360)

	if(hand_protected || prob(75))
		user.visible_message(
			span_notice("试了几次后，[user]总算点燃了[src]。"),
			span_notice("试了几次后，你总算点燃了[src]。")
		)
		return

	var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
	user.apply_damage(5, BURN, hitzone)
	user.visible_message(
		span_warning("试了几次后，[user]总算点燃了[src]，却在过程中烫伤了手指。"),
		span_warning("你点打火机时烫伤了自己！")
	)
	user.add_mood_event("burnt_thumb", /datum/mood_event/burnt_thumb)

/obj/item/lighter/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	if(lit)
		use(0.5)
		if(target_mob.ignite_mob())
			message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(target_mob)] on fire with [src] at [AREACOORD(user)]")
			log_game("[key_name(user)] set [key_name(target_mob)] on fire with [src] at [AREACOORD(user)]")
	var/obj/item/cigarette/cig = help_light_cig(target_mob)
	if(!lit || !cig || user.combat_mode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("[cig]已经点燃了！"))
	if(target_mob == user)
		cig.attempt_light(user, src)
		return

	if(fancy)
		cig.attempt_light(user, src, span_rose("[user]利落地掏出[src]，举到[target_mob]面前，点燃了[cig]。那只手臂与火苗一样，稳得纹丝不动。"))
	else
		cig.attempt_light(user, src, span_notice("[user]把[src]举到[target_mob]面前，点燃了对方的[cig.name]。"))

///Checks if the lighter is able to perform a welding task.
/obj/item/lighter/tool_use_check(mob/living/user, amount, heat_required)
	if(!lit)
		to_chat(user, span_warning("必须先点燃[src]才能完成这项操作！"))
		return FALSE
	if(get_fuel() < amount)
		to_chat(user, span_warning("焊接燃料不足，无法完成这项操作！"))
		return FALSE
	if(heat < heat_required)
		return FALSE
	return TRUE

/obj/item/lighter/process(seconds_per_tick)
	if(lit)
		open_flame(heat)
		burned_fuel_for += seconds_per_tick
		if(burned_fuel_for >= TOOL_FUEL_BURN_INTERVAL)
			use(used = 0.25)

/obj/item/lighter/get_temperature()
	return lit * heat

/// Uses fuel from the lighter.
/obj/item/lighter/use(used = 0)
	if(!lit)
		return FALSE

	if (reagents.spark_act(0, SPARK_ACT_ENCLOSED, banned_reagents = /datum/reagent/fuel) & SPARK_ACT_DESTRUCTIVE)
		qdel(src)
		return FALSE

	if(used > 0)
		burned_fuel_for = 0

	if(get_fuel() >= used)
		reagents.remove_reagent(/datum/reagent/fuel, used)
		if(get_fuel() <= 0)
			set_lit(FALSE)
		return TRUE
	return FALSE

///Returns the amount of fuel
/obj/item/lighter/proc/get_fuel()
	return reagents.get_reagent_amount(/datum/reagent/fuel) + reagents.get_reagent_amount(/datum/reagent/toxin/plasma)

/obj/item/lighter/greyscale
	name = "廉价打火机"
	desc = "一只廉价打火机。"
	icon_state = "lighter"
	maximum_fuel = 3
	fancy = FALSE
	overlay_list = list(
		"transp",
		"tall",
		"matte",
		"zoppo", //u cant stoppo th zoppo
	)

	/// The color of the lighter.
	var/lighter_color
	/// The set of colors this lighter can be autoset as on init.
	var/static/list/color_list = list( //Same 16 color selection as electronic assemblies
		COLOR_ASSEMBLY_BLACK,
		COLOR_FLOORTILE_GRAY,
		COLOR_ASSEMBLY_BGRAY,
		COLOR_ASSEMBLY_WHITE,
		COLOR_ASSEMBLY_RED,
		COLOR_ASSEMBLY_ORANGE,
		COLOR_ASSEMBLY_BEIGE,
		COLOR_ASSEMBLY_BROWN,
		COLOR_ASSEMBLY_GOLD,
		COLOR_ASSEMBLY_YELLOW,
		COLOR_ASSEMBLY_GURKHA,
		COLOR_ASSEMBLY_LGREEN,
		COLOR_ASSEMBLY_GREEN,
		COLOR_ASSEMBLY_LBLUE,
		COLOR_ASSEMBLY_BLUE,
		COLOR_ASSEMBLY_PURPLE
		)

/obj/item/lighter/greyscale/Initialize(mapload)
	. = ..()
	if(!lighter_color)
		lighter_color = pick(color_list)
	update_appearance()

/obj/item/lighter/greyscale/create_lighter_overlay()
	var/mutable_appearance/lighter_overlay = ..()
	lighter_overlay.color = lighter_color
	return lighter_overlay

/obj/item/lighter/greyscale/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_notice("鼓捣了一会儿后，[user]总算用[src]点燃了[A]。")


/obj/item/lighter/slime
	name = "slime zippo"
	desc = "A specialty zippo made from slimes and industry. Has a much hotter flame than normal."
	icon_state = "slighter"
	heat_while_on = parent_type::heat_while_on + 1000 //Blue flame is hotter, this means this does act as a welding tool.
	light_color = LIGHT_COLOR_CYAN
	overlay_state = "slime"

/obj/item/lighter/slime/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/medicine/pyroxadone = 5)

/obj/item/lighter/skull
	name = "badass zippo"
	desc = "An absolutely badass zippo lighter. Just look at that skull!"
	overlay_state = "skull"

/obj/item/lighter/mime
	name = "pale zippo"
	desc = "In lieu of fuel, performative spirit can be used to light cigarettes."
	icon_state = "mlighter" //These ones don't show a flame.
	light_color = LIGHT_COLOR_HALOGEN
	heat_while_on = TCMB //I swear it's a real lighter dude you just can't see the flame dude I promise
	overlay_state = "mime"
	light_range = 0
	light_power = 0
	fancy = FALSE

/obj/item/lighter/mime/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/toxin/mutetoxin = 5, /datum/reagent/consumable/nothing = 10)

/obj/item/lighter/mime/ignition_effect(atom/A, mob/user)
	. = span_infoplain("[user] lifts \the [src] to the [A], which miraculously lights!")

/obj/item/lighter/bright
	name = "illuminative zippo"
	desc = "Sustains an incredibly bright chemical reaction when you spark it. Avoid looking directly at the igniter when lit."
	icon_state = "slighter"
	light_color = LIGHT_COLOR_ELECTRIC_CYAN
	overlay_state = "bright"
	light_range = 8
	light_power = 3 //Irritatingly bright and large enough to cover a small room.
	fancy = FALSE

/obj/item/lighter/bright/grind_results()
	return list(/datum/reagent/iron = 1, /datum/reagent/flash_powder = 10)

/obj/item/lighter/bright/examine(mob/user)
	. = ..()

	if(lit && isliving(user))
		var/mob/living/current_viewer = user
		current_viewer.flash_act(4)

/obj/item/lighter/bright/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_infoplain(span_rose("[user] lifts the [src] to the [A], igniting it with a brilliant flash of light!"))
		var/mob/living/current_viewer = user
		current_viewer.flash_act(4)

/obj/effect/spawner/random/special_lighter
	name = "special lighter spawner"
	icon_state = "lighter"
	loot = list(
		/obj/item/lighter/skull,
		/obj/item/lighter/mime,
		/obj/item/lighter/bright,
	)

/obj/item/lighter/empty
	spawns_with_reagent = FALSE

/obj/item/lighter/greyscale/empty
	spawns_with_reagent = FALSE
