/mob/living/basic/shadow_guard
	name = "静默之心"
	desc = "一道被赋予生命的暗影，一个深不可测的生物……"
	icon = 'modular_darkpack/modules/npc/icons/shadow_guard.dmi'
	icon_state = "shadow2"
	icon_living = "shadow2"

	basic_mob_flags = DEL_ON_DEATH

	speed = 0
	maxHealth = 100
	health = 100

	obj_damage = 50
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "剜击"
	attack_verb_simple = "剜击"
	attack_sound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_hit.ogg'

	faction = list(VAMPIRE_CLAN_LASOMBRA)
	bloodpool = 1
	maxbloodpool = 1

	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon

/mob/living/basic/shadow_guard/Initialize(mapload)
	. = ..()
	if(prob(50) && icon_state == "shadow2")
		icon_state = "shadow"
		icon_living = "shadow"
	AddElement(/datum/element/ai_retaliate)

/mob/living/basic/shadow_guard/hungry_shade
	name = "饥饿幽影"
	desc = "一个来自冥界最深处、显现于世的幽影。"
	maxHealth = 150
	health = 150
	melee_damage_upper = 25
	melee_damage_lower = 25
	icon_state = "shade"
	icon_living = "shade"
	alpha = 160
	attack_sound = 'sound/mobs/humanoids/shadow/shadow_wail.ogg'
