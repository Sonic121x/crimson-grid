/mob/living/basic/szlachta
	name = "撕咬血肉战仆"
	desc = "一种形似蜘蛛、长着獠牙的凶猛生物。"
	icon = 'modular_darkpack/modules/npc/icons/szlachta.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	butcher_results = list(/obj/item/stack/sheet/meat = 1)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	speed = -0.4
	maxHealth = 75
	health = 75
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "撕咬"
	attack_verb_simple = "撕咬"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("咬牙切齿")
	faction = list(FACTION_SABBAT, VAMPIRE_CLAN_TZIMISCE)
	pressure_resistance = 200
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 2
	maxbloodpool = 2
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile_obstacles
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 2)
	default_blood_volume = BLOOD_VOLUME_NORMAL

/mob/living/basic/szlachta/fister
	name = "血肉战仆"
	desc = "一个靠双手行走的可怖憎恶，惨白的双眼空洞而悲伤。"
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	maxHealth = 125
	health = 125
	butcher_results = list(/obj/item/stack/sheet/meat = 2)
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "拳击"
	attack_verb_simple = "拳击"
	speed = 1.5
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	status_flags = CANPUSH
	bloodpool = 5
	maxbloodpool = 5
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 5)

/mob/living/basic/szlachta/tanker
	name = "攻城血仆"
	desc = "一辆骇人的血肉骨骼战车，长着利剑般的附肢，生体护层厚得令人难以置信。见多识广的吸血鬼称其为茨密希的攻城血仆。"
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/sheet/meat = 4)
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	speed = 2
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 7
	maxbloodpool = 7
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10)


/mob/living/basic/szlachta/otherthing
	name = "淤泥状攻城血仆"
	desc = "一种形如淤泥、身体鼓胀且长有獠牙的生物，与其他攻城血仆相似，却会饥渴地撕咬血肉、痛饮鲜血……"
	icon_state = "otherthing"
	icon_living = "otherthing"
	icon_dead = "otherthing_dead"
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/sheet/meat = 4)
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "挥砍"
	attack_verb_simple = "挥砍"
	speed = 2
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 10
	maxbloodpool = 10
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10)


//DARKPACK TODO - Szlachta - make this guy drain blood

/mob/living/basic/szlachta/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/szlachta/fister/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/szlachta/tanker/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/szlachta/otherthing/hostile
	faction = list(FACTION_HOSTILE)
