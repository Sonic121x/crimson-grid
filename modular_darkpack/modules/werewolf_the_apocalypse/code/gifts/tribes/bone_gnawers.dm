/proc/localized_radial_choice(choice_image, display_name)
	var/datum/radial_menu_choice/choice = new()
	choice.image = choice_image
	choice.name = display_name
	return choice



/datum/action/cooldown/power/gift/desperate_strength
	name = "绝境之力"
	desc = "唤起绝境中的潜能，让力量骤然爆发。"
	button_icon_state = "desperate_strength"
	rank = 1

/datum/action/cooldown/power/gift/desperate_strength/IsAvailable(feedback)
	. = ..()
	if(owner.has_status_effect(/datum/status_effect/desperate_strength))
		if(feedback)
			to_chat(owner, span_warning("现在无法再次使用[name]。"))
		return FALSE

/datum/action/cooldown/power/gift/desperate_strength/Activate(atom/target)
	. = ..()
	var/mob/living/caster = astype(owner)
	if(!caster)
		return

	var/static/list/radial_menu_options = list(
			"One" = localized_radial_choice(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/gifts/tribes/bone_gnawers.dmi', "radial_one"), "一点"),
			"Two" = localized_radial_choice(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/gifts/tribes/bone_gnawers.dmi', "radial_two"), "两点"),
			"Three" = localized_radial_choice(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/gifts/tribes/bone_gnawers.dmi', "radial_three"), "三点"),
			"Four" = localized_radial_choice(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/gifts/tribes/bone_gnawers.dmi', "radial_four"), "四点"),
			"Five" = localized_radial_choice(icon('modular_darkpack/modules/werewolf_the_apocalypse/icons/gifts/tribes/bone_gnawers.dmi', "radial_five"), "五点"),
		)

	var/pick = show_radial_menu(owner, owner, radial_menu_options)
	if(!pick)
		return

	var/value = word_to_int(pick)

	if(!isnull(value))
		caster.apply_status_effect(/datum/status_effect/desperate_strength, value)

/datum/status_effect/desperate_strength
	id = "desperate_strength"
	duration = STATUS_EFFECT_PERMANENT

	status_type = STATUS_EFFECT_UNIQUE

	alert_type = /atom/movable/screen/alert/status_effect/desperate_strength
	/// Passed in by the gift's activate
	var/value

/datum/status_effect/desperate_strength/on_creation(mob/living/owner, value)
	src.value = value
	return ..()

/datum/status_effect/desperate_strength/on_apply()
	owner.st_add_stat_mod(STAT_STRENGTH, value, type)
	to_chat(owner, span_userdanger("你感到力量增强了……但这需要付出代价。"))
	RegisterSignal(owner, COMSIG_LIVING_DICE_ROLLED, PROC_REF(on_dice_rolled))
	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/desperate_strength_activate.ogg', 75, FALSE)
	return TRUE

/datum/status_effect/desperate_strength/proc/on_dice_rolled(mob/living/roller, datum/storyteller_roll/roll_datum, atom/target, atom/using_item, output)
	SIGNAL_HANDLER

	if(STAT_STRENGTH in roll_datum.using_stats(roller))
		qdel(src)

/datum/status_effect/desperate_strength/on_remove()
	owner.adjust_brute_loss(value TTRPG_DAMAGE)
	owner.st_remove_stat_mod(STAT_STRENGTH, type)
	playsound(owner, 'sound/effects/magic/disintegrate.ogg', 50, FALSE)
	to_chat(owner, span_warning("力量渐渐消退，伤口的疼痛再次涌来……"))
	UnregisterSignal(owner, COMSIG_LIVING_DICE_ROLLED)

/atom/movable/screen/alert/status_effect/desperate_strength
	name = "绝境之力"
	desc = "下一次检定获得额外力量，但你会承受钝击伤害作为代价！"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "riddle" // TODO: get an icon for this


/proc/word_to_int(word)
	var/static/alist/words_to_number = list(
		"one" = 1,
		"two" = 2,
		"three" = 3,
		"four" = 4,
		"five" = 5,
		"six" = 6,
		"seven" = 7,
		"eight" = 8,
		"nine" = 9,
		"ten" = 10,
	)

	word = LOWER_TEXT(word)
	return words_to_number[word]
