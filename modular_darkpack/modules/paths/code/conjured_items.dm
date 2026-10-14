// conjured items subclassed as lighters to emit light
/obj/item/lighter/conjured
	lit = TRUE
	light_system = OVERLAY_LIGHT
	light_on = TRUE
	damtype = BURN
	item_flags = DROPDEL
	icon = 'modular_darkpack/modules/paths/icons/paths.dmi'
	lefthand_file = 'modular_darkpack/modules/paths/icons/paths_inhand_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/paths/icons/paths_inhand_righthand.dmi'
	icon_state = "flame-on"
	inhand_icon_state = "flame"

// Override parent behavior so that they can't be turned off
/obj/item/lighter/conjured/attack_self(mob/user)
	to_chat(user, span_notice("这种超自然火焰无法用寻常手段熄灭。"))
	return

/obj/item/lighter/conjured/set_lit(new_lit)
	if(!new_lit)
		return
	return ..()

/obj/item/lighter/conjured/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	set_light_on(TRUE)

/obj/item/lighter/conjured/flame
	light_range = 3
	light_power = 1
	light_color = COLOR_ORANGE

/obj/item/lighter/conjured/flame/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		if(prob(25))
			L.adjust_fire_stacks(1)
			L.ignite_mob()
		playsound(src, 'modular_darkpack/modules/paths/sounds/fireball.ogg', 25, TRUE)

	return ..()

// Lure of Flames items
/obj/item/lighter/conjured/flame/candle
	name = "召唤烛火"
	desc = "你的指尖冒出了一簇烛火般的小火苗。"
	icon_state = "candle"
	inhand_icon_state = "candle"
	force = 10

/obj/item/lighter/conjured/flame/palm_of_flame
	name = "火焰之手"
	desc = "你的手上燃烧着超自然火焰。"
	icon_state = "flame"
	inhand_icon_state = "flame"
	force = 15
	fancy = FALSE

// Levinbolt items
/obj/item/lighter/conjured/levinbolt_arm
	name = "照明"
	desc = "你的手臂上涌动着电流！"
	icon_state = "illuminate"
	inhand_icon_state = "illuminate"
	force = 10
	light_range = 2
	light_power = 1
	light_color = COLOR_WHITE
