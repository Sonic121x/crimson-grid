/obj/item/clothing/mask/muzzle
	name = "口套"
	desc = "让那些恼人的声音停下来。"
	icon_state = "muzzle"
	inhand_icon_state = "blindfold"
	lefthand_file = 'icons/mob/inhands/clothing/glasses_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/glasses_righthand.dmi'
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	equip_delay_other = 2 SECONDS

/obj/item/clothing/mask/muzzle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/muffles_speech)

/obj/item/clothing/mask/muzzle/attack_paw(mob/user, list/modifiers)
	if(user.get_item_by_slot(ITEM_SLOT_MASK) == src)
		to_chat(user, span_warning("你需要别人帮忙才能取下它！"))
		return
	return ..()

/obj/item/clothing/mask/muzzle/tape
	name = "胶带片"
	desc = "一片可以封住别人嘴巴的胶带。"
	worn_icon_state = "tape_piece_worn"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_TINY
	equip_delay_other = 4 SECONDS
	strip_delay = 4 SECONDS
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/muzzle/tape"
	post_init_icon_state = "tape_piece"
	greyscale_config = /datum/greyscale_config/tape_piece
	greyscale_config_worn = /datum/greyscale_config/tape_piece/worn
	greyscale_colors = "#B2B2B2"
	///Dertermines whether the tape piece does damage when ripped off of someone.
	var/harmful_strip = FALSE
	///The ammount of damage dealt when the tape piece is ripped off of someone.
	var/stripping_damage = 0

/obj/item/clothing/mask/muzzle/tape/create_moth_snack()
	return null

/obj/item/clothing/mask/muzzle/tape/examine(mob/user)
	. = ..()
	. += "[span_notice("在非战斗模式下对他人使用，可以封住对方的嘴！")]"

/obj/item/clothing/mask/muzzle/tape/dropped(mob/living/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_MASK) != src)
		return
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
	if(harmful_strip)
		user.apply_damage(stripping_damage, BRUTE, BODY_ZONE_HEAD)
		INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, emote), "scream")
		to_chat(user, span_userdanger("数百根小刺从你的脸上被扯出，带来一阵剧痛！"))

/obj/item/clothing/mask/muzzle/tape/attack(mob/living/carbon/victim, mob/living/carbon/attacker, list/modifiers, list/attack_modifiers)
	if(attacker.combat_mode)
		return ..()
	if(victim.is_mouth_covered(ITEM_SLOT_HEAD))
		to_chat(attacker, span_notice("[victim]的嘴被遮住了。"))
		return
	if(!mob_can_equip(victim, ITEM_SLOT_MASK))
		to_chat(attacker, span_notice("[victim]脸上已经戴着东西了。"))
		return
	balloon_alert(attacker, "正在封嘴……")
	to_chat(victim, span_userdanger("[attacker]正试图用胶带封住你的嘴！"))
	if(!do_after(attacker, equip_delay_other, target = victim))
		return
	victim.equip_to_slot_if_possible(src, ITEM_SLOT_MASK)
	update_appearance()

/obj/item/clothing/mask/muzzle/tape/super
	name = "强力胶带片"
	desc = "一片可以封住别人嘴巴的胶带。这种格外牢固。"
	icon_state = "/obj/item/clothing/mask/muzzle/tape/super"
	greyscale_colors = "#4D4D4D"
	strip_delay = 8 SECONDS

/obj/item/clothing/mask/muzzle/tape/surgical
	name = "手术胶带片"
	desc = "一片可以封住别人嘴巴的胶带。只要给病人贴上，就听不到痛苦的尖叫了！"
	icon_state = "/obj/item/clothing/mask/muzzle/tape/surgical"
	greyscale_colors = "#70BAE7"
	equip_delay_other = 3 SECONDS
	strip_delay = 3 SECONDS

/obj/item/clothing/mask/muzzle/tape/pointy
	name = "带刺胶带片"
	desc = "一片可以封住别人嘴巴的胶带。看起来撕下时会很疼。"
	worn_icon_state = "tape_piece_spikes_worn"
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "/obj/item/clothing/mask/muzzle/tape/pointy"
	post_init_icon_state = "tape_piece_spikes"
	greyscale_config = /datum/greyscale_config/tape_piece/spikes
	greyscale_config_worn = /datum/greyscale_config/tape_piece/worn/spikes
	greyscale_colors = "#E64539#AD2F45"
	harmful_strip = TRUE
	stripping_damage = 10

/obj/item/clothing/mask/muzzle/tape/pointy/super
	name = "强力带刺胶带片"
	desc = "一片可以封住别人嘴巴的胶带。撕下这东西，可能会把你的脸扯得稀烂。"
	icon_state = "/obj/item/clothing/mask/muzzle/tape/pointy/super"
	greyscale_colors = "#8C0A00#300008"
	strip_delay = 6 SECONDS
	stripping_damage = 20
