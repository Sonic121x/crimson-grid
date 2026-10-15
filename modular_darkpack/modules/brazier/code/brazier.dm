/obj/structure/brazier
	name = "火盆"
	desc = "架在石砖上的金属盆，用于生火。它以燃气为燃料，燃气旋钮中央周围有一圈奇怪的徽记。"
	icon = 'modular_darkpack/modules/brazier/icons/brazier.dmi'
	icon_state = "brazier"
	layer = OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	light_range = 0
	light_power = 0
	light_color = "null"
	var/lit = FALSE

/obj/structure/brazier/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(lit)
		turn_off(user)
	else
		turn_on(user)

/obj/structure/brazier/proc/turn_on(mob/user)
	if(lit)
		return

	lit = TRUE
	icon_state = "brazier_lit"
	light_range = 5
	light_power = 3
	light_color = "#ffa35c"
	playsound(src, 'modular_darkpack/modules/brazier/sounds/pilotlight.ogg', 75, TRUE)
	set_light(light_range, light_power, light_color)

	if(user)
		to_chat(user, span_notice("你转动旋钮，点燃了[name]。"))
		user.visible_message(span_notice("[user]转动旋钮，点燃了[name]。"), null, null, 3)

/obj/structure/brazier/proc/turn_off(mob/user)
	if(!lit)
		return

	lit = FALSE
	icon_state = "brazier"
	set_light(0)

	if(user)
		to_chat(user, span_notice("你反向转动旋钮，熄灭了[name]。"))
		user.visible_message(span_notice("[user]熄灭了[name]。"), null, null, 3)
