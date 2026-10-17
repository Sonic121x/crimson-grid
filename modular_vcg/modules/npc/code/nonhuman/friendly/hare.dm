/mob/living/basic/hare/vamp
	name = "野兔"
	desc = "这附近最圆滚滚的蹦跳小家伙。"
	icon = 'modular_vcg/modules/npc/icons/32x32small.dmi'
	icon_state = "hare"
	icon_living = "hare"
	icon_dead = "hare_dead"
	health = 15
	maxHealth = 15
	mob_biotypes = MOB_ORGANIC | MOB_BEAST
	mob_size = MOB_SIZE_SMALL
	density = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN
	speak_emote = list("抽动鼻子", "抖动身体")
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	attack_vis_effect = ATTACK_EFFECT_KICK
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	attack_verb_continuous = "踢"
	attack_verb_simple = "踢"
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	butcher_results = list(/obj/item/food/meat/slab/grassfed = 2)
	unsuitable_cold_damage = 0.7 // Cold damage is 0.7 here to account for low health on the large hare.
	unsuitable_heat_damage = 0.7 // Heat damage is 0.7 here to account for low health on the large hare.
	ai_controller = /datum/ai_controller/basic_controller/rabbit

/datum/emote/hare
	abstract_type = /datum/emote/hare
	mob_type_allowed_typecache = /mob/living/basic/hare
	mob_type_blacklist_typecache = list()

/datum/emote/hare/leap
	key = "leap"
	key_third_person = "leaps"
	message = "欢快地蹦来蹦去！"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE

/mob/living/basic/hare/vamp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "leap")
	AddElement(/datum/element/can_be_held)

/datum/ai_controller/basic_controller/hare
	behavior_tree_json = "code/modules/mob/living/basic/farm_animals/rabbit.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("咕噜。", "吱！", "咕噜？"),
			BB_EMOTE_HEAR = list("蹦跳着。"),
			BB_EMOTE_SEE = list("蹦来蹦去。", "上下跳动着。"),
			BB_SPEAK_CHANCE = 10,
		),
	)
	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
