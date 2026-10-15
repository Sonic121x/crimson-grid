/mob/living/basic/baali_guard
	name = "炼狱魔物"
	desc = "畸怪之中的防御巅峰，坚不可摧得令人难以置信……"
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "baali"
	icon_living = "baali"

	speed = 0
	max_stamina = 1500
	maxHealth = 1500
	health = 1500

	guaranteed_butcher_results = list(/obj/item/stack/sheet/meat = 20)

	combat_mode = TRUE
	melee_damage_type = AGGRAVATED
	melee_damage_lower = 20
	melee_damage_upper = 20

	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	attack_sound = 'sound/items/weapons/slash.ogg'

	bloodpool = 10
	maxbloodpool = 10

	faction = list(VAMPIRE_CLAN_BAALI)

/mob/living/basic/baali_guard/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ghost_direct_control,\
		poll_candidates = TRUE,\
		role_name = "巴力恶魔",\
		poll_ignore_key = POLL_IGNORE_BAALI_GUARD,\
		assumed_control_message = "你是来自地狱的恶魔！尽情摧毁一切吧！",\
		after_assumed_control = CALLBACK(src, PROC_REF(became_player_controlled)),\
	)

/// Triggers an alert to all ghosts that the rat has become player controlled.
/mob/living/basic/baali_guard/proc/became_player_controlled()
	notify_ghosts(
		"恭迎[name]，如今[get_area(src)]已成为其在此世的领地。",
		source = src,
		header = "巴力恶魔降临",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)
