/mob/living/basic/beastmaster/giovanni_zombie
	name = "蹒跚行尸"
	desc = "当地狱再无容身之处，死者便会行走于大地之上。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	mob_biotypes = MOB_UNDEAD
	maxHealth = 35
	health = 35
	speed = 1
	melee_damage_lower = 12
	melee_damage_upper = 12
	attack_verb_continuous = "撕咬"
	attack_verb_simple = "撕咬"
	attack_sound = 'sound/mobs/non-humanoids/dog/growl1.ogg'
	status_flags = CANPUSH
	basic_mob_flags = DEL_ON_DEATH
	combat_mode = TRUE
	faction = list(VAMPIRE_CLAN_GIOVANNI)
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon

/mob/living/basic/beastmaster/giovanni_zombie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

/mob/living/basic/beastmaster/giovanni_zombie/level1 // Low health, low damage distraction unit
	name = "无心怨灵"
	desc = "一个毫无心智、饱受折磨的怨灵。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "ghost_animated"
	icon_living = "ghost_animated"
	mob_biotypes = MOB_UNDEAD
	response_help_continuous = "穿过"
	response_help_simple = "穿过"
	speed = 2
	maxHealth = 60
	health = 60
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "紧抓"
	attack_verb_simple = "紧抓"
	attack_sound = 'sound/effects/hallucinations/growl1.ogg'
	death_message = "哀嚎着崩解为一滩灵质！"
	light_system = OVERLAY_LIGHT
	light_range = 1
	light_power = 2
	speak_emote = list("哭泣着说")

/mob/living/basic/beastmaster/giovanni_zombie/level1/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/death_drops, /obj/item/ectoplasm)

/mob/living/basic/beastmaster/giovanni_zombie/level2 // Fragile, low-damage harass, rat equivalent
	name = "寄生尸虫"
	desc = "一团四处爬窜的怪物，长满无数指趾与细小的尖牙。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "ratzombie"
	icon_living = "ratzombie"
	response_help_continuous = "驱赶"
	response_help_simple = "驱赶"
	response_disarm_continuous = "拨开"
	response_disarm_simple = "拨开"
	response_harm_continuous = "踩踏"
	response_harm_simple = "踩踏"
	density = FALSE
	speed = 0
	maxHealth = 20
	health = 20
	melee_damage_lower = 8
	melee_damage_upper = 14
	attack_verb_continuous = "啃咬"
	attack_verb_simple = "啃咬"
	attack_sound = 'modular_darkpack/modules/npc/sound/rat.ogg'
	speak_emote = list("吱吱叫道")
	death_message = "迅速干瘪萎缩！"

/mob/living/basic/beastmaster/giovanni_zombie/level2/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/swarming, 16, 16) //max_x, max_y
	AddElement(/datum/element/can_be_held)

/mob/living/basic/beastmaster/giovanni_zombie/level3 // Middling dog-level threat
	name = "尸犬伙伴"
	desc = "这具蹒跚的怪物与犬类的共同点，只有四条腿和一副骇人的利颚。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "dogzombie"
	icon_living = "dogzombie"
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "拖开"
	response_disarm_simple = "拖开"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	speed = 0
	maxHealth = 80
	health = 80
	melee_damage_lower = 20
	melee_damage_upper = 30
	attack_verb_continuous = "撕咬"
	attack_verb_simple = "撕咬"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
	speak_emote = list("汪汪叫道")
	death_message = "散成一堆皮毛与白骨！"

/mob/living/basic/beastmaster/giovanni_zombie/level4 // Tanky, but slowed bruiser
	name = "蠕尸"
	desc = "一具人类的空壳，被某种残虐的力量操纵着。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "manzombie"
	icon_living = "manzombie"
	response_help_continuous = "握手致意于"
	response_help_simple = "握手致意于"
	response_disarm_continuous = "推开"
	response_disarm_simple = "推开"
	response_harm_continuous = "拳击"
	response_harm_simple = "拳击"
	speed = 1.5
	maxHealth = 120
	health = 120
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_verb_continuous = "猛击"
	attack_verb_simple = "猛击"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/zombuzi.ogg'
	speak_emote = list("嘶哑地说")
	death_message = "腐化为细碎的肉泥！"

/mob/living/basic/beastmaster/giovanni_zombie/level5 // Chonkmaster, only really Tzimisce mobs can provide material
	name = "腐肉巨尸"
	desc = "一座令人作呕的腐肉之山。尸僵将一抹欢快的坏笑永远凝固在它脸上。"
	icon = 'modular_darkpack/modules/npc/icons/necromancy_zombies.dmi'
	icon_state = "fatzombie"
	icon_living = "fatzombie"
	response_help_continuous = "轻拍"
	response_help_simple = "轻拍"
	response_disarm_continuous = "试图推开"
	response_disarm_simple = "试图推开"
	response_harm_continuous = "掌掴"
	response_harm_simple = "掌掴"
	speed = 3
	maxHealth = 300
	health = 300
	melee_damage_lower = 40
	melee_damage_upper = 50
	attack_verb_continuous = "猛撞"
	attack_verb_simple = "猛撞"
	attack_sound = 'modular_darkpack/modules/powers/sounds/heavypunch.ogg'
	speak_emote = list("咕噜作响地说")
	death_message = "坍塌为一滩腐臭的烂泥！"

/*
/mob/living/basic/beastmaster/giovanni_zombie/level1/Initialize(mapload)
	. = ..()
	give_player()

/mob/living/basic/beastmaster/giovanni_zombie/proc/give_player()
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as summoned ghost?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, span_ghostalert("Someone is summoning a ghost!"))
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		name = C.name
		key = C.key
		visible_message(span_danger("[src] rises with fresh soul!"))
		return TRUE
	visible_message(span_warning("[src] remains unsouled..."))
	return FALSE
*/
