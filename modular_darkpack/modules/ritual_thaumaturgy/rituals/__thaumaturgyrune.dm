/obj/ritual_rune/thaumaturgy
	name = "睿魔尔符文"
	desc = "领悟鲜血的奥秘吧，新血……"
	color = rgb(128, 0, 0)
	word = "IDI NAH"
	required_discipline = /datum/discipline/thaumaturgy
	activation_color = rgb(255, 64, 64)

/obj/ritual_rune/thaumaturgy/Initialize(mapload)
	. = ..()
	difficulty = level + 3

/obj/ritual_rune/thaumaturgy/complete()
	. = ..()
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)

/obj/ritual_rune/thaumaturgy/ritual_failure()
	. = ..()
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)

/obj/ritual_rune/thaumaturgy/ritual_botch()
	. = ..()
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)

