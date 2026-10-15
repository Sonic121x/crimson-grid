/obj/effect/looping_sound_emitter
	name = "音源"
	desc = "大概是用来发出声音的。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield2"
	invisibility = INVISIBILITY_OBSERVER
	anchored = TRUE
	density = FALSE
	opacity = FALSE
	alpha = 175
	var/datum/looping_sound/main_looping_sound
	var/sound_type

/obj/effect/looping_sound_emitter/Initialize(mapload)
	. = ..()
	if(sound_type)
		main_looping_sound = new sound_type(src, TRUE)

/obj/effect/looping_sound_emitter/Destroy(force)
	. = ..()
	QDEL_NULL(main_looping_sound)
