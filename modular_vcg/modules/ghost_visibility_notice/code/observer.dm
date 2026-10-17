// I know, you were expecting more, right?
// Nah just kidding, search "can see you!" in code/modules/mob/living/carbon/examine.dm

// Okay, you came back thinking there was more, right? no thats it.

/mob/dead/observer/get_status_tab_items()
	. = ..()
	if(!GLOB.observer_default_invisibility)
		. += "生者可以看见幽灵！"
	else if (!invisibility)
		. += "生者可以看见你！"
	else if (invisibility <= SEE_INVISIBLE_LIVING)
		. += "大多数生者可以看见你！"
