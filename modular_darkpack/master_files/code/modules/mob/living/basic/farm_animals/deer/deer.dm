/mob/living/basic/deer
	name = "鹿"
	desc = "一种温顺平和的森林动物。"
	icon_state = "deer"
	icon_living = "deer"
	icon_dead = "deer_dead"
	icon = 'modular_darkpack/modules/npc/icons/deer.dmi'
	gender = PLURAL
	var/antlers = FALSE
	var/in_headlights = FALSE

/mob/living/basic/deer/Initialize(mapload)
	. = ..()
	if(gender == MALE)
		name = "雄鹿"
		if(prob(90))
			antlers = TRUE
	else
		name = "雌鹿"

	update_appearance(UPDATE_OVERLAYS)

/mob/living/basic/deer/update_overlays()
	. = ..()

	if(antlers)
		. += "antlers[(stat == DEAD) ? "_dead" : ""]_overlay"

	if(in_headlights && (stat != DEAD))
		. += "headlights_overlay"
