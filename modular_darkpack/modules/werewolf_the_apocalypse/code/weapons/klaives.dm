/obj/item/occult_artifact/werewolf/klaive
	name = "仪式银刃"
	desc = "狼人用白银打造的仪式武器。特殊的锻造工艺使这把刀泛着蓝光。"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapons.dmi'
	lefthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/righthand.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/weapon_onfloors.dmi')
	icon_state = "klaive"
	force = 2 LETHAL_TTRPG_DAMAGE
	// icon_angle = -45
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("攻击", "劈砍", "切割", "撕裂", "划伤", "扯裂", "剁砍", "割伤")
	attack_verb_simple = list("攻击", "劈砍", "切割", "撕裂", "划伤", "扯裂", "剁砍", "割伤")
	sharpness = SHARP_EDGED
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/silver = (2 * SHEET_MATERIAL_AMOUNT))
	rank = 4
	spirit_type = SPIRIT_VENGEANCE
	var/stirred_spirit = FALSE
	var/silver_damage = 2
	var/awakened_force = 3 LETHAL_TTRPG_DAMAGE
	var/awakened_bonus_silver_damage = 1

/obj/item/occult_artifact/werewolf/klaive/Initialize(mapload)
	. = ..()
	spirit_name = generate_spirit_name(spirit_type)

/obj/item/occult_artifact/werewolf/klaive/identify()
	. = ..()
	say("我是[spirit_name]……挥舞我，迎战你的敌人……")

/obj/item/occult_artifact/werewolf/klaive/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	fera_silver_damage(target, silver_damage, 1) // Copyed the other silver weapon. Not super accurate.

/obj/item/occult_artifact/werewolf/klaive/attack_self(mob/user, modifiers)
	if(!identified)
		return ..()

	var/datum/splat/werewolf/werewolf_splat = get_werewolf_splat(user)
	if(owner)
		if(stirred_spirit)
			to_chat(user, span_warning("[src]中的灵体已经苏醒！"))
			return
		if(werewolf_splat)
			awaken(user, werewolf_splat)
	else
		to_chat(user, span_notice("[src]只是一块毫无生气的白银。"))

/obj/item/occult_artifact/werewolf/klaive/proc/awaken(mob/living/carbon/human/user, datum/splat/werewolf/werewolf_splat)
	if(werewolf_splat.adjust_gnosis(-1))
		to_chat(user, span_notice("你呼唤[src]中的灵体，感受到它回应了你的召唤。"))
		stirred_spirit = TRUE
		force = awakened_force
		silver_damage += awakened_bonus_silver_damage
		addtimer(CALLBACK(src, PROC_REF(slumber), user), 1 TURNS)
	else
		to_chat(user, span_notice("你呼唤[src]中的灵体，却只得到沉默与冷漠。"))

/obj/item/occult_artifact/werewolf/klaive/proc/slumber(mob/user)
	stirred_spirit = FALSE
	force = initial(force)
	silver_damage = initial(silver_damage)
	to_chat(user, span_notice("[src]中的灵体再次沉睡。"))


/obj/item/occult_artifact/werewolf/klaive/karambit
	name = "弯曲仪式银刃"
	desc = "狼人用白银打造的仪式武器。这把刀的刀柄由骨头制成，刀身弯曲。"
	icon_state = "klaive_karambit"

/obj/item/occult_artifact/werewolf/klaive/bane
	name = "灾灵银刃"
	desc = "狼人用白银打造的仪式武器。这把刀看似锈迹斑斑，却依然锋利。"
	icon_state = "klaive_bane"

/obj/item/occult_artifact/werewolf/klaive/grand
	name = "巨型仪式银刃"
	desc = "狼人用白银打造的仪式武器。这把刀大得惊人！"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/weapons/48x32weapons.dmi'
	icon_state = "klaive_grand"
	force = 5 LETHAL_TTRPG_DAMAGE
	attack_difficulty = 7
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/silver = (4 * SHEET_MATERIAL_AMOUNT))
	rank = 5
	silver_damage = 3
	awakened_force = 6 LETHAL_TTRPG_DAMAGE
